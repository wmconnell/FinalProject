package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
import java.util.Set;

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

@RestController
@RequestMapping(path = "api")
public class TaskController {

	@Autowired TaskService taskService;
	
	@GetMapping("tasks")
	public Set<Task> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return taskService.index(principal.getName());
	}
	
	@PostMapping("tasks")
	public Task create(@RequestBody Task task, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Task created = null;
		
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
		return created;
	}
	
	@PutMapping("tasks/{id}")
	public Task update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Task task, Principal principal) {
		Task updated = null;
		
		try {
			updated = taskService.update(principal.getName(), id, task);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("tasks/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = taskService.destroy(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
