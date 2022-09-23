package com.skilldistillery.squadgoals.services;

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
	boolean isAdmin(String username);
	boolean isSameUser(String username, int userId);
}
