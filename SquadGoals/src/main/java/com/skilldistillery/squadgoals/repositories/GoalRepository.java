package com.skilldistillery.squadgoals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.User;

public interface GoalRepository extends JpaRepository<Goal, Integer> {
	List<Goal> findAllByUsers_Username(String username);
	Goal getGoalById(int id);
}
