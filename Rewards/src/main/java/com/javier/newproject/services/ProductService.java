package com.javier.newproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javier.newproject.models.Product;
import com.javier.newproject.repositories.ProductRepository;

@Service
public class ProductService {
	private ProductRepository productRepository;
	
	public ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}
	
	public void saveProduct(Product product) {
		productRepository.save(product);
	}
	
	public List<Product> allProducts(){
		return productRepository.findAll();
	}
	public Product findProduct(Long id) {
		return productRepository.findById(id).get();
	}

}
