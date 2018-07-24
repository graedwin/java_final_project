package com.javier.newproject.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name="rewards")
public class Reward {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Min(0)
	private int points;
	
	@NotEmpty
	private String description;
	
	@Column(updatable=false)
	private Date createdAt;
	private Date updatedAt;
	
//	constructors
	
	public Reward() {
	}

	public Reward(int points, String description) {
		this.points = points;
		this.description = description;
	}
	
//	relations
	@OneToMany(mappedBy="taskReward", fetch = FetchType.LAZY)
	private List<Task> tasks;
	
	@OneToMany(mappedBy="reward", fetch = FetchType.LAZY)
	private List<Recognition> recognitionsHistory;
	
	
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

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public List<Task> getTasks() {
		return tasks;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}

	public List<Recognition> getRecognitionsHistory() {
		return recognitionsHistory;
	}

	public void setRecognitionsHistory(List<Recognition> recognitionsHistory) {
		this.recognitionsHistory = recognitionsHistory;
	}
    
}
