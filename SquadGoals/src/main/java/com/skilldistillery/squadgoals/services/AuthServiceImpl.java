package com.skilldistillery.squadgoals.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Image;
import com.skilldistillery.squadgoals.entities.ReviewId;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.Task;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.GoalRepository;
import com.skilldistillery.squadgoals.repositories.ImageRepository;
import com.skilldistillery.squadgoals.repositories.ReviewRepository;
import com.skilldistillery.squadgoals.repositories.SquadRepository;
import com.skilldistillery.squadgoals.repositories.TaskRepository;
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
	@Autowired
	private SquadRepository squadRepo;
	@Autowired
	private ReviewRepository reviewRepo;
	@Autowired
	private TaskRepository taskRepo;
	
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
	
	public boolean imageExists(int imageId) {
		return imageRepo.existsById(imageId);
	}
	
	@Override
	public boolean userExists(int userId) {
		return userRepo.existsById(userId);
	}
	
	@Override
	public boolean userExists(String username) {
		return userRepo.existsByUsername(username);
	}
	
	public boolean goalExists(int goalId) {
		return goalRepo.existsById(goalId);
	}
	
	public boolean reviewExists(int goalId, int userId) {
		ReviewId rid = new ReviewId();
		rid.setGoalId(goalId);
		rid.setUserId(userId);
		return reviewRepo.existsById(rid);
	}
	
	public boolean squadsExist(List<Squad> goalSquads) {
		List<Squad> squads = new ArrayList<>();
		System.out.println("Empty squad list: " + squads);
		System.out.println("Num Squads: " + goalSquads.size());
		if (goalSquads.size() > 0) {
		for (Squad squad : goalSquads) {
			System.out.println("GoalSquad.getId() = " + squad.getId());
			Optional<Squad> squadOpt = squadRepo.findById(squad.getId());
			System.out.println("Is present? " + squadOpt.isPresent());
			if (squadOpt.isPresent()) {
				squads.add(squadOpt.get());
				System.out.println("You gon' get! " + squadOpt.get());
			}
		}
		System.out.println("Squads size = " + squads.size());
	}
		return squads.size() == goalSquads.size();
	}
	
	public boolean taskExists(int taskId) {
		return taskRepo.existsById(taskId);
	}

	@Override
	public boolean isAdmin(String username) {
		return userRepo.findByUsername(username).getRole().equals("admin");
	}

	@Override
	public boolean isSameUser(String username, int userId) {
		return userRepo.findByUsername(username).getId() == userId;
	}
	
	public boolean isUserProfilePic(String username, int imageId) {
		return getImage(imageId).getUser().getUsername().equals(username);
	}
	
	public Image getImage(int imageId) {
		Optional<Image> imageOpt = imageRepo.findById(imageId);
		return imageOpt.isPresent() ? imageOpt.get() : null;
	}

	public User getUser(String username) {
		return userRepo.findByUsername(username);
	}
	
	public Goal getGoal(int goalId) {
		Optional<Goal> goalOp = goalRepo.findById(goalId);
		return goalOp.isPresent() ? goalOp.get() : null;
	}

	public Task getTask(int taskId) {
		Optional<Task> taskOpt = taskRepo.findById(taskId);
		return taskOpt.isPresent() ? taskOpt.get() : null;
	}
	
	public boolean assignedToTask(String username, int taskId) {
		User requestor = getUser(username);
		System.out.println(requestor);
		if (requestor != null) {
			System.out.println(getTask(taskId).getUsers().contains(requestor));
			return getTask(taskId).getUsers().contains(requestor);
		}
		return false;
	}
	
	@Override
	public boolean belongsToSquad(String username, List<Squad> squads) {
		//	TODO: Change squad.users to squad.members
		User requestor = getUser(username);
		if (requestor != null) {
			if (squads != null ) {
				for (Squad squad : squads) {
					Optional<Squad> squadOpt = squadRepo.findById(squad.getId());
					if (squadOpt.isPresent()) {
						if (squadOpt.get().getUsers().contains(requestor)) {
							return true;
						}
					}
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
			if (goalOpt.isPresent()) {
				for (Squad squad : goalOpt.get().getSquads()) {
					if (squad.getUsers().contains(requestor)) {
						return true;
					}
				}
			}
			return goalOpt.isPresent() ? goalOpt.get().getUsers().contains(requestor) : false;
		}
		return false;
	}

	public boolean createdReview(String username, int userId) {
			User requestor = getUser(username);
			if (requestor != null) {
				return requestor.getId() == userId;
			}
			return false;
		}
	
	

}
