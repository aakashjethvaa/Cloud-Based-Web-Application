package cloud.assignment2.cloudassignment2.user;

import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;


@RestController
public class UserController {
	

	
	@Autowired
	private UserDao userdao;
	
	@Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="/user")
	public List<UserPojo> getAll()
	{
		return userdao.getAll();
	}
	
	@RequestMapping(value="/")
	public String authUser(HttpServletRequest request, HttpServletResponse response) {
		String authHeader = request.getHeader("Authorization");
		JsonObject jsonObject = new JsonObject();
		if(authHeader!=null)
		{
			authHeader = authHeader.replaceFirst("Basic ", "");
			String decodedString = new String(Base64.getDecoder().decode(authHeader.getBytes()));
			//jsonObject.addProperty("decodeString", decodedString);
			StringTokenizer itr = new StringTokenizer(decodedString, ":");
			String email = itr.nextToken();
			
			if(userdao.checkUser(email) == null)
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
	
	
	
	@RequestMapping(value="/user/register" , method=RequestMethod.POST)
		public String addUser(@RequestBody UserPojo userpojo) {
		if((userdao.checkUser(userpojo.getEmail()) == null)){
			UserPojo up = new UserPojo();
			up.setId(userpojo.getId());
			up.setName(userpojo.getName());
			up.setEmail(userpojo.getEmail());
			up.setPassword(bCryptPasswordEncoder.encode(userpojo.getPassword()));
			userdao.addUser(up);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("message", "User added successfully");
			return jsonObject.toString();
		}
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("message", "User already exists");
		return jsonObject.toString();
	}
	
}
