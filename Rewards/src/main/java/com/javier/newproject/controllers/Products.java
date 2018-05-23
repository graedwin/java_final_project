package com.javier.newproject.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javier.newproject.models.Product;
import com.javier.newproject.services.UserService;
import com.javier.newproject.validators.UserValidator;

@Controller
public class Products {
	private UserService userService;
    private UserValidator userValidator;

    public Products(UserService userService, UserValidator userValidator) {
        this.userService = userService;
        this.userValidator = userValidator;
    }
    
    @RequestMapping("/product/add")
    public String renderAddProduct(@ModelAttribute("new_Product") Product product) {
    	return "add_Product.jsp";
    }
    
    @PostMapping("/product/add")
    public String processAddProduct(@Valid @ModelAttribute("new_Product") Product product, BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
        if (result.hasErrors()) {
            return "add_Product.jsp";
        }else {
        	return "redirect:/";
        }
    }

}
