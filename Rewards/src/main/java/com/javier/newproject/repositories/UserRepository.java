package com.javier.newproject.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.javier.newproject.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
	
	User findByLogin(String login);
	User findOneByLogin(String login);
}
