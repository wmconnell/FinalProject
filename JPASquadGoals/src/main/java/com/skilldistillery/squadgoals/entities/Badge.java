package com.skilldistillery.squadgoals.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Badge {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;
	@ManyToMany(mappedBy="badges")
	@JsonIgnoreProperties({"badges"})
	private List<User> users;
	@ManyToMany(mappedBy="badges")
	@JsonIgnoreProperties({"badges"})
	private List<Squad> squads;
	@OneToMany(mappedBy="badge")
	private List<BadgeRequirement> requirements;

	public Badge() {
		
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
			user.addBadge(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeBadge(this);
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
			squad.addBadge(this);
		}
	}

	public void removeSquad(Squad squad) {
		if (squads != null && squads.contains(squad)) {
			squads.remove(squad);
			squad.removeBadge(this);
		}
	}
	
	public List<BadgeRequirement> getBadgeRequirements() {
		return requirements;
	}

	public void setBadgeRequirements(List<BadgeRequirement> requirements) {
		this.requirements = requirements;
	}

	public void addBadgeRequirement(BadgeRequirement requirement) {
		if (requirements == null) {
			requirements = new ArrayList<>();
		}
		if (!requirements.contains(requirement)) {
			requirements.add(requirement);
			requirement.setBadge(this);
		}
	}

	public void removeBadgeRequirement(BadgeRequirement requirement) {
		requirement.setBadge(null);
		if (requirements != null && requirements.contains(requirement)) {
			requirements.remove(requirement);
		}
	}
}
