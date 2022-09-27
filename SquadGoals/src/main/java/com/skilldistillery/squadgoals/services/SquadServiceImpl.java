package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Image;
import com.skilldistillery.squadgoals.entities.Squad;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.ImageRepository;
import com.skilldistillery.squadgoals.repositories.SquadRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class SquadServiceImpl implements SquadService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private SquadRepository squadRepo;
	@Autowired
	private ImageRepository imageRepo;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Squad create(String username, Squad squad) {
		//	Any user may create a squad.
			try {
				//	TODO:	Consider adding a "creator" property to the Squad entity.
				//			squad.setCreator(userRepo.findById(username);
				Image newImage = new Image("https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg", true);
				newImage = imageRepo.saveAndFlush(newImage);
				squad.setProfilePic(newImage);
//				List<User> users = new ArrayList<>(squad.getUsers());
//				squad.setUsers(new ArrayList<>());
				squad.setActive(true);
					
//				for (User user : users) {
					User managedUser = userRepo.findByUsername(username);
					if (managedUser != null) {
						managedUser.addSquad(squad);
						squad.setLeader(managedUser);
						squad = squadRepo.saveAndFlush(squad);
						userRepo.saveAndFlush(managedUser);
					}
//				}
				return show(username, squad.getId());
			}	catch (Exception e) {
				e.printStackTrace();
			}
		return null;
	}
	
	// READ
	@Override
	public List<Squad> index(String username) {
		//	Any user may retrieve a list of all squads.
		//	TODO:	We will implement public/private visibility on the front end.
		//	TODO: 	Consider whether it would be better to instead
		//	create many more specific index methods, such as
		//		- showAllActiveSquads()
		//		- showAllAttendingSquads(int goalId);
		//	This may be advantageous because it is a leaner approach.
		//	Once the user base grows enough, the level of data transfer
		//	could slow the site. In addition, it may be better for security
		//	since its precision means that less data is available at any given time.
		if (isUser(username)) {
			return squadRepo.findAll();
		}
		return new ArrayList<>();
	}
	
	@Override
	public List<Squad> squadsByUser(String username) {
		//	Any user may retrieve a list of all squads.
		//	TODO:	We will implement public/private visibility on the front end.
		//	TODO: 	Consider whether it would be better to instead
		//	create many more specific index methods, such as
		//		- showAllActiveSquads()
		//		- showAllAttendingSquads(int goalId);
		//	This may be advantageous because it is a leaner approach.
		//	Once the user base grows enough, the level of data transfer
		//	could slow the site. In addition, it may be better for security
		//	since its precision means that less data is available at any given time.
		if (isUser(username)) {
			return squadRepo.findSquadByUsers_Username(username);
		}
		return new ArrayList<>();
	}
	
	

	@Override
	public Squad show(String username, int squadId) {
		//	Any user may look up any squad.
		//	TODO:	We will implement public/private visibility on the front end.
		if (isUser(username)) {
			try {
				Optional<Squad> squadOpt = squadRepo.findById(squadId);
				if (squadOpt.isPresent()) {
					return squadOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public Squad getSquadByName(String name) {
		//	Any user may look up any squad.
		//	TODO:	We will implement public/private visibility on the front end.
		Squad squad = null;
			try {
//				Optional<Squad> squadOpt = squadRepo.findById(squadId);
//				if (squadOpt.isPresent()) {
//					return squadOpt.get();
//				}
				return squadRepo.findByName(name);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return squad;
	}

	//	UPDATE
	@SuppressWarnings("unchecked")
	//
	//	This update method allows for a partially defined entity to
	//	be passed as an argument. The method then simply uses this partially
	//	defined entity to overwrite any permissible fields of the target
	//	entity. This is achieved via reflection, as seen in the use of
	//	the Field class and the getDeclaredFields() method, inter alia.
//	@Override
//	public Squad update(String username, int squadId, Squad squad) {
//		//	A user with role "member" can only update a squad to which they belong.
//		//	A user with role "admin" can update any squad.
//		System.out.println("**** UPDATE SQUAD ****");
//		System.out.println(squad.getUsers());
//		System.out.println("**** UPDATE SQUAD ****");
//		if (isUser(username) && (belongsToSquad(username, squadId) || isAdmin(username))) {
//			Optional<Squad> squadOpt = squadRepo.findById(squadId);
//			Squad toUpdate = null;
//			//	
//			if (squadOpt.isPresent()) {
//				toUpdate = squadOpt.get();
//				Field[] fields = squad.getClass().getDeclaredFields();
////				for (Field field : fields) {
////					field.setAccessible(true);
////				try {
////					System.out.println(field +":" + field.get(squad));
////				} catch (IllegalArgumentException e) {
////					// TODO Auto-generated catch block
////					System.out.println(field +"does not exist");
////				} catch (IllegalAccessException e) {
////					// TODO Auto-generated catch block
////					System.out.println(field +"does not exist");
////				}
////				}
//					if(squad.getUsers().size() > 0) {
//						for (User user : squad.getUsers()) {
//							user.addSquad(squad);
//							
//						}
//					}
//					for (Field field : fields) {
//					field.setAccessible(true);
//					Object value = null;
//					try {
//						value = field.get(squad);
//					} catch (IllegalAccessException iae) {
//						System.out.println(
//								"SquadServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
//					} catch (Exception e) {
//						e.printStackTrace();
//					}
//					if (value != null &&
//							!field.getName().equals("id") &&
//							!field.getName().equals("createdDate")) {
//						try {
//						
//							System.out.println(field.getName() + ":" + value);
//							field.set(toUpdate, value);
//						} catch (IllegalAccessException iae) {
//							System.out.println("SquadServiceImpl.update() - Illegal Access Exception: Cannot set "
//									+ field.getName());
//						} catch (Exception e) {
//							e.printStackTrace();
//						}
//					}
//				}
//				System.out.println("*****");
//				return squadRepo.saveAndFlush(toUpdate);
//			}
//		}
//		return null;
//	}
	@Override
	public Squad update(String username, int squadId, Squad squad) {
		//	A user with role "member" can only update a squad to which they belong.
		//	A user with role "admin" can update any squad.
		System.out.println("**** UPDATE SQUAD ****");
		System.out.println(squad.getUsers());
		System.out.println("**** UPDATE SQUAD ****");
		if (isUser(username) && (belongsToSquad(username, squadId) || isAdmin(username))) {
			Optional<Squad> squadOpt = squadRepo.findById(squadId);
			Squad toUpdate = null;
			//	
			if (squadOpt.isPresent()) {
				toUpdate = squadOpt.get();
				Field[] fields = squad.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(squad);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"SquadServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id") &&
							!field.getName().equals("createdDate")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("SquadServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return squadRepo.saveAndFlush(toUpdate);
			}
		}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the squad inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int squadId) {
		// A user with role "member" may only disable a squad to which they belong.
		// A user with role "admin" may disable any squad.
		if (isUser(username) && (belongsToSquad(username, squadId) || isAdmin(username))) {
			Squad toDisable = show(username, squadId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					squadRepo.save(toDisable);
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

	public boolean belongsToSquad(String username, int squadId) {
		//	TODO: Change squad.users to squad.members
		User requestor = getUser(username);
		if (requestor != null) {
			return show(username, squadId).getUsers().contains(requestor);
		}
		return false;
	}

	@Override
	public void addMemberToSquad(int squadId, int memberId, String username) {
		
		
	
	if (isUser(username) && (belongsToSquad(username, squadId) || isAdmin(username))) {
		Optional<Squad> squadOpt = squadRepo.findById(squadId);
		Squad toUpdate = null;
		//	
		if (squadOpt.isPresent()) {
			toUpdate = squadOpt.get();
			Optional<User> userOpt = userRepo.findById(memberId);
			if(userOpt.isPresent()) {
				User user = userOpt.get();
						user.addSquad(toUpdate);
												
				}
		}
			squadRepo.saveAndFlush(toUpdate);
		}
	

}
}
