package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.BadgeRequirement;

public interface BadgeRequirementService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	BadgeRequirement create(int loginId, BadgeRequirement badgeRequirement);
	//	READ
	BadgeRequirement show(int loginId, int badgeRequirementId);
	List<BadgeRequirement> index(int loginId);
	//	UPDATE
	BadgeRequirement update(int loginId, int badgeRequirementId, BadgeRequirement badgeRequirement);
	//	DELETE
	boolean disable(int loginId, int badgeRequirementId);
}
