package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.squadgoals.entities.Task;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.TaskService;

@RestController
@RequestMapping(path = "api")
public class TaskController {

	@Autowired
	private TaskService taskService;

	@Autowired
	private AuthService authService;

	// CREATE
	//
	// ACCESS RULES:
	// Users may only create a task for a goal to which they belong.
	@PostMapping("tasks")
	public Task create(@RequestBody Task task, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		// Users may only create a task for a goal to which they belong.
		Task created = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.goalExists(task.getGoal().getId())) {
				if (authService.belongsToGoal(principal.getName(), task.getGoal().getId())
						|| authService.isAdmin(principal.getName())) {

					try {
						created = taskService.create(principal.getName(), task);
						res.setStatus(201);
						StringBuffer url = req.getRequestURL();
						url.append("/").append(created.getId());
						res.setHeader("Location", url.toString());
					} catch (Exception e) {
						res.setStatus(400);
						e.printStackTrace();
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Goal with id " + task.getGoal().getId() + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return created;
	}

	// READ
	//
	// ACCESS RULES:
	// A user may only retrieve a list of tasks for a goal to which they belong.
	// TODO: We will implement additional visibility options on the front end.
	@GetMapping("tasks")
	public List<Task> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Task> tasks = new ArrayList<>();
		if (authService.isLoggedInUser(principal.getName())) {
			tasks = taskService.index(principal.getName());
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return tasks;
	}

	@GetMapping("tasks/{id}")
	public Task show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Task task = null;
		if (authService.isLoggedInUser(principal.getName())) {
			task = taskService.show(principal.getName(), id);
			if (task == null) {
				res.setStatus(404);
				res.setHeader("Result", "Task with id " + id + " does not exist");
			} else {
				res.setStatus(200);
				res.setHeader("Result", "Returned task with id " + id);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return task;
	}

	// UPDATE
	//
	// ACCESS RULES:
	// Any user may look up any task that belongs to a goal to which the user also
	// belongs.
	// TODO: We will implement additional visibility on the front end.
	@PutMapping("tasks/{id}")
	public Task update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Task task,
			Principal principal) {
		Task updated = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.taskExists(id)) {
				if (authService.assignedToTask(principal.getName(), id) || authService.isAdmin(principal.getName())) {
					try {
						updated = taskService.update(principal.getName(), id, task);
						if (updated == null) {
							throw new Exception();
						} else {
							res.setStatus(200);
							res.setHeader("Result", "Updated task id " + id);
						}
					} catch (Exception e) {
						res.setStatus(400);
						res.setHeader("Error", "Unable to update task id " + id);
						e.printStackTrace();
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Task with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return updated;
	}

	// DELETE
	//
	// ACCESS RULES:
	// A user with role "member" can only disable a task assigned to them.
	// A user with role "admin" can disable any task.
	@DeleteMapping("tasks/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.taskExists(id)) {
				if (authService.assignedToTask(principal.getName(), id) || authService.isAdmin(principal.getName())) {
					boolean deleted = taskService.disable(principal.getName(), id);
					if (deleted) {
						res.setStatus(204);
						res.setHeader("Result", "Deactivated task id " + id);
					} else {
						res.setStatus(404);
						res.setHeader("Result", "Task with id " + id + " does not exist");
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Task with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
	}
}
