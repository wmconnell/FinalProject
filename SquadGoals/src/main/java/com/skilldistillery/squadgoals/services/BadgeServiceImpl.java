package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Badge;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.BadgeRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class BadgeServiceImpl implements BadgeService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private BadgeRepository badgeRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Badge create(String username, Badge badge) {
		//	Only admins may create badges.
		if (isUser(username) && isAdmin(username)) {
			try {
				//	Make sure the badge doesn't already exist.
				//	TODO:	Make "name" the Primary Key for badge, remove "id".
				if (!index(username).contains(badge)) {
					return badgeRepo.saveAndFlush(badge);
				}
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Badge> index(String username) {
		//	Any user may retrieve a list of all badges.
		if (isUser(username)) {
			return badgeRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public Badge show(String username, int badgeId) {
		//	Any user may look up any badge.
		if (isUser(username)) {
			try {
				Optional<Badge> badgeOpt = badgeRepo.findById(badgeId);
				if (badgeOpt.isPresent()) {
					return badgeOpt.get();
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
	public Badge update(String username, int badgeId, Badge badge) {
		//	Only a user with role "admin" may update a badge.
		if (isUser(username) && isAdmin(username)) {
			Optional<Badge> badgeOpt = badgeRepo.findById(badgeId);
			Badge toUpdate = null;
			//	
			if (badgeOpt.isPresent()) {
				toUpdate = badgeOpt.get();
				Field[] fields = badge.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(badge);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"BadgeServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("BadgeServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return badgeRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the badge inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int badgeId) {
		// Only a user with role "admin" may disable a badge.
		if (isUser(username) && isAdmin(username)) {
			Badge toDisable = show(username, badgeId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					badgeRepo.save(toDisable);
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
		return userRepo.findByUsername(username);
	}
	
	public boolean isUser(String username) {
		return userRepo.existsByUsername(username);
	}

	public boolean isAdmin(String username) {
		return getUser(username).getRole().equals("admin");
	}
}
