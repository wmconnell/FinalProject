package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Goal;
import com.skilldistillery.squadgoals.entities.Review;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.ReviewRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private ReviewRepository reviewRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Review create(String username, Review review) {
		//	Users may only create a review for a goal to which they belong.
		
		if (isUser(username) && review.getGoal() != null && belongsToGoal(username, review.getGoal())) {
			try {
				review.setUser(getUser(username));
				return reviewRepo.saveAndFlush(review);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	// READ
	@Override
	public List<Review> index(String username) {
		//	Any user may view any review for any goal.
		//	TODO:	We will implement additional visibility options on the front end.
		if (isUser(username)) {
			try {
				return reviewRepo.findAll();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ArrayList<>();
	}

	@Override
	public Review show(String username, int reviewId) {
		//	Any user may look up any review.
		//	TODO:	We will implement additional visibility on the front end.
		if (isUser(username)) {
			try {
				Optional<Review> reviewOpt = reviewRepo.findById(reviewId);
				if (reviewOpt.isPresent()) {
					return reviewOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	//	UPDATE
	//
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
	@Override
	public Review update(String username, int reviewId, Review review) {
		//	A user with role "member" can only update a review that they created.
		//	A user with role "admin" can update any review.
		if (isUser(username) && (createdReview(username, reviewId) || isAdmin(username))) {
			Optional<Review> reviewOpt = reviewRepo.findById(reviewId);
			Review toUpdate = null;
			//	
			if (reviewOpt.isPresent()) {
				toUpdate = reviewOpt.get();
				Field[] fields = review.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(review);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"ReviewServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id") &&
							!field.getName().equals("reviewDate") &&
							!field.getName().equals("goal") &&
							!field.getName().equals("user")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("ReviewServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return reviewRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the review inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int reviewId) {
		// A user with role "member" can only disable a review they created.
		// A user with role "admin" can disable any review.
		if (isUser(username) && (createdReview(username, reviewId) || isAdmin(username))) {
			Review toDisable = show(username, reviewId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					reviewRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	// Helper Methods
	//
	// The following methods ensure that the user requesting an action is
	// logged in and authorized to perform the given action.
	// Outsourcing the logic to these methods makes the code in the CRUD
	// methods read more like the actual problem.
	public User getUser(String username) {
		return userRepo.findByUsername(username);
	}
	
	public boolean isUser(String username) {
		return userRepo.existsByUsername(username);
	}

	public boolean isAdmin(String username) {
		return getUser(username).getRole().equals("admin");
	}
	
	public boolean belongsToGoal(String username, Goal goal) {
		User requestor = getUser(username);
		if (requestor != null) {
			return goal.getUsers().contains(requestor);
		}
		return false;
	}

	public boolean createdReview(String username, int reviewId) {
		User requestor = getUser(username);
		if (requestor != null) {
			return show(username, reviewId).getUser().getId() == reviewId;
		}
		return false;
	}
}
