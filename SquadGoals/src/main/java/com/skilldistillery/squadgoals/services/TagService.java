package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Tag;

public interface TagService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Tag create(int loginId, Tag tag);
	//	READ
	Tag show(int loginId, int tagId);
	List<Tag> index(int loginId);
	//	UPDATE
	Tag update(int loginId, int tagId, Tag tag);
	//	DELETE
	boolean disable(int loginId, int tagId);
}
