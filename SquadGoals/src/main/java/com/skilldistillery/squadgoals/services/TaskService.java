package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Task;

public interface TaskService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Task create(String username, Task task);
	//	READ
	Task show(String username, int taskId);
	List<Task> index(String username);
	//	UPDATE
	Task update(String username, int taskId, Task task);
	//	DELETE
	boolean disable(String username, int taskId);
}
