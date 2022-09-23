package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.BadgeRequirement;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.BadgeRequirementRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class BadgeRequirementServiceImpl implements BadgeRequirementService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private BadgeRequirementRepository badgeRequirementRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public BadgeRequirement create(String username, BadgeRequirement badgeRequirement) {
		//	Only admins may create badgeRequirements.
		if (isUser(username) && isAdmin(username)) {
			try {
				if (!index(username).contains(badgeRequirement)) {
					return badgeRequirementRepo.saveAndFlush(badgeRequirement);
				}
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<BadgeRequirement> index(String username) {
		//	Any user may retrieve a list of all badgeRequirements.
		if (isUser(username)) {
			return badgeRequirementRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public BadgeRequirement show(String username, int badgeRequirementId) {
		//	Any user may look up any badgeRequirement.
		if (isUser(username)) {
			try {
				Optional<BadgeRequirement> badgeRequirementOpt = badgeRequirementRepo.findById(badgeRequirementId);
				if (badgeRequirementOpt.isPresent()) {
					return badgeRequirementOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	//	UPDATE
	//
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public BadgeRequirement update(String username, int badgeRequirementId, BadgeRequirement badgeRequirement) {
		//	Only a user with role "admin" may update a badgeRequirement.
		if (isUser(username) && isAdmin(username)) {
			Optional<BadgeRequirement> badgeRequirementOpt = badgeRequirementRepo.findById(badgeRequirementId);
			BadgeRequirement toUpdate = null;
			//	
			if (badgeRequirementOpt.isPresent()) {
				toUpdate = badgeRequirementOpt.get();
				Field[] fields = badgeRequirement.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(badgeRequirement);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"BadgeRequirementServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("BadgeRequirementServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return badgeRequirementRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the badgeRequirement inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int badgeRequirementId) {
		// Only a user with role "admin" may disable a badgeRequirement.
		if (isUser(username) && isAdmin(username)) {
			BadgeRequirement toDisable = show(username, badgeRequirementId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					badgeRequirementRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	// Helper Methods
	//
	// The following methods ensure that the user requesting an action is
	// logged in and authorized to perform the given action.
	// Outsourcing the logic to these methods makes the code in the CRUD
	// methods read more like the actual problem.
	public User getUser(String username) {
		//	TODO:	Make sure repo sends back null.
		return userRepo.findByUsername(username);
	}
	
	public boolean isUser(String username) {
		return userRepo.existsByUsername(username);
	}

	public boolean isAdmin(String username) {
		User requestor = getUser(username);
		return requestor.getRole().equals("admin");
	}
}
