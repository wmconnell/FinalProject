package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Goal;

public interface GoalService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Goal create(String username, Goal goal, int squadId);
	//	READ
	Goal show(String username, int goalId);
	List<Goal> index(String username);
	List<Goal> getGoalBySquad(int squadId);
	//	UPDATE
	Goal update(String username, int goalId, Goal goal);
	//	DELETE
	boolean disable(String username, int goalId);
}
