package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Review;

public interface ReviewService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Review create(int loginId, Review review);
	//	READ
	Review show(int loginId, int reviewId);
	List<Review> index(int loginId);
	//	UPDATE
	Review update(int loginId, int reviewId, Review review);
	//	DELETE
	boolean disable(int loginId, int reviewId);
}
