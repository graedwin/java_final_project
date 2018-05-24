package com.javier.newproject.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javier.newproject.services.RewardService;
import com.javier.newproject.services.UserService;

@Controller
public class Rewards {
	
	private RewardService rewardService;
	private UserService userService;
	
	public Rewards (RewardService rewardService, UserService userService) {
		this.rewardService = rewardService;
		this.userService = userService;
	}
	
	@RequestMapping ("/rewards/assign")
	public String showRewardAssign(Model model) {
		model.addAttribute("users", userService.findAll());
		model.addAttribute("rewards", rewardService.findAll());
		return "add_Points.jsp";
	}
}
