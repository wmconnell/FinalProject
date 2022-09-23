package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Tag;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.TagRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class TagServiceImpl implements TagService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private TagRepository tagRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Tag create(String username, Tag tag) {
		//	Any user may create a tag.
		if (isUser(username)) {
			try {
				//	Make sure the tag doesn't already exist.
				//	TODO:	Make "name" the Primary Key for tag, remove "id".
				if (!index(username).contains(tag)) {
					return tagRepo.saveAndFlush(tag);
				}
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Tag> index(String username) {
		//	Any user may retrieve a list of all tags.
		if (isUser(username)) {
			return tagRepo.findAll();
		}
		return new ArrayList<>();
	}

	@Override
	public Tag show(String username, int tagId) {
		//	Any user may look up any tag.
		if (isUser(username)) {
			try {
				Optional<Tag> tagOpt = tagRepo.findById(tagId);
				if (tagOpt.isPresent()) {
					return tagOpt.get();
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
	public Tag update(String username, int tagId, Tag tag) {
		//	Only a user with role "admin" may update a tag.
		if (isUser(username) && isAdmin(username)) {
			Optional<Tag> tagOpt = tagRepo.findById(tagId);
			Tag toUpdate = null;
			//	
			if (tagOpt.isPresent()) {
				toUpdate = tagOpt.get();
				Field[] fields = tag.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(tag);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"TagServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("TagServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return tagRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the tag inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int tagId) {
		// Only a user with role "admin" may disable a tag.
		if (isUser(username) && isAdmin(username)) {
			Tag toDisable = show(username, tagId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					tagRepo.save(toDisable);
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
