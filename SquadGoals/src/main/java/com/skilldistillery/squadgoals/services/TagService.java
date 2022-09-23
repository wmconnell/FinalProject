package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Tag;

public interface TagService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Tag create(String username, Tag tag);
	//	READ
	Tag show(String username, int tagId);
	List<Tag> index(String username);
	//	UPDATE
	Tag update(String username, int tagId, Tag tag);
	//	DELETE
	boolean disable(String username, int tagId);
}
