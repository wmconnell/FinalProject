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

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Task {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
	@ManyToMany(mappedBy="tasks")
	@JsonIgnoreProperties({"tasks"})
	private List<User> users;
	@ManyToMany(mappedBy="tasks")
	@JsonIgnoreProperties({"tasks"})
	private List<Squad> squads;
	@ManyToOne
	@JoinColumn(name="goal_id")
	@JsonIgnoreProperties({"tasks"})
	private Goal goal;
	@ManyToMany
	@JoinTable(name="task_has_task", joinColumns = @JoinColumn(name="task_id"), inverseJoinColumns=@JoinColumn(name="precursor_task_id"))
	private List<Task> prerequisites;

	public Task() {

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
			user.addTask(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeTask(this);
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
			squad.addTask(this);
		}
	}

	public void removeSquad(Squad squad) {
		if (squads != null && squads.contains(squad)) {
			squads.remove(squad);
			squad.removeTask(this);
		}
	}


	public Goal getGoal() {
		return goal;
	}


	public void setGoal(Goal goal) {
		this.goal = goal;
	}
	
	public List<Task> getPrerequisites() {
		return prerequisites;
	}


	public void setTasks(List<Task> prerequisites) {
		this.prerequisites = prerequisites;
	}
	
	public void addTask(Task prerequisite) {
		if (prerequisites == null) {
			prerequisites = new ArrayList<>();
		}
		if (!prerequisites.contains(prerequisite)) {
			prerequisites.add(prerequisite);
			prerequisite.addTask(this);
		}
	}

	public void removeTask(Task prerequisite) {
		if (prerequisites != null && prerequisites.contains(prerequisite)) {
			prerequisites.remove(prerequisite);
			prerequisite.removeTask(this);
		}
	}
	
}
