package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Badge;

public interface BadgeRepository extends JpaRepository<Badge, Integer> {

}
