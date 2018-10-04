package com.cloud;

import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import aj.org.objectweb.asm.Type;

@RestController
public class TransactionController {

	@Autowired
	private TransactionRepository transactionRepository;

	@Autowired
	private UserRepository userRepository;

	@GetMapping("/transaction")
	public String getAllTransactionsByUserId(HttpServletRequest request, HttpServletResponse response) {
		String authHeader = request.getHeader("Authorization");
		JsonObject jsonObject = new JsonObject();
		if (authHeader != null) {
			authHeader = authHeader.replaceFirst("Basic ", "");
			String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
			// jsonObject.addProperty("decodeString", decodedString);
			StringTokenizer itr = new StringTokenizer(decodedString, ":");
			String email = itr.nextToken();
			User user = userRepository.findByEmail(email);
			if (user == null) {
				jsonObject.addProperty("message", "The user doesnot exist.Try again!");
			} else {
				List<Transaction> transationList = transactionRepository.findByUserId(user.getId());
				// jsonObject.addProperty("message", transationList.toString());
				Gson gson = new Gson();
				String jsonTransList = gson.toJson(transationList);
				// System.out.println("jsonStudents = " + jsonStudents);
				jsonObject.addProperty("", jsonTransList);

				// jsonObject.addProperty("message", "You are logged in. current time is " + new
				// Date().toString());
			}

			return jsonObject.toString();
		}
		jsonObject.addProperty("message", "You are not logged in!");
		return jsonObject.toString();
	}

	// public getAllTransactionsByUserId(@PathVariable (value = "userId") Long
	// userId,
	// Pageable pageable) {
	// return transactionRepository.findByUserId(userId, pageable);
	// }

	@PostMapping("/transaction")
	public String postTransactionsByUserId(HttpServletRequest request, HttpServletResponse response,
			@Valid @RequestBody Transaction transaction) {
		String authHeader = request.getHeader("Authorization");
		JsonObject jsonObject = new JsonObject();
		if (authHeader != null) {
			authHeader = authHeader.replaceFirst("Basic ", "");
			String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
			// jsonObject.addProperty("decodeString", decodedString);
			StringTokenizer itr = new StringTokenizer(decodedString, ":");
			String email = itr.nextToken();
			User user = userRepository.findByEmail(email);
			if (user == null) {
				jsonObject.addProperty("message", "The user doesnot exist.Try again!");
			} else {

				transaction.setUser(user);
				transactionRepository.save(transaction);
				// Gson gson = new Gson();
				// String jsonTransList = gson.toJson(transationFile);
				// System.out.println("jsonStudents = " + jsonStudents);
				jsonObject.addProperty("message", "The transaction is added successfully.");

			}
		}
		return jsonObject.toString();
	}

	@PutMapping("/transaction/{transactionId}")
	public String putTransactionsByUserId(HttpServletRequest request, HttpServletResponse response,
			@PathVariable(value = "transactionId") Long transactionId,
			@Valid @RequestBody Transaction transactionRequest)
	{
		
		String authHeader = request.getHeader("Authorization");
		JsonObject jsonObject = new JsonObject();
		if (authHeader != null) 
		{
			authHeader = authHeader.replaceFirst("Basic ", "");
			String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
			// jsonObject.addProperty("decodeString", decodedString);
			StringTokenizer itr = new StringTokenizer(decodedString, ":");
			String email = itr.nextToken();
			User user = userRepository.findByEmail(email);
			if (user == null) 
			{
				jsonObject.addProperty("message", "The user doesnot exist.Try again!");
			} else
				{
				
				//Get all transactions for the user
				List<Transaction> transactionList = transactionRepository.findByUserId(user.getId());
				Optional<Transaction> transaction = transactionRepository.findById(transactionId);
				Transaction tr = transaction.get();
				
					if(transactionList.contains(tr))
					{
						//Set all the new values
						tr.setAmount(transactionRequest.getAmount());
						tr.setCategory(transactionRequest.getCategory());
						tr.setDescription(transactionRequest.getDescription());
						tr.setMerchant(transactionRequest.getMerchant());
						Transaction tf= transactionRepository.save(tr);
						
						Gson gson = new Gson();
						String jsonTransList = gson.toJson(tf);
						jsonObject.addProperty("", jsonTransList);
						
					}
					else{
						jsonObject.addProperty("message", "The transaction does not belongs to particular user.");
					}
				}
		}
			return jsonObject.toString();
		
		}


	@DeleteMapping("transaction/{transactionId}")
	//
	public String deleteTransactionsByUserId(HttpServletRequest request, HttpServletResponse response,
			@PathVariable(value = "transactionId") Long transactionId)
	{
		
		String authHeader = request.getHeader("Authorization");
		JsonObject jsonObject = new JsonObject();
		if (authHeader != null) 
		{
			authHeader = authHeader.replaceFirst("Basic ", "");
			String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
			// jsonObject.addProperty("decodeString", decodedString);
			StringTokenizer itr = new StringTokenizer(decodedString, ":");
			String email = itr.nextToken();
			User user = userRepository.findByEmail(email);
			if (user == null) 
			{
				jsonObject.addProperty("message", "The user doesnot exist.Try again!");
			} else
				{
				
				List<Transaction> transactionList = transactionRepository.findByUserId(user.getId());
				Optional<Transaction> transaction = transactionRepository.findById(transactionId);
				Transaction tr = transaction.get();
				
				if(transactionList.contains(tr))
				{
				
			transactionRepository.delete(tr);
			jsonObject.addProperty("message", "The transaction is deleted successfully.");
				}
				else {
					jsonObject.addProperty("message", "The transaction does not belongs to particular user.");
				}	
		}
	}
		return jsonObject.toString();
	}
		
}
