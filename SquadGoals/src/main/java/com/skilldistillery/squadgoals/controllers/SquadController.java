package com.skilldistillery.squadgoals.controllers;

import java.security.Principal;
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

import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.services.AuthService;
import com.skilldistillery.squadgoals.services.SquadService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost" })
public class SquadController {

	@Autowired
	private SquadService squadService;

	@Autowired
	private AuthService authService;

	@GetMapping("squads")
	public List<Squad> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return squadService.index(principal.getName());
	}

	@GetMapping("squads/user")
	public List<Squad> squadsByUser(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return squadService.squadsByUser(principal.getName());
	}

	@GetMapping("squads/{id}")
	public Squad show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		Squad squad = squadService.show(principal.getName(), id);
		if (squad == null) {
			res.setStatus(404);
		}
		return squad;
	}

	@GetMapping("squads/name/{name}")
	public Squad getSquadByName(HttpServletRequest req, HttpServletResponse res, @PathVariable String name,
			Principal principal) {
		Squad squad = squadService.getSquadByName(name);
		if (squad == null) {
			res.setStatus(404);
		}
		return squad;
	}
	
	@PostMapping("squads/exist")
	public boolean squadExistsByName(@RequestBody Squad squad, HttpServletRequest req, HttpServletResponse res,
			Principal principal) {
		return authService.squadExists(squad.getName());
	}

	@PostMapping("squads")
	public Squad create(@RequestBody Squad squad, HttpServletRequest req, HttpServletResponse res,
			Principal principal) {
		Squad created = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (!authService.squadExists(squad.getName())) {
			try {
				System.out.println("IN SQUAD CONTROLLER CREATE");
//				System.out.println(squad.getUsers());
//				for (User user : squad.getUsers()) {
//					System.out.println(user.getUsername());
//					System.out.println(user.getId());
//				}
				System.out.println("IN SQUAD CONTROLLER CREATE");
				created = squadService.create(principal.getName(), squad);
				System.out.println(created);
				res.setStatus(201);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(created.getId());
				res.setHeader("Location", url.toString());
			} catch (Exception e) {
				res.setStatus(400);
				e.printStackTrace();
			}
			} else {
				res.setStatus(400);
				res.setHeader("Error", "Squad name '" + squad.getName() + "' already taken");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return created;
	}

	@PutMapping("squads/{id}")
	public Squad update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Squad squad,
			Principal principal) {
		Squad updated = null;
		if (authService.isLoggedInUser(principal.getName())) {
			if (authService.squadExists(id)) {
				if (authService.squadNameUnique(squad.getName())) {
					if (authService.belongsToSquad(principal.getName(), Arrays.asList(authService.getSquad(id)))
							|| authService.isAdmin(principal.getName())) {

						try {

							updated = squadService.update(principal.getName(), id, squad);
							res.setStatus(200);
						} catch (Exception e) {
							res.setStatus(400);
							e.printStackTrace();
						}
//		System.out.println(updated.getUsers() + " In controller!!!!!!");
					} else {
						res.setStatus(401);
						res.setHeader("Error", "User does not have permission to perform this action");
					}
				} else {
					res.setStatus(400);
					res.setHeader("Error", "Squad name '" + squad.getName() + "' already taken"); 
				}
			} else {
				res.setStatus(404);
				res.setHeader("Error", "Squad with id " + id + " does not exist");
			}
		} else {
			res.setStatus(401);
			res.setHeader("Error", "Client must be logged in to perform this action");
		}
		return updated;
	}

	@GetMapping("squads/add/{id}/{memberId}")
	public void addMember(HttpServletRequest req, HttpServletResponse res, @PathVariable int id,
			@PathVariable int memberId, Principal principal) {

		try {
			System.out.println("************* in controller memberId: "+memberId+"*******");
			System.out.println(id);
			System.out.println(principal);
			squadService.addMemberToSquad(id, memberId, principal.getName());
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
	}
	@GetMapping("squads/remove/{id}/{memberId}")
	public void removeMember(HttpServletRequest req, HttpServletResponse res, @PathVariable int id,
			@PathVariable int memberId, Principal principal) {
		
		try {
			System.out.println("************* in remove memberId: "+memberId+"*******");
			System.out.println(id);
			System.out.println(principal);
			squadService.removeMemberFromSquad(id, memberId, principal.getName());
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
	}

	@DeleteMapping("squads/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = squadService.disable(principal.getName(), id);
		if (deleted) {
			System.out.println("SUCCESSFULLY DELETED ID " + id + ": " + deleted);
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

}
