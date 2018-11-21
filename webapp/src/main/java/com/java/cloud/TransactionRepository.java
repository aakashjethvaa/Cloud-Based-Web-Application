package com.java.cloud;

import org.springframework.data.repository.CrudRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@Transactional
public interface TransactionRepository extends CrudRepository<Transaction, Long> {
    //Transaction findById(Long Id);

    List<Transaction> findByUser(User user);
}
