package cloud.assignment2.cloudassignment2.user;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserDao {
	
	@Autowired
	UserRepository userRepository;
	
	public UserPojo checkUser(String email)
	{
		for(UserPojo user: userRepository.findAll())
		{
			if(user.getEmail().equals(email))
				return user;
		}
		return null;
	}
	
	public void addUser(UserPojo userobj)
	{
		userRepository.save(userobj);
	}
	
	public List<UserPojo> getAll(){
		
		List<UserPojo> newls = new ArrayList<UserPojo>();
		userRepository.findAll()
		.forEach(newls::add);
		return newls;

	}
    public UserPojo getUserPojo(String header){
        System.out.println("Header is " +header);
        String head = header.replaceFirst("Basic ", "");
        String decodedString = new String(Base64.getDecoder().decode(head.getBytes()));
        StringTokenizer itr = new StringTokenizer(decodedString, ":");
        String email = itr.nextToken();
        UserPojo userpojo = checkUser(email);
        return userpojo;
	}

	public int authUserCheck(String header){
		System.out.println("Header is " +header);
		String head = header.replaceFirst("Basic ", "");
		String decodedString = new String(Base64.getDecoder().decode(head.getBytes()));
		StringTokenizer itr = new StringTokenizer(decodedString, ":");
		String email = itr.nextToken();
		UserPojo userpojo = checkUser(email);
		if(userpojo == null){
			return 0;
		}
		else return Integer.parseInt(userpojo.getId());
	}

}
