package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Image;

public interface ImageService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Image create(String username, Image image);
	//	READ
	Image show(String username, int imageId);
	List<Image> index(String username);
	//	UPDATE
	Image update(String username, int imageId, Image image);
	//	DELETE
	boolean disable(String username, int imageId);
}
