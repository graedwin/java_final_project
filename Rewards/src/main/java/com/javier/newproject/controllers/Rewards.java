package com.javier.newproject.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javier.newproject.models.Reward;
import com.javier.newproject.models.User;
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
	
	@PostMapping ("/rewards/assign")
	public String assignReward (@RequestParam("associate") Long userId, @RequestParam("reward") Long rewardId, Principal principal, Model model) {
		User user = userService.findById(userId);
		Reward reward = rewardService.findById(rewardId);
		List <Reward> rewards = user.getRewardsLog();
		int points = user.getPoints();
		points += reward.getPoints();
		rewards.add(reward);
		user.setPoints(points);
		user.setRewardsLog(rewards);
		userService.save(user);
		return "add_Points.jsp";
	}
}
