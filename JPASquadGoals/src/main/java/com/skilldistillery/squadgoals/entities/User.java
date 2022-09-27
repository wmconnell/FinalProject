package com.skilldistillery.squadgoals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String username;
	private String password;
	private String email;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	private String role;
	private String bio;
	private Boolean active; 
	@Column(name = "create_date")
	private LocalDateTime createDate;
	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<Review> reviews;
	@ManyToMany
	@JoinTable(name = "user_has_squad", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "squad_id"))
	@JsonIgnoreProperties({"users", "leader"})
//	@JsonIgnore
	private List<Squad> squads;
	@ManyToMany
	@JoinTable(name = "user_has_goal", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "goal_id"))
	@JsonIgnoreProperties({"reviews", "users", "squads", "images", "creator", "tasks", "tags"})
	private List<Goal> goals;
	@ManyToMany
	@JoinTable(name = "user_has_task", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "task_id"))
	@JsonIgnore
	private List<Task> tasks;
	@ManyToMany
	@JoinTable(name = "badge_has_user", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "badge_id"))
	@JsonIgnore
	private List<Badge> badges;
	@OneToMany(mappedBy="sender")
	@JsonIgnore
	private List<SquadMessage> squadMessages;
	@ManyToMany
	@JoinTable(name = "user_has_tag", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "tag_id"))
	@JsonIgnore
	private List<Tag> tags;
	@OneToOne
	@JoinColumn(name="profile_image_id")
	@JsonIgnoreProperties({"user"})
	private Image profilePic;
	@OneToMany
	@JoinColumn(name = "creator_id")
	@JsonIgnore
	private List<Goal> goalsCreated;
	@OneToMany
	@JoinColumn(name = "leader_id")
	private List<Squad> squadsCreated;
	

	public User() {

	}
	
	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
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

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
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
			squad.addUser(this);
		}
	}

	public void removeSquad(Squad squad) {
		if (squads != null && squads.contains(squad)) {
			squads.remove(squad);
			squad.removeUser(this);
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
			goal.addUser(this);
		}
	}

	public void removeGoal(Goal goal) {
		if (goals != null && goals.contains(goal)) {
			goals.remove(goal);
			goal.removeUser(this);
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
			task.addUser(this);
		}
	}

	public void removeTask(Task task) {
		if (tasks != null && tasks.contains(task)) {
			tasks.remove(task);
			task.removeUser(this);
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
			badge.addUser(this);
		}
	}

	public void removeBadge(Badge badge) {
		if (badges != null && badges.contains(badge)) {
			badges.remove(badge);
			badge.removeUser(this);
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
			if (squadMessage.getSender() != null) {
				squadMessage.getSender().getSquadMessages().remove(squadMessage);
			}
			squadMessage.setSender(this);
		}
	}

	public void removeSquadMessage(SquadMessage squadMessage) {
		squadMessage.setSender(null);
		if (squadMessages != null && squadMessages.contains(squadMessage)) {
			squadMessages.remove(squadMessage);
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
			tag.addUser(this);
		}
	}

	public void removeTag(Tag tag) {
		if (tags != null && tags.contains(tag)) {
			tags.remove(tag);
			tag.removeUser(this);
		}
	}

	public Image getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(Image image) {
		this.profilePic = image;
	}

	public List<Goal> getGoalsCreated() {
		return goalsCreated;
	}

	public void setGoalsCreated(List<Goal> goalsCreated) {
		this.goalsCreated = goalsCreated;
	}

	public void addGoalCreated(Goal goal) {
		if (goalsCreated == null) {
			goalsCreated = new ArrayList<>();
		}
		if (!goalsCreated.contains(goal)) {
			goalsCreated.add(goal);
			goal.setCreator(this);
		}
	}

	public void removeGoalCreated(Goal goal) {
		goal.setCreator(null);
		if (goalsCreated != null && goalsCreated.contains(goal)) {
			goalsCreated.remove(goal);
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(active, id, password, role, username);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(active, other.active) && id == other.id && Objects.equals(password, other.password)
				&& Objects.equals(role, other.role) && Objects.equals(username, other.username);
	}

}
