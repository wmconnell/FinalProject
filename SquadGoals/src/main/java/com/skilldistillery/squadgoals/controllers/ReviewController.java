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

import com.skilldistillery.squadgoals.entities.Review;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.ReviewService;

@RestController
@RequestMapping(path = "api")
public class ReviewController {

	@Autowired
	ReviewService reviewService;

	@Autowired
	AuthService authService;

	@GetMapping("reviews")
	public List<Review> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Review> reviews = new ArrayList<>();
		if (authService.isLoggedInUser(principal.getName())) {
			reviews = reviewService.index(principal.getName());
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return reviews;
	}

	@GetMapping("reviews/{gid}/{uid}")
	public Review show(HttpServletRequest req, HttpServletResponse res, @PathVariable int gid, @PathVariable int uid,
			Principal principal) {
		System.out.println(gid);
		System.out.println(uid);
		Review review = null;
		if (authService.isLoggedInUser(principal.getName())) {
			review = reviewService.show(principal.getName(), gid, uid);
			if (review == null) {
				res.setStatus(404);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return review;
	}

	@PostMapping("reviews/{gid}")
	public Review create(@RequestBody Review review, @PathVariable int gid, HttpServletRequest req,
			HttpServletResponse res, Principal principal) {
		Review created = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.goalExists(gid)) {
				if (authService.belongsToGoal(principal.getName(), gid)
						|| authService.belongsToSquad(principal.getName(), authService.getGoal(gid).getSquads())) {

					try {
						System.out.println("IN REVIEW CONTROLLER CREATE");
						System.out.println("IN REVIEW CONTROLLER CREATE");
						created = reviewService.create(principal.getName(), review, gid);
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
				res.setHeader("Result", "Goal with id " + gid + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return created;
	}

	@PutMapping("reviews/{gid}/{uid}")
	public Review update(HttpServletRequest req, HttpServletResponse res, @PathVariable int gid, @PathVariable int uid,
			@RequestBody Review review, Principal principal) {
		Review updated = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.goalExists(gid)) {
				if (authService.createdReview(principal.getName(), uid) || authService.isAdmin(principal.getName())) {
					if (authService.reviewExists(gid, uid)) {
						try {

							updated = reviewService.update(gid, uid, review);
							res.setStatus(200);
						} catch (Exception e) {
							res.setStatus(400);
							e.printStackTrace();
						}
					} else {
						res.setStatus(404);
						res.setHeader("Error", "Review does not exist");
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Goal with id " + gid + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return updated;
	}

	@DeleteMapping("reviews/{gid}/{uid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int gid, @PathVariable int uid,
			Principal principal) {
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.goalExists(gid)) {
				if (authService.createdReview(principal.getName(), uid) || authService.isAdmin(principal.getName())) {

					boolean deleted = reviewService.disable(principal.getName(), gid, uid);
					if (deleted) {
						res.setStatus(204);
						res.setHeader("Result", "Deactivated review");
					} else {
						res.setStatus(400);
						res.setHeader("Result", "Unable to deactive review");
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Result", "Goal with id " + gid + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
	}

}
