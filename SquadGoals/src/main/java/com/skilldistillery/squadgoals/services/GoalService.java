package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Goal;

public interface GoalService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Goal create(int loginId, Goal goal);
	//	READ
	Goal show(int loginId, int goalId);
	List<Goal> index(int loginId);
	//	UPDATE
	Goal update(int loginId, int goalId, Goal goal);
	//	DELETE
	boolean disable(int loginId, int goalId);
}
