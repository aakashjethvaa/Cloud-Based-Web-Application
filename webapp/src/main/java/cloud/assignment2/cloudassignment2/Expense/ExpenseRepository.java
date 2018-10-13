package cloud.assignment2.cloudassignment2.Expense;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExpenseRepository extends CrudRepository<ExpensePojo, String> {

    List<ExpensePojo> findByUserId(String userid);
    List<ExpensePojo> findAllById(String transactionID);
}
