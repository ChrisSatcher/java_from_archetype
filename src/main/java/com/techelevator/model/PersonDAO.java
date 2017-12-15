package com.techelevator.model;

import java.util.List;

public interface PersonDAO {

	List<Person> getAllPersons();
	Person getPersonById(int personId);
	List<Person> getPersonsByAddressId(int addressId);
	
}
