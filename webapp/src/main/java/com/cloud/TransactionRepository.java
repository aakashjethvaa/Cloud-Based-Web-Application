package com.cloud;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    
	List<Transaction> findByUserId(Long user_id);
	// Page<Transaction> findByUserId(Long user_id, Pageable pageable);
	
}