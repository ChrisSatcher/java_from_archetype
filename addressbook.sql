--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: seq_address_id; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seq_address_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE address (
    address_id integer DEFAULT nextval('seq_address_id'::regclass) NOT NULL,
    description character varying(255),
    line1 character varying(128) NOT NULL,
    line2 character varying(128),
    city character varying(40) NOT NULL,
    state character varying(2) NOT NULL,
    postal_code character varying(10) NOT NULL
);


--
-- Name: seq_person_id; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seq_person_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person (
    person_id integer DEFAULT nextval('seq_person_id'::regclass) NOT NULL,
    first_name character varying(35) NOT NULL,
    last_name character varying(35) NOT NULL
);


--
-- Name: person_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person_address (
    person_id integer NOT NULL,
    address_id integer NOT NULL
);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY address (address_id, description, line1, line2, city, state, postal_code) FROM stdin;
1	Jims Place	123 1st Street		Columbus	OH	43212
2	Homestreet Home	138 Homestreet	Apt 2	Columbus	OH	43215
3	The Rats Nest	1 Underbridge Road		Columbus	OH	43220
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: -
--

COPY person (person_id, first_name, last_name) FROM stdin;
1	Jim	Stone
2	Bobby	Reagan
3	Ratboy	Jones
4	Matt	Reagan
\.


--
-- Data for Name: person_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY person_address (person_id, address_id) FROM stdin;
1	1
2	2
3	3
4	2
\.


--
-- Name: seq_address_id; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('seq_address_id', 1, false);


--
-- Name: seq_person_id; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('seq_person_id', 1, false);


--
-- Name: address pk_address_address_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY address
    ADD CONSTRAINT pk_address_address_id PRIMARY KEY (address_id);


--
-- Name: person_address pk_person_address_person_id_address_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT pk_person_address_person_id_address_id PRIMARY KEY (person_id, address_id);


--
-- Name: person pk_person_person_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pk_person_person_id PRIMARY KEY (person_id);


--
-- Name: person_address person_address_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT person_address_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id);


--
-- Name: person_address person_address_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_address
    ADD CONSTRAINT person_address_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(person_id);


--
-- PostgreSQL database dump complete
--

