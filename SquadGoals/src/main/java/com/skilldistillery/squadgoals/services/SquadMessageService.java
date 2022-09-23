package com.skilldistillery.squadgoals.services;

import java.util.List;

import com.skilldistillery.squadgoals.entities.SquadMessage;

public interface SquadMessageService {
	//	Login Id included with each method to ensure that a user is logged in and has
	//	the appropriate permissions to perform the requested action.
	
	//	CREATE
	SquadMessage create(int loginId, SquadMessage squadMessage);
	//	READ
	SquadMessage show(int loginId, int squadMessageId);
	List<SquadMessage> index(int loginId);
	//	UPDATE
	SquadMessage update(int loginId, int squadMessageId, SquadMessage squadMessage);
	//	DELETE
	SquadMessage disable(int loginId, int squadMessageId);
}
