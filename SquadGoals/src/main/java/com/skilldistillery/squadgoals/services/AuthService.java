package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;

public interface AuthService {
	User register(User user);
	User getUserByUsername(String username);
	User getUserById(int id);
	boolean usernameTaken(String username);
	boolean emailAlreadyAssociatedWithAccount(String email);
	
	//	Helper Methods
	boolean isLoggedInUser(String username);
	boolean userExists(int userId);
	boolean goalExists(int goalId);
	boolean reviewExists(int goalId, int userId);
	boolean squadsExist(List<Squad> goalSquads);
	boolean taskExists(int taskId);
	boolean isAdmin(String username);
	boolean isSameUser(String username, int userId);
	User getUser(String username);
	Goal getGoal(int goalId);
	boolean assignedToTask(String username, int taskId);
	boolean belongsToSquad(String username, List<Squad> squads);
	boolean belongsToGoal(String username, int goalId);
	boolean createdReview(String username, int userId);
}
