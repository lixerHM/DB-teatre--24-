--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2025-05-21 09:39:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 231 (class 1255 OID 65521)
-- Name: deskription_predstav(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deskription_predstav() RETURNS text
    LANGUAGE sql
    AS $$
select description from predstavlenie;
$$;


ALTER FUNCTION public.deskription_predstav() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 65522)
-- Name: kassir(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kassir() RETURNS character varying
    LANGUAGE sql
    AS $$
select dolzhnost from kassir;
$$;


ALTER FUNCTION public.kassir() OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 65589)
-- Name: log_admins(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_admins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    INSERT INTO logger (log_username)  
    VALUES (ROW(OLD.id, OLD.username, OLD.password)::text);
    
    RAISE NOTICE 'admins table updated #%', OLD.id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_admins() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 65591)
-- Name: log_mesto(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_mesto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    INSERT INTO logger (log_username)  
    VALUES (ROW(OLD.id, OLD.name)::text);
    
    RAISE NOTICE 'mesto table updated #%', OLD.id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_mesto() OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 65592)
-- Name: log_predstavlenie(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_predstavlenie() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    INSERT INTO logger (log_username)  
    VALUES (ROW(OLD.id, OLD.name, OLD.date,old.description)::text);
    
    RAISE NOTICE 'predstavlenie table updated #%', OLD.id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_predstavlenie() OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 65590)
-- Name: log_zritel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_zritel() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    INSERT INTO logger (log_username)  
    VALUES (ROW(OLD.id, OLD.imya, OLD.familya,old.contact_data)::text);
    
    RAISE NOTICE 'admins table updated #%', OLD.id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_zritel() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 65307)
-- Name: mesto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mesto (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.mesto OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 65486)
-- Name: price_ticket(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.price_ticket() RETURNS SETOF public.mesto
    LANGUAGE sql
    AS $$
SELECT * FROM mesto;
$$;


ALTER FUNCTION public.price_ticket() OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 65480)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 65479)
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admins_id_seq OWNER TO postgres;

--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 226
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- TOC entry 223 (class 1259 OID 65327)
-- Name: kassir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kassir (
    id integer NOT NULL,
    imya character varying(100) NOT NULL,
    familya character varying(100) NOT NULL,
    dolzhnost character varying(100) NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.kassir OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 65375)
-- Name: dolzhnost; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.dolzhnost AS
 SELECT kassir.dolzhnost
   FROM public.kassir
  WHERE (kassir.visible IS TRUE);


ALTER TABLE public.dolzhnost OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 65379)
-- Name: dolzhnosta; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.dolzhnosta AS
 SELECT kassir.id,
    kassir.dolzhnost
   FROM public.kassir
  WHERE (kassir.visible IS TRUE);


ALTER TABLE public.dolzhnosta OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 65326)
-- Name: kassir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kassir_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kassir_id_seq OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 222
-- Name: kassir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kassir_id_seq OWNED BY public.kassir.id;


--
-- TOC entry 229 (class 1259 OID 65558)
-- Name: logger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logger (
    id_ bigint NOT NULL,
    log_ text NOT NULL,
    time_ timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.logger OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 65557)
-- Name: logger_id__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logger_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logger_id__seq OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 228
-- Name: logger_id__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logger_id__seq OWNED BY public.logger.id_;


--
-- TOC entry 216 (class 1259 OID 65306)
-- Name: mesto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mesto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mesto_id_seq OWNER TO postgres;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 216
-- Name: mesto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mesto_id_seq OWNED BY public.mesto.id;


--
-- TOC entry 215 (class 1259 OID 65298)
-- Name: predstavlenie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.predstavlenie (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date date NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.predstavlenie OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 65297)
-- Name: predstavlenie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.predstavlenie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.predstavlenie_id_seq OWNER TO postgres;

--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 214
-- Name: predstavlenie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.predstavlenie_id_seq OWNED BY public.predstavlenie.id;


--
-- TOC entry 219 (class 1259 OID 65312)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    id integer NOT NULL,
    performance_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    mesto integer NOT NULL,
    date_prodaze date NOT NULL
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 65311)
-- Name: ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 218
-- Name: ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_id_seq OWNED BY public.ticket.id;


--
-- TOC entry 221 (class 1259 OID 65319)
-- Name: zritel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zritel (
    id integer NOT NULL,
    imya character varying(100) NOT NULL,
    familya character varying(100) NOT NULL,
    contact_data character varying(255) NOT NULL
);


ALTER TABLE public.zritel OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 65318)
-- Name: zritel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zritel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zritel_id_seq OWNER TO postgres;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 220
-- Name: zritel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zritel_id_seq OWNED BY public.zritel.id;


--
-- TOC entry 3224 (class 2604 OID 65483)
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 65330)
-- Name: kassir id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassir ALTER COLUMN id SET DEFAULT nextval('public.kassir_id_seq'::regclass);


--
-- TOC entry 3225 (class 2604 OID 65561)
-- Name: logger id_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logger ALTER COLUMN id_ SET DEFAULT nextval('public.logger_id__seq'::regclass);


--
-- TOC entry 3219 (class 2604 OID 65310)
-- Name: mesto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesto ALTER COLUMN id SET DEFAULT nextval('public.mesto_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 65301)
-- Name: predstavlenie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predstavlenie ALTER COLUMN id SET DEFAULT nextval('public.predstavlenie_id_seq'::regclass);


--
-- TOC entry 3220 (class 2604 OID 65315)
-- Name: ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN id SET DEFAULT nextval('public.ticket_id_seq'::regclass);


--
-- TOC entry 3221 (class 2604 OID 65322)
-- Name: zritel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zritel ALTER COLUMN id SET DEFAULT nextval('public.zritel_id_seq'::regclass);


--
-- TOC entry 3396 (class 0 OID 65480)
-- Dependencies: 227
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, username, password) FROM stdin;
1	admin	0000
\.


--
-- TOC entry 3394 (class 0 OID 65327)
-- Dependencies: 223
-- Data for Name: kassir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kassir (id, imya, familya, dolzhnost, visible) FROM stdin;
1	fti	hi[ppp	kassir	t
2	geniy	grogo	kassir	t
3	fola	horo	kassir	t
4	kola	horo	kassir	t
5	keke	jojja	kassir	t
\.


--
-- TOC entry 3398 (class 0 OID 65558)
-- Dependencies: 229
-- Data for Name: logger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logger (id_, log_, time_) FROM stdin;
\.


--
-- TOC entry 3388 (class 0 OID 65307)
-- Dependencies: 217
-- Data for Name: mesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mesto (id, name) FROM stdin;
1	grogo
2	grigo
3	kiany
4	lolpoa
5	kiya
\.


--
-- TOC entry 3386 (class 0 OID 65298)
-- Dependencies: 215
-- Data for Name: predstavlenie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.predstavlenie (id, name, date, description) FROM stdin;
5	kryaz	2021-10-30	lol
4	juju\n	2005-12-21	grag
3	fall	2021-12-10	pol
2	temmmi	2020-05-01	ullu
1	maks	2000-03-02	lily
\.


--
-- TOC entry 3390 (class 0 OID 65312)
-- Dependencies: 219
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket (id, performance_id, price, mesto, date_prodaze) FROM stdin;
5	5	14.00	5	2025-08-12
4	4	12.00	4	2025-12-14
3	3	11.00	3	2025-10-23
2	2	10.00	2	2025-10-21
1	1	10.00	1	2025-12-02
\.


--
-- TOC entry 3392 (class 0 OID 65319)
-- Dependencies: 221
-- Data for Name: zritel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zritel (id, imya, familya, contact_data) FROM stdin;
5	kolya	jojo	pasport
4	hoto	tommy	pasport
3	fsrhst	lolorma	pasport
2	grogo	grishko	pasport
1	kolya	glushko	pasport
\.


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 226
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, true);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 222
-- Name: kassir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kassir_id_seq', 3, true);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 228
-- Name: logger_id__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logger_id__seq', 1, false);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 216
-- Name: mesto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mesto_id_seq', 1, true);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 214
-- Name: predstavlenie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.predstavlenie_id_seq', 1, true);


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 218
-- Name: ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_id_seq', 1, false);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 220
-- Name: zritel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zritel_id_seq', 1, true);


--
-- TOC entry 3238 (class 2606 OID 65485)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 65337)
-- Name: kassir kassir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassir
    ADD CONSTRAINT kassir_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 65339)
-- Name: mesto mesto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesto
    ADD CONSTRAINT mesto_pkey PRIMARY KEY (id);


--
-- TOC entry 3228 (class 2606 OID 65305)
-- Name: predstavlenie predstavlenie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predstavlenie
    ADD CONSTRAINT predstavlenie_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 65317)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 65341)
-- Name: zritel zritel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zritel
    ADD CONSTRAINT zritel_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2618 OID 65383)
-- Name: dolzhnosta del_dolzhnost; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE del_dolzhnost AS
    ON DELETE TO public.dolzhnosta DO INSTEAD  UPDATE public.kassir SET visible = false
  WHERE (kassir.id = old.id);


--
-- TOC entry 3239 (class 2606 OID 65331)
-- Name: ticket peres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT peres FOREIGN KEY (performance_id) REFERENCES public.predstavlenie(id) NOT VALID;


-- Completed on 2025-05-21 09:39:53

--
-- PostgreSQL database dump complete
--

