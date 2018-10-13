package cloud.assignment2.cloudassignment2.Receipt;

import cloud.assignment2.cloudassignment2.Expense.ExpensePojo;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ReceiptRepository extends CrudRepository<ReceiptPojo, String> {
    List<ReceiptPojo> findByTransactionId(String tid);
    List<ReceiptPojo> findByReceiptid(String receiptId);
}
