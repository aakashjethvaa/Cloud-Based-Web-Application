package cloud.assignment2.cloudassignment2.Expense;

import cloud.assignment2.cloudassignment2.user.UserDao;
import cloud.assignment2.cloudassignment2.user.UserPojo;
import com.google.gson.JsonObject;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@RestController
public class ExpenseController {

    @Autowired
    UserDao userDao;

    @Autowired
    ExpenseDao expenseDao;

    @Autowired
    ExpenseRepository expenseRepository;

    @RequestMapping(value="/transaction")
    public List<ExpensePojo> getAllExpense(HttpServletRequest req, HttpServletResponse res){
        String authHeader = req.getHeader("Authorization");
        if (authHeader==null){
            List<ExpensePojo> newpojo1 = new ArrayList<ExpensePojo>();
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return newpojo1;
        }
        else{
            UserPojo up =userDao.getUserPojo(authHeader);
            if(up == null){
                List<ExpensePojo> newpojo = new ArrayList<ExpensePojo>();
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return newpojo;

            }
            String id = up.getId();
            System.out.print("id " +id);
            return expenseRepository.findByUserId(id);
        }

    }


    @RequestMapping(value="/transaction", method=RequestMethod.POST)
    public String addExpense(@RequestBody ExpensePojo expensePojo, HttpServletRequest req, HttpServletResponse res){

        JsonObject json = new JsonObject();
        if(!expensePojo.getAmount().isEmpty()) {
            String authHeader = req.getHeader("Authorization");
            if(authHeader!=null)
            {
                int result = userDao.authUserCheck(authHeader);
                if(result>0)
                {
                    expensePojo.setUserId(String.valueOf(result));
                    expenseRepository.save(expensePojo);
                    res.setStatus(HttpServletResponse.SC_CREATED);
                    json.addProperty("message", "Expense added for the User.");
                }
                else
                {
                    res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    json.addProperty("message","You are unauthorized");
                }


            }
            else
            {
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                json.addProperty("message","You are unauthorized");
            }
        }
        else{
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            json.addProperty("message", "Bad request");
        }

        return json.toString();

    }

    @RequestMapping(value="/transaction/{id}" , method = RequestMethod.DELETE)
    public String deleteExpense(@PathVariable(value="id") String transactionId, HttpServletRequest req
                                            , HttpServletResponse res){

        JsonObject json = new JsonObject();
        String header = req.getHeader("Authorization");
        if(header != null){
            int result = userDao.authUserCheck(header);
            if(result>0){
                List<ExpensePojo> expensePojoRecord = expenseRepository.findAllById(transactionId);

                if(expensePojoRecord.size()>0)
                {
                    ExpensePojo expenseRecord = expensePojoRecord.get(0);

                    if(Integer.parseInt(expenseRecord.getUserId()) == result){
                        expenseRepository.delete(expenseRecord);
                        res.setStatus(HttpServletResponse.SC_NO_CONTENT);
                        json.addProperty("message","Record deleted");
                        return json.toString();
                    }
                    else{
                        res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        json.addProperty("message","You are unauthorized. UserId do not match");
                    }


                }

                else{
                    res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    json.addProperty("message","Bad Request! No id found");
                }
            }
            else {
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                json.addProperty("message","You are unauthorized");
            }

        }
        else
        {
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            json.addProperty("message","You are unauthorized");
        }

        return json.toString();
    }

    @RequestMapping(value="/transaction/{id}",method = RequestMethod.PUT)
    public String updateExpense(@RequestBody ExpensePojo expensePojo, @PathVariable(value="id") String transactionId,
                                HttpServletRequest req, HttpServletResponse res){
        JsonObject json = new JsonObject();

        String header = req.getHeader("Authorization");
        if(header != null){
            int result = userDao.authUserCheck(header);
            if(result>0){
                List<ExpensePojo> expensePojoRecord = expenseRepository.findAllById(transactionId);
                if(expensePojoRecord.size()>0){
                    if(expensePojo.getAmount().isEmpty())
                    {
                        res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        json.addProperty("message","Bad Request! Amount is mandatory");
                    }
                    else {
                        ExpensePojo expenseRecord = expensePojoRecord.get(0);

                        if(Integer.parseInt(expenseRecord.getUserId()) == result)
                        {
                            expenseRecord.setDescription(expensePojo.getDescription());
                            expenseRecord.setMerchant(expensePojo.getMerchant());
                            expenseRecord.setAmount(expensePojo.getAmount());
                            expenseRecord.setDate(expensePojo.getDate());
                            expenseRecord.setCategory(expensePojo.getCategory());
                            expenseRepository.save(expenseRecord);
                            res.setStatus(HttpServletResponse.SC_CREATED);
                            json.addProperty("message","Record updated!");
                            return json.toString();
                        }
                        else{
                            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                            json.addProperty("message","You are unauthorized. Userid do not match");
                        }


                    }
                }
                else{
                    res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    json.addProperty("message","Bad Request! No id found");
                }
            }
            else{
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                json.addProperty("message","You are unauthorized");
            }
        }
        else{
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            json.addProperty("message","You are unauthorized");
        }
        return json.toString();
    }
}
