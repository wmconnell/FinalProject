package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Image;

public interface ImageRepository extends JpaRepository<Image, Integer> {

}
