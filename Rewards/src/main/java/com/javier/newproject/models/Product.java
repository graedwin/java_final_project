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
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="products")
public class Product {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty
	private String name;
	
	@Min(0)
	private int price;
	
	@Min(1)
	private int stock;
	
	@Lob
	@NotEmpty
	private String description;
	
	private String image;
	
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
//    Constructors
    public Product () {
    }

	public Product(String name, int price, int stock, String description) {
		this.name = name;
		this.price = price;
		this.stock = stock;
		this.description = description;
	}
    
//    Relations
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    		name="users_products",
    		joinColumns = @JoinColumn(name="product_id"),
    		inverseJoinColumns = @JoinColumn(name="user_id"))
    private List<User> orderedBy;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User productCreator;
	
	@OneToMany(mappedBy="product", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Purchase> purchases;

	
//	 Auto created/updated at
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
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

	public List<User> getOrderedBy() {
		return orderedBy;
	}

	public void setOrderedBy(List<User> orderedBy) {
		this.orderedBy = orderedBy;
	}

	public User getProductCreator() {
		return productCreator;
	}

	public void setProductCreator(User productCreator) {
		this.productCreator = productCreator;
	}

	public List<Purchase> getPurchases() {
		return purchases;
	}

	public void setPurchases(List<Purchase> purchases) {
		this.purchases = purchases;
	}
	
	
	
}
