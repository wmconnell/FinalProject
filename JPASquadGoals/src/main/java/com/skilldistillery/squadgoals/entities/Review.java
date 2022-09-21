package com.skilldistillery.squadgoals.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Review {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private int rating;
	private String comment;
	@ManyToOne
	@JoinColumn(name="goal_id")
	@JsonIgnoreProperties({"reviews"})
	private Goal goal;
	
	public Review() {
		
	}
}
