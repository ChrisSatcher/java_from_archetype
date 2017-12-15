package com.techelevator.model.jdbc;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.Person;
import com.techelevator.model.PersonDAO;

@Component
public class JdbcPersonDAO implements PersonDAO {

	private final static String selectSql = "SELECT person_id, first_name, last_name FROM person";
	
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JdbcPersonDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public List<Person> getAllPersons() {
		List<Person> persons = new ArrayList<Person>();
		SqlRowSet results = jdbcTemplate.queryForRowSet(selectSql);
		while(results.next()) {
			persons.add(mapRowToPerson(results));
		}
		return persons;
	}

	@Override
	public Person getPersonById(int personId) {
		Person person = null;
		String sql = selectSql + " WHERE person_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, personId);
		if (results.next()) {
			person = mapRowToPerson(results);
		}
		return person;
	}

	@Override
	public List<Person> getPersonsByAddressId(int addressId) {
		List<Person> persons = new ArrayList<Person>();
		String sql = new StringBuilder(selectSql)
				.append(" JOIN person_address ON person_address.person_id = person.person_id")
				.append(" JOIN address ON address.address_id = person_address.address_id")
				.append(" WHERE address.address_id = ?").toString();
				
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, addressId);
		while(results.next()) {
			persons.add(mapRowToPerson(results));
		}
		return persons;
	}
	
	private Person mapRowToPerson(SqlRowSet row) {
		Person person = new Person();
		person.setPesonId(row.getLong("person_id"));
		person.setFirstName(row.getString("first_name"));
		person.setLastName(row.getString("last_name"));
		return person;
	}

}
