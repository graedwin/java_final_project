package com.javier.newproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javier.newproject.models.Reward;
import com.javier.newproject.repositories.RewardRepository;

@Service
public class RewardService {

	private RewardRepository rewardRepository;
	
	public RewardService (RewardRepository rewardRepository) {
		this.rewardRepository = rewardRepository;
	}

	public Reward findById(Long rewardId) {
		return rewardRepository.findById(rewardId).get();
	}

	public List<Reward> findAll() {
		return rewardRepository.findAll();
	}
	
	
}
