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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({"*", "http://localhost"})
public class UserController {

	@Autowired 
	private UserService userService;
	 
	@Autowired
	private AuthService authService;
	
	@GetMapping("users")
	public List<User> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		System.out.println("****IN CONTROLLER - INDEX****");
		List<User> users = userService.index("originaltom");
			if (users.size() > 0) {
				res.setStatus(200);
				res.setHeader("Result", "Generated complete user list");
			} else if (users.size() == 0) {
				res.setStatus(404);
				res.setHeader("Result", "No users found.");	
			} else {
				res.setStatus(400);
				res.setHeader("Error", "Unable to generate user list");
			}
		return users;
	}
	
	@GetMapping("users/uid/{id}")
	public User show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		System.out.println(principal);
		User user = null;
		if (authService.isLoggedInUser(principal.getName())) {
			user = userService.show(principal.getName(), id);
			if (user == null) {
				res.setStatus(404);
				res.setHeader("Result", "User with id " + id + " does not exist");	
			} else {
				res.setStatus(200);
				res.setHeader("Result", "Returned user with id " + id);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return user;
	}
	
	@PutMapping("users/{id}")
	public User update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody User user, Principal principal) {
		System.out.println("**** USER UPDATE ****" + principal);
		User updated = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.isSameUser(principal.getName(), id) || authService.isAdmin(principal.getName())) {
				if (authService.userExists(id)) {
					try {
						updated = userService.update(principal.getName(), id, user);
						if (updated == null) {
							throw new Exception();
						} else {
							res.setStatus(200);
							res.setHeader("Result", "Updated user id " + id);
						}
					} catch (Exception e) {
						res.setStatus(400);
						res.setHeader("Error", "Unable to update user id " + id);
						e.printStackTrace();
					}
				} else {
					res.setStatus(404);
					res.setHeader("Result", "User with id " + id + " does not exist");	
				}
			} else {
				res.setStatus(401);
				res.setHeader("Error", "User does not have permission to perform this action");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return updated;
	}
	
	@DeleteMapping("users/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.isSameUser(principal.getName(), id) || authService.isAdmin(principal.getName())) {
				if (authService.userExists(id)) {
					boolean deleted = userService.disable(principal.getName(), id);
					if (deleted) {
						res.setStatus(204);
						res.setHeader("Result", "Deactivated user id " + id);
					}
				} else {
					res.setStatus(404);
					res.setHeader("Result", "User with id " + id + " does not exist");	
				}
			} else {
				res.setStatus(401);
				res.setHeader("Error", "User does not have permission to perform this action");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
	}
	@GetMapping("users/{username}")
	public User show(HttpServletRequest req, HttpServletResponse res, @PathVariable String username, Principal principal) {
		System.out.println(principal);
		System.out.println(username+ "***********");
//		User user = userService.show(principal.getName(), username);
		User user = userService.getUserByUserName(username);
		if (user == null) {
			res.setStatus(404);
		}
		System.out.println(user.getUsername());
		return user;
	}

}
