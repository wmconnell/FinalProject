package com.skilldistillery.squadgoals.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.squadgoals.entities.Image;
import com.skilldistillery.squadgoals.entities.User;
import com.skilldistillery.squadgoals.repositories.ImageRepository;
import com.skilldistillery.squadgoals.repositories.UserRepository;

@Service
public class ImageServiceImpl implements ImageService {
	@Autowired
	private UserRepository userRepo;	//	For authentication
	@Autowired
	private ImageRepository imageRepo;
	@Autowired
	private AuthService authService;

	// CRUD Methods
	//
	// CREATE
	@Override
	public Image create(String username, Image image) {
		//	Users may only create an image for their account.
		//	Goal images are added by calling the GoalServiceImpl.update() method		TODO: Change this?
		//	Review images are added by calling the ReviewServiceImpl.update() method	TODO: Change this?
			try {
				image.setUser(authService.getUser(username));
				image.setActive(true);
				return imageRepo.saveAndFlush(image);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		return null;
	}
	
	// READ
	@Override
	public List<Image> index(String username) {
		//	Any user may retrieve all images.
		//	TODO:	We will implement visibility on the front end.
		//	TODO: 	Consider whether it would be better to instead
		//	create many more specific index methods, such as
		//		- showAllImagesAssociatedWithUserGoals()
		//		- showAllImagesAssociatedWithUserReviews()
		//	This may be advantageous because it is a leaner approach.
		//	Once the user base grows enough, the level of data transfer
		//	could slow the site. In addition, it may be better for security
		//	since its precision means that less data is available at any given time.
			try {
				return imageRepo.findAll();
			} catch (Exception e) {
				e.printStackTrace();
			}
		return new ArrayList<>();
	}

	@Override
	public Image show(String username, int imageId) {
		//	Any user may look up any image.
		//	TODO: 	Refine this
			try {
				Optional<Image> imageOpt = imageRepo.findById(imageId);
				if (imageOpt.isPresent()) {
					return imageOpt.get();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return null;
	}

	@Override
	public Image getImageBySquad(int squadId) {
		//	Any user may look up any image.
		//	TODO: 	Refine this
			try {
				return imageRepo.findBySquad_Id(squadId);
			} catch (Exception e) {
				e.printStackTrace();
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
	public Image update(String username, int imageId, Image image) {
		//	A user with role "member" can only update their profile image.
		//	TODO: What about images associated with goals to which they belong or reviews they made?
		//	A user with role "admin" can update any image.
		
			Optional<Image> imageOpt = imageRepo.findById(imageId);
			Image toUpdate = null;
			//	
			if (imageOpt.isPresent()) {
				toUpdate = imageOpt.get();
				Field[] fields = image.getClass().getDeclaredFields();
				for (Field field : fields) {
					field.setAccessible(true);
					Object value = null;
					try {
						value = field.get(image);
					} catch (IllegalAccessException iae) {
						System.out.println(
								"ImageServiceImpl.update() - Illegal Access Exception: Cannot get " + field.getName());
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (value != null &&
							!field.getName().equals("id")) {
						try {
							field.set(toUpdate, value);
						} catch (IllegalAccessException iae) {
							System.out.println("ImageServiceImpl.update() - Illegal Access Exception: Cannot set "
									+ field.getName());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return imageRepo.saveAndFlush(toUpdate);
			}
		return null;
	}

	// DELETE
	//
	// Note: "Delete" functionality is implemented by rendering the image inactive,
	// making the action reversible.
	//
	// TODO: Consider providing the user with two options: a pause and a true delete.
	//
	@Override
	public boolean disable(String username, int imageId) {
		// A user with role "member" can only disable their own profile pic.
		// A user with role "admin" can disable any image.
			Image toDisable = show(username, imageId);
			if (toDisable != null) {
				try {
					toDisable.setActive(false);
					imageRepo.save(toDisable);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		return false;
	}

		
}
