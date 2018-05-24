package com.javier.newproject.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="users")
public class User {
    
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    @NotEmpty
    private String login;
    
    private String firstName;
    private String lastName;
    private int level;
    private String image;
    private int points;
    
    @Size(min=8)
    private String password;
    
    @Transient
    private String passwordConfirmation;
    
    
    @Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
 
//    Security relation
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "users_roles", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;
    
//    Relations
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    		name="users_products",
    		joinColumns = @JoinColumn(name="user_id"),
    		inverseJoinColumns = @JoinColumn(name="product_id"))
    private List<Product> products;
    
    @OneToMany(mappedBy="productCreator", fetch=FetchType.LAZY)
    private List<Product> createdProducts;
    
    
    @OneToMany(mappedBy="taskResolver", fetch = FetchType.LAZY)
    private List<Task> resolvedTasks;
    
    @OneToMany(mappedBy="taskCreator", fetch=FetchType.LAZY)
    private List<Task> createdTasks;
    
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "users_rewards", 
            joinColumns = @JoinColumn(name = "user_id"), 
            inverseJoinColumns = @JoinColumn(name = "reward_id"))
        private List<Reward> rewardsLog;
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Purchase> purchases;
    
//    Constructors
    public User() {
    	
    }
     
    public User(String login, String password) {
		this.login = login;
		this.password = password;
    }

//	Auto created/updated at
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
	
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

//  getters and setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
	
	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
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

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<Product> getCreatedProducts() {
		return createdProducts;
	}

	public void setCreatedProducts(List<Product> createdProducts) {
		this.createdProducts = createdProducts;
	}

	public List<Task> getResolvedTasks() {
		return resolvedTasks;
	}

	public void setResolvedTasks(List<Task> resolvedTasks) {
		this.resolvedTasks = resolvedTasks;
	}

	public List<Task> getCreatedTasks() {
		return createdTasks;
	}

	public void setCreatedTasks(List<Task> createdTasks) {
		this.createdTasks = createdTasks;
	}

	public List<Reward> getRewardsLog() {
		return rewardsLog;
	}

	public void setRewardsLog(List<Reward> rewardsLog) {
		this.rewardsLog = rewardsLog;
	}

	public List<Purchase> getPurchases() {
		return purchases;
	}

	public void setPurchases(List<Purchase> purchases) {
		this.purchases = purchases;
	}
	
    
}