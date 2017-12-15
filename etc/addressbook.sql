DROP TABLE person_address;
DROP TABLE person;
DROP TABLE address;
DROP SEQUENCE seq_person_id;
DROP SEQUENCE seq_address_id;

CREATE SEQUENCE seq_person_id;
CREATE TABLE person (
        person_id integer NOT NULL DEFAULT nextval('seq_person_id'),
        first_name VARCHAR(35) NOT NULL,
        last_name VARCHAR(35) NOT NULL,

        CONSTRAINT pk_person_person_id PRIMARY KEY (person_id)
);

CREATE SEQUENCE seq_address_id;           
CREATE TABLE address (
        address_id integer NOT NULL DEFAULT nextval('seq_address_id'),
        description VARCHAR(255),
        line1 VARCHAR(128) NOT NULL,
        line2 VARCHAR(128),
        city VARCHAR(40) NOT NULL,
        state VARCHAR(2) NOT NULL,
        postal_code VARCHAR(10) NOT NULL,

        CONSTRAINT pk_address_address_id PRIMARY KEY (address_id)
);

CREATE TABLE person_address (
        person_id integer NOT NULL,
        address_id integer NOT NULL,
        CONSTRAINT pk_person_address_person_id_address_id PRIMARY KEY (person_id, address_id)
);

INSERT INTO person (person_id, first_name, last_name) VALUES (1, 'Jim', 'Stone');
INSERT INTO person (person_id, first_name, last_name) VALUES (2, 'Bobby', 'Reagan');
INSERT INTO person (person_id, first_name, last_name) VALUES (3, 'Ratboy', 'Jones');
INSERT INTO person (person_id, first_name, last_name) VALUES (4, 'Matt', 'Reagan');

INSERT INTO address (address_id, description, line1, line2, city, state, postal_code) VALUES (1, 'Jims Place', '123 1st Street', '', 'Columbus', 'OH', '43212');
INSERT INTO address (address_id, description, line1, line2, city, state, postal_code) VALUES (2, 'Homestreet Home', '138 Homestreet', 'Apt 2', 'Columbus', 'OH', '43215');
INSERT INTO address (address_id, description, line1, line2, city, state, postal_code) VALUES (3, 'The Rats Nest', '1 Underbridge Road', '', 'Columbus', 'OH', '43220');

INSERT INTO person_address (person_id, address_id) VALUES (1,1);
INSERT INTO person_address (person_id, address_id) VALUES (2, 2);
INSERT INTO person_address (person_id, address_id) VALUES (3,3);
INSERT INTO person_address (person_id, address_id) VALUES (4,2);

ALTER TABLE person_address ADD FOREIGN KEY (person_id) REFERENCES person(person_id);
ALTER TABLE person_address ADD FOREIGN KEY (address_id) REFERENCES address(address_id);