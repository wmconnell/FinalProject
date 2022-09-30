package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
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

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.GoalService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({"*", "http://localhost"})
public class GoalController {

	@Autowired
	private GoalService goalService;

	@Autowired
	private AuthService authService;

//	@PostMapping("goals")
//	public Goal create(@RequestBody Goal goal, HttpServletRequest req, HttpServletResponse res, Principal principal) {
////		System.out.println(" ***IN CONTROLLER*** Num squads: " + goal.getSquads().size());
//		Goal created = null;
////		System.out.println(goal);
//		// ACCESS RULES:
//		// Users may only create a goal for a squad to which they belong.
//		// TODO: Make it so only a leader can create a goal
//		if (authService.isLoggedInUser(principal.getName())) {
//			if (goal.getSquads() != null) {
//				if (authService.squadsExist(goal.getSquads())) {
//					if (authService.belongsToSquad(principal.getName(), goal.getSquads())
//							|| authService.isAdmin(principal.getName())) {
//						try {
//							goal.setCreator(authService.getUser(principal.getName()));
//							System.out.print("JUST ADDED CREATOR TO GOAL");
//							created = goalService.create(principal.getName(), goal);
//							if (created == null) {
//								res.setStatus(400);
//								res.setHeader("Error", "Unable to create new goal");
//							} else {
//								res.setStatus(201);
//								StringBuffer url = req.getRequestURL();
//								url.append("/").append(created.getId());
//								res.setHeader("Location", url.toString());
//								res.setHeader("Result", "Created goal with id " + created.getId());
//							}
//						} catch (Exception e) {
//							res.setStatus(400);
//							res.setHeader("Error", "Unable to create new goal");
//							e.printStackTrace();
//						}
//					} else {
//						res.setStatus(401);
//						res.setHeader("Error", "User does not have permission to perform this action");
//					}
//				} else {
//					res.setStatus(400);
//					res.setHeader("Error", "Entity is associated with one or more non-existent squads.");
//				}
//			} else {
//				res.setStatus(400);
//				res.setHeader("Error", "This entity must be associated with one or more squads.");
//			}
//		} else {
//			res.setStatus(401);
//			res.setHeader("Error", "Client must be logged in to perform this action");
//		}
//		return created;
//	}
	
	@PostMapping("goals/{squadId}")
	public Goal create(@RequestBody Goal goal, @PathVariable int squadId, HttpServletRequest req, HttpServletResponse res, Principal principal) {
//		System.out.println(" ***IN CONTROLLER*** Num squads: " + goal.getSquads().size());
		Goal created = null;
//		System.out.println(goal);
		// ACCESS RULES:
		// Users may only create a goal for a squad to which they belong.
		// TODO: Make it so only a leader can create a goal
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.squadExists(squadId)) {
//				if (authService.squadsExist(goal.getSquads())) {
					if (authService.belongsToSquad(principal.getName(), Arrays.asList(authService.getSquad(squadId)))
							|| authService.isAdmin(principal.getName())) {
						try {
//							goal.setCreator(authService.getUser(principal.getName()));
//							System.out.print("JUST ADDED CREATOR TO GOAL");
							created = goalService.create(principal.getName(), goal, squadId);
							if (created == null) {
								res.setStatus(400);
								res.setHeader("Error", "Unable to create new goal");
							} else {
								res.setStatus(201);
								StringBuffer url = req.getRequestURL();
								url.append("/").append(created.getId());
								res.setHeader("Location", url.toString());
								res.setHeader("Result", "Created goal with id " + created.getId());
							}
						} catch (Exception e) {
							res.setStatus(400);
							res.setHeader("Error", "Unable to create new goal");
							e.printStackTrace();
						}
					} else {
						res.setStatus(401);
						res.setHeader("Error", "User does not have permission to perform this action");
					}
			} else {
				res.setStatus(400);
				res.setHeader("Error", "This entity is associated with a squad that does not exist.");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return created;
	}

	@GetMapping("goals/{id}")
	public Goal show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		// ACCESS RULES:
		// Any user may look up any goal.
		// TODO: We will implement public/private visibility on the front end.
		Goal goal = null;
		if (authService.isLoggedInUser(principal.getName())) {
			goal = goalService.show(principal.getName(), id);
			if (goal == null) {
				res.setStatus(404);
				res.setHeader("Result", "Goal with id " + id + " does not exist");
			} else {
				res.setStatus(200);
				res.setHeader("Result", "Returned goal with id " + id);
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return goal;
	}
	
	@GetMapping("goals/squads/{id}")
	public List<Goal> getGoalBySquad(@PathVariable int id, HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Goal> goals = new ArrayList<>();
		if (authService.isLoggedInUser(principal.getName())) {
			goals = goalService.getGoalBySquad(id);
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return goals;
	}

	@GetMapping("goals")
	public List<Goal> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		// Any user may retrieve a list of all goals, regardless of which squad they
		// belong to.
		// TODO: We will implement visibility on the front end.
		List<Goal> goals = new ArrayList<>();
		if (authService.isLoggedInUser(principal.getName())) {
			goals = goalService.index(principal.getName());
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return goals;
	}

	@PutMapping("goals/{id}")
	public Goal update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Goal goal,
			Principal principal) {
		Goal updated = null;
		// ACCESS RULES:
		// A user with role "member" may only update a goal to which they belong.
		// A user with role "admin" may update any goal.

					try {
						updated = goalService.update(principal.getName(), id, goal);
						if (updated == null) {
							throw new Exception();
						} else {
							res.setStatus(200);
							res.setHeader("Result", "Updated goal id " + id);
						}
					} catch (Exception e) {
						res.setStatus(400);
						res.setHeader("Error", "Unable to update goal id " + id);
						e.printStackTrace();
					}
		
		return updated;
	}

	@DeleteMapping("goals/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		// ACCESS RULES:
		// A user with role "member" can only disable a goal to which they belong.
		// A user with role "admin" can disable any goal.
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.goalExists(id)) {
				if (authService.belongsToGoal(principal.getName(), id) || authService.isAdmin(principal.getName())) {
					boolean deleted = goalService.disable(principal.getName(), id);
					if (deleted) {
						res.setStatus(204);
						res.setHeader("Result", "Deactivated goal id " + id);
					} else {
						res.setStatus(404);
						res.setHeader("Result", "Goal with id " + id + " does not exist");
					}
				} else {
					res.setStatus(401);
					res.setHeader("Error", "User does not have permission to perform this action");
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Goal with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
	}

}
