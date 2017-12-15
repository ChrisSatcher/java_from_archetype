package com.techelevator.model.jdbc;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.Address;
import com.techelevator.model.AddressDAO;

@Component
public class JdbcAddressDAO implements AddressDAO {

	private final static String selectSql = "SELECT address_id, description, line1, line2, city, state, postal_code FROM address";
	
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JdbcAddressDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public List<Address> getAllAddresses() {
		List<Address> addresses = new ArrayList<Address>();
		SqlRowSet results = jdbcTemplate.queryForRowSet(selectSql);
		while(results.next()) {
			addresses.add(mapRowToAddress(results));
		}
		return addresses;
	}

	@Override
	public Address getAddressByAddressId(int addressId) {
		Address address = null;
		String sql = selectSql + " WHERE address_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, addressId);
		if (results.next()) {
			address = mapRowToAddress(results);
		}

		return address;
	}

	@Override
	public Address getAddressByPersonId(int personId) {
		Address address = null;
		String sql = new StringBuilder(selectSql)
				.append(" JOIN person_address ON person_address.address_id = address.address_id")
				.append(" JOIN person ON person.person_id = person_address.person_id")
				.append(" WHERE person.person_id = ?").toString();
				
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, personId);
		if (results.next()) {
			address = mapRowToAddress(results);
		}
		return address;
	}
	
	private Address mapRowToAddress(SqlRowSet row) {
		Address address = new Address();
		address.setAddressId(row.getLong("address_id"));
		address.setDescription(row.getString("description"));
		address.setLine1(row.getString("line1"));
		address.setLine2(row.getString("line2"));
		address.setCity(row.getString("city"));
		address.setState(row.getString("state"));
		address.setPostalCode(row.getString("postal_code"));

		return address;
	}

}
