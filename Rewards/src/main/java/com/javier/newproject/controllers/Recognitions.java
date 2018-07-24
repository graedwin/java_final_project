package com.javier.newproject.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javier.newproject.models.User;
import com.javier.newproject.services.RecognitionService;
import com.javier.newproject.services.UserService;

@Controller
public class Recognitions {
	private UserService userService;
	private RecognitionService recognitionService;
	
	public Recognitions (UserService userService, RecognitionService recognitionService) {
		this.userService = userService;
		this.recognitionService = recognitionService;
	}
	
	@RequestMapping("/recognitions/history")
	public String recognitionsHistory(Principal principal, Model model) {
		String login = principal.getName();
		User currentUser = userService.findByUsername(login);
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("recognitions", recognitionService.findAll());
		return "recognitionsHistory.jsp";
	}
}
