package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Image;

public interface ImageService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Image create(int loginId, Image image);
	//	READ
	Image show(int loginId, int imageId);
	List<Image> index(int loginId);
	//	UPDATE
	Image update(int loginId, int imageId, Image image);
	//	DELETE
	boolean disable(int loginId, int imageId);
}
