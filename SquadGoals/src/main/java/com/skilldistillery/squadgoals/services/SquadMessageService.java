package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.SquadMessage;

public interface SquadMessageService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	SquadMessage create(String username, SquadMessage squadMessage);
	//	READ
	SquadMessage show(String username, int squadMessageId);
	List<SquadMessage> index(String username);
	//	UPDATE
	SquadMessage update(String username, int squadMessageId, SquadMessage squadMessage);
	//	DELETE
	SquadMessage disable(String username, int squadMessageId);
}
