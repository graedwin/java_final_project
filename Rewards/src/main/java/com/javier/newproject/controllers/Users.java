package com.javier.newproject.controllers;

import java.security.Principal;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javier.newproject.models.User;
import com.javier.newproject.services.NotificationService;
import com.javier.newproject.services.PurchaseService;
import com.javier.newproject.services.TaskService;
import com.javier.newproject.services.UserService;
import com.javier.newproject.validators.UserValidator;


@Controller
public class Users {
    private UserService userService;
    private UserValidator userValidator;
    private NotificationService notificationService;
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public Users(UserService userService, NotificationService notificationService,UserValidator userValidator, TaskService taskService,BCryptPasswordEncoder bCryptPasswordEncoder,PurchaseService purchaseService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.notificationService=notificationService;
        this.bCryptPasswordEncoder=bCryptPasswordEncoder;
    }
    
    @PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("new_user") User user, BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
    	userValidator.validate(user, result);
        if (result.hasErrors()) {
            return "login.jsp";
        }
        if (userService.findRoleByName("ROLE_ADMIN").getUsers().size() <1) {
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
    	User currentUser = userService.findByUsername(email);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userTasks", currentUser.getResolvedTasks());
        model.addAttribute("createdTasks", currentUser.getCreatedTasks());
        model.addAttribute("userProducts", currentUser.getPurchases());
        model.addAttribute("assignedRecognitions", currentUser.getCreatedRecognitions());
        return "Profile.jsp";
    }
    @RequestMapping(value="/forgotPassword/{login}", method = RequestMethod.GET)
    @ResponseBody
    public  String  recoverPassword(@PathVariable("login") String login) {
    	if(userService.findByUsername(login)==null) {
    		return "We couldn't find any account with that login";
    	}
    	User user = userService.findByUsername(login);
    	String alphabet= "abcdefghijklmnopqrstuvwxyz1234567890";
        String s = "";
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            s+= alphabet.charAt(random.nextInt(36));
        }
        user.setPassword(s);
        if(user.getLevel()>=3) {
        	userService.saveWithUserRole(user);
        }
        else {
        	userService.saveUserWithAdminRole(user);
        }
    	notificationService.sendNotification(login+"@amazon.com", "Password recovery email",
    			"This is your new temporary password: "+ s );
    	return "We have successfully sent an email to reset your password" ;
    }
    
    @RequestMapping("/editPassword")
    public String editPassword(Model model, Principal principal, @ModelAttribute("new_user") User user) {
    	String email = principal.getName();
    	model.addAttribute("currentUser", userService.findByUsername(email));
        return "edit_password.jsp";
        
    }
    
    @PostMapping(value="/editPassword")
    public String updatePassword(Model model, Principal principal,@RequestParam("oldPassword") String oldPassword,@RequestParam("newPassword") String newPassword,
    		@RequestParam("confirmPassword") String confirmPassword) {
    	String email = principal.getName();
    	User user = userService.findByUsername(email);
    	model.addAttribute("currentUser", userService.findByUsername(email));
    	boolean error= false;
    	if(!BCrypt.checkpw(oldPassword,user.getPassword())) {
    		model.addAttribute("error1", "The old password doesn't match");
    		error=true;
    	}
    	if(!newPassword.equals(confirmPassword)) {
    		model.addAttribute("error2", "Password and Password confirmation are different");
    		error=true;
    	}
    	if(newPassword.length()<8) {
    		model.addAttribute("error3", "Password must be at least 8 characters");
    		error=true;
    	}
    	if(error) {
    		return "edit_password.jsp" ;
    		
    	}
    	user.setPassword(bCryptPasswordEncoder.encode(newPassword));
    	userService.save(user);
    	return "redirect:/" ;
    }
    
    @RequestMapping(value="/user/{id}/passUpdate")
    public String resetPassword(Principal principal, @PathVariable("id") Long id) {
    	User user = userService.findById(id);
		user.setPassword(bCryptPasswordEncoder.encode("Amazon1995"));
		userService.save(user);
		return "redirect:/admin";
    }
    
}

