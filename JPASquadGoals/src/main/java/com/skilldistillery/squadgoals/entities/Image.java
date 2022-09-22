package com.skilldistillery.squadgoals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Image {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String url;
	@OneToOne(mappedBy="profilePic")
	@JsonIgnoreProperties({"profilePic"})
	private User user;
	@OneToOne(mappedBy="profilePic")
	@JsonIgnoreProperties({"profilePic"})
	private Squad squad;
	@ManyToMany
	@JoinTable(name = "image_has_goal", joinColumns = @JoinColumn(name = "image_id"), inverseJoinColumns = @JoinColumn(name = "goal_id"))
	@JsonIgnore
	private List<Goal> goals;
	@ManyToMany
	@JoinTable(name = "image_has_review",
		joinColumns = @JoinColumn(name = "image_id"),
		inverseJoinColumns = {@JoinColumn(name = "review_goal_id"), @JoinColumn(name="review_user_id")})
	@JsonIgnore
	private List<Review> reviews;

	public Image() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Squad getSquad() {
		return squad;
	}

	public void setSquad(Squad squad) {
		this.squad = squad;
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
			goal.addImage(this);
		}
	}

	public void removeGoal(Goal goal) {
		if (goals != null && goals.contains(goal)) {
			goals.remove(goal);
			goal.removeImage(this);
		}
	}
	
	public List<Review> getReviews() {
		return reviews;
	}
	
	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public void addReview(Review review) {
		if (reviews == null) {
			reviews = new ArrayList<>();
		}
		if (!reviews.contains(review)) {
			reviews.add(review);
			review.addImage(this);
		}
	}

	public void removeReview(Review review) {
		if (reviews != null && reviews.contains(review)) {
			reviews.remove(review);
			review.removeImage(this);
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, url);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Image other = (Image) obj;
		return id == other.id && Objects.equals(url, other.url);
	}

	@Override
	public String toString() {
		return "Image [id=" + id + ", url=" + url + "]";
	}
	
	
}
