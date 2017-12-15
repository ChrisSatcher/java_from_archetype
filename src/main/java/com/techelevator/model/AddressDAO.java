package com.techelevator.model;

import java.util.List;

public interface AddressDAO {

	List<Address> getAllAddresses();
	Address getAddressByAddressId(int addressId);
	Address getAddressByPersonId(int personId);
}
