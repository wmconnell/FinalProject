package com.skilldistillery.squadgoals.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Tag {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;
	private Boolean active;
	@ManyToMany(mappedBy="tags")
	@JsonIgnoreProperties({"tags"})
	private List<User> users;
	@ManyToMany(mappedBy="tags")
	@JsonIgnoreProperties({"tags"})
	private List<Squad> squads;
	@ManyToMany(mappedBy="tags")
	@JsonIgnoreProperties({"tags"})
	private List<Goal> goals;
	
	public Tag() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public void addUser(User user) {
		if (users == null) {
			users = new ArrayList<>();
		}
		if (!users.contains(user)) {
			users.add(user);
			user.addTag(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeTag(this);
		}
	}
	
	public List<Squad> getSquads() {
		return squads;
	}

	public void setSquads(List<Squad> squads) {
		this.squads = squads;
	}

	public void addSquad(Squad squad) {
		if (squads == null) {
			squads = new ArrayList<>();
		}
		if (!squads.contains(squad)) {
			squads.add(squad);
			squad.addTag(this);
		}
	}

	public void removeSquad(Squad squad) {
		if (squads != null && squads.contains(squad)) {
			squads.remove(squad);
			squad.removeTag(this);
		}
	}
	
	public List<Goal> getGoals() {
		return goals;
	}

	public void setGoals(List<Goal> goals) {
		this.goals = goals;
	}
	
	public void addGoal(Goal goal) {
		if (goals == null) { 
			goals = new ArrayList<>();
		}
		if (!goals.contains(goal)) {
			goals.add(goal);
			goal.addTag(this);
		}
	}
	
	public void removeGoal(Goal goal) {
		if (goals != null && goals.contains(goal)) {
			goals.remove(goal);
			goal.removeTag(this);
		}
	}
	
}
