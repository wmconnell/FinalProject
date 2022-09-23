package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Badge;

public interface BadgeService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Badge create(int loginId, Badge badge);
	//	READ
	Badge show(int loginId, int badgeId);
	List<Badge> index(int loginId);
	//	UPDATE
	Badge update(int loginId, int badgeId, Badge badge);
	//	DELETE
	boolean disable(int loginId, int badgeId);
}
