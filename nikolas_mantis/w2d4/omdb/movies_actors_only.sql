--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actors; Type: TABLE; Schema: public; Owner: Nikolas; Tablespace: 
--

CREATE TABLE actors (
    id integer NOT NULL,
    first_name character varying(200),
    last_name character varying(200),
    image_url text,
    dob character varying(200)
);


ALTER TABLE public.actors OWNER TO "Nikolas";

--
-- Name: actors_id_seq; Type: SEQUENCE; Schema: public; Owner: Nikolas
--

CREATE SEQUENCE actors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actors_id_seq OWNER TO "Nikolas";

--
-- Name: actors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Nikolas
--

ALTER SEQUENCE actors_id_seq OWNED BY actors.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Nikolas
--

ALTER TABLE ONLY actors ALTER COLUMN id SET DEFAULT nextval('actors_id_seq'::regclass);


--
-- Data for Name: actors; Type: TABLE DATA; Schema: public; Owner: Nikolas
--

COPY actors (id, first_name, last_name, image_url, dob) FROM stdin;
9	Al	Paccino	www.google.com	2000-12-2
10	Morgan	Freeman	www.yahoo.com	1950-01-01
11	Matt	Damon	www.techcrunch.com	1970-04-04
\.


--
-- Name: actors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Nikolas
--

SELECT pg_catalog.setval('actors_id_seq', 11, true);


--
-- Name: actors_pkey; Type: CONSTRAINT; Schema: public; Owner: Nikolas; Tablespace: 
--

ALTER TABLE ONLY actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

