package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Task;

public interface TaskService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Task create(int loginId, Task task);
	//	READ
	Task show(int loginId, int taskId);
	List<Task> index(int loginId);
	//	UPDATE
	Task update(int loginId, int taskId, Task task);
	//	DELETE
	boolean disable(int loginId, int taskId);
}
