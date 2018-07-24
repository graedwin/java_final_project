package com.javier.newproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.javier.newproject.models.Recognition;

@Repository
public interface RecognitionRepository extends CrudRepository<Recognition,Long>{
	List <Recognition> findAll();

}
