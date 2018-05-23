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
import javax.validation.constraints.Future;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name="tasks")
public class Task {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty
	private String name;
	
	@NotEmpty
	private String status;
	
	@Min(0)
	@Max(10)
	private int rating;
	
	@NotEmpty
	private String description;
	
	private String image;
	
	@Min(0)
	private int worth;
	
	@Future
	private Date dueDate;
	
	@Column(updatable=false)
	private Date createdAt;
	private Date updatedAt;
	
//	constructors
	public Task() {
	}

	public Task(String name, String status, int rating, String description, int worth, Date dueDate) {
		this.name = name;
		this.status = status;
		this.rating = rating;
		this.description = description;
		this.worth = worth;
		this.dueDate = dueDate;
	}
	
//	Relations
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id_resolver")
	private User taskResolver;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id_creator")
	private User taskCreator;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="reward_id")
	private Reward taskReward;
	
	
//	Auto created/updated at
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
	
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

//    getters and setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getWorth() {
		return worth;
	}

	public void setWorth(int worth) {
		this.worth = worth;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
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

	public User getTaskResolver() {
		return taskResolver;
	}

	public void setTaskResolver(User taskResolver) {
		this.taskResolver = taskResolver;
	}

	public User getTaskCreator() {
		return taskCreator;
	}

	public void setTaskCreator(User taskCreator) {
		this.taskCreator = taskCreator;
	}

	public Reward getTaskReward() {
		return taskReward;
	}

	public void setTaskReward(Reward taskReward) {
		this.taskReward = taskReward;
	}
    
}
