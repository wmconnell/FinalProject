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

import com.skilldistillery.squadgoals.entities.Goal;

@RestController
@RequestMapping(path = "api")
public class GoalController {

	@Autowired GoalService goalService;
	
	@GetMapping("goals")
	public Set<Goal> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return goalService.index(principal.getName());
	}
	
	@GetMapping("goals/{id}")
	public Goal show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Goal goal = goalService.show(principal.getName(), id);
		if (goal == null) {
			res.setStatus(404);
		}
		return goal;
	}
	
	@PostMapping("users")
	public Goal create(@RequestBody Goal goal, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Goal created = null;
		
		try {
			created = goalService.create(principal.getName(), user);
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
	
	@PutMapping("goals/{id}")
	public Goal update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Goal goal, Principal principal) {
		Goal updated = null;
		
		try {
			updated = goalService.update(principal.getName(), id, goal);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("goals/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = goalService.destroy(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
