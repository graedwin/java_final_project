package com.javier.newproject.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@RequestMapping ("/rewards")
	public String showRewards (Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("rewards", rewardService.findAll());
		return "rewards.jsp";
	}
	
	@RequestMapping ("/rewards/add")
	public String newReward (@ModelAttribute ("newReward") Reward reward, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() < 3) {
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("rewards", rewardService.findAll());
			return "addRewards.jsp";
		} else {
			return "redirect:/rewards";
		}
	}
	
	@PostMapping ("/rewards/add")
	public String createReward (@Valid @ModelAttribute ("newReward") Reward reward, BindingResult result, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() < 3) {
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("rewards", rewardService.findAll());
			if (result.hasErrors()) {
				return "addRewards.jsp";
			} else {
				rewardService.newReward(reward);
				return "redirect:/rewards";
			}
		} else {
			return "redirect:/rewards";
		}
	}
	
	@RequestMapping ("/rewards/{id}/edit")
	public String editReward (@ModelAttribute ("editReward") Reward reward, @PathVariable("id") Long id, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() < 3) {
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("reward", rewardService.findById(id));
			return "editRewards.jsp";
		} else {
			return "redirect:/rewards";
		}
	}
	
	@PostMapping ("/rewards/{id}/edit")
	public String updateReward (@Valid @ModelAttribute ("editReward") Reward reward, BindingResult result, @PathVariable ("id") Long id, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() < 3) {
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("reward", rewardService.findById(id));
			if (result.hasErrors()) {
				return "editRewards.jsp";
			} else {
				rewardService.updateReward(reward);
				return "redirect:/rewards";
			}
		} else {
			return "redirect:/rewards";
			}
		}
	
	@RequestMapping ("/rewards/{id}/delete")
	public String deleteReward (@PathVariable ("id") Long id, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() < 3) {
			model.addAttribute("currentUser", currentUser);
			rewardService.deleteReward(rewardService.findById(id));
			return "redirect:/rewards";
		} else {
			return "redirect:/rewards";
		}
	}
	
	@RequestMapping ("/rewards/assign")
	public String showRewardAssign(Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() != 3) {
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("users", userService.findAll());
			model.addAttribute("rewards", rewardService.findAll());
			return "add_Points.jsp";
		} else {
			return "redirect:/rewards";
		}
	}
	
	@PostMapping ("/rewards/assign")
	public String assignReward (@RequestParam("associate") Long userId, @RequestParam("reward") Long rewardId, Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser.getLevel() != 3) {
			model.addAttribute("currentUser", currentUser);
			User user = userService.findById(userId);
			Reward reward = rewardService.findById(rewardId);
			List <Reward> rewards = user.getRewardsLog();
			int points = user.getPoints();
			points += reward.getPoints();
			rewards.add(reward);
			user.setPoints(points);
			user.setRewardsLog(rewards);
			userService.save(user);
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("users", userService.findAll());
			model.addAttribute("rewards", rewardService.findAll());
			model.addAttribute("success","Points Assigned");
			return "add_Points.jsp";
		} else {
			return "redirect:/rewards";
		}
	}
}
