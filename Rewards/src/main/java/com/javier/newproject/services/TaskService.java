package com.javier.newproject.services;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

import com.javier.newproject.models.Task;
import com.javier.newproject.repositories.TaskPaginationRepository;
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

	//Pagination
	
	@Autowired 
    TaskPaginationRepository paginationRepo;
    private static final int PAGE_SIZE = 5;
    public Page<Task> tasksPerPage(int pageNumber) {
        @SuppressWarnings("deprecation")
		PageRequest pageRequest = new PageRequest(pageNumber, PAGE_SIZE, Sort.Direction.ASC, "dueDate");
        return paginationRepo.findAll(pageRequest);
    }
    
    public Page<Task> findByStatus(int pageNumber){
    	@SuppressWarnings("deprecation")
		PageRequest pageRequest = new PageRequest(pageNumber, PAGE_SIZE, Sort.Direction.ASC, "dueDate");
        return paginationRepo.findByStatus(pageRequest, "Available");
    }
	
	//Helps to storage images
	
	Logger log = LoggerFactory.getLogger(this.getClass().getName());
	private final Path rootLocation = Paths.get(System.getProperty("user.dir")+"/src/main/resources/static/taskImages");

	public void store(MultipartFile file){
		try {
            Files.copy(file.getInputStream(), this.rootLocation.resolve(file.getOriginalFilename()));
        } catch (Exception e) {
        	throw new RuntimeException("FAIL!");
        }
	}

    public Resource loadFile(String filename) {
        try {
            Path file = rootLocation.resolve(filename);
            Resource resource = new UrlResource(file.toUri());
            if(resource.exists() || resource.isReadable()) {
                return resource;
            }else{
            	throw new RuntimeException("File not found!");
            }
        } catch (MalformedURLException e) {
        	throw new RuntimeException("File not found!");
        }
    }
    
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    public void init() {
        try {
            Files.createDirectory(rootLocation);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize storage!");
        }
    }	
}
