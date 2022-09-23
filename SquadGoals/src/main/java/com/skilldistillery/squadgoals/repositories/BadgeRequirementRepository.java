package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.BadgeRequirement;

public interface BadgeRequirementRepository extends JpaRepository<BadgeRequirement, Integer> {

}
