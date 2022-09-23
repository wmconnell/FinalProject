package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Tag;

public interface TagRepository extends JpaRepository<Tag, Integer> {

}
