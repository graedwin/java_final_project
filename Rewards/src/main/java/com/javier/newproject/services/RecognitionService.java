package com.javier.newproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javier.newproject.models.Recognition;
import com.javier.newproject.repositories.RecognitionRepository;

@Service
public class RecognitionService {

		private RecognitionRepository recognitionRepository;
		
		public RecognitionService (RecognitionRepository recognitionRepository) {
			this.recognitionRepository = recognitionRepository;
		}
		
		public Recognition findById(Long recognitionId) {
			return recognitionRepository.findById(recognitionId).get();
		}
		
		public List<Recognition> findAll(){
			return recognitionRepository.findAll();
		}

		public void saveRecognition(Recognition currentRecognition) {
			recognitionRepository.save(currentRecognition);
			
		}
}
