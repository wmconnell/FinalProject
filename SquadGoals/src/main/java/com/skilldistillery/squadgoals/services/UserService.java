package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.User;

public interface UserService {
	User create(User user);
	List<User> index(int loginId);
	User show(int loginId, int userId);
	User update(int loginId, int userId, User user);
	boolean destroy(int loginId, int userId);
}
