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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Table(name="squad_message")
@Entity
public class SquadMessage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="message_date")
	private LocalDateTime messageDate;
	private String content;
	@ManyToOne
	@JoinColumn(name="sender_id")
	@JsonIgnoreProperties({"squadMessages"})
	private User sender;
	@ManyToOne
	@JoinColumn(name="squad_id")
	@JsonIgnoreProperties({"squadMessages"})
	private Squad squad;
	@ManyToOne
	@JoinColumn(name="reply_to_id")
	@JsonIgnore
	private SquadMessage original;
	@OneToMany(mappedBy="original")
	private List<SquadMessage> replies;
	
	public SquadMessage() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getMessageDate() {
		return messageDate;
	}

	public void setMessageDate(LocalDateTime messageDate) {
		this.messageDate = messageDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}
	
	

	public Squad getSquad() {
		return squad;
	}

	public void setSquad(Squad squad) {
		this.squad = squad;
	}

	public SquadMessage getOriginal() {
		return original;
	}

	public void setOriginal(SquadMessage original) {
		this.original = original;
	}

	public List<SquadMessage> getReplies() {
		return replies;
	}

	public void setReplies(List<SquadMessage> replies) {
		this.replies = replies;
	}
	
	public void addReply(SquadMessage reply) {
		if (replies == null) {
			replies = new ArrayList<>();
		}
		if(!replies.contains(reply)) {
			replies.add(reply);
			reply.setOriginal(this);
		}
	}
	
	public void removeReply(SquadMessage reply) {
		reply.setOriginal(null);
		if (replies != null && replies.contains(reply)) {
			replies.remove(reply);
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SquadMessage other = (SquadMessage) obj;
		return id == other.id;
	}
	
	
	
}
