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

import com.skilldistillery.squadgoals.entities.Tag;
import com.skilldistillery.squadgoals.services.TagService;

@RestController
@RequestMapping(path = "api")
public class TagController {

	@Autowired TagService tagService;
	
	@GetMapping("tags")
	public List<Tag> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return tagService.index(principal.getName());
	}
	
	@GetMapping("tags/{id}")
	public Tag show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Tag tag = tagService.show(principal.getName(), id);
		if (tag == null) {
			res.setStatus(404);
		}
		return tag;
	}
	
	@PostMapping("tags")
	public Tag create(@RequestBody Tag tag, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Tag created = null;
		
		try {
			System.out.println("IN TAG CONTROLLER CREATE");
			System.out.println("IN TAG CONTROLLER CREATE");
			created = tagService.create(principal.getName(), tag);
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
	
	@PutMapping("tags/{id}")
	public Tag update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Tag tag, Principal principal) {
		Tag updated = null;
		
		try {
			
			updated = tagService.update(principal.getName(), id, tag);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updated;
	}
	
	@DeleteMapping("tags/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = tagService.disable(principal.getName(), id);
		if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}
	
	
	
}
