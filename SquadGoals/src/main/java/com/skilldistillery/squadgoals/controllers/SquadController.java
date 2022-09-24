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

import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.services.SquadService;

@RestController
@RequestMapping(path = "api")
public class SquadController {

	@Autowired SquadService squadService;
	
	@GetMapping("squads")
	public List<Squad> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return squadService.index(principal.getName());
	}
	
	@GetMapping("squads/{id}")
	public Squad show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Squad squad = squadService.show(principal.getName(), id);
		if (squad == null) {
			res.setStatus(404);
		}
		return squad;
	}
	
	@PostMapping("squads")
	public Squad create(@RequestBody Squad squad, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Squad created = null;
		
		try {
			System.out.println("IN SQUAD CONTROLLER CREATE");
			for (User user: squad.getUsers()) {
				System.out.println(user.getUsername());
				System.out.println(user.getId());
			}
			System.out.println("IN SQUAD CONTROLLER CREATE");
			created = squadService.create(principal.getName(), squad);
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
	
	@PutMapping("squads/{id}")
	public Squad update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Squad squad, Principal principal) {
		Squad updated = null;
		
		try {
			
			updated = squadService.update(principal.getName(), id, squad);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("squads/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = squadService.disable(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
