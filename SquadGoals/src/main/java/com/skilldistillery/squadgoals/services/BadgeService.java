package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Badge;

public interface BadgeService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Badge create(String username, Badge badge);
	//	READ
	Badge show(String username, int badgeId);
	List<Badge> index(String username);
	//	UPDATE
	Badge update(String username, int badgeId, Badge badge);
	//	DELETE
	boolean disable(String username, int badgeId);
}
