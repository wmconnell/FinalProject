package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.GoalRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class GoalServiceImpl implements GoalService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private GoalRepository goalRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Goal create(String username, Goal goal) {
		//	Users may only create a goal for a squad to which they belong.
		//	TODO: Make it so only a leader can create a goal
		if (isUser(username) && belongsToSquad(username, goal.getSquads())) {
			try {
				goal.setCreator(getUser(username));
				return goalRepo.saveAndFlush(goal);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Goal> index(String username) {
		//	Any user may retrieve a list of all goals, regardless of which squad they belong to.
		//	TODO:	We will implement visibility on the front end.
		//	TODO: 	Consider whether it would be better to instead
		//	create many more specific index methods, such as
		//		- showAllActiveGoals()
		//		- showAllAttendingGoals(int goalId)
		//		- showGoalsToWhichUserBelongs()
		//	This may be advantageous because it is a leaner approach.
		//	Once the user base grows enough, the level of data transfer
		//	could slow the site. In addition, it may be better for security
		//	since its precision means that less data is available at any given time.
		if (isUser(username)) {
			return goalRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public Goal show(String username, int goalId) {
		//	Any user may look up any goal.
		//	TODO:	We will implement public/private visibility on the front end.
		if (isUser(username)) {
			try {
				Optional<Goal> goalOpt = goalRepo.findById(goalId);
				if (goalOpt.isPresent()) {
					return goalOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	//	UPDATE
	//
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public Goal update(String username, int goalId, Goal goal) {
		//	A user with role "member" may only update a goal to which they belong.
		//	A user with role "admin" may update any goal.
		if (isUser(username) && (belongsToGoal(username, goalId) || isAdmin(username))) {
			Optional<Goal> goalOpt = goalRepo.findById(goalId);
			Goal toUpdate = null;
			//	
			if (goalOpt.isPresent()) {
				toUpdate = goalOpt.get();
				Field[] fields = goal.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(goal);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"GoalServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id") &&
							!field.getName().equals("createdDate") &&
							!field.getName().equals("updatedDate") &&
							!field.getName().equals("creator")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("GoalServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return goalRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the goal inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int goalId) {
		// A user with role "member" can only disable a goal to which they belong.
		// A user with role "admin" can disable any goal.
		if (isUser(username) && (belongsToGoal(username, goalId) || isAdmin(username))) {
			Goal toDisable = show(username, goalId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					goalRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	// Helper Methods
	//
	// The following methods ensure that the user requesting an action is
	// logged in and authorized to perform the given action.
	// Outsourcing the logic to these methods makes the code in the CRUD
	// methods read more like the actual problem.
	public User getUser(String username) {
		return userRepo.findByUsername(username);
	}
	
	public boolean isUser(String username) {
		return userRepo.existsByUsername(username);
	}

	public boolean isAdmin(String username) {
		return getUser(username).getRole().equals("admin");
	}
	
	public boolean belongsToSquad(String username, List<Squad> squads) {
		//	TODO: Change squad.users to squad.members
		User requestor = getUser(username);
		if (requestor != null) {
			for (Squad squad : squads) {
				if (squad.getUsers().contains(requestor)) {
					return true;
				}
			}
		}
		return false;
	}

	public boolean belongsToGoal(String username, int goalId) {
		//	TODO: Change goal.users to goal.members
		User requestor = getUser(username);
		if (requestor != null) {
			return show(username, goalId).getUsers().contains(requestor);
		}
		return false;
	}
}
