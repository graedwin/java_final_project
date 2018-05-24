package com.javier.newproject.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javier.newproject.models.Task;
import com.javier.newproject.services.RewardService;
import com.javier.newproject.services.TaskService;
import com.javier.newproject.services.UserService;

@Controller
public class Tasks {

	private TaskService taskService;
	private UserService userService;
	private RewardService rewardService;
	
	public Tasks (TaskService taskService, UserService userService, RewardService rewardService) {
		this.taskService = taskService;
		this.userService = userService;
		this.rewardService = rewardService;
	}
	
	@RequestMapping ("/tasks")
	public String showTasks (Model model, Principal principal) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		model.addAttribute("tasks", taskService.findAll());
		return "show_all_Tasks.jsp";
	}
	
	@RequestMapping ("/tasks/add")
	public String addTasks (@ModelAttribute ("new_Task") Task task, Principal principal, Model model) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		return "add_Task.jsp";
	}
	
	@PostMapping ("/tasks/add")
	public String createTasks (@Valid @ModelAttribute ("new_Task") Task task, BindingResult result, @RequestParam ("taskReward") Long rewardId, Principal principal, Model model) {
		if(result.hasErrors()) {
			return "add_Task.jsp";
		} else {
			task.setTaskReward(rewardService.findById(rewardId));
			task.setTaskCreator(userService.findByUsername(principal.getName()));
			taskService.newTask(task);
			return "redirect:/tasks";
		}
	}
	
	@RequestMapping ("/tasks/{id}/show")
	public String viewTask (@PathVariable("id") Long id, Model model, Principal principal) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		model.addAttribute("task", taskService.findById(id));
		System.out.println(taskService.findById(id).getTaskCreator());
		return "show_Task.jsp";
	}
	
	@RequestMapping ("/tasks/{id}/edit")
	public String editTask (@ModelAttribute ("task") Task task, @PathVariable("id") Long id, Principal principal, Model model) {
		if (userService.findByUsername(principal.getName()) == taskService.findById(id).getTaskCreator() || userService.findByUsername(principal.getName()).getLevel() < 3) {
			model.addAttribute("task", taskService.findById(id));
			model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
			return "edit_Task.jsp";
		} else {
			return "redirect:/tasks";
		}
	}
	
	@PostMapping ("/tasks/{id}/edit")
	public String updateTask (@Valid @ModelAttribute("task") Task task, BindingResult result, @PathVariable("id") Long id, Principal principal, Model model) {
		if (result.hasErrors()) {
			return "edit_Task.jsp";
		} else {
			taskService.updateTask(task);
			return "redirect/tasks";
		}
	}
	
	@RequestMapping ("/tasks/{id}/cancel")
	public String cancelTask (@PathVariable("id") Long id, Principal principal) {
		if (userService.findByUsername(principal.getName()) == taskService.findById(id).getTaskCreator() || userService.findByUsername(principal.getName()).getLevel() < 3) {
			Task task = taskService.findById(id);
			taskService.cancelTask(task);
			return "redirect:/tasks";
		} else {
			return "redirect:/tasks";
		}
	}
}
