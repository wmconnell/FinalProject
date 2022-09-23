package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserRepository userRepo;

	// CRUD Methods
	//
	// CREATE (This function is achieved via the AuthServiceImpl.)
	//
	// READ
	@Override
	public List<User> index(int loginId) {
		//	Any user may retrieve a list of all users.
		//	We will implement public/private visibility on the front end.
		//	TODO: Consider whether it would be better to instead
		//	create many more specific index methods, such as
		//		- showAllFellowSquadMembers()
		//		- showActiveMembers()
		//		- showAttendees()
		//	This may be advantageous because it is a leaner approach.
		//	Once the user base grows enough, the level of data transfer
		//	could slow the site. In addition, it may be better for security
		//	since its precision means that less data is available at any given time.
		if (isUser(loginId)) {
			return userRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public User show(int loginId, int userId) {
		// Any user may look up another user, for now at least.
		//	TODO:	A stretch goal is to implement public/private profiles.
		if (isUser(loginId)) {
			try {
				Optional<User> userOpt = userRepo.findById(userId);
				if (userOpt.isPresent()) {
					return userOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	// 	UPDATE
	//	
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public User update(int loginId, int userId, User user) {
		//	A user with role "member" may only update their own account.
		//	A user with role "admin" may update any account.
		if (isUser(loginId) && (isSameUser(loginId, userId) || isAdmin(loginId))) {
			Optional<User> userOpt = userRepo.findById(userId);
			User toUpdate = null;
			//	We checked to make sure that the initiator of the action was an actual user,
			//	but we now have to make sure that the recipient of the action is.
			if (userOpt.isPresent()) {
				toUpdate = userOpt.get();
				Field[] fields = user.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(user);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"UserServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null && !field.getName().equals("id") && !field.getName().equals("username")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("UserServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return userRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	//	DELETE
	//
	//	Note: "Delete" functionality is implemented by rendering the user inactive,
	//	making the action reversible.
	//
	// 	TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(int loginId, int userId) {
		//	A user with role "member" can only disable their own account.
		//	A user with role "admin" can disable any account.
		if (isUser(loginId) && (isSameUser(loginId, userId) || isAdmin(loginId))) {
			User toDisable = show(loginId, userId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					userRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	//	Helper Methods
	//	
	//	The following methods ensure that the user requesting an action is
	//	logged in and authorized to perform the given action.
	//	Outsourcing the logic to these methods makes the code in the CRUD
	//	methods read more like the actual problem.
	public boolean isUser(int loginId) {
		return userRepo.existsById(loginId);
	}

	public boolean isAdmin(int loginId) {
		User requestor = show(loginId, loginId);
		return requestor.getRole() == "admin";
	}

	public boolean isSameUser(int loginId, int userId) {
		return loginId == userId;
	}

}
