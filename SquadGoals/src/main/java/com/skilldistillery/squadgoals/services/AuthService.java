package com.skilldistillery.squadgoals.services;

import com.skilldistillery.squadgoals.entities.User;

public interface AuthService {
	User register(User user);
	User getUserByUsername(String username);
	User getUserById(int id);
}
