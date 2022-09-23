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

import com.skilldistillery.squadgoals.entities.User;

@RestController
@RequestMapping(path = "api")
public class UserController {

	@Autowired UserService userService;
	
	@GetMapping("users")
	public Set<User> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return userService.index(principal.getName());
	}
	
	@GetMapping("users/{id}")
	public User show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		User user = userService.show(principal.getName(), id);
		if (user == null) {
			res.setStatus(404);
		}
		return user;
	}
	
	@PostMapping("users")
	public User create(@RequestBody User user, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		User created = null;
		
		try {
			created = userService.create(principal.getName(), user);
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
	
	@PutMapping("users/{id}")
	public User update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody User user, Principal principal) {
		User updated = null;
		
		try {
			updated = userService.update(principal.getName(), id, user);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("users/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = userService.destroy(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}