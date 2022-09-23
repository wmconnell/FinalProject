package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Squad;

public interface SquadService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Squad create(int loginId, Squad squad);
	//	READ
	Squad show(int loginId, int squadId);
	List<Squad> index(int loginId);
	//	UPDATE
	Squad update(int loginId, int squadId, Squad squad);
	//	DELETE
	boolean disable(int loginId, int squadId);
}
