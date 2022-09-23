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
	public Goal create(int loginId, Goal goal) {
		//	Users may only create a goal for a squad to which they belong.
		if (isUser(loginId) && belongsToSquad(loginId, goal.getSquads())) {
			try {
				goal.setCreator(getUser(loginId));
				return goalRepo.saveAndFlush(goal);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Goal> index(int loginId) {
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
		if (isUser(loginId)) {
			return goalRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public Goal show(int loginId, int goalId) {
		//	Any user may look up any goal.
		//	TODO:	We will implement public/private visibility on the front end.
		if (isUser(loginId)) {
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
	public Goal update(int loginId, int goalId, Goal goal) {
		//	A user with role "member" may only update a goal to which they belong.
		//	A user with role "admin" may update any goal.
		if (isUser(loginId) && (belongsToGoal(loginId, goalId) || isAdmin(loginId))) {
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
	public boolean disable(int loginId, int goalId) {
		// A user with role "member" can only disable a goal to which they belong.
		// A user with role "admin" can disable any goal.
		if (isUser(loginId) && (belongsToGoal(loginId, goalId) || isAdmin(loginId))) {
			Goal toDisable = show(loginId, goalId);
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
	public User getUser(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		return userOpt.isPresent() ? userOpt.get() : null;
	}
	
	public boolean isUser(int loginId) {
		return userRepo.existsById(loginId);
	}

	public boolean isAdmin(int loginId) {
		User requestor = getUser(loginId);
		return requestor.getRole() == "admin";
	}
	
	public boolean belongsToSquad(int loginId, List<Squad> squads) {
		//	TODO: Change squad.users to squad.members
		User requestor = getUser(loginId);
		if (requestor != null) {
			for (Squad squad : squads) {
				if (squad.getUsers().contains(requestor)) {
					return true;
				}
			}
		}
		return false;
	}

	public boolean belongsToGoal(int loginId, int goalId) {
		//	TODO: Change goal.users to goal.members
		User requestor = getUser(loginId);
		if (requestor != null) {
			return show(loginId, goalId).getUsers().contains(requestor);
		}
		return false;
	}
}
