package com.skilldistillery.squadgoals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Review {
	
	@EmbeddedId
	private ReviewId id;
	
	private int rating;
	private String comment;
	
	@Column(name="review_date")
	private LocalDateTime reviewDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value = "userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="goal_id")
	@MapsId(value = "goalId")
	private Goal goal;
	
	@ManyToMany(mappedBy="reviews")
	@JsonIgnoreProperties({"reviews"})
	private List<Image> images;

	public ReviewId getId() {
		return id;
	}

	public void setId(ReviewId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Goal getGoal() {
		return goal;
	}

	public void setGoal(Goal goal) {
		this.goal = goal;
	}

	public Review() {
		
	}
	
	public LocalDateTime getReviewDate() {
		return reviewDate;
	}
	
	public void setReviewDate(LocalDateTime reviewDate) {
		this.reviewDate = reviewDate;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
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
			image.addReview(this);
		}
	}
	
	public void removeImage(Image image) {
		if (images != null && images.contains(image)) {
			images.remove(image);
			image.removeReview(this);
		}
	}
	
	
}
