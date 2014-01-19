--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


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
-- Name: movies; Type: TABLE; Schema: public; Owner: Nikolas; Tablespace: 
--

CREATE TABLE movies (
    id integer NOT NULL,
    title character varying(1000),
    poster text,
    year character varying(4),
    rated character varying(10),
    released character varying(25),
    runtime character varying(25),
    genre character varying(100),
    director character varying(100),
    writers character varying(200),
    actors character varying(200),
    plot text
);


ALTER TABLE public.movies OWNER TO "Nikolas";

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: Nikolas
--

CREATE SEQUENCE movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_id_seq OWNER TO "Nikolas";

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Nikolas
--

ALTER SEQUENCE movies_id_seq OWNED BY movies.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Nikolas
--

ALTER TABLE ONLY actors ALTER COLUMN id SET DEFAULT nextval('actors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Nikolas
--

ALTER TABLE ONLY movies ALTER COLUMN id SET DEFAULT nextval('movies_id_seq'::regclass);


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
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: Nikolas
--

COPY movies (id, title, poster, year, rated, released, runtime, genre, director, writers, actors, plot) FROM stdin;
19	Oldboy	http://ia.media-imdb.com/images/M/MV5BMTI3NTQyMzU5M15BMl5BanBnXkFtZTcwMTM2MjgyMQ@@._V1_SX300.jpg	2003	R	21 Nov 2003	120 min	Drama, Mystery, Thriller	Chan-wook Park	Garon Tsuchiya (story), Nobuaki Minegishi (comic), Chan-wook Park (screenplay), Chun-hyeong Lim (screenplay), Jo-yun Hwang (screenplay), Joon-hyung Lim	Min-sik Choi, Ji-tae Yu, Hye-jeong Kang, Dae-han Ji	After being kidnapped and imprisoned for 15 years, Oh Dae-Su is released, only to find that he must find his captor in 5 days.
20	The Wolf of Wall Street	http://ia.media-imdb.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_SX300.jpg	2013	R	25 Dec 2013	180 min	Biography, Comedy, Crime	Martin Scorsese	Terence Winter (screenplay), Jordan Belfort (book)	Leonardo DiCaprio, Jonah Hill, Margot Robbie, Matthew McConaughey	Based on the true story of Jordan Belfort, from his rise to a wealthy stockbroker living the high life to his fall involving crime, corruption and the federal government.
\.


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Nikolas
--

SELECT pg_catalog.setval('movies_id_seq', 20, true);


--
-- Name: actors_pkey; Type: CONSTRAINT; Schema: public; Owner: Nikolas; Tablespace: 
--

ALTER TABLE ONLY actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (id);


--
-- Name: movies_pkey; Type: CONSTRAINT; Schema: public; Owner: Nikolas; Tablespace: 
--

ALTER TABLE ONLY movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: Nikolas
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "Nikolas";
GRANT ALL ON SCHEMA public TO "Nikolas";
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

