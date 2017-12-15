package com.techelevator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.techelevator.model.AddressDAO;
import com.techelevator.model.Person;
import com.techelevator.model.PersonDAO;

@Controller 
public class AddressBookController {

	
	private PersonDAO personDAO;
	private AddressDAO addressDAO;
	
	@Autowired
	public AddressBookController(PersonDAO personDAO, AddressDAO addressDAO)
	{
		this.personDAO = personDAO;
		this.addressDAO = addressDAO;
	}
	
	@RequestMapping("/")
	public String displayPersonList(ModelMap model) {
		
		List<Person> persons = this.personDAO.getAllPersons();
		model.addAttribute("persons", persons);
		return "greeting";
	}
}
