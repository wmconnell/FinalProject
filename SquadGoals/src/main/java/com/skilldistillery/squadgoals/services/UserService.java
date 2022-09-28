package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.User;

public interface UserService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	//	Login Id not included in the create User method, since this will be used for registration.
	
	//	CREATE	(This function is achieved via the register method in the AuthServiceImpl.)

	//	READ
	List<User> index(String username);
	User show(String username, int userId);
	List<User> getUsersBySquad(int squadId);
	//	UPDATE
	User update(String username, int userId, User user);
	//	DELETE
	boolean disable(String username, int userId);
	public User getUserByUserName(String username);

}
