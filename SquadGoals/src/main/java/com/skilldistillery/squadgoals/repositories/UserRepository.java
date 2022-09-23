package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User getUserById(int id);
	User findByUsername(String username);
	boolean existsByUsername(String username);
	boolean existsByEmail(String email);
}
