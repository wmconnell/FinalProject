package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Squad;

public interface SquadRepository extends JpaRepository<Squad, Integer> {

}
