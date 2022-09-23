package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Task;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.GoalRepository;
import com.skilldistillery.squadgoals.repositories.TaskRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class TaskServiceImpl implements TaskService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private GoalRepository goalRepo;
	@Autowired
	private TaskRepository taskRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Task create(String username, Task task) {
		//	Users may only create a task for a goal to which they belong.
		if (isUser(username) && belongsToGoal(username, task.getGoal())) {
			try {
				//	TODO:	Consider adding a "creator" property to the Task entity.
				//			task.setCreator(userRepo.findById(username);
				return taskRepo.saveAndFlush(task);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Task> index(String username) {
		//	A user may only retrieve a list of tasks for a goal to which they belong.
		//	TODO:	We will implement additional visibility options on the front end.
		List<Task> tasks = new ArrayList<>();
		if (isUser(username)) {
			try {
				List<Goal> goals = goalRepo.findAllByUsers_Username(username);
				//	If user belongs to any goals
				if (goals.size() > 0) {
					//	Compile a list of all tasks associated with those goals,
					//	regardless of the user to which the task is assigned.
					for (Goal goal : goals) {
						tasks.addAll(goal.getTasks());
					}
					return tasks;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return tasks;
	}

	@Override
	public Task show(String username, int taskId) {
		//	Any user may look up any task that belongs to a goal to which the user also belongs.
		//	TODO:	We will implement additional visibility on the front end.
		if (isUser(username) && (taskBelongsToUserGoals(username, taskId) || isAdmin(username))) {
			try {
				Optional<Task> taskOpt = taskRepo.findById(taskId);
				if (taskOpt.isPresent()) {
					return taskOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	//	UPDATE
	//
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public Task update(String username, int taskId, Task task) {
		//	A user with role "member" can only update a task assigned to them.
		//	A user with role "admin" can update any task.
		if (isUser(username) && (assignedToTask(username, taskId) || isAdmin(username))) {
			Optional<Task> taskOpt = taskRepo.findById(taskId);
			Task toUpdate = null;
			//	
			if (taskOpt.isPresent()) {
				toUpdate = taskOpt.get();
				Field[] fields = task.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(task);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"TaskServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id") &&
							!field.getName().equals("createdDate") &&
							!field.getName().equals("updatedDate")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("TaskServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return taskRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the task inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int taskId) {
		// A user with role "member" can only disable a task assigned to them.
		// A user with role "admin" can disable any task.
		if (isUser(username) && (assignedToTask(username, taskId) || isAdmin(username))) {
			Task toDisable = show(username, taskId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					taskRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	// Helper Methods
	//
	// The following methods ensure that the user requesting an action is
	// logged in and authorized to perform the given action.
	// Outsourcing the logic to these methods makes the code in the CRUD
	// methods read more like the actual problem.
	public User getUser(String username) {
		return userRepo.findByUsername(username);
	}
	
	public Task getTask(int taskId) {
		Optional<Task> taskOpt = taskRepo.findById(taskId);
		return taskOpt.isPresent() ? taskOpt.get() : null;
	}
	
	public boolean isUser(String username) {
		return userRepo.existsByUsername(username);
	}

	public boolean isAdmin(String username) {
		return getUser(username).getRole().equals("admin");
	}
	
	public boolean belongsToGoal(String username, Goal goal) {
		User requestor = getUser(username);
		if (requestor != null) {
			return goal.getUsers().contains(requestor);
		}
		return false;
	}

	public boolean assignedToTask(String username, int taskId) {
		User requestor = getUser(username);
		if (requestor != null) {
			return show(username, taskId).getUsers().contains(requestor);
		}
		return false;
	}
	
	public boolean taskBelongsToUserGoals(String username, int taskId) {
		Task task = getTask(taskId);
		return index(username).contains(task);
	}
}
