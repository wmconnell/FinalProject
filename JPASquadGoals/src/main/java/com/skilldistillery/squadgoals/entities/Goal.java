package com.skilldistillery.squadgoals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Goal {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String title;
	private String description;
	@CreationTimestamp
	@Column(name = "created_date")
	private LocalDateTime createdDate;
	@UpdateTimestamp
	@Column(name = "updated_date")
	private LocalDateTime updatedDate;
	@Column(name = "completed_date")
	private LocalDateTime completedDate;
	@Column(name = "start_date")
	private LocalDateTime startDate;
	@Column(name = "end_date")
	private LocalDateTime endDate;
	private Boolean completed;
	@Column(name= "public_visibility")
	private Boolean publicVisibility;
	@Column(name= "public_attendance")
	private Boolean publicAttendance;
	private String recurring;
	private Boolean active;
	@OneToMany(mappedBy = "goal")
	@JsonIgnore
	private List<Review> reviews;
	@ManyToMany(mappedBy="goals")
	@JsonIgnoreProperties({"goals", "goalsCreated"})
	private List<User> users;
	@ManyToMany(mappedBy="goals")
	@JsonIgnoreProperties({"goals"})
	private List<Squad> squads;
	@ManyToMany(mappedBy="goals")
	@JsonIgnoreProperties({"goals"})
	private List<Image> images;
	@ManyToOne
	@JoinColumn(name="creator_id")
	@JsonIgnoreProperties({"goalsCreated"})
	private User creator;
	@OneToMany
	@JoinColumn(name="goal_id")
	@JsonIgnoreProperties({"goal"})
	private List<Task> tasks;
	@ManyToMany
	@JoinTable(name = "tag_has_goal", joinColumns = @JoinColumn(name = "tag_id"), inverseJoinColumns = @JoinColumn(name = "goal_id"))
	@JsonIgnore
	private List<Tag> tags;
	

	public Goal() {
		
	}
	
	public Boolean getPublicVisibility() {
		return publicVisibility;
	}
	
	public void setPublicVisibility(Boolean publicVisibility) {
		this.publicVisibility = publicVisibility;
	}
	
	public Boolean getPublicAttendance() {
		return publicAttendance;
	}
	
	public void setPublicAttendance(Boolean publicAttendance) {
		this.publicAttendance = publicAttendance;
	}
	
	public Boolean getActive() {
		return active;
	}
	
	public void setActive(Boolean active) {
		this.active = active;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public LocalDateTime getCompletedDate() {
		return completedDate;
	}

	public void setCompletedDate(LocalDateTime completedDate) {
		this.completedDate = completedDate;
	}

	public LocalDateTime getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDateTime startDate) {
		this.startDate = startDate;
	}

	public LocalDateTime getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}

	public Boolean getCompleted() {
		return completed;
	}

	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}

	public String getRecurring() {
		return recurring;
	}

	public void setRecurring(String recurring) {
		this.recurring = recurring;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
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
			user.addGoal(this);
		}
	}
	
	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeGoal(this);
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
			squad.addGoal(this);
		}
	}
	
	public void removeSquad(Squad squad) {
		if (squads != null && squads.contains(squad)) {
			squads.remove(squad);
			squad.removeGoal(this);
		}
	}
	
	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}
	
	public void addImage(Image image) {
		if (images == null) { 
			images = new ArrayList<>();
		}
		if (!images.contains(image)) {
			images.add(image);
			image.addGoal(this);
		}
	}
	
	public void removeImage(Image image) {
		if (images != null && images.contains(image)) {
			images.remove(image);
			image.removeGoal(this);
		}
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
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
			task.setGoal(this);
		}
	}
	
	public void removeTask(Task task) {
		task.setGoal(null);
		if (tasks != null && tasks.contains(task)) {
			tasks.remove(task);
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
			tag.addGoal(this);
		}
	}
	
	public void removeTag(Tag tag) {
		if (tags != null && tags.contains(tag)) {
			tags.remove(tag);
			tag.removeGoal(this);
		}
	}
}
