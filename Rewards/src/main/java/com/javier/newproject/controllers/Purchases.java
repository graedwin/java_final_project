package com.javier.newproject.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javier.newproject.models.Purchase;
import com.javier.newproject.services.PurchaseService;
import com.javier.newproject.services.UserService;

@Controller
public class Purchases {
	private PurchaseService purchaseService;
	private UserService userService;
	
	public Purchases(UserService userService,PurchaseService purchaseService){
		this.userService = userService;
		this.purchaseService = purchaseService;

	}
	
	@RequestMapping("/purchases/{id}/delivered")
	public String deliverPurchase(@PathVariable("id") Long id, Principal principal, Model model) {
		String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        model.addAttribute("pendingPurchases", purchaseService.pendingPurchases());
        Purchase purchase = purchaseService.getById(id);
        purchase.setStatus("Delivered");
        purchaseService.savePurchase(purchase);
    	return "redirect:/";
	}

}