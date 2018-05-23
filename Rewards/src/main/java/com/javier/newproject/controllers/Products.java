package com.javier.newproject.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javier.newproject.models.Product;
import com.javier.newproject.services.ProductService;
import com.javier.newproject.services.UserService;
import com.javier.newproject.validators.UserValidator;

@Controller
public class Products {
	private UserService userService;
    private UserValidator userValidator;
    private ProductService productService;

    public Products(UserService userService, UserValidator userValidator, ProductService productService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.productService = productService;
    }
    
    @RequestMapping("/products")
    public String showProducts(Model model, Principal principal) {
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
    	model.addAttribute("all_Products", productService.allProducts());
    	return "show_all_Products.jsp";
    }
    @RequestMapping("/products/{id}")
    public String showProduct(@PathVariable("id") Long id,Principal principal,Model model) {
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
    	model.addAttribute("product", productService.findProduct(id));
    	return "show_Product.jsp";
    }
    
    @RequestMapping("/products/add")
    public String renderAddProduct(@ModelAttribute("new_Product") Product product, BindingResult result, Principal principal, Model model) {
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
    	if (userService.findByUsername(principal.getName()).getLevel() < 3) {
    		return "addProduct.jsp";
    	}else {
            return "redirect:/products";
        }
    }
    


  
    

}
