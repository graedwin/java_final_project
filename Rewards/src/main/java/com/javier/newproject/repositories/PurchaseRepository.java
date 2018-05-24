package com.javier.newproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.javier.newproject.models.Purchase;

@Repository
public interface PurchaseRepository extends CrudRepository<Purchase, Long> {
	List <Purchase> findAll();
	List <Purchase> findByStatusEquals(String string);
}
