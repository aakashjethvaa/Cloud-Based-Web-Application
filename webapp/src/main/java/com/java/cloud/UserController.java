package com.java.cloud;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.InstanceProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.google.gson.Gson;
import com.timgroup.statsd.StatsDClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.google.gson.JsonObject;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private  TransactionRepository trsnRepo;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private AmazonClient amazonClient;

    @Autowired
    private StatsDClient statsDClient;



    @RequestMapping(value = "/user")
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @RequestMapping(value="/")
    public String authUser1(HttpServletRequest request, HttpServletResponse response) {
        String authHeader = request.getHeader("Authorization");
        JsonObject jsonObject = new JsonObject();
        if(authHeader!=null)
        {
            authHeader = authHeader.replaceFirst("Basic ", "");
            String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
            //jsonObject.addProperty("decodeString", decodedString);
            StringTokenizer itr = new StringTokenizer(decodedString, ":");
            String email = itr.nextToken();

            if(userRepository.findByEmail(email)== null)
            {
                jsonObject.addProperty("message", "The user doesnot exist.Try again!");
            }
            else
            {
                jsonObject.addProperty("message", "You are logged in. current time is " + new Date().toString());
            }

            return jsonObject.toString();
        }
        jsonObject.addProperty("message", "You are not logged in!");
        return jsonObject.toString();
    }

    @RequestMapping(value="/time")
    public String getTime(){
        statsDClient.incrementCounter("getTime");
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", "Current time is :" +new Date().toString());
        return  jsonObject.toString();
    }
    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String addUser(@RequestBody User user)
    {
        statsDClient.incrementCounter("addUser");
        if((userRepository.findByEmail(user.getEmail()) == null)){
            User up = new User();
            up.setId(user.getId());
            up.setEmail(user.getEmail());
            up.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
            userRepository.save(up);

            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("message", "User added successfully");
            return jsonObject.toString();
        }
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", "User already exists");
        return jsonObject.toString();
    }


    @RequestMapping("/api/ping")
    public String getPing() {
            return "OK";
    }

    @RequestMapping(value = "/transaction", method = RequestMethod.POST)
    public String createTransaction(@RequestBody Transaction transaction){
        statsDClient.incrementCounter("createTransaction");
        JsonObject j = new JsonObject();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        try{

            User user = userRepository.findByEmail(auth.getName());

            Transaction newtransaction = new Transaction();
            newtransaction.setAmount(transaction.getAmount());
            newtransaction.setCategory(transaction.getCategory());
            newtransaction.setDescription(transaction.getDescription());
            newtransaction.setDate(transaction.getDate());
            newtransaction.setMerchant(transaction.getMerchant());
            newtransaction.setUser(user);
            trsnRepo.save(newtransaction);

            j.addProperty("message", "Transaction added successfully");
            return j.toString();


        } catch (Exception e){
            j.addProperty("message", e.getMessage());
            return j.toString();
        }

    }

    @RequestMapping(value = "/transaction", method = RequestMethod.GET)
    public String getTransaction() {
        statsDClient.incrementCounter("getTransaction");
        JsonObject j = new JsonObject();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userRepository.findByEmail(auth.getName());
        List<Transaction> transactions = trsnRepo.findByUser(user);
        Gson gson = new Gson();
        String txns= gson.toJson(transactions);
        return txns;
    }

    @RequestMapping(value = "/transaction/{id}", method = RequestMethod.PUT)
    public String updateTransaction(@PathVariable("id") Long id, @RequestBody Transaction transaction){
        statsDClient.incrementCounter("updateTransaction");

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userRepository.findByEmail(auth.getName());
        JsonObject j =new JsonObject();
        List<Transaction> txns = trsnRepo.findByUser(user);
        Optional<Transaction> cr = null;
        /*for(Transaction txn : txns){

            if(txn.getId()==id){
                 currentTransaction = txn;
            }
        }*/
        cr = trsnRepo.findById(id);
        Transaction currentTransaction = cr.get();
        //Transaction currentTransaction = (Transaction) trsnRepo.findByTaskId(id);
        //if(user.equals(currentTransaction.getUser())){
        currentTransaction.setMerchant(transaction.getMerchant());
        currentTransaction.setDate(transaction.getDate());
        currentTransaction.setDescription(transaction.getDescription());
        currentTransaction.setAmount(transaction.getAmount());

        trsnRepo.save(currentTransaction);

        j.addProperty("message", "Transaction Updated");
        //response.setStatus(HttpServletResponse.SC_OK);
        return j.toString();


        //return j.toString();


    }

    @RequestMapping(value = "/transaction/{id}", method = RequestMethod.DELETE)
    public String DeleteTransaction(@PathVariable("id") Long id) {
        statsDClient.incrementCounter("deleteTransaction");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userRepository.findByEmail(auth.getName());
        JsonObject j =new JsonObject();
        List<Transaction> txns = trsnRepo.findByUser(user);

        /*for(Transaction txn : txns){


            if(txn.getId().toString().equals(id.toString())){
                currentTransaction = txn;
            }
        }*/
        Optional<Transaction> cr = null;
        /*for(Transaction txn : txns){

            if(txn.getId()==id){
                 currentTransaction = txn;
            }
        }*/
        cr = trsnRepo.findById(id);
        Transaction currentTransaction = cr.get();
        trsnRepo.delete(currentTransaction);
        j.addProperty("message", "Transaction Deleted");
        return j.toString();
    }


        @GetMapping("/transaction/{id}/attachment")
        public ResponseEntity<Object> getAttachment(@PathVariable(value="id") Long id){
            statsDClient.incrementCounter("getAttachment");
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user = userRepository.findByEmail(auth.getName());
            Optional<Transaction> trn = trsnRepo.findById(id);
            Transaction crtrn = trn.get();
            if(crtrn.getUser().getId() != user.getId()){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }
            List<Attachment> attachments = crtrn.getAttachments();
            List<String> attstr = new ArrayList<String>();
            for(Attachment a : attachments){
                String ste = a.getId()+":"+a.getUrl();
                attstr.add(ste);
            }
            Gson gson = new Gson();
            String atts= gson.toJson(attstr);

            return ResponseEntity.ok(atts);
        }

        @PostMapping("/transaction/{id}/attachment")
        public ResponseEntity<Object> uploadAttachment(@PathVariable(value="id") Long id, @RequestPart(value="file") MultipartFile file){

            statsDClient.incrementCounter("uploadAttachment");
            String mimeType = file.getContentType();
            String type = mimeType.split("/")[0];
            if (!type.equalsIgnoreCase("image")) {
                return ResponseEntity.badRequest().body("Only Images allowed");
            }
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user = userRepository.findByEmail(auth.getName());
            Optional<Transaction> trn = trsnRepo.findById(id);
            Transaction crtrn = trn.get();
            if(crtrn.getUser().getId() != user.getId()){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            String fileUrl = uploadReceipt(file,this.amazonClient.getProfilename());
            Attachment att = new Attachment();
            att.setUrl(fileUrl);
            att.setTransaction(crtrn);
            crtrn.getAttachments().add(att);
            trsnRepo.save(crtrn);

            return ResponseEntity.ok(fileUrl);
        }



        @PutMapping("/transaction/{id}/attachment/{aid}")
        public ResponseEntity<Object> uploadAttachment(@PathVariable(value="id") Long id,@PathVariable(value="aid") Long aid, @RequestPart(value="file") MultipartFile file){
            statsDClient.incrementCounter("updateAttachment");
            String mimeType = file.getContentType();
            String type = mimeType.split("/")[0];
            if (!type.equalsIgnoreCase("image")) {
                return ResponseEntity.badRequest().body("Only Images allowed");
            }
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user = userRepository.findByEmail(auth.getName());
            Optional<Transaction> trn = trsnRepo.findById(id);
            Transaction crtrn = trn.get();
            if(crtrn.getUser().getId() != user.getId()){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            List<Attachment> attachments = crtrn.getAttachments();
            Attachment cat = null;
            for(Attachment e : attachments){
                if(e.getId()==aid)
                    cat = e;

            }
            if(cat == null)
                return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
            String delete=this.amazonClient.deleteFileFromS3Bucket(cat.getUrl());
            String fileUrl = uploadReceipt(file,this.amazonClient.getProfilename());

            cat.setUrl(fileUrl);

            trsnRepo.save(crtrn);

            return ResponseEntity.ok(fileUrl);
        }

        @DeleteMapping("/transaction/{id}/attachment/{attachmentid}")
        public ResponseEntity<Object> deleteAttachment(@PathVariable(value="id") Long id, @PathVariable(value="attachmentid") Long aid){
            statsDClient.incrementCounter("deleteAttachment");
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user = userRepository.findByEmail(auth.getName());

            Optional<Transaction> trn = trsnRepo.findById(id);
            Transaction crtrn = trn.get();
            if(crtrn.getUser().getId() != user.getId()){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }
            List<Attachment> attachments = crtrn.getAttachments();
            Attachment cat = null;
            for(Attachment e : attachments){
                if(e.getId()==aid)
                    cat = e;

            }
            if(cat == null)
                return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
            String fileUrl = cat.getUrl();
            String message = deleteReceipt(fileUrl,this.amazonClient.getProfilename());
            attachments.remove(cat);
            trsnRepo.save(crtrn);
            //JsonObject j =new JsonObject();
            //j.addProperty("message", "Attachment Deleted");
            return ResponseEntity.ok("Attachment Delete");
        }

        @PostMapping("/uploadFile")
        public String uploadFile(@RequestPart(value = "file") MultipartFile file) {
            return this.amazonClient.uploadFile(file);
        }

        @DeleteMapping("/deleteFile")
        public String deleteFile(@RequestPart(value = "url") String fileUrl) {
            return this.amazonClient.deleteFileFromS3Bucket(fileUrl);
        }
        @PostMapping("/forgotpass")
        public String forgotPassword(@RequestPart(value="email") String userName) {
            System.out.println("Send reset link to: "+userName);
            statsDClient.incrementCounter("forgotPassword");
            User user = userRepository.findByEmail(userName);
            if(user!=null){
                BasicAWSCredentials credentials = this.amazonClient.getCredentials();
                //AmazonSNSClient snsClient = new AmazonSNSClient(new InstanceProfileCredentialsProvider());
                AmazonSNSClient snsClient = (AmazonSNSClient) AmazonSNSClient
                        .builder()
                        .withRegion(String.valueOf(Region.getRegion(Regions.US_EAST_1)))
                        .withCredentials(new AWSStaticCredentialsProvider(credentials))
                        .build();


                String topicArn = snsClient.createTopic("LambdaTopic").getTopicArn();

                PublishRequest publishRequest = new PublishRequest(topicArn, userName);
                PublishResult publishResult = snsClient.publish(publishRequest);
                // response.setStatus(HttpServletResponse.SC_OK);
                return "Request Sent";
            }else{
                return "No user found";
            }

    }

    private String uploadReceipt(MultipartFile file, String profilename){
        if(profilename.equals("dev")){
            return this.amazonClient.uploadFile(file);
        }else{

            try {
                // Get the file and save it somewhere
                byte[] bytes = file.getBytes();
                Path path = Paths.get(System.getProperty("user.dir") + file.getOriginalFilename());
                Files.write(path, bytes);
                return path.toString();

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return "path";
    }

    private String deleteReceipt(String fileURL, String profilename){
        if(profilename.equals("dev")){
            return this.amazonClient.deleteFileFromS3Bucket(fileURL);
        }else{

            try{

                //System.out.println("Delete filepath from AJX");
                File file = new File(fileURL);

                if(file.delete()){
                    return "File Deleted";
                }else{
                    return "Delete operation is failed.";
                }

            }catch(Exception e){

                e.printStackTrace();

            }
        }

        return "Deleted";

    }


//    @RequestMapping(value = "/deleteFileTest", method = RequestMethod.DELETE)
//    private String deleteReceipt(@RequestPart(value = "url") String fileURL){
//
//            try{
//
//                //System.out.println("Delete filepath from AJX");
//                File file = new File(fileURL);
//
//                if(file.delete()){
//                    return "File Deleted";
//                }else{
//                    return "Delete operation is failed.";
//                }
//
//            }catch(Exception e) {
//
//                e.printStackTrace();
//
//            }
//
//        return "Deleted";
//
//    }


}
