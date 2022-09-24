package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Review;

public interface ReviewService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Review create(String username, Review review, int gid);
	//	READ
	Review show(String username, int goalId, int userId);
	List<Review> index(String username);
	//	UPDATE
	Review update(int goalId, int userId, Review review);
	//	DELETE
	boolean disable(String username, int goalId, int userId);
}
