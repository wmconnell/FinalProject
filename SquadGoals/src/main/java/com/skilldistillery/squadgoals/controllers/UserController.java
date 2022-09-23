package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({"*", "http://localhost/"})
public class UserController {

	@Autowired 
	UserService userService;
	
	@GetMapping("users")
	public List<User> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		System.out.println("****IN CONTROLLER - INDEX****");
		return userService.index("originaltom");
	}
	
	@GetMapping("users/{id}")
	public User show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		System.out.println(principal);
		User user = userService.show(principal.getName(), id);
		if (user == null) {
			res.setStatus(404);
		}
		return user;
	}
	
	@PutMapping("users/{id}")
	public User update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody User user, Principal principal) {
		User updated = null;
		System.out.println("**** USER UPDATE ****" + principal);
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
		boolean deleted = userService.disable(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
