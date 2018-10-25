package cloud.assignment2.cloudassignment2.Receipt;

import cloud.assignment2.cloudassignment2.Expense.ExpensePojo;
import cloud.assignment2.cloudassignment2.Expense.ExpenseRepository;
import cloud.assignment2.cloudassignment2.user.UserDao;
import cloud.assignment2.cloudassignment2.user.UserPojo;
import com.google.gson.JsonObject;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@Configuration
@Profile("local")
public class ReceiptController {

    @Autowired
    UserDao userDao;

    @Autowired
    ExpenseRepository expenseRepository;

    @Autowired
    ReceiptRepository receiptRepository;


    @RequestMapping(value="/transaction/{id}/attachments" , method = RequestMethod.POST)
    public String receiptUpload(@PathVariable(value="id") String transactionId, @RequestParam ("file") MultipartFile file, HttpServletRequest req,
                                HttpServletResponse res){

        System.out.println("Local Environment");

        JsonObject json = new JsonObject();
        String filePath = "/home/aakash/Documents/";
        String fileName = file.getOriginalFilename();
        String NewPath = filePath + fileName;
        System.out.println("PATH IS " + filePath);
        String header = req.getHeader("Authorization");
        if(header != null) {
            int result = userDao.authUserCheck(header);
            if(result>0)
            {
                List<ExpensePojo> expensePojoRecord = expenseRepository.findAllById(transactionId);
                if(expensePojoRecord.size()>0){
                    ExpensePojo expenseRecord = expensePojoRecord.get(0);
                    if(Integer.parseInt(expenseRecord.getUserId()) == result)
                    {

                        File dest = new File(NewPath);
                        try {
                            file.transferTo(dest);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        ReceiptPojo receiptPojo = new ReceiptPojo();
                        receiptPojo.setTransactionId(transactionId);
                        receiptPojo.setUrl(NewPath);
                        receiptPojo.setUserId(String.valueOf(result));
                        receiptRepository.save(receiptPojo);
                        res.setStatus(HttpServletResponse.SC_OK);
                        json.addProperty("message","File uploaded");
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
            else{
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                json.addProperty("message","You are unauthorized");
            }

        }else{
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            json.addProperty("message","You are unauthorized");
        }
        return json.toString();
    }

    @RequestMapping(value="/transaction/{id}/attachments", method=RequestMethod.GET)
    public List<ReceiptPojo> getReceipt(@PathVariable(value="id") String transactionId, HttpServletRequest req, HttpServletResponse res){

        JsonObject json = new JsonObject();
        System.out.println("Local Environment");
        String authHeader = req.getHeader("Authorization");

        if (authHeader==null){
            List<ReceiptPojo> newpojo1 = new ArrayList<ReceiptPojo>();
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return newpojo1;
        }

        else {
            int result = userDao.authUserCheck(authHeader);
            if(result>0){
                List<ExpensePojo> expensePojoRecord = expenseRepository.findAllById(transactionId);

                if(expensePojoRecord.size()>0){
                    ExpensePojo expenseRecord = expensePojoRecord.get(0);
                    if(Integer.parseInt(expenseRecord.getUserId()) == result){
                        res.setStatus(HttpServletResponse.SC_OK);
                        return receiptRepository.findByTransactionId(transactionId);
                    }
                    else{
                        res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        List<ReceiptPojo> newpojo1 = new ArrayList<ReceiptPojo>();
                        return newpojo1;
                    }
                }
                else{
                    res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    List<ReceiptPojo> newpojo1 = new ArrayList<ReceiptPojo>();
                    return newpojo1;
                }
            }
            else{
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                List<ReceiptPojo> newpojo1 = new ArrayList<ReceiptPojo>();
                return newpojo1;
            }

        }
    }

    @RequestMapping(value="/transaction/{id}/attachments/{idAttachments}", method=RequestMethod.DELETE)
    public String deleteAttachment(@PathVariable(value="id") String transactionId,
                                   @PathVariable(value="idAttachments") String attachmentId,
                                   HttpServletRequest req, HttpServletResponse res){

        System.out.println("Local Environment");

        JsonObject json = new JsonObject();

        String header = req.getHeader("Authorization");
        if(header != null) {
            int result = userDao.authUserCheck(header);
            if(result>0){
                if(transactionId!="") {
                    if (attachmentId != ""){
                        List<ReceiptPojo> rpList = receiptRepository.findByReceiptid(attachmentId);
                        ReceiptPojo rp = rpList.get(0);
                        System.out.println("Receipt has tx id as" + rp.getTransactionId());

                        if(rp.getTransactionId().equals(transactionId)){
                            if(Integer.parseInt(rp.getUserId()) == result)
                            {
                                receiptRepository.delete(rp);
                                res.setStatus(HttpServletResponse.SC_NO_CONTENT);
                                json.addProperty("message","Record deleted");
                                return json.toString();
                            }
                            else{
                                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                                return json.toString();
                            }
                        }

                    }
                    else{
                        json.addProperty("message", "Invalid attachment Id.");
                        return json.toString();
                    }
                }
                else{
                    json.addProperty("message", "Invalid Expense Id.");
                    return json.toString();
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

        return null;

    }

    @RequestMapping(value="/transaction/{id}/attachments/{idAttachments}", method=RequestMethod.PUT)
    public String updateReceipt(@PathVariable(value="id") String transactionId,
                                 @PathVariable(value="idAttachments") String attachmentId,
                                @RequestParam ("file") MultipartFile file,
                                HttpServletRequest req, HttpServletResponse res){

        System.out.println("Local Environment");

        JsonObject json = new JsonObject();

        String filePath = "/home/aakash/Documents/";
        String fileName = file.getOriginalFilename();
        String NewPath = filePath + fileName;
        System.out.println("PATH IS " + filePath);

        String header = req.getHeader("Authorization");
        if(header != null) {
            int result = userDao.authUserCheck(header);
            if(result>0){
                if(transactionId!="") {
                    if (attachmentId != ""){
                        List<ReceiptPojo> rpList = receiptRepository.findByReceiptid(attachmentId);
                        ReceiptPojo rp = rpList.get(0);
                        System.out.println("Receipt has tx id as" + rp.getTransactionId());
                        if(rp.getTransactionId().equals(transactionId)){
                            if(Integer.parseInt(rp.getUserId()) == result){
                                File dest = new File(NewPath);
                                try {
                                    file.transferTo(dest);
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                                rp.setTransactionId(rp.getTransactionId());
                                rp.setUrl(NewPath);
                                rp.setUserId(rp.getUserId());
                                receiptRepository.save(rp);
                                res.setStatus(HttpServletResponse.SC_OK);
                                json.addProperty("message","Record updated!");
                                return json.toString();
                            }
                            else{
                                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                                return json.toString();
                            }
                        }
                    }
                    else{
                        json.addProperty("message", "Invalid attachment Id.");
                        return json.toString();
                    }
                }
                else{
                    json.addProperty("message", "Invalid Expense Id.");
                    return json.toString();
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

        return null;

    }


}
