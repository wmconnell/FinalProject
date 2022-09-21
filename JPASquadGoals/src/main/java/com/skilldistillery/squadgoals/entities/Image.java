package com.skilldistillery.squadgoals.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Image {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String url;


	@OneToOne(mappedBy="profileImg")
	@JsonIgnore
	private User user;
	@OneToOne(mappedBy="profileImg")
	@JsonIgnore
	private Squad squad;

	public Image() {

	}
}
