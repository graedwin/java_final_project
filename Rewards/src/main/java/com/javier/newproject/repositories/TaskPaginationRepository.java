package com.javier.newproject.repositories;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.javier.newproject.models.Task;

public interface TaskPaginationRepository extends PagingAndSortingRepository<Task, Long>{

}
