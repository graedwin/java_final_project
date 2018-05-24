package com.javier.newproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.javier.newproject.models.Reward;

@Repository
public interface RewardRepository extends CrudRepository <Reward,Long>{
	List <Reward> findAll();

}
