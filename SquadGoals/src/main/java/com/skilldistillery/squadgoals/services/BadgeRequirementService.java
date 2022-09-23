package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.BadgeRequirement;

public interface BadgeRequirementService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	BadgeRequirement create(String username, BadgeRequirement badgeRequirement);
	//	READ
	BadgeRequirement show(String username, int badgeRequirementId);
	List<BadgeRequirement> index(String username);
	//	UPDATE
	BadgeRequirement update(String username, int badgeRequirementId, BadgeRequirement badgeRequirement);
	//	DELETE
	boolean disable(String username, int badgeRequirementId);
}
