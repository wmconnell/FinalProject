package com.skilldistillery.squadgoals.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Image;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.GoalRepository;
import com.skilldistillery.squadgoals.repositories.ImageRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private ImageRepository imageRepo;
	@Autowired
	private GoalRepository goalRepo;
	
	@Override
	public User register(User user) {
		User registeredUser = null;
		try {
			String encodedPW =  encoder.encode(user.getPassword());
			Image newImage = new Image("https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg", true);
			newImage = imageRepo.saveAndFlush(newImage);
			user.setPassword(encodedPW);
			user.setProfilePic(newImage);
			user.setActive(true);
			user.setRole("member");
			registeredUser = userRepo.saveAndFlush(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return registeredUser;
	}
	
	//	TODO: Need method for smurfdating password

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
	
	@Override
	public boolean usernameTaken(String username) {
		return userRepo.existsByUsername(username);
	}
	
	@Override
	public boolean emailAlreadyAssociatedWithAccount(String email) {
		return userRepo.existsByEmail(email);
	}
	
	//	Helper Methods
	//	
	//	The following methods ensure that the user requesting an action is
	//	logged in and authorized to perform the given action.
	//	Outsourcing the logic to these methods makes the code in the CRUD
	//	methods read more like the actual problem.
	@Override
	public boolean isLoggedInUser(String username) {
		return userRepo.existsByUsername(username);
	}
	
	@Override
	public boolean userExists(int userId) {
		return userRepo.existsById(userId);
	}
	
	public boolean goalExists(int goalId) {
		return goalRepo.existsById(goalId);
	}

	@Override
	public boolean isAdmin(String username) {
		return userRepo.findByUsername(username).getRole().equals("admin");
	}

	@Override
	public boolean isSameUser(String username, int userId) {
		return userRepo.findByUsername(username).getId() == userId;
	}

	public User getUser(String username) {
		return userRepo.findByUsername(username);
	}
	
	@Override
	public boolean belongsToSquad(String username, List<Squad> squads) {
		//	TODO: Change squad.users to squad.members
		User requestor = getUser(username);
		if (requestor != null) {
			for (Squad squad : squads) {
				if (squad.getUsers().contains(requestor)) {
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public boolean belongsToGoal(String username, int goalId) {
		//	TODO: Change goal.users to goal.members
		User requestor = getUser(username);
		if (requestor != null) {
			Optional<Goal> goalOpt = goalRepo.findById(goalId);
			return goalOpt.isPresent() ? goalOpt.get().getUsers().contains(requestor) : false;
		}
		return false;
	}

}
