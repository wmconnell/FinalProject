package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
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

import com.skilldistillery.squadgoals.entities.Badge;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.services.BadgeService;

@RestController
@RequestMapping(path = "api")
public class BadgeController {

	@Autowired BadgeService badgeService;
	
	@GetMapping("badges")
	public List<Badge> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return badgeService.index(principal.getName());
	}
	
	@GetMapping("badges/{id}")
	public Badge show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Badge badge = badgeService.show(principal.getName(), id);
		if (badge == null) {
			res.setStatus(404);
		}
		return badge;
	}
	
	@PostMapping("badges")
	public Badge create(@RequestBody Badge badge, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Badge created = null;
		
		try {
			System.out.println("IN BADGE CONTROLLER CREATE");
			System.out.println("IN BADGE CONTROLLER CREATE");
			created = badgeService.create(principal.getName(), badge);
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
	
	@PutMapping("badges/{id}")
	public Badge update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Badge badge, Principal principal) {
		Badge updated = null;
		
		try {
			
			updated = badgeService.update(principal.getName(), id, badge);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("badges/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = badgeService.disable(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
