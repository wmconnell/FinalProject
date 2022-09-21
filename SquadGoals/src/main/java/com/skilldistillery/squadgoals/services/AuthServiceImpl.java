package com.skilldistillery.squadgoals.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public User register(User user) {
		String encodedPW =  encoder.encode(user.getPassword());
//		user.setPassword(encodedPW);
//		user.setActive(true);
//		user.setRole("standard");
		userRepo.saveAndFlush(user);
		return user;
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	
	@Override
	public User getUserById(int id) {
		Optional<User> userOpt = userRepo.findById(id);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		return user;
	}

}
