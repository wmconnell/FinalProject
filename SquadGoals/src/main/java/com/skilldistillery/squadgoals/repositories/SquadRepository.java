package com.skilldistillery.squadgoals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Squad;

public interface SquadRepository extends JpaRepository<Squad, Integer> {

	List<Squad> findSquadByUsers_Username(String username);
}
