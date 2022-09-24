package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.repositories.GoalRepository;
import com.skilldistillery.squadgoals.repositories.SquadRepository;

@Service
public class GoalServiceImpl implements GoalService {
	@Autowired
	private GoalRepository goalRepo;
	@Autowired
	private SquadRepository squadRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Goal create(String username, Goal goal) {
		try {
			List<Squad> squads = new ArrayList<>();
			for (Squad squad : goal.getSquads()) {
				Optional<Squad> squadOpt = squadRepo.findById(squad.getId());
				if (squadOpt.isPresent()) {
					squads.add(squadOpt.get());
				}
			}
			System.out.println("All squads in squads");
			for (Squad squad : squads) {
				System.out.println(squad.getId());
			}
			System.out.println("All squads in goal.getSquads()");
			for (Squad squad : goal.getSquads()) {
				System.out.println(squad.getId());
			}
			goal.setSquads(squads);
			return goalRepo.saveAndFlush(goal);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// READ
	@Override
	public List<Goal> index(String username) {
		// TODO: Consider whether it would be better to instead
		// create many more specific index methods, such as
		// - showAllActiveGoals()
		// - showAllAttendingGoals(int goalId)
		// - showGoalsToWhichUserBelongs()
		// This may be advantageous because it is a leaner approach.
		// Once the user base grows enough, the level of data transfer
		// could slow the site. In addition, it may be better for security
		// since its precision means that less data is available at any given time.
		return goalRepo.findAll();
	}

	@Override
	public Goal show(String username, int goalId) {
		try {
			Optional<Goal> goalOpt = goalRepo.findById(goalId);
			if (goalOpt.isPresent()) {
				return goalOpt.get();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// UPDATE
	//
	// This update method allows for a partially defined entity to
	// be passed as an argument. The method then simply uses this partially
	// defined entity to overwrite any permissible fields of the target
	// entity. This is achieved via reflection, as seen in the use of
	// the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public Goal update(String username, int goalId, Goal goal) {
		Optional<Goal> goalOpt = goalRepo.findById(goalId);
		Goal toUpdate = null;
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
				if (value != null && !field.getName().equals("id") && !field.getName().equals("createdDate")
						&& !field.getName().equals("updatedDate") && !field.getName().equals("creator")) {
					try {
						field.set(toUpdate, value);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"GoalServiceImpl.update() - Illegal Access Exception: Cannot set " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			return goalRepo.saveAndFlush(toUpdate);
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the goal inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true
	// delete.
	//
	@Override
	public boolean disable(String username, int goalId) {
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
		return false;
	}

}
