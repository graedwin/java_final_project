package com.javier.newproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javier.newproject.models.Task;
import com.javier.newproject.repositories.TaskRepository;

@Service
public class TaskService {
	private TaskRepository taskRepository;
	
	public TaskService (TaskRepository taskRepository) {
		this.taskRepository = taskRepository;
	}

	public List<Task> findAll() {
		return taskRepository.findAll();
	}

	public void newTask(Task task) {
		task.setStatus("Available");
		taskRepository.save(task);
	}

	public Task findById(Long id) {
		return taskRepository.findById(id).get();
	}

	public void updateTask(Task task) {
		taskRepository.save(task);
	}

	public void cancelTask(Task task) {
		taskRepository.delete(task);		
	}
	
	
}
