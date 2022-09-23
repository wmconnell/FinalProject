package com.skilldistillery.squadgoals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.squadgoals.entities.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {

}
