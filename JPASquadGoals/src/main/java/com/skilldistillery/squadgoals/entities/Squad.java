package com.skilldistillery.squadgoals.entities;

import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Squad {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String name;
	private String bio;
	private Boolean active;
	// TODO: Decide whether to keep the leader designation/field
	@ManyToOne
	@JoinColumn(name="leader_id")
	@JsonIgnore
	private User leader;
	private int points;
	@OneToOne(cascade=CascadeType.PERSIST)
	@JoinColumn(name="profile_img_id")
	@JsonIgnoreProperties({"squad"})
	private Image profileImg;
	
	public Squad() {
		
	}
	
}
