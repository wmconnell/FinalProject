package com.skilldistillery.squadgoals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Goal;

public interface GoalRepository extends JpaRepository<Goal, Integer> {
	List<Goal> findAllByUserId(int userId);
}
