package com.skilldistillery.squadgoals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Squad {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	private String bio;
	private Boolean active;
	@Column(name="created_date")
	private LocalDateTime createdDate;
	@ManyToMany(mappedBy="squads")

//	@JsonIgnoreProperties({"squads", "password"})
	@JsonIgnore
	private List<User> users;
	@ManyToMany
	@JoinTable(name = "squad_has_goal", joinColumns = @JoinColumn(name = "squad_id"), inverseJoinColumns = @JoinColumn(name = "goal_id"))
	@JsonIgnore
	private List<Goal> goals;
	@ManyToMany
	@JoinTable(name = "squad_has_task", joinColumns = @JoinColumn(name = "squad_id"), inverseJoinColumns = @JoinColumn(name = "task_id"))
	@JsonIgnore
	private List<Task> tasks;
	@ManyToMany
	@JoinTable(name = "squad_has_tag", joinColumns = @JoinColumn(name = "squad_id"), inverseJoinColumns = @JoinColumn(name = "tag_id"))
	@JsonIgnore
	private List<Tag> tags;
	@ManyToMany
	@JoinTable(name = "badge_has_squad", joinColumns = @JoinColumn(name = "squad_id"), inverseJoinColumns = @JoinColumn(name = "badge_id"))
	@JsonIgnore
	private List<Badge> badges;
	@OneToMany(mappedBy="squad")
	@JsonIgnore
	private List<SquadMessage> squadMessages;
	@OneToOne
	@JoinColumn(name="profile_image_id")
//	@JsonIgnoreProperties({"squad"})
	@JsonIgnore
	private Image profilePic;
	@ManyToOne
	@JoinColumn(name="leader_id")
	@JsonIgnoreProperties({"squads"})
//	@JsonIgnore
	private User leader;


	public Squad() {
		
	}
	
	public LocalDateTime getCreatedDate() {
		return createdDate;
	}
	
	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}
	
	public User getLeader() {
		return leader;
	}
	
	public void setLeader(User leader) {
		this.leader = leader;
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

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public LocalDateTime getCreateDate() {
		return createdDate;
	}

	public void setCreateDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
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
			user.addSquad(this);
		}
	}
	
	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeSquad(this);
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
			goal.addSquad(this);
		}
	}
	
	public void removeGoal(Goal goal) {
		if (goals != null && goals.contains(goal)) {
			goals.remove(goal);
			goal.removeSquad(this);
		}
	}
	

	public List<Task> getTasks() {
		return tasks;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
	
	public void addTask(Task task) {
		if (tasks == null) {
			tasks = new ArrayList<>();
		}
		if (!tasks.contains(task)) {
			tasks.add(task);
			task.addSquad(this);
		}
	}
	
	public void removeTask(Task task) {
		if (tasks != null && tasks.contains(task)) {
			tasks.remove(task);
			task.removeSquad(this);
		}
	}
	

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
	
	public void addTag(Tag tag) {
		if (tags == null) {
			tags = new ArrayList<>();
		}
		if (!tags.contains(tag)) {
			tags.add(tag);
			tag.addSquad(this);
		}
	}
	
	public void removeTag(Tag tag) {
		if (tags != null && tags.contains(tag)) {
			tags.remove(tag);
			tag.removeSquad(this);
		}
	}
	
	public List<Badge> getBadges() {
		return badges;
	}

	public void setBadges(List<Badge> badges) {
		this.badges = badges;
	}
	
	public void addBadge(Badge badge) {
		if (badges == null) {
			badges = new ArrayList<>();
		}
		if (!badges.contains(badge)) {
			badges.add(badge);
			badge.addSquad(this);
		}
	}
	
	public void removeBadge(Badge badge) {
		if (badges != null && badges.contains(badge)) {
			badges.remove(badge);
			badge.removeSquad(this);
		}
	}
	
	public List<SquadMessage> getSquadMessages() {
		return squadMessages;
	}

	public void setSquadMessages(List<SquadMessage> squadMessages) {
		this.squadMessages = squadMessages;
	}
	
	public void addSquadMessage(SquadMessage squadMessage) {
		if (squadMessages == null) {
			squadMessages = new ArrayList<>();
		}
		if (!squadMessages.contains(squadMessage)) {
			squadMessages.add(squadMessage);
			if (squadMessage.getSquad() != null) {
				squadMessage.getSquad().getSquadMessages().remove(squadMessage);
			}
			squadMessage.setSquad(this);
		}
	}

	public Image getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(Image profilePic) {
		this.profilePic = profilePic;
	}

	public void removeSquadMessage(SquadMessage squadMessage) {
		squadMessage.setSquad(null);
		if (squadMessages != null && squadMessages.contains(squadMessage)) {
			squadMessages.remove(squadMessage);
		}
	}

}
