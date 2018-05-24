package com.javier.newproject.repositories;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.javier.newproject.models.Task;

public interface TaskPaginationRepository extends PagingAndSortingRepository<Task, Long>{
	
}
