package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.Squad;

public interface SquadService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	Squad create(String username, Squad squad);
	//	READ
	Squad show(String username, int squadId);
	List<Squad> index(String username);
	List<Squad> squadsByUser(String username);
	//	UPDATE
	Squad update(String username, int squadId, Squad squad);
	//	DELETE
	boolean disable(String username, int squadId);
	void addMemberToSquad(int id, int memberId, String userName);
}
