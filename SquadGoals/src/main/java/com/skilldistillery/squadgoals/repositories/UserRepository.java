package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.User;

public interface UserRepository extends JpaRepository<User, Long> {
	User getUserById(long id);
	User findByUsername(String username);
}
