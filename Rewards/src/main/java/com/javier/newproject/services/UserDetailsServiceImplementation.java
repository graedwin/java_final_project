package com.javier.newproject.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.javier.newproject.models.Role;
import com.javier.newproject.models.User;
import com.javier.newproject.repositories.UserRepository;

@Service
public class UserDetailsServiceImplementation implements UserDetailsService {
    private UserRepository userRepository;
    
    public UserDetailsServiceImplementation(UserRepository userRepository){
        this.userRepository = userRepository;
    }
    // 1
    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        User user = userRepository.findByLogin(login);
        
        if(user == null) {
            throw new UsernameNotFoundException("User not found");
        }
    	userRepository.save(user);
        return new org.springframework.security.core.userdetails.User(user.getLogin(), user.getPassword(), getAuthorities(user));
    }
    
    // 2
    private List<GrantedAuthority> getAuthorities(User user){
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for(Role role : user.getRoles()) {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(role.getName());
            authorities.add(grantedAuthority);
        }
        return authorities;
    }
}

