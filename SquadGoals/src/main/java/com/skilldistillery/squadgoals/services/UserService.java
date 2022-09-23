package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.User;

public interface UserService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	//	Login Id not included in the create User method, since this will be used for registration.
	
	//	CREATE	(This function is achieved via the AuthServiceImpl.)

	//	READ
	List<User> index(int loginId);
	User show(int loginId, int userId);
	//	UPDATE
	User update(int loginId, int userId, User user);
	//	DELETE
	boolean disable(int loginId, int userId);
}
