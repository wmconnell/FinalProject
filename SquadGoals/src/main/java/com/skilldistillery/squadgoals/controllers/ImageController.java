package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
import java.util.ArrayList;
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

import com.skilldistillery.squadgoals.entities.Image;
import com.skilldistillery.squadgoals.entities.Task;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.ImageService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost:4200/"})
public class ImageController {

	@Autowired
	private ImageService imageService;

	@Autowired
	private AuthService authService;

	@GetMapping("images")
	public List<Image> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Image> images = new ArrayList<>();
		if (authService.isLoggedInUser(principal.getName())) {
			images = imageService.index(principal.getName());
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return images;
	}

	@GetMapping("images/{id}")
	public Image show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Image image = null;
		if (authService.isLoggedInUser(principal.getName())) {
			image = imageService.show(principal.getName(), id);
			if (image == null) {
				res.setStatus(404);
				res.setHeader("Result", "Image with id " + id + " does not exist");
			} else {
				res.setStatus(200);
				res.setHeader("Result", "Returned image with id " + id);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return image;
	}

	@GetMapping("images/squad/{squadId}")
	public Image getImageBySquad(HttpServletRequest req, HttpServletResponse res, @PathVariable int squadId, Principal principal) {
		Image image = null;
		if (authService.isLoggedInUser(principal.getName())) {
			image = imageService.getImageBySquad(squadId);
			if (image == null) {
				res.setStatus(404);
				res.setHeader("Result", "Squad id " + squadId + " has no associated image");
			} else {
				res.setStatus(200);
				res.setHeader("Result", "Returned image for squad id " + squadId);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		System.out.println("Image for squad " + squadId + ": " + image.getUrl());
		return image;
	}

	@PostMapping("images")
	public Image create(@RequestBody Image image, HttpServletRequest req, HttpServletResponse res,
			Principal principal) {
		Image created = null;
		if (authService.isLoggedInUser(principal.getName())) {
			try {
				created = imageService.create(principal.getName(), image);
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
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return created;
	}

	@PutMapping("images/{id}")
	public Image update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Image image,
			Principal principal) {
		Image updated = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.imageExists(id)) {
				if (authService.isUserProfilePic(principal.getName(), id) || authService.isAdmin(principal.getName())) {
					try {
						updated = imageService.update(principal.getName(), id, image);
						if (updated == null) {
							throw new Exception();
						} else {
							res.setStatus(200);
							res.setHeader("Result", "Updated image id " + id);
						}
					} catch (Exception e) {
						res.setStatus(400);
						res.setHeader("Error", "Unable to update image id " + id);
						e.printStackTrace();
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Image with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return updated;
	}

	@DeleteMapping("images/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.imageExists(id)) {
				if (authService.isUserProfilePic(principal.getName(), id) || authService.isAdmin(principal.getName())) {
					try {
						boolean deleted = imageService.disable(principal.getName(), id);
						if (deleted) {
							res.setStatus(204);
							res.setHeader("Result", "Deactivated image id " + id);
						} else {
							res.setStatus(404);
							res.setHeader("Result", "Image with id " + id + " does not exist");
						}
					} catch (Exception e) {
						res.setStatus(400);
						res.setHeader("Error", "Unable to disable image id " + id);
						e.printStackTrace();
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Image with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
	}

}
