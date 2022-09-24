package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Review;
import com.skilldistillery.squadgoals.entities.ReviewId;

public interface ReviewRepository extends JpaRepository<Review, ReviewId> {

	
}
