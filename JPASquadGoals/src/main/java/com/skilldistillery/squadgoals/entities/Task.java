package com.skilldistillery.squadgoals.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Task {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
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


	public Task() {

	}

}
