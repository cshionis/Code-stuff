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
-- Name: videos; Type: TABLE; Schema: public; Owner: Nikolas; Tablespace: 
--

CREATE TABLE videos (
    id integer NOT NULL,
    title character varying(200),
    genre character varying(200),
    url text,
    description text
);


ALTER TABLE public.videos OWNER TO "Nikolas";

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: Nikolas
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO "Nikolas";

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Nikolas
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Nikolas
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: Nikolas
--

COPY videos (id, title, genre, url, description) FROM stdin;
7	Funny animals	Funny	VxvDVhjALoU	Animals being funny
8	Dodgeball - Best bits	Movie lines	3A_WXBpT6ag	Squeeeeze it!
16	Old Scool	Movie lines	LQEpyfH_Xxg	You are my boy Blue!
17	Queen - Bohemian Rhapsody	Music	3p4MZJsexEs	Best song ever
18	Best tennis points 2013	Sports	LL_Jko-z334	
19	Italian mafia	Documentary	HdfmWUYsm-g	
4	Apoel - Lyon	Sports	ZNNKdpS9P3Y	Etsi gama o thrylos olan
21	C++ - Templates	Educational	W0aoAm6eYSk	Learn more and more
28	Apoel Ultras	Sports	dKUqf_qnRaU	
29	The Wire - Clay Davis	Movie lines	70eU840lc38	Shiiiiiii
\.


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Nikolas
--

SELECT pg_catalog.setval('videos_id_seq', 29, true);


--
-- Name: videos_pkey; Type: CONSTRAINT; Schema: public; Owner: Nikolas; Tablespace: 
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


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

