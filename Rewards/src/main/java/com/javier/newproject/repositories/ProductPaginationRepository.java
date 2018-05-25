package com.javier.newproject.repositories;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.javier.newproject.models.Product;

public interface ProductPaginationRepository extends PagingAndSortingRepository<Product, Long>{
	
}
