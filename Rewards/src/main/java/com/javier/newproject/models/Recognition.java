package com.javier.newproject.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;

@Entity
@Table(name="recognitions")
public class Recognition {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
//	Relations
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id_asignee")
	private User recognitionReceiver;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id_creator")
	private User recognitionCreator;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="reward_id")
	private Reward reward;
	
//  Constructor
	public Recognition () {
	}
	
//	Auto created at/updated at
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

//	Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getRecognitionReceiver() {
		return recognitionReceiver;
	}

	public void setRecognitionReceiver(User recognitionReceiver) {
		this.recognitionReceiver = recognitionReceiver;
	}

	public User getRecognitionCreator() {
		return recognitionCreator;
	}

	public void setRecognitionCreator(User recognitionCreator) {
		this.recognitionCreator = recognitionCreator;
	}

	public Reward getReward() {
		return reward;
	}

	public void setReward(Reward reward) {
		this.reward = reward;
	}
	
	
}
