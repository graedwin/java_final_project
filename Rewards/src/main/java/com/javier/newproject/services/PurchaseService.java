package com.javier.newproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javier.newproject.models.Purchase;
import com.javier.newproject.repositories.PurchaseRepository;

@Service
public class PurchaseService {
	private PurchaseRepository purchaseRepository;
	
	public PurchaseService(PurchaseRepository purchaseRepository) {
		this.purchaseRepository = purchaseRepository;
	}
	public void savePurchase(Purchase purchase) {
		purchaseRepository.save(purchase);
	}
	public List<Purchase> pendingPurchases(){
		return purchaseRepository.findByStatusEquals("Pending");
	}
	public Purchase getById(Long id) {
		return purchaseRepository.findById(id).get();
	}

}
