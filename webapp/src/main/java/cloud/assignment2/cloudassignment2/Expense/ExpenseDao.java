package cloud.assignment2.cloudassignment2.Expense;

import cloud.assignment2.cloudassignment2.user.UserPojo;
import cloud.assignment2.cloudassignment2.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExpenseDao {

    @Autowired
    ExpenseRepository expenseRepository;

    public List<ExpensePojo> getAllExpenses(){

        List<ExpensePojo> newls = new ArrayList<ExpensePojo>();
        expenseRepository.findAll()
                .forEach(newls::add);
        return newls;

    }
}
