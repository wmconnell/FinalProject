package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Review;

public interface ReviewService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Review create(String username, Review review);
	//	READ
	Review show(String username, int reviewId);
	List<Review> index(String username);
	//	UPDATE
	Review update(String username, int reviewId, Review review);
	//	DELETE
	boolean disable(String username, int reviewId);
}
