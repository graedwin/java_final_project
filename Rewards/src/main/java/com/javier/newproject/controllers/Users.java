package com.javier.newproject.controllers;

import java.security.Principal;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javier.newproject.models.Task;
import com.javier.newproject.models.User;
import com.javier.newproject.services.PurchaseService;
import com.javier.newproject.services.TaskService;
import com.javier.newproject.services.UserService;
import com.javier.newproject.validators.UserValidator;


@Controller
public class Users {
    private UserService userService;
    private TaskService taskService;
    private UserValidator userValidator;
    private PurchaseService purchaseService;

    public Users(UserService userService, UserValidator userValidator, TaskService taskService,PurchaseService purchaseService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.taskService=taskService;
        this.purchaseService = purchaseService;
    }
    
    @PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("new_user") User user, BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
    	userValidator.validate(user, result);
        if (result.hasErrors()) {
            return "login.jsp";
        }
        if (userService.findRoleByName("ROLE_ADMIN").getUsers().size() == 0) {
	    	userService.saveUserWithAdminRole(user);
    	}
        else {
        	userService.saveWithUserRole(user);
        	}
        try {
			request.login(user.getLogin(), user.getPasswordConfirmation());
		} catch (ServletException e) {
			return "redirect:/login"; 
		}
        return "redirect:/";
    }
    
    @RequestMapping("/user/delete/{id}")
    public String delete(@PathVariable("id") Long id){
    	userService.deleteUser(id);
    	return "redirect:/admin";
    }
    
    @RequestMapping("/user/{role}/{id}")
    public String makeAdmin(@PathVariable("id") Long id, @PathVariable("role") String role,Principal principal, Model model){
    	System.out.println("got here");
    	if(role.equals("ROLE_ADMIN")) {
    		userService.makeAdmin(userService.findById(id));
    	}else if(role.equals("ROLE_USER")){
    		userService.makeUser(userService.findById(id));
    	}else if(role.equals("ROLE_SUPERUSER")){
    		userService.makeSuperUser(userService.findById(id));
    	}else if(role.equals("ROLE_SUPERVISOR")){
    		userService.makeSupervisor(userService.findById(id));
    	}else if(role.equals("ROLE_MANAGER")){
    		System.out.println("manager");
    		userService.makeManager(userService.findById(id));
    	}
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        model.addAttribute("users", userService.findAll());
        model.addAttribute("roles", userService.findAllRoles());
    	return "redirect:/admin";
    }
    
    @RequestMapping("/admin")
    public String adminPage(Principal principal, Model model) {
        String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        model.addAttribute("users", userService.findAll());
        model.addAttribute("roles", userService.findAllRoles());
        return "adminPage.jsp";
    }
    
    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, @ModelAttribute("new_user") User user, Principal principal) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        
        return "login.jsp";
    }
    
    @RequestMapping(value = {"/", "/home"})
    public String home() {
        return "redirect:/dashboard/pages/1";
        
    }
    @RequestMapping("/users/{id}/profile")
    public String profile(@PathVariable("id") Long id,Principal principal, Model model){
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        model.addAttribute("userTasks", userService.findByUsername(email).getResolvedTasks());
        model.addAttribute("userProducts", userService.findByUsername(email).getPurchases());
        return "Profile.jsp";
    }
    
}

