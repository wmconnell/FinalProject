package com.skilldistillery.squadgoals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User getUserById(int id);
	User findByUsername(String username);
	List<User> findAllBySquads_Id(int squadId);
	boolean existsByUsername(String username);
	boolean existsByEmail(String email);
}
