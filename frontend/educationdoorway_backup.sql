--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_event (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    event_id integer NOT NULL,
    details character varying NOT NULL,
    branch character varying NOT NULL,
    role character varying,
    "userId" integer
);


ALTER TABLE public.activity_event OWNER TO postgres;

--
-- Name: activity_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_event_id_seq OWNER TO postgres;

--
-- Name: activity_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_event_id_seq OWNED BY public.activity_event.id;


--
-- Name: application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    course_label character varying,
    application_status character varying DEFAULT 'pending'::character varying,
    intake_year character varying,
    intake_month character varying,
    course_details character varying,
    "universityId" integer,
    "leadId" integer
);


ALTER TABLE public.application OWNER TO postgres;

--
-- Name: application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_id_seq OWNER TO postgres;

--
-- Name: application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_id_seq OWNED BY public.application.id;


--
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    details character varying,
    branch character varying
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branch_id_seq OWNER TO postgres;

--
-- Name: branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branch_id_seq OWNED BY public.branch.id;


--
-- Name: cats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cats (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    parent integer,
    label character varying NOT NULL,
    value character varying NOT NULL
);


ALTER TABLE public.cats OWNER TO postgres;

--
-- Name: cats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cats_id_seq OWNER TO postgres;

--
-- Name: cats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cats_id_seq OWNED BY public.cats.id;


--
-- Name: coachingclass; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coachingclass (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying NOT NULL,
    c_type character varying,
    class_date timestamp without time zone,
    is_present boolean DEFAULT false,
    "leadId" integer
);


ALTER TABLE public.coachingclass OWNER TO postgres;

--
-- Name: coachingclass_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coachingclass_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coachingclass_id_seq OWNER TO postgres;

--
-- Name: coachingclass_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coachingclass_id_seq OWNED BY public.coachingclass.id;


--
-- Name: kpi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kpi (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.kpi OWNER TO postgres;

--
-- Name: kpi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kpi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kpi_id_seq OWNER TO postgres;

--
-- Name: kpi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kpi_id_seq OWNED BY public.kpi.id;


--
-- Name: lead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lead (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    fullname character varying NOT NULL,
    email character varying NOT NULL,
    phone_no character varying NOT NULL,
    country character varying,
    application_country character varying,
    state character varying,
    address_details character varying,
    branch_name character varying,
    previous_educations text,
    last_education json,
    english_proficiency character varying,
    english_proficiency_result jsonb,
    purpose character varying,
    stage character varying,
    sub_stage character varying,
    source character varying DEFAULT 'others'::character varying,
    has_account boolean DEFAULT false NOT NULL,
    classes jsonb,
    exams jsonb,
    last_remark character varying,
    "assignedId" integer,
    interested_country character varying
);


ALTER TABLE public.lead OWNER TO postgres;

--
-- Name: lead_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lead_document (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    document_name character varying,
    document_link character varying,
    "leadId" integer
);


ALTER TABLE public.lead_document OWNER TO postgres;

--
-- Name: lead_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lead_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lead_document_id_seq OWNER TO postgres;

--
-- Name: lead_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lead_document_id_seq OWNED BY public.lead_document.id;


--
-- Name: lead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lead_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lead_id_seq OWNER TO postgres;

--
-- Name: lead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lead_id_seq OWNED BY public.lead.id;


--
-- Name: mail_cred; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mail_cred (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    smtp_host character varying NOT NULL,
    smtp_port character varying NOT NULL,
    smtp_from character varying,
    smtp_user character varying NOT NULL,
    smtp_password character varying NOT NULL
);


ALTER TABLE public.mail_cred OWNER TO postgres;

--
-- Name: mail_cred_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mail_cred_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mail_cred_id_seq OWNER TO postgres;

--
-- Name: mail_cred_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mail_cred_id_seq OWNED BY public.mail_cred.id;


--
-- Name: metacridential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metacridential (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    app_id character varying,
    app_secret character varying,
    page_id character varying,
    page_access_token character varying
);


ALTER TABLE public.metacridential OWNER TO postgres;

--
-- Name: metacridential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metacridential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metacridential_id_seq OWNER TO postgres;

--
-- Name: metacridential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metacridential_id_seq OWNED BY public.metacridential.id;


--
-- Name: module_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.module_permission (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "moduleId" integer,
    "permissionId" integer
);


ALTER TABLE public.module_permission OWNER TO postgres;

--
-- Name: module_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_permission_id_seq OWNER TO postgres;

--
-- Name: module_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_permission_id_seq OWNED BY public.module_permission.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "userId" integer NOT NULL,
    message character varying NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    url character varying
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permission_id_seq OWNER TO postgres;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permission_id_seq OWNED BY public.permission.id;


--
-- Name: remark; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.remark (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    previous_step character varying,
    current_step character varying,
    remark character varying,
    "leadId" integer,
    "assignedId" integer
);


ALTER TABLE public.remark OWNER TO postgres;

--
-- Name: remark_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.remark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.remark_id_seq OWNER TO postgres;

--
-- Name: remark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.remark_id_seq OWNED BY public.remark.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permission (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "roleId" integer,
    "permissionModuleId" integer
);


ALTER TABLE public.role_permission OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_permission_id_seq OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permission_id_seq OWNED BY public.role_permission.id;


--
-- Name: status_change; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_change (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "initialStatus" character varying NOT NULL,
    "finalStatus" character varying NOT NULL,
    branch_name character varying,
    "leadId" integer,
    "initiatorId" integer
);


ALTER TABLE public.status_change OWNER TO postgres;

--
-- Name: status_change_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_change_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_change_id_seq OWNER TO postgres;

--
-- Name: status_change_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_change_id_seq OWNED BY public.status_change.id;


--
-- Name: substagelabel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.substagelabel (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    stage character varying,
    substage character varying,
    substagelabel character varying
);


ALTER TABLE public.substagelabel OWNER TO postgres;

--
-- Name: substagelabel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.substagelabel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.substagelabel_id_seq OWNER TO postgres;

--
-- Name: substagelabel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.substagelabel_id_seq OWNED BY public.substagelabel.id;


--
-- Name: system_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_module (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.system_module OWNER TO postgres;

--
-- Name: system_module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.system_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_module_id_seq OWNER TO postgres;

--
-- Name: system_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.system_module_id_seq OWNED BY public.system_module.id;


--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    task character varying,
    description character varying,
    status character varying,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    "assignedId" integer
);


ALTER TABLE public.task OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_id_seq OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_id_seq OWNED BY public.task.id;


--
-- Name: university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    university_name character varying NOT NULL,
    country character varying NOT NULL
);


ALTER TABLE public.university OWNER TO postgres;

--
-- Name: university_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.university_id_seq OWNER TO postgres;

--
-- Name: university_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_id_seq OWNED BY public.university.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    full_name character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    status character varying DEFAULT 'active'::character varying NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    phone_number character varying,
    otp character varying,
    provider character varying,
    branch_name character varying DEFAULT 'dhanmondi'::character varying,
    role text DEFAULT '["user"]'::text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activity_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_event ALTER COLUMN id SET DEFAULT nextval('public.activity_event_id_seq'::regclass);


--
-- Name: application id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application ALTER COLUMN id SET DEFAULT nextval('public.application_id_seq'::regclass);


--
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_id_seq'::regclass);


--
-- Name: cats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cats ALTER COLUMN id SET DEFAULT nextval('public.cats_id_seq'::regclass);


--
-- Name: coachingclass id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachingclass ALTER COLUMN id SET DEFAULT nextval('public.coachingclass_id_seq'::regclass);


--
-- Name: kpi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi ALTER COLUMN id SET DEFAULT nextval('public.kpi_id_seq'::regclass);


--
-- Name: lead id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead ALTER COLUMN id SET DEFAULT nextval('public.lead_id_seq'::regclass);


--
-- Name: lead_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_document ALTER COLUMN id SET DEFAULT nextval('public.lead_document_id_seq'::regclass);


--
-- Name: mail_cred id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mail_cred ALTER COLUMN id SET DEFAULT nextval('public.mail_cred_id_seq'::regclass);


--
-- Name: metacridential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metacridential ALTER COLUMN id SET DEFAULT nextval('public.metacridential_id_seq'::regclass);


--
-- Name: module_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_permission ALTER COLUMN id SET DEFAULT nextval('public.module_permission_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission ALTER COLUMN id SET DEFAULT nextval('public.permission_id_seq'::regclass);


--
-- Name: remark id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.remark ALTER COLUMN id SET DEFAULT nextval('public.remark_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: role_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission ALTER COLUMN id SET DEFAULT nextval('public.role_permission_id_seq'::regclass);


--
-- Name: status_change id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_change ALTER COLUMN id SET DEFAULT nextval('public.status_change_id_seq'::regclass);


--
-- Name: substagelabel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.substagelabel ALTER COLUMN id SET DEFAULT nextval('public.substagelabel_id_seq'::regclass);


--
-- Name: system_module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_module ALTER COLUMN id SET DEFAULT nextval('public.system_module_id_seq'::regclass);


--
-- Name: task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task ALTER COLUMN id SET DEFAULT nextval('public.task_id_seq'::regclass);


--
-- Name: university id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university ALTER COLUMN id SET DEFAULT nextval('public.university_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activity_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_event (id, created_at, updated_at, deleted_at, event_id, details, branch, role, "userId") FROM stdin;
200	2024-09-13 19:45:36.797232	2024-09-13 19:45:36.797232	\N	1	Logged in	Dhanmondi	admin	1
201	2024-09-13 19:49:49.415384	2024-09-13 19:49:49.415384	\N	1	Logged in	Dhanmondi	admin	1
202	2024-09-13 20:04:47.055164	2024-09-13 20:04:47.055164	\N	2	Lead created	Dhanmondi	admin	1
203	2024-09-13 20:04:47.072236	2024-09-13 20:04:47.072236	\N	2	Lead created	Dhanmondi	admin	1
204	2024-09-13 20:04:47.074379	2024-09-13 20:04:47.074379	\N	2	Lead created	Dhanmondi	admin	1
205	2024-09-13 20:04:47.088635	2024-09-13 20:04:47.088635	\N	2	Lead created	Dhanmondi	admin	1
206	2024-09-13 20:04:47.099449	2024-09-13 20:04:47.099449	\N	2	Lead created	Dhanmondi	admin	1
207	2024-09-13 20:04:47.111601	2024-09-13 20:04:47.111601	\N	2	Lead created	Dhanmondi	admin	1
208	2024-09-13 20:04:47.122524	2024-09-13 20:04:47.122524	\N	2	Lead created	Dhanmondi	admin	1
209	2024-09-13 20:04:47.139008	2024-09-13 20:04:47.139008	\N	2	Lead created	Dhanmondi	admin	1
210	2024-09-13 20:05:39.123129	2024-09-13 20:05:39.123129	\N	2	Lead created	Dhanmondi	admin	1
211	2024-09-13 20:05:39.139996	2024-09-13 20:05:39.139996	\N	2	Lead created	Dhanmondi	admin	1
212	2024-09-13 20:05:39.141722	2024-09-13 20:05:39.141722	\N	2	Lead created	Dhanmondi	admin	1
213	2024-09-13 20:05:39.154267	2024-09-13 20:05:39.154267	\N	2	Lead created	Dhanmondi	admin	1
214	2024-09-13 20:05:39.164688	2024-09-13 20:05:39.164688	\N	2	Lead created	Dhanmondi	admin	1
215	2024-09-13 20:05:39.175534	2024-09-13 20:05:39.175534	\N	2	Lead created	Dhanmondi	admin	1
216	2024-09-13 20:05:39.185056	2024-09-13 20:05:39.185056	\N	2	Lead created	Dhanmondi	admin	1
217	2024-09-13 20:05:39.194722	2024-09-13 20:05:39.194722	\N	2	Lead created	Dhanmondi	admin	1
218	2024-09-13 20:08:44.855411	2024-09-13 20:08:44.855411	\N	2	Lead created	Dhanmondi	admin	1
219	2024-09-13 20:08:44.863451	2024-09-13 20:08:44.863451	\N	2	Lead created	Dhanmondi	admin	1
220	2024-09-13 20:08:44.87149	2024-09-13 20:08:44.87149	\N	2	Lead created	Dhanmondi	admin	1
221	2024-09-13 20:08:44.88312	2024-09-13 20:08:44.88312	\N	2	Lead created	Dhanmondi	admin	1
222	2024-09-13 20:08:44.892441	2024-09-13 20:08:44.892441	\N	2	Lead created	Dhanmondi	admin	1
223	2024-09-13 20:08:44.901668	2024-09-13 20:08:44.901668	\N	2	Lead created	Dhanmondi	admin	1
224	2024-09-13 20:08:44.909406	2024-09-13 20:08:44.909406	\N	2	Lead created	Dhanmondi	admin	1
225	2024-09-13 20:08:44.919928	2024-09-13 20:08:44.919928	\N	2	Lead created	Dhanmondi	admin	1
226	2024-09-13 20:08:44.928239	2024-09-13 20:08:44.928239	\N	2	Lead created	Dhanmondi	admin	1
227	2024-09-13 20:08:44.936437	2024-09-13 20:08:44.936437	\N	2	Lead created	Dhanmondi	admin	1
228	2024-09-13 20:08:44.948083	2024-09-13 20:08:44.948083	\N	2	Lead created	Dhanmondi	admin	1
229	2024-09-13 20:08:44.957909	2024-09-13 20:08:44.957909	\N	2	Lead created	Dhanmondi	admin	1
230	2024-09-13 20:08:44.968484	2024-09-13 20:08:44.968484	\N	2	Lead created	Dhanmondi	admin	1
231	2024-09-13 20:08:44.977948	2024-09-13 20:08:44.977948	\N	2	Lead created	Dhanmondi	admin	1
232	2024-09-13 20:08:44.985849	2024-09-13 20:08:44.985849	\N	2	Lead created	Dhanmondi	admin	1
233	2024-09-13 20:08:44.994991	2024-09-13 20:08:44.994991	\N	2	Lead created	Dhanmondi	admin	1
234	2024-09-13 20:08:45.002751	2024-09-13 20:08:45.002751	\N	2	Lead created	Dhanmondi	admin	1
235	2024-09-13 20:08:45.014216	2024-09-13 20:08:45.014216	\N	2	Lead created	Dhanmondi	admin	1
236	2024-09-13 20:08:45.023948	2024-09-13 20:08:45.023948	\N	2	Lead created	Dhanmondi	admin	1
237	2024-09-13 20:08:45.033831	2024-09-13 20:08:45.033831	\N	2	Lead created	Dhanmondi	admin	1
238	2024-09-13 20:08:45.041957	2024-09-13 20:08:45.041957	\N	2	Lead created	Dhanmondi	admin	1
239	2024-09-13 20:08:45.050603	2024-09-13 20:08:45.050603	\N	2	Lead created	Dhanmondi	admin	1
240	2024-09-13 20:08:45.059055	2024-09-13 20:08:45.059055	\N	2	Lead created	Dhanmondi	admin	1
241	2024-09-13 20:08:45.067366	2024-09-13 20:08:45.067366	\N	2	Lead created	Dhanmondi	admin	1
242	2024-09-13 20:08:45.076765	2024-09-13 20:08:45.076765	\N	2	Lead created	Dhanmondi	admin	1
243	2024-09-13 20:08:45.084773	2024-09-13 20:08:45.084773	\N	2	Lead created	Dhanmondi	admin	1
244	2024-09-13 20:08:45.097504	2024-09-13 20:08:45.097504	\N	2	Lead created	Dhanmondi	admin	1
245	2024-09-13 20:08:45.106273	2024-09-13 20:08:45.106273	\N	2	Lead created	Dhanmondi	admin	1
246	2024-09-13 20:08:45.114996	2024-09-13 20:08:45.114996	\N	2	Lead created	Dhanmondi	admin	1
247	2024-09-13 20:08:45.124213	2024-09-13 20:08:45.124213	\N	2	Lead created	Dhanmondi	admin	1
248	2024-09-13 20:08:45.13701	2024-09-13 20:08:45.13701	\N	2	Lead created	Dhanmondi	admin	1
249	2024-09-13 20:08:45.146011	2024-09-13 20:08:45.146011	\N	2	Lead created	Dhanmondi	admin	1
250	2024-09-13 20:08:45.157752	2024-09-13 20:08:45.157752	\N	2	Lead created	Dhanmondi	admin	1
251	2024-09-13 20:08:45.167061	2024-09-13 20:08:45.167061	\N	2	Lead created	Dhanmondi	admin	1
252	2024-09-13 20:08:45.177663	2024-09-13 20:08:45.177663	\N	2	Lead created	Dhanmondi	admin	1
253	2024-09-13 20:08:45.185673	2024-09-13 20:08:45.185673	\N	2	Lead created	Dhanmondi	admin	1
254	2024-09-13 20:08:45.19523	2024-09-13 20:08:45.19523	\N	2	Lead created	Dhanmondi	admin	1
255	2024-09-13 20:08:45.203612	2024-09-13 20:08:45.203612	\N	2	Lead created	Dhanmondi	admin	1
256	2024-09-13 20:08:45.211569	2024-09-13 20:08:45.211569	\N	2	Lead created	Dhanmondi	admin	1
257	2024-09-13 20:08:45.219007	2024-09-13 20:08:45.219007	\N	2	Lead created	Dhanmondi	admin	1
258	2024-09-13 20:08:45.22657	2024-09-13 20:08:45.22657	\N	2	Lead created	Dhanmondi	admin	1
259	2024-09-13 20:08:45.234198	2024-09-13 20:08:45.234198	\N	2	Lead created	Dhanmondi	admin	1
260	2024-09-13 20:08:45.241854	2024-09-13 20:08:45.241854	\N	2	Lead created	Dhanmondi	admin	1
261	2024-09-13 20:08:45.25035	2024-09-13 20:08:45.25035	\N	2	Lead created	Dhanmondi	admin	1
262	2024-09-13 20:08:45.258602	2024-09-13 20:08:45.258602	\N	2	Lead created	Dhanmondi	admin	1
263	2024-09-13 20:08:45.271263	2024-09-13 20:08:45.271263	\N	2	Lead created	Dhanmondi	admin	1
264	2024-09-13 20:08:45.279793	2024-09-13 20:08:45.279793	\N	2	Lead created	Dhanmondi	admin	1
265	2024-09-13 20:08:45.287914	2024-09-13 20:08:45.287914	\N	2	Lead created	Dhanmondi	admin	1
266	2024-09-13 20:08:45.297948	2024-09-13 20:08:45.297948	\N	2	Lead created	Dhanmondi	admin	1
267	2024-09-13 20:08:45.305852	2024-09-13 20:08:45.305852	\N	2	Lead created	Dhanmondi	admin	1
268	2024-09-13 20:08:45.315966	2024-09-13 20:08:45.315966	\N	2	Lead created	Dhanmondi	admin	1
269	2024-09-13 20:08:45.323964	2024-09-13 20:08:45.323964	\N	2	Lead created	Dhanmondi	admin	1
270	2024-09-13 20:08:45.33157	2024-09-13 20:08:45.33157	\N	2	Lead created	Dhanmondi	admin	1
271	2024-09-13 20:08:45.340111	2024-09-13 20:08:45.340111	\N	2	Lead created	Dhanmondi	admin	1
272	2024-09-13 20:08:45.348354	2024-09-13 20:08:45.348354	\N	2	Lead created	Dhanmondi	admin	1
273	2024-09-13 20:08:45.357508	2024-09-13 20:08:45.357508	\N	2	Lead created	Dhanmondi	admin	1
274	2024-09-13 20:08:45.364866	2024-09-13 20:08:45.364866	\N	2	Lead created	Dhanmondi	admin	1
275	2024-09-13 20:08:45.372096	2024-09-13 20:08:45.372096	\N	2	Lead created	Dhanmondi	admin	1
276	2024-09-13 20:08:45.379648	2024-09-13 20:08:45.379648	\N	2	Lead created	Dhanmondi	admin	1
277	2024-09-13 20:08:45.388231	2024-09-13 20:08:45.388231	\N	2	Lead created	Dhanmondi	admin	1
278	2024-09-13 20:08:45.39837	2024-09-13 20:08:45.39837	\N	2	Lead created	Dhanmondi	admin	1
279	2024-09-13 20:08:45.406856	2024-09-13 20:08:45.406856	\N	2	Lead created	Dhanmondi	admin	1
280	2024-09-13 20:08:45.416988	2024-09-13 20:08:45.416988	\N	2	Lead created	Dhanmondi	admin	1
281	2024-09-13 20:08:45.425231	2024-09-13 20:08:45.425231	\N	2	Lead created	Dhanmondi	admin	1
282	2024-09-13 20:08:45.43382	2024-09-13 20:08:45.43382	\N	2	Lead created	Dhanmondi	admin	1
283	2024-09-13 20:08:45.443008	2024-09-13 20:08:45.443008	\N	2	Lead created	Dhanmondi	admin	1
284	2024-09-13 20:08:45.453321	2024-09-13 20:08:45.453321	\N	2	Lead created	Dhanmondi	admin	1
285	2024-09-13 20:08:45.461025	2024-09-13 20:08:45.461025	\N	2	Lead created	Dhanmondi	admin	1
286	2024-09-13 20:08:45.469328	2024-09-13 20:08:45.469328	\N	2	Lead created	Dhanmondi	admin	1
287	2024-09-13 20:08:45.476816	2024-09-13 20:08:45.476816	\N	2	Lead created	Dhanmondi	admin	1
288	2024-09-13 20:08:45.484649	2024-09-13 20:08:45.484649	\N	2	Lead created	Dhanmondi	admin	1
289	2024-09-13 20:08:45.498948	2024-09-13 20:08:45.498948	\N	2	Lead created	Dhanmondi	admin	1
290	2024-09-13 20:08:45.508245	2024-09-13 20:08:45.508245	\N	2	Lead created	Dhanmondi	admin	1
291	2024-09-13 20:08:45.517656	2024-09-13 20:08:45.517656	\N	2	Lead created	Dhanmondi	admin	1
292	2024-09-13 20:08:45.525342	2024-09-13 20:08:45.525342	\N	2	Lead created	Dhanmondi	admin	1
293	2024-09-13 20:08:45.533623	2024-09-13 20:08:45.533623	\N	2	Lead created	Dhanmondi	admin	1
294	2024-09-13 20:08:45.54222	2024-09-13 20:08:45.54222	\N	2	Lead created	Dhanmondi	admin	1
295	2024-09-13 20:08:45.550956	2024-09-13 20:08:45.550956	\N	2	Lead created	Dhanmondi	admin	1
296	2024-09-13 20:08:45.558804	2024-09-13 20:08:45.558804	\N	2	Lead created	Dhanmondi	admin	1
297	2024-09-13 20:08:45.566055	2024-09-13 20:08:45.566055	\N	2	Lead created	Dhanmondi	admin	1
298	2024-09-13 20:08:45.573523	2024-09-13 20:08:45.573523	\N	2	Lead created	Dhanmondi	admin	1
299	2024-09-13 20:08:45.581887	2024-09-13 20:08:45.581887	\N	2	Lead created	Dhanmondi	admin	1
300	2024-09-13 20:08:45.590066	2024-09-13 20:08:45.590066	\N	2	Lead created	Dhanmondi	admin	1
301	2024-09-13 20:08:45.597278	2024-09-13 20:08:45.597278	\N	2	Lead created	Dhanmondi	admin	1
302	2024-09-13 20:08:45.6048	2024-09-13 20:08:45.6048	\N	2	Lead created	Dhanmondi	admin	1
303	2024-09-13 20:08:45.61202	2024-09-13 20:08:45.61202	\N	2	Lead created	Dhanmondi	admin	1
304	2024-09-13 20:08:45.619191	2024-09-13 20:08:45.619191	\N	2	Lead created	Dhanmondi	admin	1
305	2024-09-13 20:08:45.626394	2024-09-13 20:08:45.626394	\N	2	Lead created	Dhanmondi	admin	1
306	2024-09-13 20:08:45.633984	2024-09-13 20:08:45.633984	\N	2	Lead created	Dhanmondi	admin	1
307	2024-09-13 20:08:45.647091	2024-09-13 20:08:45.647091	\N	2	Lead created	Dhanmondi	admin	1
308	2024-09-13 20:08:45.662527	2024-09-13 20:08:45.662527	\N	2	Lead created	Dhanmondi	admin	1
309	2024-09-13 20:08:45.678131	2024-09-13 20:08:45.678131	\N	2	Lead created	Dhanmondi	admin	1
310	2024-09-13 20:08:45.687362	2024-09-13 20:08:45.687362	\N	2	Lead created	Dhanmondi	admin	1
311	2024-09-13 20:08:45.695779	2024-09-13 20:08:45.695779	\N	2	Lead created	Dhanmondi	admin	1
312	2024-09-13 20:08:45.706004	2024-09-13 20:08:45.706004	\N	2	Lead created	Dhanmondi	admin	1
313	2024-09-13 20:08:45.713607	2024-09-13 20:08:45.713607	\N	2	Lead created	Dhanmondi	admin	1
314	2024-09-13 20:08:45.72183	2024-09-13 20:08:45.72183	\N	2	Lead created	Dhanmondi	admin	1
315	2024-09-13 20:08:45.731067	2024-09-13 20:08:45.731067	\N	2	Lead created	Dhanmondi	admin	1
316	2024-09-13 20:08:45.739507	2024-09-13 20:08:45.739507	\N	2	Lead created	Dhanmondi	admin	1
317	2024-09-13 20:08:45.75035	2024-09-13 20:08:45.75035	\N	2	Lead created	Dhanmondi	admin	1
318	2024-09-13 20:08:45.764284	2024-09-13 20:08:45.764284	\N	2	Lead created	Dhanmondi	admin	1
319	2024-09-13 20:08:45.772879	2024-09-13 20:08:45.772879	\N	2	Lead created	Dhanmondi	admin	1
320	2024-09-13 20:08:45.783299	2024-09-13 20:08:45.783299	\N	2	Lead created	Dhanmondi	admin	1
321	2024-09-13 20:08:45.79431	2024-09-13 20:08:45.79431	\N	2	Lead created	Dhanmondi	admin	1
322	2024-09-13 20:08:45.806231	2024-09-13 20:08:45.806231	\N	2	Lead created	Dhanmondi	admin	1
323	2024-09-13 20:08:45.816709	2024-09-13 20:08:45.816709	\N	2	Lead created	Dhanmondi	admin	1
324	2024-09-13 20:08:45.824842	2024-09-13 20:08:45.824842	\N	2	Lead created	Dhanmondi	admin	1
325	2024-09-13 20:08:45.832261	2024-09-13 20:08:45.832261	\N	2	Lead created	Dhanmondi	admin	1
326	2024-09-13 20:08:45.842926	2024-09-13 20:08:45.842926	\N	2	Lead created	Dhanmondi	admin	1
327	2024-09-13 20:08:45.856073	2024-09-13 20:08:45.856073	\N	2	Lead created	Dhanmondi	admin	1
328	2024-09-13 20:08:45.863922	2024-09-13 20:08:45.863922	\N	2	Lead created	Dhanmondi	admin	1
329	2024-09-13 20:08:45.870814	2024-09-13 20:08:45.870814	\N	2	Lead created	Dhanmondi	admin	1
330	2024-09-13 20:08:45.87778	2024-09-13 20:08:45.87778	\N	2	Lead created	Dhanmondi	admin	1
331	2024-09-13 20:08:45.886178	2024-09-13 20:08:45.886178	\N	2	Lead created	Dhanmondi	admin	1
332	2024-09-13 20:08:45.899135	2024-09-13 20:08:45.899135	\N	2	Lead created	Dhanmondi	admin	1
333	2024-09-13 20:08:45.908034	2024-09-13 20:08:45.908034	\N	2	Lead created	Dhanmondi	admin	1
334	2024-09-13 20:08:45.916304	2024-09-13 20:08:45.916304	\N	2	Lead created	Dhanmondi	admin	1
335	2024-09-13 20:08:45.925155	2024-09-13 20:08:45.925155	\N	2	Lead created	Dhanmondi	admin	1
336	2024-09-13 20:08:45.93601	2024-09-13 20:08:45.93601	\N	2	Lead created	Dhanmondi	admin	1
337	2024-09-13 20:08:45.944046	2024-09-13 20:08:45.944046	\N	2	Lead created	Dhanmondi	admin	1
338	2024-09-13 20:08:45.953007	2024-09-13 20:08:45.953007	\N	2	Lead created	Dhanmondi	admin	1
339	2024-09-13 20:08:45.960205	2024-09-13 20:08:45.960205	\N	2	Lead created	Dhanmondi	admin	1
340	2024-09-13 20:08:45.967306	2024-09-13 20:08:45.967306	\N	2	Lead created	Dhanmondi	admin	1
341	2024-09-13 20:08:45.976872	2024-09-13 20:08:45.976872	\N	2	Lead created	Dhanmondi	admin	1
342	2024-09-13 20:08:45.986811	2024-09-13 20:08:45.986811	\N	2	Lead created	Dhanmondi	admin	1
343	2024-09-13 20:08:45.994642	2024-09-13 20:08:45.994642	\N	2	Lead created	Dhanmondi	admin	1
344	2024-09-13 20:08:46.004448	2024-09-13 20:08:46.004448	\N	2	Lead created	Dhanmondi	admin	1
345	2024-09-13 20:08:46.013174	2024-09-13 20:08:46.013174	\N	2	Lead created	Dhanmondi	admin	1
346	2024-09-13 20:08:46.020288	2024-09-13 20:08:46.020288	\N	2	Lead created	Dhanmondi	admin	1
347	2024-09-13 20:08:46.030975	2024-09-13 20:08:46.030975	\N	2	Lead created	Dhanmondi	admin	1
348	2024-09-13 20:08:46.039434	2024-09-13 20:08:46.039434	\N	2	Lead created	Dhanmondi	admin	1
349	2024-09-13 20:08:46.050111	2024-09-13 20:08:46.050111	\N	2	Lead created	Dhanmondi	admin	1
350	2024-09-13 20:08:46.05859	2024-09-13 20:08:46.05859	\N	2	Lead created	Dhanmondi	admin	1
351	2024-09-13 20:08:46.066711	2024-09-13 20:08:46.066711	\N	2	Lead created	Dhanmondi	admin	1
352	2024-09-13 20:08:46.075332	2024-09-13 20:08:46.075332	\N	2	Lead created	Dhanmondi	admin	1
353	2024-09-13 20:08:46.082987	2024-09-13 20:08:46.082987	\N	2	Lead created	Dhanmondi	admin	1
354	2024-09-13 20:08:46.090381	2024-09-13 20:08:46.090381	\N	2	Lead created	Dhanmondi	admin	1
355	2024-09-13 20:08:46.099471	2024-09-13 20:08:46.099471	\N	2	Lead created	Dhanmondi	admin	1
356	2024-09-13 20:08:46.10728	2024-09-13 20:08:46.10728	\N	2	Lead created	Dhanmondi	admin	1
357	2024-09-13 20:08:46.115377	2024-09-13 20:08:46.115377	\N	2	Lead created	Dhanmondi	admin	1
358	2024-09-13 20:08:46.122578	2024-09-13 20:08:46.122578	\N	2	Lead created	Dhanmondi	admin	1
359	2024-09-13 20:08:46.128894	2024-09-13 20:08:46.128894	\N	2	Lead created	Dhanmondi	admin	1
360	2024-09-13 20:08:46.137388	2024-09-13 20:08:46.137388	\N	2	Lead created	Dhanmondi	admin	1
361	2024-09-13 20:08:46.144811	2024-09-13 20:08:46.144811	\N	2	Lead created	Dhanmondi	admin	1
362	2024-09-13 20:08:46.156567	2024-09-13 20:08:46.156567	\N	2	Lead created	Dhanmondi	admin	1
363	2024-09-13 20:08:46.164468	2024-09-13 20:08:46.164468	\N	2	Lead created	Dhanmondi	admin	1
364	2024-09-13 20:08:46.171177	2024-09-13 20:08:46.171177	\N	2	Lead created	Dhanmondi	admin	1
365	2024-09-13 20:08:46.178091	2024-09-13 20:08:46.178091	\N	2	Lead created	Dhanmondi	admin	1
366	2024-09-13 20:08:46.185413	2024-09-13 20:08:46.185413	\N	2	Lead created	Dhanmondi	admin	1
367	2024-09-13 20:08:46.194003	2024-09-13 20:08:46.194003	\N	2	Lead created	Dhanmondi	admin	1
368	2024-09-13 20:08:46.201694	2024-09-13 20:08:46.201694	\N	2	Lead created	Dhanmondi	admin	1
369	2024-09-13 20:08:46.209696	2024-09-13 20:08:46.209696	\N	2	Lead created	Dhanmondi	admin	1
370	2024-09-14 09:54:47.497818	2024-09-14 09:54:47.497818	\N	1	Logged in	Dhanmondi	admin	1
371	2024-09-14 09:54:50.310334	2024-09-14 09:54:50.310334	\N	1	Logged in	Dhanmondi	admin	1
372	2024-09-14 10:05:27.134038	2024-09-14 10:05:27.134038	\N	2	Lead created	Dhanmondi	admin	1
373	2024-09-14 10:05:58.332523	2024-09-14 10:05:58.332523	\N	4	remark : Lead 188 updated by Naf	Dhanmondi	admin	1
374	2024-09-14 10:07:44.057283	2024-09-14 10:07:44.057283	\N	4	remark : Lead 188 updated by Naf	Dhanmondi	admin	1
375	2024-09-14 10:08:44.456865	2024-09-14 10:08:44.456865	\N	4	remark : Lead 188 updated by Naf	Dhanmondi	admin	1
376	2024-09-14 10:09:00.949293	2024-09-14 10:09:00.949293	\N	3	Lead 188 assigned to Naf	Dhanmondi	admin	1
377	2024-09-14 10:09:00.976563	2024-09-14 10:09:00.976563	\N	4	remark : Lead 188 updated by Naf	Dhanmondi	admin	1
378	2024-09-14 10:12:31.599257	2024-09-14 10:12:31.599257	\N	4	remark : office visit on 25th sept	Dhanmondi	admin	1
379	2024-09-14 10:12:31.613563	2024-09-14 10:12:31.613563	\N	5	Status changed from new to appointment-book of lead 188 by Naf	Dhanmondi	admin	1
380	2024-09-14 10:13:22.195834	2024-09-14 10:13:22.195834	\N	4	remark : will send doc on 26th sept	Dhanmondi	admin	1
381	2024-09-14 10:13:22.212845	2024-09-14 10:13:22.212845	\N	5	Status changed from appointment-book to waiting-for-document of lead 188 by Naf	Dhanmondi	admin	1
382	2024-09-14 10:16:47.198264	2024-09-14 10:16:47.198264	\N	4	remark : aply as soon as possib le	Dhanmondi	admin	1
383	2024-09-14 10:16:47.211622	2024-09-14 10:16:47.211622	\N	5	Status changed from waiting-for-document to start-application of lead 188 by Naf	Dhanmondi	admin	1
384	2024-09-14 10:19:11.96736	2024-09-14 10:19:11.96736	\N	4	remark : rec on 5th	Dhanmondi	admin	1
385	2024-09-14 10:19:11.980922	2024-09-14 10:19:11.980922	\N	5	Status changed from offer-received to unconditional-offer of lead 188 by Naf	Dhanmondi	admin	1
386	2024-09-14 10:19:51.830626	2024-09-14 10:19:51.830626	\N	4	remark : on 6th	Dhanmondi	admin	1
387	2024-09-14 10:19:51.843678	2024-09-14 10:19:51.843678	\N	5	Status changed from unconditional-offer to first-payment of lead 188 by Naf	Dhanmondi	admin	1
388	2024-09-14 10:20:31.271731	2024-09-14 10:20:31.271731	\N	4	remark : on  7th	Dhanmondi	admin	1
389	2024-09-14 10:20:31.286038	2024-09-14 10:20:31.286038	\N	5	Status changed from first-payment to end-application of lead 188 by Naf	Dhanmondi	admin	1
390	2024-09-14 10:20:54.988691	2024-09-14 10:20:54.988691	\N	4	remark : jj	Dhanmondi	admin	1
391	2024-09-14 10:20:54.995899	2024-09-14 10:20:54.995899	\N	5	Status changed from end-application to final-choice of lead 188 by Naf	Dhanmondi	admin	1
392	2024-09-14 15:19:36.648652	2024-09-14 15:19:36.648652	\N	1	Logged in	Dhanmondi	admin	1
393	2024-09-14 17:20:46.080802	2024-09-14 17:20:46.080802	\N	1	Logged in	Dhanmondi	admin	1
394	2024-09-14 17:27:04.410108	2024-09-14 17:27:04.410108	\N	1	Logged in	Dhanmondi	admin	1
395	2024-09-14 18:37:46.302478	2024-09-14 18:37:46.302478	\N	2	Lead created	Dhanmondi	admin	1
396	2024-09-14 18:37:46.312756	2024-09-14 18:37:46.312756	\N	2	Lead created	Dhanmondi	admin	1
397	2024-09-14 18:37:46.321512	2024-09-14 18:37:46.321512	\N	2	Lead created	Dhanmondi	admin	1
398	2024-09-14 18:37:46.330009	2024-09-14 18:37:46.330009	\N	2	Lead created	Dhanmondi	admin	1
399	2024-09-14 18:37:46.338795	2024-09-14 18:37:46.338795	\N	2	Lead created	Dhanmondi	admin	1
400	2024-09-14 18:37:46.345814	2024-09-14 18:37:46.345814	\N	2	Lead created	Dhanmondi	admin	1
401	2024-09-14 18:37:46.353093	2024-09-14 18:37:46.353093	\N	2	Lead created	Dhanmondi	admin	1
402	2024-09-14 18:37:46.35997	2024-09-14 18:37:46.35997	\N	2	Lead created	Dhanmondi	admin	1
403	2024-09-14 18:37:46.368095	2024-09-14 18:37:46.368095	\N	2	Lead created	Dhanmondi	admin	1
404	2024-09-14 18:37:46.37558	2024-09-14 18:37:46.37558	\N	2	Lead created	Dhanmondi	admin	1
405	2024-09-14 18:37:46.383093	2024-09-14 18:37:46.383093	\N	2	Lead created	Dhanmondi	admin	1
406	2024-09-14 18:37:46.391202	2024-09-14 18:37:46.391202	\N	2	Lead created	Dhanmondi	admin	1
407	2024-09-14 18:37:46.398969	2024-09-14 18:37:46.398969	\N	2	Lead created	Dhanmondi	admin	1
408	2024-09-14 18:37:46.406317	2024-09-14 18:37:46.406317	\N	2	Lead created	Dhanmondi	admin	1
409	2024-09-14 18:37:46.414473	2024-09-14 18:37:46.414473	\N	2	Lead created	Dhanmondi	admin	1
410	2024-09-14 18:37:46.42326	2024-09-14 18:37:46.42326	\N	2	Lead created	Dhanmondi	admin	1
411	2024-09-14 18:37:46.439572	2024-09-14 18:37:46.439572	\N	2	Lead created	Dhanmondi	admin	1
412	2024-09-14 18:37:46.451672	2024-09-14 18:37:46.451672	\N	2	Lead created	Dhanmondi	admin	1
413	2024-09-14 18:37:46.469099	2024-09-14 18:37:46.469099	\N	2	Lead created	Dhanmondi	admin	1
414	2024-09-14 18:37:46.477266	2024-09-14 18:37:46.477266	\N	2	Lead created	Dhanmondi	admin	1
415	2024-09-14 18:37:46.485666	2024-09-14 18:37:46.485666	\N	2	Lead created	Dhanmondi	admin	1
416	2024-09-14 18:37:46.49298	2024-09-14 18:37:46.49298	\N	2	Lead created	Dhanmondi	admin	1
417	2024-09-14 18:37:46.500593	2024-09-14 18:37:46.500593	\N	2	Lead created	Dhanmondi	admin	1
418	2024-09-14 18:37:46.509065	2024-09-14 18:37:46.509065	\N	2	Lead created	Dhanmondi	admin	1
419	2024-09-14 18:37:46.516736	2024-09-14 18:37:46.516736	\N	2	Lead created	Dhanmondi	admin	1
420	2024-09-14 18:37:46.524378	2024-09-14 18:37:46.524378	\N	2	Lead created	Dhanmondi	admin	1
421	2024-09-14 18:37:46.531405	2024-09-14 18:37:46.531405	\N	2	Lead created	Dhanmondi	admin	1
422	2024-09-14 18:37:46.538397	2024-09-14 18:37:46.538397	\N	2	Lead created	Dhanmondi	admin	1
423	2024-09-14 18:37:46.546163	2024-09-14 18:37:46.546163	\N	2	Lead created	Dhanmondi	admin	1
424	2024-09-14 18:37:46.553839	2024-09-14 18:37:46.553839	\N	2	Lead created	Dhanmondi	admin	1
425	2024-09-14 18:37:46.5614	2024-09-14 18:37:46.5614	\N	2	Lead created	Dhanmondi	admin	1
426	2024-09-14 18:37:46.568184	2024-09-14 18:37:46.568184	\N	2	Lead created	Dhanmondi	admin	1
427	2024-09-14 18:37:46.577675	2024-09-14 18:37:46.577675	\N	2	Lead created	Dhanmondi	admin	1
428	2024-09-14 18:37:46.58567	2024-09-14 18:37:46.58567	\N	2	Lead created	Dhanmondi	admin	1
429	2024-09-14 18:37:46.592942	2024-09-14 18:37:46.592942	\N	2	Lead created	Dhanmondi	admin	1
430	2024-09-14 18:37:46.603598	2024-09-14 18:37:46.603598	\N	2	Lead created	Dhanmondi	admin	1
431	2024-09-14 18:37:46.612383	2024-09-14 18:37:46.612383	\N	2	Lead created	Dhanmondi	admin	1
432	2024-09-14 18:37:46.620811	2024-09-14 18:37:46.620811	\N	2	Lead created	Dhanmondi	admin	1
433	2024-09-14 18:37:46.631663	2024-09-14 18:37:46.631663	\N	2	Lead created	Dhanmondi	admin	1
434	2024-09-14 18:37:46.639184	2024-09-14 18:37:46.639184	\N	2	Lead created	Dhanmondi	admin	1
435	2024-09-14 18:37:46.64679	2024-09-14 18:37:46.64679	\N	2	Lead created	Dhanmondi	admin	1
436	2024-09-14 18:37:46.65653	2024-09-14 18:37:46.65653	\N	2	Lead created	Dhanmondi	admin	1
437	2024-09-14 18:37:46.667144	2024-09-14 18:37:46.667144	\N	2	Lead created	Dhanmondi	admin	1
438	2024-09-14 18:37:46.676794	2024-09-14 18:37:46.676794	\N	2	Lead created	Dhanmondi	admin	1
439	2024-09-14 18:37:46.686434	2024-09-14 18:37:46.686434	\N	2	Lead created	Dhanmondi	admin	1
440	2024-09-14 18:37:46.693861	2024-09-14 18:37:46.693861	\N	2	Lead created	Dhanmondi	admin	1
441	2024-09-14 18:37:46.702338	2024-09-14 18:37:46.702338	\N	2	Lead created	Dhanmondi	admin	1
442	2024-09-14 18:37:46.71057	2024-09-14 18:37:46.71057	\N	2	Lead created	Dhanmondi	admin	1
443	2024-09-14 18:37:46.718471	2024-09-14 18:37:46.718471	\N	2	Lead created	Dhanmondi	admin	1
444	2024-09-14 18:37:46.726448	2024-09-14 18:37:46.726448	\N	2	Lead created	Dhanmondi	admin	1
445	2024-09-14 18:37:46.736234	2024-09-14 18:37:46.736234	\N	2	Lead created	Dhanmondi	admin	1
446	2024-09-14 18:37:46.744278	2024-09-14 18:37:46.744278	\N	2	Lead created	Dhanmondi	admin	1
447	2024-09-14 18:37:46.751966	2024-09-14 18:37:46.751966	\N	2	Lead created	Dhanmondi	admin	1
448	2024-09-14 18:37:46.759182	2024-09-14 18:37:46.759182	\N	2	Lead created	Dhanmondi	admin	1
449	2024-09-14 18:37:46.766172	2024-09-14 18:37:46.766172	\N	2	Lead created	Dhanmondi	admin	1
450	2024-09-14 18:37:46.772507	2024-09-14 18:37:46.772507	\N	2	Lead created	Dhanmondi	admin	1
451	2024-09-14 18:37:46.779357	2024-09-14 18:37:46.779357	\N	2	Lead created	Dhanmondi	admin	1
452	2024-09-14 18:37:46.787367	2024-09-14 18:37:46.787367	\N	2	Lead created	Dhanmondi	admin	1
453	2024-09-14 18:37:46.795972	2024-09-14 18:37:46.795972	\N	2	Lead created	Dhanmondi	admin	1
454	2024-09-14 18:37:46.803805	2024-09-14 18:37:46.803805	\N	2	Lead created	Dhanmondi	admin	1
455	2024-09-14 18:37:46.810388	2024-09-14 18:37:46.810388	\N	2	Lead created	Dhanmondi	admin	1
456	2024-09-14 18:37:46.817203	2024-09-14 18:37:46.817203	\N	2	Lead created	Dhanmondi	admin	1
457	2024-09-14 18:37:46.824141	2024-09-14 18:37:46.824141	\N	2	Lead created	Dhanmondi	admin	1
458	2024-09-14 18:37:46.83083	2024-09-14 18:37:46.83083	\N	2	Lead created	Dhanmondi	admin	1
459	2024-09-14 18:37:46.837705	2024-09-14 18:37:46.837705	\N	2	Lead created	Dhanmondi	admin	1
460	2024-09-14 18:37:46.845454	2024-09-14 18:37:46.845454	\N	2	Lead created	Dhanmondi	admin	1
461	2024-09-14 18:37:46.852065	2024-09-14 18:37:46.852065	\N	2	Lead created	Dhanmondi	admin	1
462	2024-09-14 18:37:46.859142	2024-09-14 18:37:46.859142	\N	2	Lead created	Dhanmondi	admin	1
463	2024-09-14 18:37:46.866748	2024-09-14 18:37:46.866748	\N	2	Lead created	Dhanmondi	admin	1
464	2024-09-14 18:37:46.874144	2024-09-14 18:37:46.874144	\N	2	Lead created	Dhanmondi	admin	1
465	2024-09-14 18:37:46.883199	2024-09-14 18:37:46.883199	\N	2	Lead created	Dhanmondi	admin	1
466	2024-09-14 18:37:46.891689	2024-09-14 18:37:46.891689	\N	2	Lead created	Dhanmondi	admin	1
467	2024-09-14 18:37:46.899523	2024-09-14 18:37:46.899523	\N	2	Lead created	Dhanmondi	admin	1
468	2024-09-14 18:37:46.90914	2024-09-14 18:37:46.90914	\N	2	Lead created	Dhanmondi	admin	1
469	2024-09-14 18:37:46.917506	2024-09-14 18:37:46.917506	\N	2	Lead created	Dhanmondi	admin	1
470	2024-09-14 18:37:46.930155	2024-09-14 18:37:46.930155	\N	2	Lead created	Dhanmondi	admin	1
471	2024-09-14 18:37:46.939743	2024-09-14 18:37:46.939743	\N	2	Lead created	Dhanmondi	admin	1
472	2024-09-14 18:37:46.948274	2024-09-14 18:37:46.948274	\N	2	Lead created	Dhanmondi	admin	1
473	2024-09-14 18:37:46.95756	2024-09-14 18:37:46.95756	\N	2	Lead created	Dhanmondi	admin	1
474	2024-09-14 18:37:46.964982	2024-09-14 18:37:46.964982	\N	2	Lead created	Dhanmondi	admin	1
475	2024-09-14 18:37:46.974065	2024-09-14 18:37:46.974065	\N	2	Lead created	Dhanmondi	admin	1
476	2024-09-14 18:37:46.984691	2024-09-14 18:37:46.984691	\N	2	Lead created	Dhanmondi	admin	1
477	2024-09-14 18:37:46.992089	2024-09-14 18:37:46.992089	\N	2	Lead created	Dhanmondi	admin	1
478	2024-09-14 18:37:47.000419	2024-09-14 18:37:47.000419	\N	2	Lead created	Dhanmondi	admin	1
479	2024-09-14 18:37:47.010405	2024-09-14 18:37:47.010405	\N	2	Lead created	Dhanmondi	admin	1
480	2024-09-14 18:37:47.019014	2024-09-14 18:37:47.019014	\N	2	Lead created	Dhanmondi	admin	1
481	2024-09-14 18:37:47.027804	2024-09-14 18:37:47.027804	\N	2	Lead created	Dhanmondi	admin	1
482	2024-09-14 18:37:47.035937	2024-09-14 18:37:47.035937	\N	2	Lead created	Dhanmondi	admin	1
483	2024-09-14 18:37:47.045114	2024-09-14 18:37:47.045114	\N	2	Lead created	Dhanmondi	admin	1
484	2024-09-14 18:37:47.053924	2024-09-14 18:37:47.053924	\N	2	Lead created	Dhanmondi	admin	1
485	2024-09-14 18:37:47.062591	2024-09-14 18:37:47.062591	\N	2	Lead created	Dhanmondi	admin	1
486	2024-09-14 18:37:47.071086	2024-09-14 18:37:47.071086	\N	2	Lead created	Dhanmondi	admin	1
487	2024-09-14 18:37:47.078554	2024-09-14 18:37:47.078554	\N	2	Lead created	Dhanmondi	admin	1
488	2024-09-14 18:37:47.08658	2024-09-14 18:37:47.08658	\N	2	Lead created	Dhanmondi	admin	1
489	2024-09-14 18:37:47.094602	2024-09-14 18:37:47.094602	\N	2	Lead created	Dhanmondi	admin	1
490	2024-09-14 18:37:47.102161	2024-09-14 18:37:47.102161	\N	2	Lead created	Dhanmondi	admin	1
491	2024-09-14 18:37:47.108895	2024-09-14 18:37:47.108895	\N	2	Lead created	Dhanmondi	admin	1
492	2024-09-14 18:37:47.116012	2024-09-14 18:37:47.116012	\N	2	Lead created	Dhanmondi	admin	1
493	2024-09-14 18:37:47.122369	2024-09-14 18:37:47.122369	\N	2	Lead created	Dhanmondi	admin	1
494	2024-09-14 18:37:47.130137	2024-09-14 18:37:47.130137	\N	2	Lead created	Dhanmondi	admin	1
495	2024-09-14 18:37:47.140853	2024-09-14 18:37:47.140853	\N	2	Lead created	Dhanmondi	admin	1
496	2024-09-14 18:37:47.152629	2024-09-14 18:37:47.152629	\N	2	Lead created	Dhanmondi	admin	1
497	2024-09-14 18:37:47.161876	2024-09-14 18:37:47.161876	\N	2	Lead created	Dhanmondi	admin	1
498	2024-09-14 18:37:47.170413	2024-09-14 18:37:47.170413	\N	2	Lead created	Dhanmondi	admin	1
499	2024-09-14 18:37:47.177992	2024-09-14 18:37:47.177992	\N	2	Lead created	Dhanmondi	admin	1
500	2024-09-14 18:37:47.187021	2024-09-14 18:37:47.187021	\N	2	Lead created	Dhanmondi	admin	1
501	2024-09-14 18:37:47.194706	2024-09-14 18:37:47.194706	\N	2	Lead created	Dhanmondi	admin	1
502	2024-09-14 18:37:47.2031	2024-09-14 18:37:47.2031	\N	2	Lead created	Dhanmondi	admin	1
503	2024-09-14 18:37:47.21028	2024-09-14 18:37:47.21028	\N	2	Lead created	Dhanmondi	admin	1
504	2024-09-14 18:37:47.217329	2024-09-14 18:37:47.217329	\N	2	Lead created	Dhanmondi	admin	1
505	2024-09-14 18:37:47.225822	2024-09-14 18:37:47.225822	\N	2	Lead created	Dhanmondi	admin	1
506	2024-09-14 18:37:47.235316	2024-09-14 18:37:47.235316	\N	2	Lead created	Dhanmondi	admin	1
507	2024-09-14 18:37:47.245569	2024-09-14 18:37:47.245569	\N	2	Lead created	Dhanmondi	admin	1
508	2024-09-14 18:37:47.253916	2024-09-14 18:37:47.253916	\N	2	Lead created	Dhanmondi	admin	1
509	2024-09-14 18:37:47.261057	2024-09-14 18:37:47.261057	\N	2	Lead created	Dhanmondi	admin	1
510	2024-09-14 18:37:47.268903	2024-09-14 18:37:47.268903	\N	2	Lead created	Dhanmondi	admin	1
511	2024-09-14 18:37:47.276605	2024-09-14 18:37:47.276605	\N	2	Lead created	Dhanmondi	admin	1
512	2024-09-14 18:37:47.284196	2024-09-14 18:37:47.284196	\N	2	Lead created	Dhanmondi	admin	1
513	2024-09-14 18:37:47.292913	2024-09-14 18:37:47.292913	\N	2	Lead created	Dhanmondi	admin	1
514	2024-09-14 18:37:47.299529	2024-09-14 18:37:47.299529	\N	2	Lead created	Dhanmondi	admin	1
515	2024-09-14 18:37:47.306862	2024-09-14 18:37:47.306862	\N	2	Lead created	Dhanmondi	admin	1
516	2024-09-14 18:37:47.315114	2024-09-14 18:37:47.315114	\N	2	Lead created	Dhanmondi	admin	1
517	2024-09-14 18:37:47.323327	2024-09-14 18:37:47.323327	\N	2	Lead created	Dhanmondi	admin	1
518	2024-09-14 18:37:47.334072	2024-09-14 18:37:47.334072	\N	2	Lead created	Dhanmondi	admin	1
519	2024-09-14 18:37:47.343114	2024-09-14 18:37:47.343114	\N	2	Lead created	Dhanmondi	admin	1
520	2024-09-14 18:37:47.354535	2024-09-14 18:37:47.354535	\N	2	Lead created	Dhanmondi	admin	1
521	2024-09-14 18:37:47.362323	2024-09-14 18:37:47.362323	\N	2	Lead created	Dhanmondi	admin	1
522	2024-09-14 18:37:47.369426	2024-09-14 18:37:47.369426	\N	2	Lead created	Dhanmondi	admin	1
523	2024-09-14 18:37:47.377958	2024-09-14 18:37:47.377958	\N	2	Lead created	Dhanmondi	admin	1
524	2024-09-14 18:37:47.386324	2024-09-14 18:37:47.386324	\N	2	Lead created	Dhanmondi	admin	1
525	2024-09-14 18:37:47.395106	2024-09-14 18:37:47.395106	\N	2	Lead created	Dhanmondi	admin	1
526	2024-09-14 18:37:47.402133	2024-09-14 18:37:47.402133	\N	2	Lead created	Dhanmondi	admin	1
527	2024-09-14 18:37:47.409812	2024-09-14 18:37:47.409812	\N	2	Lead created	Dhanmondi	admin	1
528	2024-09-14 18:37:47.416739	2024-09-14 18:37:47.416739	\N	2	Lead created	Dhanmondi	admin	1
529	2024-09-14 18:37:47.424269	2024-09-14 18:37:47.424269	\N	2	Lead created	Dhanmondi	admin	1
530	2024-09-14 18:37:47.431729	2024-09-14 18:37:47.431729	\N	2	Lead created	Dhanmondi	admin	1
531	2024-09-14 18:37:47.439713	2024-09-14 18:37:47.439713	\N	2	Lead created	Dhanmondi	admin	1
532	2024-09-14 18:37:47.447957	2024-09-14 18:37:47.447957	\N	2	Lead created	Dhanmondi	admin	1
533	2024-09-14 18:37:47.45521	2024-09-14 18:37:47.45521	\N	2	Lead created	Dhanmondi	admin	1
534	2024-09-14 18:37:47.461777	2024-09-14 18:37:47.461777	\N	2	Lead created	Dhanmondi	admin	1
535	2024-09-14 18:37:47.469007	2024-09-14 18:37:47.469007	\N	2	Lead created	Dhanmondi	admin	1
536	2024-09-14 18:37:47.476408	2024-09-14 18:37:47.476408	\N	2	Lead created	Dhanmondi	admin	1
537	2024-09-14 18:37:47.483767	2024-09-14 18:37:47.483767	\N	2	Lead created	Dhanmondi	admin	1
538	2024-09-14 18:37:47.490793	2024-09-14 18:37:47.490793	\N	2	Lead created	Dhanmondi	admin	1
539	2024-09-14 18:37:47.497834	2024-09-14 18:37:47.497834	\N	2	Lead created	Dhanmondi	admin	1
540	2024-09-14 18:37:47.505029	2024-09-14 18:37:47.505029	\N	2	Lead created	Dhanmondi	admin	1
541	2024-09-14 18:37:47.512374	2024-09-14 18:37:47.512374	\N	2	Lead created	Dhanmondi	admin	1
542	2024-09-14 18:37:47.519007	2024-09-14 18:37:47.519007	\N	2	Lead created	Dhanmondi	admin	1
543	2024-09-14 18:37:47.526086	2024-09-14 18:37:47.526086	\N	2	Lead created	Dhanmondi	admin	1
544	2024-09-14 18:37:47.534699	2024-09-14 18:37:47.534699	\N	2	Lead created	Dhanmondi	admin	1
545	2024-09-14 18:37:47.545024	2024-09-14 18:37:47.545024	\N	2	Lead created	Dhanmondi	admin	1
546	2024-09-14 18:37:47.554791	2024-09-14 18:37:47.554791	\N	2	Lead created	Dhanmondi	admin	1
547	2024-09-14 20:26:55.916696	2024-09-14 20:26:55.916696	\N	1	Logged in	Dhanmondi	admin	1
548	2024-09-16 14:34:00.115211	2024-09-16 14:34:00.115211	\N	1	Logged in	Dhanmondi	counsellor	13
549	2024-09-16 14:39:11.339196	2024-09-16 14:39:11.339196	\N	1	Logged in	Dhanmondi	counsellor	15
550	2024-09-16 15:21:33.077965	2024-09-16 15:21:33.077965	\N	1	Logged in	Dhanmondi	admin	1
551	2024-09-16 15:23:26.346563	2024-09-16 15:23:26.346563	\N	1	Logged in	Dhanmondi	counsellor	14
552	2024-09-16 15:24:09.044466	2024-09-16 15:24:09.044466	\N	2	Lead created	Dhanmondi	admin	1
553	2024-09-16 15:25:21.715298	2024-09-16 15:25:21.715298	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
554	2024-09-16 15:28:03.096138	2024-09-16 15:28:03.096138	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
555	2024-09-16 15:28:46.796246	2024-09-16 15:28:46.796246	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
556	2024-09-16 15:29:01.039141	2024-09-16 15:29:01.039141	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
557	2024-09-16 15:30:32.153926	2024-09-16 15:30:32.153926	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
558	2024-09-16 15:30:51.520316	2024-09-16 15:30:51.520316	\N	3	Lead 341 assigned to Naf	Dhanmondi	admin	1
559	2024-09-16 15:30:51.534766	2024-09-16 15:30:51.534766	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
560	2024-09-16 15:31:24.673363	2024-09-16 15:31:24.673363	\N	4	remark : N/A	Dhanmondi	admin	1
561	2024-09-16 15:31:24.691989	2024-09-16 15:31:24.691989	\N	5	Status changed from new to appointment-book of lead 341 by Naf	Dhanmondi	admin	1
562	2024-09-16 15:31:40.062131	2024-09-16 15:31:40.062131	\N	4	remark : n/a	Dhanmondi	admin	1
563	2024-09-16 15:31:40.078211	2024-09-16 15:31:40.078211	\N	5	Status changed from appointment-book to waiting-for-document of lead 341 by Naf	Dhanmondi	admin	1
564	2024-09-16 23:10:56.73226	2024-09-16 23:10:56.73226	\N	1	Logged in	Dhanmondi	admin	1
565	2024-09-17 07:52:07.979185	2024-09-17 07:52:07.979185	\N	1	Logged in	Dhanmondi	admin	1
566	2024-09-17 13:42:16.154729	2024-09-17 13:42:16.154729	\N	1	Logged in	Dhanmondi	admin	1
567	2024-09-17 15:00:00.830312	2024-09-17 15:00:00.830312	\N	1	Logged in	Dhanmondi	admin	1
568	2024-09-17 18:04:26.515152	2024-09-17 18:04:26.515152	\N	1	Logged in	Dhanmondi	admin	1
569	2024-09-18 06:34:37.995659	2024-09-18 06:34:37.995659	\N	1	Logged in	Dhanmondi	admin	1
570	2024-09-18 06:34:52.552662	2024-09-18 06:34:52.552662	\N	1	Logged in	Dhanmondi	admin	1
571	2024-09-18 06:37:48.481186	2024-09-18 06:37:48.481186	\N	4	remark : Lead 339 updated by Naf	Dhanmondi	admin	1
572	2024-09-18 06:38:50.039217	2024-09-18 06:38:50.039217	\N	4	remark : he will visit office on 25th september 	Dhanmondi	admin	1
573	2024-09-18 06:38:50.058655	2024-09-18 06:38:50.058655	\N	5	Status changed from new to appointment-book of lead 339 by Naf	Dhanmondi	admin	1
574	2024-09-18 06:39:30.488856	2024-09-18 06:39:30.488856	\N	4	remark : he will visit office after ielts 	Dhanmondi	admin	1
575	2024-09-18 06:39:30.505023	2024-09-18 06:39:30.505023	\N	5	Status changed from appointment-book to postponed of lead 339 by Naf	Dhanmondi	admin	1
576	2024-09-18 06:42:16.322686	2024-09-18 06:42:16.322686	\N	3	Lead 337 assigned to Farzana	Dhanmondi	admin	1
577	2024-09-18 06:42:16.323207	2024-09-18 06:42:16.323207	\N	3	Lead 336 assigned to Farzana	Dhanmondi	admin	1
578	2024-09-18 06:42:16.334396	2024-09-18 06:42:16.334396	\N	3	Lead 338 assigned to Farzana	Dhanmondi	admin	1
579	2024-09-18 06:42:16.335075	2024-09-18 06:42:16.335075	\N	3	Lead 335 assigned to Farzana	Dhanmondi	admin	1
580	2024-09-18 06:42:16.345198	2024-09-18 06:42:16.345198	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
581	2024-09-18 06:42:16.345653	2024-09-18 06:42:16.345653	\N	3	Lead 340 assigned to Farzana	Dhanmondi	admin	1
582	2024-09-18 06:42:16.346102	2024-09-18 06:42:16.346102	\N	3	Lead 334 assigned to Farzana	Dhanmondi	admin	1
583	2024-09-18 06:42:16.35579	2024-09-18 06:42:16.35579	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
584	2024-09-18 06:42:16.355284	2024-09-18 06:42:16.355284	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
585	2024-09-18 06:42:16.368574	2024-09-18 06:42:16.368574	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
586	2024-09-18 06:42:16.370635	2024-09-18 06:42:16.370635	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
587	2024-09-18 06:42:16.372207	2024-09-18 06:42:16.372207	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
588	2024-09-18 06:42:16.487984	2024-09-18 06:42:16.487984	\N	3	Lead 333 assigned to Farzana	Dhanmondi	admin	1
589	2024-09-18 06:42:16.4883	2024-09-18 06:42:16.4883	\N	3	Lead 332 assigned to Farzana	Dhanmondi	admin	1
590	2024-09-18 06:42:16.495758	2024-09-18 06:42:16.495758	\N	3	Lead 331 assigned to Farzana	Dhanmondi	admin	1
1671	2024-09-23 14:04:54.812013	2024-09-23 14:04:54.812013	\N	1	Logged in	Dhanmondi	admin	1
592	2024-09-18 06:42:16.506311	2024-09-18 06:42:16.506311	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
1421	2024-09-21 16:15:52.505993	2024-09-21 16:15:52.505993	\N	4	remark : call him tomorrow	Dhanmondi	counsellor	14
1422	2024-09-21 16:15:52.522243	2024-09-21 16:15:52.522243	\N	5	Status changed from new to first of lead 204 by Farzana	Dhanmondi	counsellor	14
1468	2024-09-21 17:51:42.797542	2024-09-21 17:51:42.797542	\N	4	remark : no 	Dhanmondi	counsellor	13
1469	2024-09-21 17:51:42.813795	2024-09-21 17:51:42.813795	\N	5	Status changed from new to unreachable of lead 303 by Jarin	Dhanmondi	counsellor	13
1470	2024-09-21 17:51:50.660657	2024-09-21 17:51:50.660657	\N	4	remark : Lead 303 updated by Jarin	Dhanmondi	counsellor	13
1471	2024-09-21 17:51:53.488646	2024-09-21 17:51:53.488646	\N	4	remark : Lead 303 updated by Jarin	Dhanmondi	counsellor	13
1505	2024-09-21 18:47:05.87976	2024-09-21 18:47:05.87976	\N	4	remark : wrong number	Dhanmondi	counsellor	13
1506	2024-09-21 18:47:05.893651	2024-09-21 18:47:05.893651	\N	5	Status changed from new to not-interested of lead 213 by Jarin	Dhanmondi	counsellor	13
1545	2024-09-22 05:29:59.190659	2024-09-22 05:29:59.190659	\N	4	remark : No Answer	Dhanmondi	counsellor	13
1546	2024-09-22 05:29:59.205582	2024-09-22 05:29:59.205582	\N	5	Status changed from new to unreachable of lead 263 by Jarin	Dhanmondi	counsellor	13
1593	2024-09-22 05:53:05.199283	2024-09-22 05:53:05.199283	\N	5	Status changed from new to not-interested of lead 220 by Jarin	Dhanmondi	counsellor	13
1632	2024-09-22 06:16:53.596818	2024-09-22 06:16:53.596818	\N	4	remark : Lead 312 updated by Naf	Dhanmondi	admin	1
1672	2024-09-23 22:22:46.126297	2024-09-23 22:22:46.126297	\N	1	Logged in	Dhanmondi	admin	1
1703	2024-09-25 06:38:18.655697	2024-09-25 06:38:18.655697	\N	4	remark : 28th September exam. i will call him 13th October	Dhanmondi	counsellor	14
1704	2024-09-25 06:38:18.675783	2024-09-25 06:38:18.675783	\N	5	Status changed from course-new to course-first of lead 322 by Farzana	Dhanmondi	counsellor	14
1732	2024-09-28 06:35:53.70165	2024-09-28 06:35:53.70165	\N	4	remark : He wants to go australia	Dhanmondi	counsellor	13
1733	2024-09-28 06:35:53.716462	2024-09-28 06:35:53.716462	\N	5	Status changed from new to appointment-book of lead 354 by Jarin	Dhanmondi	counsellor	13
1734	2024-09-28 06:35:59.327432	2024-09-28 06:35:59.327432	\N	4	remark : Lead 354 updated by Jarin	Dhanmondi	counsellor	13
1754	2024-10-10 10:47:53.350683	2024-10-10 10:47:53.350683	\N	1	Logged in	Dhanmondi	counsellor	14
1800	2024-11-24 06:21:26.843039	2024-11-24 06:21:26.843039	\N	4	remark : Lead 317 updated by Farzana	Dhanmondi	counsellor	14
1801	2024-11-24 06:21:26.849344	2024-11-24 06:21:26.849344	\N	5	Status changed from course-new to new of lead 317 by Farzana	Dhanmondi	counsellor	14
2033	2024-11-25 10:33:18.178257	2024-11-25 10:33:18.178257	\N	1	Logged in	Dhanmondi	counsellor	14
591	2024-09-18 06:42:16.501795	2024-09-18 06:42:16.501795	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
1423	2024-09-21 16:16:49.580559	2024-09-21 16:16:49.580559	\N	4	remark : no response 	Dhanmondi	counsellor	14
1424	2024-09-21 16:16:49.595807	2024-09-21 16:16:49.595807	\N	5	Status changed from new to unreachable of lead 203 by Farzana	Dhanmondi	counsellor	14
1472	2024-09-21 18:18:07.143284	2024-09-21 18:18:07.143284	\N	4	remark : busy	Dhanmondi	counsellor	13
1473	2024-09-21 18:18:07.157542	2024-09-21 18:18:07.157542	\N	5	Status changed from new to unreachable of lead 262 by Jarin	Dhanmondi	counsellor	13
1507	2024-09-21 18:48:23.174632	2024-09-21 18:48:23.174632	\N	4	remark : no answer	Dhanmondi	counsellor	13
1508	2024-09-21 18:48:23.187447	2024-09-21 18:48:23.187447	\N	5	Status changed from new to first of lead 214 by Jarin	Dhanmondi	counsellor	13
1547	2024-09-22 05:34:00.042369	2024-09-22 05:34:00.042369	\N	4	remark : No answer	Dhanmondi	counsellor	13
1548	2024-09-22 05:34:00.057903	2024-09-22 05:34:00.057903	\N	5	Status changed from new to unreachable of lead 259 by Jarin	Dhanmondi	counsellor	13
1549	2024-09-22 05:34:02.174916	2024-09-22 05:34:02.174916	\N	4	remark : Lead 259 updated by Jarin	Dhanmondi	counsellor	13
1595	2024-09-22 05:53:49.848114	2024-09-22 05:53:49.848114	\N	4	remark : BUSY	Dhanmondi	counsellor	13
1596	2024-09-22 05:53:49.864438	2024-09-22 05:53:49.864438	\N	5	Status changed from new to unreachable of lead 219 by Jarin	Dhanmondi	counsellor	13
1636	2024-09-22 06:16:53.747208	2024-09-22 06:16:53.747208	\N	4	remark : Lead 306 updated by Naf	Dhanmondi	admin	1
1639	2024-09-22 06:17:01.286625	2024-09-22 06:17:01.286625	\N	4	remark : He wants to go Malta	Dhanmondi	counsellor	13
1640	2024-09-22 06:17:01.290569	2024-09-22 06:17:01.290569	\N	5	Status changed from new to future-interest of lead 342 by Jarin	Dhanmondi	counsellor	13
1673	2024-09-24 05:11:59.100911	2024-09-24 05:11:59.100911	\N	1	Logged in	Dhanmondi	counsellor	14
1705	2024-09-25 06:43:46.826393	2024-09-25 06:43:46.826393	\N	4	remark : He will tell me his time for visit	Dhanmondi	counsellor	14
1706	2024-09-25 06:43:46.844705	2024-09-25 06:43:46.844705	\N	5	Status changed from first to appointment-book of lead 289 by Farzana	Dhanmondi	counsellor	14
1735	2024-09-28 06:37:01.479164	2024-09-28 06:37:01.479164	\N	4	remark : He will send documents	Dhanmondi	counsellor	13
1736	2024-09-28 06:37:01.50218	2024-09-28 06:37:01.50218	\N	5	Status changed from appointment-book to waiting-for-document of lead 354 by Jarin	Dhanmondi	counsellor	13
1755	2024-10-10 10:48:24.8513	2024-10-10 10:48:24.8513	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1756	2024-10-10 10:48:24.891681	2024-10-10 10:48:24.891681	\N	5	Status changed from appointment-book to course-new of lead 328 by Farzana	Dhanmondi	counsellor	14
1802	2024-11-24 06:28:35.529544	2024-11-24 06:28:35.529544	\N	4	remark : i called him several time	Dhanmondi	counsellor	14
1803	2024-11-24 06:28:35.549602	2024-11-24 06:28:35.549602	\N	5	Status changed from new to unreachable of lead 317 by Farzana	Dhanmondi	counsellor	14
593	2024-09-18 06:42:16.509419	2024-09-18 06:42:16.509419	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
594	2024-09-18 06:42:16.512961	2024-09-18 06:42:16.512961	\N	3	Lead 330 assigned to Farzana	Dhanmondi	admin	1
595	2024-09-18 06:42:16.516203	2024-09-18 06:42:16.516203	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
596	2024-09-18 06:42:41.02848	2024-09-18 06:42:41.02848	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
597	2024-09-18 06:42:41.033297	2024-09-18 06:42:41.033297	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
598	2024-09-18 06:42:41.03529	2024-09-18 06:42:41.03529	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
599	2024-09-18 06:42:41.04263	2024-09-18 06:42:41.04263	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
600	2024-09-18 06:42:41.044961	2024-09-18 06:42:41.044961	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
601	2024-09-18 06:42:41.064074	2024-09-18 06:42:41.064074	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
602	2024-09-18 06:42:41.084109	2024-09-18 06:42:41.084109	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
603	2024-09-18 06:42:41.097835	2024-09-18 06:42:41.097835	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
604	2024-09-18 06:42:41.106646	2024-09-18 06:42:41.106646	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
605	2024-09-18 06:42:41.116453	2024-09-18 06:42:41.116453	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
606	2024-09-18 06:43:05.173287	2024-09-18 06:43:05.173287	\N	3	Lead 329 assigned to Farzana	Dhanmondi	admin	1
607	2024-09-18 06:43:05.175422	2024-09-18 06:43:05.175422	\N	3	Lead 324 assigned to Farzana	Dhanmondi	admin	1
608	2024-09-18 06:43:05.175096	2024-09-18 06:43:05.175096	\N	3	Lead 328 assigned to Farzana	Dhanmondi	admin	1
609	2024-09-18 06:43:05.180629	2024-09-18 06:43:05.180629	\N	3	Lead 327 assigned to Farzana	Dhanmondi	admin	1
610	2024-09-18 06:43:05.18613	2024-09-18 06:43:05.18613	\N	3	Lead 325 assigned to Farzana	Dhanmondi	admin	1
611	2024-09-18 06:43:05.184573	2024-09-18 06:43:05.184573	\N	3	Lead 326 assigned to Farzana	Dhanmondi	admin	1
612	2024-09-18 06:43:05.193781	2024-09-18 06:43:05.193781	\N	4	remark : Lead 325 updated by Naf	Dhanmondi	admin	1
613	2024-09-18 06:43:05.192425	2024-09-18 06:43:05.192425	\N	4	remark : Lead 326 updated by Naf	Dhanmondi	admin	1
614	2024-09-18 06:43:05.213817	2024-09-18 06:43:05.213817	\N	4	remark : Lead 328 updated by Naf	Dhanmondi	admin	1
615	2024-09-18 06:43:05.218552	2024-09-18 06:43:05.218552	\N	4	remark : Lead 329 updated by Naf	Dhanmondi	admin	1
616	2024-09-18 06:43:05.224593	2024-09-18 06:43:05.224593	\N	4	remark : Lead 324 updated by Naf	Dhanmondi	admin	1
617	2024-09-18 06:43:05.226829	2024-09-18 06:43:05.226829	\N	4	remark : Lead 327 updated by Naf	Dhanmondi	admin	1
618	2024-09-18 06:43:05.2639	2024-09-18 06:43:05.2639	\N	3	Lead 322 assigned to Farzana	Dhanmondi	admin	1
619	2024-09-18 06:43:05.263305	2024-09-18 06:43:05.263305	\N	3	Lead 323 assigned to Farzana	Dhanmondi	admin	1
620	2024-09-18 06:43:05.266969	2024-09-18 06:43:05.266969	\N	4	remark : Lead 323 updated by Naf	Dhanmondi	admin	1
621	2024-09-18 06:43:05.268994	2024-09-18 06:43:05.268994	\N	4	remark : Lead 322 updated by Naf	Dhanmondi	admin	1
622	2024-09-18 06:43:05.290782	2024-09-18 06:43:05.290782	\N	3	Lead 321 assigned to Farzana	Dhanmondi	admin	1
623	2024-09-18 06:43:05.293194	2024-09-18 06:43:05.293194	\N	3	Lead 320 assigned to Farzana	Dhanmondi	admin	1
624	2024-09-18 06:43:05.294899	2024-09-18 06:43:05.294899	\N	4	remark : Lead 321 updated by Naf	Dhanmondi	admin	1
625	2024-09-18 06:43:05.296984	2024-09-18 06:43:05.296984	\N	4	remark : Lead 320 updated by Naf	Dhanmondi	admin	1
626	2024-09-18 06:45:29.482032	2024-09-18 06:45:29.482032	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
627	2024-09-18 06:45:29.484235	2024-09-18 06:45:29.484235	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
628	2024-09-18 06:45:29.489587	2024-09-18 06:45:29.489587	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
629	2024-09-18 06:45:29.502177	2024-09-18 06:45:29.502177	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
630	2024-09-18 06:45:29.611268	2024-09-18 06:45:29.611268	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
631	2024-09-18 06:45:29.616482	2024-09-18 06:45:29.616482	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
632	2024-09-18 06:45:29.617372	2024-09-18 06:45:29.617372	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
633	2024-09-18 06:45:29.621295	2024-09-18 06:45:29.621295	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
634	2024-09-18 06:45:29.646037	2024-09-18 06:45:29.646037	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
635	2024-09-18 06:45:29.659856	2024-09-18 06:45:29.659856	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
636	2024-09-18 06:45:40.493873	2024-09-18 06:45:40.493873	\N	3	Lead 336 assigned to Jarin	Dhanmondi	admin	1
637	2024-09-18 06:45:40.537756	2024-09-18 06:45:40.537756	\N	3	Lead 335 assigned to Jarin	Dhanmondi	admin	1
638	2024-09-18 06:45:40.540746	2024-09-18 06:45:40.540746	\N	3	Lead 340 assigned to Jarin	Dhanmondi	admin	1
639	2024-09-18 06:45:40.542859	2024-09-18 06:45:40.542859	\N	3	Lead 338 assigned to Jarin	Dhanmondi	admin	1
640	2024-09-18 06:45:40.543487	2024-09-18 06:45:40.543487	\N	3	Lead 337 assigned to Jarin	Dhanmondi	admin	1
641	2024-09-18 06:45:40.550435	2024-09-18 06:45:40.550435	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
642	2024-09-18 06:45:40.552756	2024-09-18 06:45:40.552756	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
643	2024-09-18 06:45:40.554775	2024-09-18 06:45:40.554775	\N	3	Lead 334 assigned to Jarin	Dhanmondi	admin	1
644	2024-09-18 06:45:40.565038	2024-09-18 06:45:40.565038	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
645	2024-09-18 06:45:40.572173	2024-09-18 06:45:40.572173	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
646	2024-09-18 06:45:40.580009	2024-09-18 06:45:40.580009	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
647	2024-09-18 06:45:40.5831	2024-09-18 06:45:40.5831	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
648	2024-09-18 06:45:40.665202	2024-09-18 06:45:40.665202	\N	3	Lead 333 assigned to Jarin	Dhanmondi	admin	1
649	2024-09-18 06:45:40.66797	2024-09-18 06:45:40.66797	\N	3	Lead 332 assigned to Jarin	Dhanmondi	admin	1
650	2024-09-18 06:45:40.671221	2024-09-18 06:45:40.671221	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
651	2024-09-18 06:45:40.671639	2024-09-18 06:45:40.671639	\N	3	Lead 331 assigned to Jarin	Dhanmondi	admin	1
652	2024-09-18 06:45:40.67641	2024-09-18 06:45:40.67641	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
653	2024-09-18 06:45:40.677425	2024-09-18 06:45:40.677425	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
654	2024-09-18 06:45:40.696011	2024-09-18 06:45:40.696011	\N	3	Lead 330 assigned to Jarin	Dhanmondi	admin	1
655	2024-09-18 06:45:40.700511	2024-09-18 06:45:40.700511	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
656	2024-09-18 06:45:51.383193	2024-09-18 06:45:51.383193	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
657	2024-09-18 06:45:51.397711	2024-09-18 06:45:51.397711	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
658	2024-09-18 06:45:51.400719	2024-09-18 06:45:51.400719	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
659	2024-09-18 06:45:51.404603	2024-09-18 06:45:51.404603	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
660	2024-09-18 06:45:51.405105	2024-09-18 06:45:51.405105	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
661	2024-09-18 06:45:51.407447	2024-09-18 06:45:51.407447	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
662	2024-09-18 06:45:51.440809	2024-09-18 06:45:51.440809	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
663	2024-09-18 06:45:51.521265	2024-09-18 06:45:51.521265	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
667	2024-09-18 06:46:00.521022	2024-09-18 06:46:00.521022	\N	3	Lead 338 assigned to Farzana	Dhanmondi	admin	1
669	2024-09-18 06:46:00.524807	2024-09-18 06:46:00.524807	\N	3	Lead 337 assigned to Farzana	Dhanmondi	admin	1
670	2024-09-18 06:46:00.528872	2024-09-18 06:46:00.528872	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
672	2024-09-18 06:46:00.533462	2024-09-18 06:46:00.533462	\N	3	Lead 340 assigned to Farzana	Dhanmondi	admin	1
675	2024-09-18 06:46:00.553355	2024-09-18 06:46:00.553355	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
677	2024-09-18 06:46:00.559804	2024-09-18 06:46:00.559804	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
678	2024-09-18 06:46:00.664364	2024-09-18 06:46:00.664364	\N	3	Lead 332 assigned to Farzana	Dhanmondi	admin	1
684	2024-09-18 06:46:00.681928	2024-09-18 06:46:00.681928	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
691	2024-09-18 06:46:08.465595	2024-09-18 06:46:08.465595	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
693	2024-09-18 06:46:08.741111	2024-09-18 06:46:08.741111	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
695	2024-09-18 06:46:08.748408	2024-09-18 06:46:08.748408	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
1425	2024-09-21 16:17:00.086773	2024-09-21 16:17:00.086773	\N	4	remark : bad	Dhanmondi	counsellor	14
1426	2024-09-21 16:17:00.102834	2024-09-21 16:17:00.102834	\N	5	Status changed from new to not-interested of lead 202 by Farzana	Dhanmondi	counsellor	14
1474	2024-09-21 18:18:19.253112	2024-09-21 18:18:19.253112	\N	4	remark : Lead 262 updated by Jarin	Dhanmondi	counsellor	13
1509	2024-09-21 18:49:17.876206	2024-09-21 18:49:17.876206	\N	4	remark : No number	Dhanmondi	counsellor	13
1510	2024-09-21 18:49:17.891286	2024-09-21 18:49:17.891286	\N	5	Status changed from new to not-interested of lead 215 by Jarin	Dhanmondi	counsellor	13
1550	2024-09-22 05:35:45.458827	2024-09-22 05:35:45.458827	\N	4	remark : no	Dhanmondi	counsellor	13
1551	2024-09-22 05:35:45.476187	2024-09-22 05:35:45.476187	\N	5	Status changed from new to not-interested of lead 258 by Jarin	Dhanmondi	counsellor	13
1552	2024-09-22 05:35:47.299777	2024-09-22 05:35:47.299777	\N	4	remark : Lead 258 updated by Jarin	Dhanmondi	counsellor	13
1597	2024-09-22 05:54:08.528229	2024-09-22 05:54:08.528229	\N	4	remark : Number missing	Dhanmondi	counsellor	13
1598	2024-09-22 05:54:08.531665	2024-09-22 05:54:08.531665	\N	5	Status changed from new to unreachable of lead 265 by Jarin	Dhanmondi	counsellor	13
1638	2024-09-22 06:16:53.757243	2024-09-22 06:16:53.757243	\N	4	remark : Lead 305 updated by Naf	Dhanmondi	admin	1
1641	2024-09-22 06:17:08.51464	2024-09-22 06:17:08.51464	\N	1	Logged in	Dhanmondi	counsellor	14
1674	2024-09-24 06:11:25.794248	2024-09-24 06:11:25.794248	\N	1	Logged in	Dhanmondi	counsellor	13
1707	2024-09-25 06:51:36.262113	2024-09-25 06:51:36.262113	\N	4	remark : he will come 	Dhanmondi	counsellor	14
1708	2024-09-25 06:51:36.276449	2024-09-25 06:51:36.276449	\N	5	Status changed from first to appointment-book of lead 288 by Farzana	Dhanmondi	counsellor	14
1737	2024-09-29 21:00:15.127297	2024-09-29 21:00:15.127297	\N	1	Logged in	Dhanmondi	admin	1
1757	2024-10-10 10:48:31.541269	2024-10-10 10:48:31.541269	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1758	2024-10-10 10:48:31.548542	2024-10-10 10:48:31.548542	\N	5	Status changed from course-new to new of lead 328 by Farzana	Dhanmondi	counsellor	14
1804	2024-11-24 09:38:38.077941	2024-11-24 09:38:38.077941	\N	1	Logged in	Dhanmondi	admin	1
664	2024-09-18 06:45:51.526855	2024-09-18 06:45:51.526855	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
665	2024-09-18 06:45:51.530543	2024-09-18 06:45:51.530543	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
666	2024-09-18 06:46:00.517308	2024-09-18 06:46:00.517308	\N	3	Lead 334 assigned to Farzana	Dhanmondi	admin	1
668	2024-09-18 06:46:00.523091	2024-09-18 06:46:00.523091	\N	3	Lead 335 assigned to Farzana	Dhanmondi	admin	1
673	2024-09-18 06:46:00.532653	2024-09-18 06:46:00.532653	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
674	2024-09-18 06:46:00.543345	2024-09-18 06:46:00.543345	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
676	2024-09-18 06:46:00.555275	2024-09-18 06:46:00.555275	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
1427	2024-09-21 16:17:11.955172	2024-09-21 16:17:11.955172	\N	4	remark : bad	Dhanmondi	counsellor	14
1428	2024-09-21 16:17:11.969302	2024-09-21 16:17:11.969302	\N	5	Status changed from new to not-interested of lead 201 by Farzana	Dhanmondi	counsellor	14
1475	2024-09-21 18:20:09.723356	2024-09-21 18:20:09.723356	\N	4	remark : wrong number	Dhanmondi	counsellor	13
1476	2024-09-21 18:20:09.735441	2024-09-21 18:20:09.735441	\N	5	Status changed from new to not-interested of lead 260 by Jarin	Dhanmondi	counsellor	13
1511	2024-09-21 18:51:00.550732	2024-09-21 18:51:00.550732	\N	4	remark : Wrong number	Dhanmondi	counsellor	13
1512	2024-09-21 18:51:00.568199	2024-09-21 18:51:00.568199	\N	5	Status changed from new to not-interested of lead 216 by Jarin	Dhanmondi	counsellor	13
1553	2024-09-22 05:36:53.98171	2024-09-22 05:36:53.98171	\N	4	remark : Busy	Dhanmondi	counsellor	13
1554	2024-09-22 05:36:53.995959	2024-09-22 05:36:53.995959	\N	5	Status changed from new to unreachable of lead 257 by Jarin	Dhanmondi	counsellor	13
1555	2024-09-22 05:36:54.837966	2024-09-22 05:36:54.837966	\N	4	remark : Lead 257 updated by Jarin	Dhanmondi	counsellor	13
1599	2024-09-22 05:55:29.913803	2024-09-22 05:55:29.913803	\N	4	remark : Number missing	Dhanmondi	counsellor	13
1600	2024-09-22 05:55:29.918231	2024-09-22 05:55:29.918231	\N	5	Status changed from new to unreachable of lead 255 by Jarin	Dhanmondi	counsellor	13
1642	2024-09-22 06:21:40.940586	2024-09-22 06:21:40.940586	\N	1	Logged in	Dhanmondi	counsellor	14
1675	2024-09-24 10:38:25.001963	2024-09-24 10:38:25.001963	\N	1	Logged in	Dhanmondi	admin	1
1709	2024-09-25 09:11:37.60134	2024-09-25 09:11:37.60134	\N	4	remark : mistake	Dhanmondi	counsellor	14
1710	2024-09-25 09:11:37.615278	2024-09-25 09:11:37.615278	\N	5	Status changed from new to not-interested of lead 333 by Farzana	Dhanmondi	counsellor	14
1738	2024-09-30 06:09:54.826833	2024-09-30 06:09:54.826833	\N	2	Lead created	Dhanmondi	counsellor	13
1759	2024-10-10 10:48:51.812782	2024-10-10 10:48:51.812782	\N	4	remark : Several times i called him, no response	Dhanmondi	counsellor	14
1760	2024-10-10 10:48:51.831174	2024-10-10 10:48:51.831174	\N	5	Status changed from new to unreachable of lead 328 by Farzana	Dhanmondi	counsellor	14
1761	2024-10-10 10:48:54.848191	2024-10-10 10:48:54.848191	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1762	2024-10-10 10:48:56.818702	2024-10-10 10:48:56.818702	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1805	2024-11-24 12:42:12.164268	2024-11-24 12:42:12.164268	\N	1	Logged in	Dhanmondi	admin	1
671	2024-09-18 06:46:00.530429	2024-09-18 06:46:00.530429	\N	3	Lead 336 assigned to Farzana	Dhanmondi	admin	1
679	2024-09-18 06:46:00.666358	2024-09-18 06:46:00.666358	\N	3	Lead 331 assigned to Farzana	Dhanmondi	admin	1
680	2024-09-18 06:46:00.671791	2024-09-18 06:46:00.671791	\N	3	Lead 333 assigned to Farzana	Dhanmondi	admin	1
681	2024-09-18 06:46:00.67243	2024-09-18 06:46:00.67243	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
682	2024-09-18 06:46:00.675701	2024-09-18 06:46:00.675701	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
683	2024-09-18 06:46:00.68258	2024-09-18 06:46:00.68258	\N	3	Lead 330 assigned to Farzana	Dhanmondi	admin	1
685	2024-09-18 06:46:00.686928	2024-09-18 06:46:00.686928	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
687	2024-09-18 06:46:08.450343	2024-09-18 06:46:08.450343	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
688	2024-09-18 06:46:08.454354	2024-09-18 06:46:08.454354	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
689	2024-09-18 06:46:08.460353	2024-09-18 06:46:08.460353	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
690	2024-09-18 06:46:08.464321	2024-09-18 06:46:08.464321	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
692	2024-09-18 06:46:08.737175	2024-09-18 06:46:08.737175	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
694	2024-09-18 06:46:08.743789	2024-09-18 06:46:08.743789	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
1429	2024-09-21 16:17:28.554356	2024-09-21 16:17:28.554356	\N	4	remark : no response 	Dhanmondi	counsellor	14
1430	2024-09-21 16:17:28.5697	2024-09-21 16:17:28.5697	\N	5	Status changed from new to unreachable of lead 200 by Farzana	Dhanmondi	counsellor	14
1477	2024-09-21 18:24:53.353429	2024-09-21 18:24:53.353429	\N	4	remark :  	Dhanmondi	counsellor	13
1478	2024-09-21 18:24:53.367907	2024-09-21 18:24:53.367907	\N	5	Status changed from new to unreachable of lead 264 by Jarin	Dhanmondi	counsellor	13
1479	2024-09-21 18:25:00.188417	2024-09-21 18:25:00.188417	\N	4	remark : Lead 264 updated by Jarin	Dhanmondi	counsellor	13
1513	2024-09-21 18:53:33.372663	2024-09-21 18:53:33.372663	\N	4	remark : waiting for office visit	Dhanmondi	counsellor	13
1514	2024-09-21 18:53:33.388526	2024-09-21 18:53:33.388526	\N	5	Status changed from new to appointment-book of lead 296 by Jarin	Dhanmondi	counsellor	13
1556	2024-09-22 05:37:50.191585	2024-09-22 05:37:50.191585	\N	4	remark : no	Dhanmondi	counsellor	13
1557	2024-09-22 05:37:50.208681	2024-09-22 05:37:50.208681	\N	5	Status changed from new to not-interested of lead 256 by Jarin	Dhanmondi	counsellor	13
1558	2024-09-22 05:37:50.238364	2024-09-22 05:37:50.238364	\N	4	remark : no	Dhanmondi	counsellor	13
1601	2024-09-22 05:57:26.909782	2024-09-22 05:57:26.909782	\N	4	remark : No answer	Dhanmondi	counsellor	13
1602	2024-09-22 05:57:26.923478	2024-09-22 05:57:26.923478	\N	5	Status changed from new to unreachable of lead 249 by Jarin	Dhanmondi	counsellor	13
1643	2024-09-22 06:33:47.105299	2024-09-22 06:33:47.105299	\N	2	Lead created	Dhanmondi	counsellor	13
1676	2024-09-24 11:21:20.885299	2024-09-24 11:21:20.885299	\N	1	Logged in	Dhanmondi	admin	1
1711	2024-09-26 11:24:37.030226	2024-09-26 11:24:37.030226	\N	1	Logged in	Dhanmondi	counsellor	14
1739	2024-09-30 06:10:55.650756	2024-09-30 06:10:55.650756	\N	4	remark : Lead 355 updated by Jarin	Dhanmondi	counsellor	13
1740	2024-09-30 06:11:53.506376	2024-09-30 06:11:53.506376	\N	4	remark : interested for australia 2025 september doing ielts or pte	Dhanmondi	counsellor	13
1763	2024-10-10 10:52:01.582197	2024-10-10 10:52:01.582197	\N	4	remark : Lead 289 updated by Farzana	Dhanmondi	counsellor	14
1764	2024-10-10 10:52:01.605985	2024-10-10 10:52:01.605985	\N	5	Status changed from appointment-book to course-new of lead 289 by Farzana	Dhanmondi	counsellor	14
1777	2024-10-30 09:35:03.118139	2024-10-30 09:35:03.118139	\N	1	Logged in	Dhanmondi	admin	1
1806	2024-11-24 12:44:59.169822	2024-11-24 12:44:59.169822	\N	1	Logged in	Dhanmondi	counsellor	14
686	2024-09-18 06:46:08.445278	2024-09-18 06:46:08.445278	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
696	2024-09-18 06:54:16.121753	2024-09-18 06:54:16.121753	\N	3	Lead 340 assigned to Jarin	Dhanmondi	admin	1
697	2024-09-18 06:54:16.128176	2024-09-18 06:54:16.128176	\N	3	Lead 338 assigned to Jarin	Dhanmondi	admin	1
698	2024-09-18 06:54:16.131938	2024-09-18 06:54:16.131938	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
699	2024-09-18 06:54:16.139611	2024-09-18 06:54:16.139611	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
700	2024-09-18 06:54:16.250752	2024-09-18 06:54:16.250752	\N	3	Lead 336 assigned to Jarin	Dhanmondi	admin	1
701	2024-09-18 06:54:16.25157	2024-09-18 06:54:16.25157	\N	3	Lead 337 assigned to Jarin	Dhanmondi	admin	1
702	2024-09-18 06:54:16.256973	2024-09-18 06:54:16.256973	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
703	2024-09-18 06:54:16.272609	2024-09-18 06:54:16.272609	\N	3	Lead 335 assigned to Jarin	Dhanmondi	admin	1
704	2024-09-18 06:54:16.287732	2024-09-18 06:54:16.287732	\N	3	Lead 333 assigned to Jarin	Dhanmondi	admin	1
705	2024-09-18 06:54:16.297217	2024-09-18 06:54:16.297217	\N	3	Lead 332 assigned to Jarin	Dhanmondi	admin	1
706	2024-09-18 06:54:16.303947	2024-09-18 06:54:16.303947	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
707	2024-09-18 06:54:16.305663	2024-09-18 06:54:16.305663	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
708	2024-09-18 06:54:16.319111	2024-09-18 06:54:16.319111	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
709	2024-09-18 06:54:16.322293	2024-09-18 06:54:16.322293	\N	3	Lead 334 assigned to Jarin	Dhanmondi	admin	1
710	2024-09-18 06:54:16.32473	2024-09-18 06:54:16.32473	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
711	2024-09-18 06:54:16.327098	2024-09-18 06:54:16.327098	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
712	2024-09-18 06:54:16.368733	2024-09-18 06:54:16.368733	\N	3	Lead 331 assigned to Jarin	Dhanmondi	admin	1
713	2024-09-18 06:54:16.372219	2024-09-18 06:54:16.372219	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
714	2024-09-18 06:54:16.403608	2024-09-18 06:54:16.403608	\N	3	Lead 330 assigned to Jarin	Dhanmondi	admin	1
715	2024-09-18 06:54:16.405881	2024-09-18 06:54:16.405881	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
716	2024-09-18 06:54:23.78892	2024-09-18 06:54:23.78892	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
717	2024-09-18 06:54:23.792308	2024-09-18 06:54:23.792308	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
718	2024-09-18 06:54:23.796376	2024-09-18 06:54:23.796376	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
719	2024-09-18 06:54:23.799028	2024-09-18 06:54:23.799028	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
720	2024-09-18 06:54:23.804169	2024-09-18 06:54:23.804169	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
721	2024-09-18 06:54:23.806722	2024-09-18 06:54:23.806722	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
722	2024-09-18 06:54:23.905042	2024-09-18 06:54:23.905042	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
723	2024-09-18 06:54:23.914955	2024-09-18 06:54:23.914955	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
724	2024-09-18 06:54:23.915176	2024-09-18 06:54:23.915176	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
725	2024-09-18 06:54:23.920976	2024-09-18 06:54:23.920976	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
726	2024-09-18 06:54:31.300833	2024-09-18 06:54:31.300833	\N	3	Lead 334 assigned to Farzana	Dhanmondi	admin	1
727	2024-09-18 06:54:31.302461	2024-09-18 06:54:31.302461	\N	3	Lead 337 assigned to Farzana	Dhanmondi	admin	1
728	2024-09-18 06:54:31.304142	2024-09-18 06:54:31.304142	\N	3	Lead 338 assigned to Farzana	Dhanmondi	admin	1
729	2024-09-18 06:54:31.308409	2024-09-18 06:54:31.308409	\N	3	Lead 340 assigned to Farzana	Dhanmondi	admin	1
730	2024-09-18 06:54:31.316176	2024-09-18 06:54:31.316176	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
731	2024-09-18 06:54:31.322645	2024-09-18 06:54:31.322645	\N	3	Lead 336 assigned to Farzana	Dhanmondi	admin	1
732	2024-09-18 06:54:31.330925	2024-09-18 06:54:31.330925	\N	3	Lead 335 assigned to Farzana	Dhanmondi	admin	1
733	2024-09-18 06:54:31.33826	2024-09-18 06:54:31.33826	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
734	2024-09-18 06:54:31.341149	2024-09-18 06:54:31.341149	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
735	2024-09-18 06:54:31.355059	2024-09-18 06:54:31.355059	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
736	2024-09-18 06:54:31.3554	2024-09-18 06:54:31.3554	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
737	2024-09-18 06:54:31.357056	2024-09-18 06:54:31.357056	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
738	2024-09-18 06:54:31.446174	2024-09-18 06:54:31.446174	\N	3	Lead 333 assigned to Farzana	Dhanmondi	admin	1
739	2024-09-18 06:54:31.451999	2024-09-18 06:54:31.451999	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
740	2024-09-18 06:54:31.479113	2024-09-18 06:54:31.479113	\N	3	Lead 332 assigned to Farzana	Dhanmondi	admin	1
741	2024-09-18 06:54:31.479375	2024-09-18 06:54:31.479375	\N	3	Lead 331 assigned to Farzana	Dhanmondi	admin	1
742	2024-09-18 06:54:31.483527	2024-09-18 06:54:31.483527	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
743	2024-09-18 06:54:31.483906	2024-09-18 06:54:31.483906	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
744	2024-09-18 06:54:31.487209	2024-09-18 06:54:31.487209	\N	3	Lead 330 assigned to Farzana	Dhanmondi	admin	1
745	2024-09-18 06:54:31.495159	2024-09-18 06:54:31.495159	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
746	2024-09-18 06:54:40.803675	2024-09-18 06:54:40.803675	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
747	2024-09-18 06:54:40.807316	2024-09-18 06:54:40.807316	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
748	2024-09-18 06:54:40.810415	2024-09-18 06:54:40.810415	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
749	2024-09-18 06:54:40.814684	2024-09-18 06:54:40.814684	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
750	2024-09-18 06:54:40.817959	2024-09-18 06:54:40.817959	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
751	2024-09-18 06:54:40.822689	2024-09-18 06:54:40.822689	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
752	2024-09-18 06:54:40.948453	2024-09-18 06:54:40.948453	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
753	2024-09-18 06:54:40.977542	2024-09-18 06:54:40.977542	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
754	2024-09-18 06:54:40.987906	2024-09-18 06:54:40.987906	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
755	2024-09-18 06:54:40.996793	2024-09-18 06:54:40.996793	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
756	2024-09-18 07:00:18.463908	2024-09-18 07:00:18.463908	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
757	2024-09-18 07:00:18.566155	2024-09-18 07:00:18.566155	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
758	2024-09-18 07:00:18.579542	2024-09-18 07:00:18.579542	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
759	2024-09-18 07:00:18.594285	2024-09-18 07:00:18.594285	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
760	2024-09-18 07:00:18.596724	2024-09-18 07:00:18.596724	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
761	2024-09-18 07:00:18.597762	2024-09-18 07:00:18.597762	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
762	2024-09-18 07:00:18.684216	2024-09-18 07:00:18.684216	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
764	2024-09-18 07:00:18.715027	2024-09-18 07:00:18.715027	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
1431	2024-09-21 16:17:42.568724	2024-09-21 16:17:42.568724	\N	4	remark : bad	Dhanmondi	counsellor	14
1432	2024-09-21 16:17:42.585608	2024-09-21 16:17:42.585608	\N	5	Status changed from new to not-interested of lead 199 by Farzana	Dhanmondi	counsellor	14
1435	2024-09-21 16:17:57.123069	2024-09-21 16:17:57.123069	\N	4	remark : bad	Dhanmondi	counsellor	14
1436	2024-09-21 16:17:57.127387	2024-09-21 16:17:57.127387	\N	5	Status changed from new to not-interested of lead 197 by Farzana	Dhanmondi	counsellor	14
1480	2024-09-21 18:26:18.151692	2024-09-21 18:26:18.151692	\N	4	remark : no number	Dhanmondi	counsellor	13
1481	2024-09-21 18:26:18.166023	2024-09-21 18:26:18.166023	\N	5	Status changed from new to unreachable of lead 267 by Jarin	Dhanmondi	counsellor	13
1515	2024-09-21 18:54:57.198712	2024-09-21 18:54:57.198712	\N	4	remark : Lead 295 updated by Jarin	Dhanmondi	counsellor	13
1559	2024-09-22 05:38:52.429905	2024-09-22 05:38:52.429905	\N	4	remark : Busy	Dhanmondi	counsellor	13
1560	2024-09-22 05:38:52.441826	2024-09-22 05:38:52.441826	\N	5	Status changed from new to unreachable of lead 254 by Jarin	Dhanmondi	counsellor	13
1603	2024-09-22 06:06:13.846638	2024-09-22 06:06:13.846638	\N	4	remark : No answer	Dhanmondi	counsellor	13
1604	2024-09-22 06:06:13.859313	2024-09-22 06:06:13.859313	\N	5	Status changed from new to unreachable of lead 229 by Jarin	Dhanmondi	counsellor	13
1644	2024-09-22 06:33:50.88157	2024-09-22 06:33:50.88157	\N	4	remark : Lead 343 updated by Jarin	Dhanmondi	counsellor	13
1677	2024-09-24 13:02:51.81386	2024-09-24 13:02:51.81386	\N	1	Logged in	Dhanmondi	admin	1
1712	2024-09-26 11:25:43.755042	2024-09-26 11:25:43.755042	\N	4	remark : several time i called her father. no response	Dhanmondi	counsellor	14
1713	2024-09-26 11:25:43.780304	2024-09-26 11:25:43.780304	\N	5	Status changed from first to unreachable of lead 205 by Farzana	Dhanmondi	counsellor	14
1741	2024-09-30 06:11:53.519896	2024-09-30 06:11:53.519896	\N	5	Status changed from new to future-interest of lead 355 by Jarin	Dhanmondi	counsellor	13
1765	2024-10-10 10:52:05.047468	2024-10-10 10:52:05.047468	\N	4	remark : Lead 289 updated by Farzana	Dhanmondi	counsellor	14
1766	2024-10-10 10:52:05.052686	2024-10-10 10:52:05.052686	\N	5	Status changed from course-new to new of lead 289 by Farzana	Dhanmondi	counsellor	14
1778	2024-10-31 13:54:09.531927	2024-10-31 13:54:09.531927	\N	1	Logged in	Dhanmondi	admin	1
1807	2024-11-24 12:45:42.854361	2024-11-24 12:45:42.854361	\N	4	remark : Lead 340 updated by Farzana	Dhanmondi	counsellor	14
1808	2024-11-24 12:45:42.874697	2024-11-24 12:45:42.874697	\N	5	Status changed from unreachable to course-new of lead 340 by Farzana	Dhanmondi	counsellor	14
763	2024-09-18 07:00:18.705417	2024-09-18 07:00:18.705417	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
765	2024-09-18 07:00:18.814924	2024-09-18 07:00:18.814924	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
766	2024-09-18 07:00:53.742259	2024-09-18 07:00:53.742259	\N	4	remark : Lead 325 updated by Naf	Dhanmondi	admin	1
767	2024-09-18 07:00:53.750794	2024-09-18 07:00:53.750794	\N	4	remark : Lead 324 updated by Naf	Dhanmondi	admin	1
768	2024-09-18 07:00:53.769379	2024-09-18 07:00:53.769379	\N	4	remark : Lead 328 updated by Naf	Dhanmondi	admin	1
769	2024-09-18 07:00:53.775835	2024-09-18 07:00:53.775835	\N	4	remark : Lead 327 updated by Naf	Dhanmondi	admin	1
770	2024-09-18 07:00:53.794058	2024-09-18 07:00:53.794058	\N	4	remark : Lead 329 updated by Naf	Dhanmondi	admin	1
771	2024-09-18 07:00:53.788812	2024-09-18 07:00:53.788812	\N	4	remark : Lead 326 updated by Naf	Dhanmondi	admin	1
772	2024-09-18 07:00:53.851626	2024-09-18 07:00:53.851626	\N	4	remark : Lead 323 updated by Naf	Dhanmondi	admin	1
773	2024-09-18 07:00:53.912668	2024-09-18 07:00:53.912668	\N	4	remark : Lead 321 updated by Naf	Dhanmondi	admin	1
774	2024-09-18 07:00:53.915844	2024-09-18 07:00:53.915844	\N	4	remark : Lead 322 updated by Naf	Dhanmondi	admin	1
775	2024-09-18 07:00:53.991332	2024-09-18 07:00:53.991332	\N	4	remark : Lead 320 updated by Naf	Dhanmondi	admin	1
776	2024-09-18 07:02:22.244561	2024-09-18 07:02:22.244561	\N	4	remark : Lead 335 updated by Naf	Dhanmondi	admin	1
777	2024-09-18 07:02:22.254081	2024-09-18 07:02:22.254081	\N	4	remark : Lead 338 updated by Naf	Dhanmondi	admin	1
778	2024-09-18 07:02:22.256408	2024-09-18 07:02:22.256408	\N	4	remark : Lead 334 updated by Naf	Dhanmondi	admin	1
779	2024-09-18 07:02:22.25691	2024-09-18 07:02:22.25691	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
780	2024-09-18 07:02:22.271478	2024-09-18 07:02:22.271478	\N	4	remark : Lead 336 updated by Naf	Dhanmondi	admin	1
781	2024-09-18 07:02:22.275138	2024-09-18 07:02:22.275138	\N	4	remark : Lead 340 updated by Naf	Dhanmondi	admin	1
782	2024-09-18 07:02:22.518155	2024-09-18 07:02:22.518155	\N	4	remark : Lead 330 updated by Naf	Dhanmondi	admin	1
783	2024-09-18 07:02:22.518583	2024-09-18 07:02:22.518583	\N	4	remark : Lead 332 updated by Naf	Dhanmondi	admin	1
784	2024-09-18 07:02:22.518977	2024-09-18 07:02:22.518977	\N	4	remark : Lead 331 updated by Naf	Dhanmondi	admin	1
785	2024-09-18 07:02:22.530815	2024-09-18 07:02:22.530815	\N	4	remark : Lead 333 updated by Naf	Dhanmondi	admin	1
786	2024-09-18 07:02:47.543574	2024-09-18 07:02:47.543574	\N	4	remark : Lead 328 updated by Naf	Dhanmondi	admin	1
787	2024-09-18 07:02:47.553726	2024-09-18 07:02:47.553726	\N	4	remark : Lead 326 updated by Naf	Dhanmondi	admin	1
788	2024-09-18 07:02:47.566294	2024-09-18 07:02:47.566294	\N	4	remark : Lead 329 updated by Naf	Dhanmondi	admin	1
789	2024-09-18 07:02:47.570694	2024-09-18 07:02:47.570694	\N	4	remark : Lead 327 updated by Naf	Dhanmondi	admin	1
790	2024-09-18 07:02:47.584548	2024-09-18 07:02:47.584548	\N	4	remark : Lead 324 updated by Naf	Dhanmondi	admin	1
791	2024-09-18 07:02:47.584654	2024-09-18 07:02:47.584654	\N	4	remark : Lead 325 updated by Naf	Dhanmondi	admin	1
792	2024-09-18 07:02:47.637881	2024-09-18 07:02:47.637881	\N	4	remark : Lead 323 updated by Naf	Dhanmondi	admin	1
793	2024-09-18 07:02:47.673923	2024-09-18 07:02:47.673923	\N	4	remark : Lead 322 updated by Naf	Dhanmondi	admin	1
794	2024-09-18 07:02:47.677118	2024-09-18 07:02:47.677118	\N	4	remark : Lead 321 updated by Naf	Dhanmondi	admin	1
795	2024-09-18 07:02:47.680417	2024-09-18 07:02:47.680417	\N	4	remark : Lead 320 updated by Naf	Dhanmondi	admin	1
796	2024-09-18 07:03:04.418747	2024-09-18 07:03:04.418747	\N	3	Lead 314 assigned to Jarin	Dhanmondi	admin	1
797	2024-09-18 07:03:04.419279	2024-09-18 07:03:04.419279	\N	3	Lead 315 assigned to Jarin	Dhanmondi	admin	1
798	2024-09-18 07:03:04.437854	2024-09-18 07:03:04.437854	\N	3	Lead 316 assigned to Jarin	Dhanmondi	admin	1
799	2024-09-18 07:03:04.441552	2024-09-18 07:03:04.441552	\N	3	Lead 317 assigned to Jarin	Dhanmondi	admin	1
800	2024-09-18 07:03:04.450431	2024-09-18 07:03:04.450431	\N	4	remark : Lead 317 updated by Naf	Dhanmondi	admin	1
801	2024-09-18 07:03:04.4671	2024-09-18 07:03:04.4671	\N	4	remark : Lead 316 updated by Naf	Dhanmondi	admin	1
802	2024-09-18 07:03:04.473801	2024-09-18 07:03:04.473801	\N	4	remark : Lead 314 updated by Naf	Dhanmondi	admin	1
803	2024-09-18 07:03:04.474911	2024-09-18 07:03:04.474911	\N	3	Lead 319 assigned to Jarin	Dhanmondi	admin	1
804	2024-09-18 07:03:04.475797	2024-09-18 07:03:04.475797	\N	4	remark : Lead 315 updated by Naf	Dhanmondi	admin	1
805	2024-09-18 07:03:04.48471	2024-09-18 07:03:04.48471	\N	4	remark : Lead 319 updated by Naf	Dhanmondi	admin	1
806	2024-09-18 07:03:04.487421	2024-09-18 07:03:04.487421	\N	3	Lead 318 assigned to Jarin	Dhanmondi	admin	1
807	2024-09-18 07:03:04.49122	2024-09-18 07:03:04.49122	\N	4	remark : Lead 318 updated by Naf	Dhanmondi	admin	1
808	2024-09-18 07:03:04.579178	2024-09-18 07:03:04.579178	\N	3	Lead 313 assigned to Jarin	Dhanmondi	admin	1
809	2024-09-18 07:03:04.57906	2024-09-18 07:03:04.57906	\N	3	Lead 312 assigned to Jarin	Dhanmondi	admin	1
810	2024-09-18 07:03:04.585862	2024-09-18 07:03:04.585862	\N	4	remark : Lead 313 updated by Naf	Dhanmondi	admin	1
811	2024-09-18 07:03:04.586757	2024-09-18 07:03:04.586757	\N	4	remark : Lead 312 updated by Naf	Dhanmondi	admin	1
812	2024-09-18 07:03:04.604085	2024-09-18 07:03:04.604085	\N	3	Lead 310 assigned to Jarin	Dhanmondi	admin	1
813	2024-09-18 07:03:04.605684	2024-09-18 07:03:04.605684	\N	3	Lead 311 assigned to Jarin	Dhanmondi	admin	1
814	2024-09-18 07:03:04.609455	2024-09-18 07:03:04.609455	\N	4	remark : Lead 310 updated by Naf	Dhanmondi	admin	1
815	2024-09-18 07:03:04.610078	2024-09-18 07:03:04.610078	\N	4	remark : Lead 311 updated by Naf	Dhanmondi	admin	1
816	2024-09-18 07:03:21.263263	2024-09-18 07:03:21.263263	\N	4	remark : Lead 319 updated by Naf	Dhanmondi	admin	1
817	2024-09-18 07:03:21.268334	2024-09-18 07:03:21.268334	\N	4	remark : Lead 318 updated by Naf	Dhanmondi	admin	1
818	2024-09-18 07:03:21.276456	2024-09-18 07:03:21.276456	\N	4	remark : Lead 314 updated by Naf	Dhanmondi	admin	1
819	2024-09-18 07:03:21.298735	2024-09-18 07:03:21.298735	\N	4	remark : Lead 317 updated by Naf	Dhanmondi	admin	1
820	2024-09-18 07:03:21.303621	2024-09-18 07:03:21.303621	\N	4	remark : Lead 315 updated by Naf	Dhanmondi	admin	1
821	2024-09-18 07:03:21.303739	2024-09-18 07:03:21.303739	\N	4	remark : Lead 316 updated by Naf	Dhanmondi	admin	1
822	2024-09-18 07:03:21.401859	2024-09-18 07:03:21.401859	\N	4	remark : Lead 310 updated by Naf	Dhanmondi	admin	1
823	2024-09-18 07:03:21.413136	2024-09-18 07:03:21.413136	\N	4	remark : Lead 312 updated by Naf	Dhanmondi	admin	1
824	2024-09-18 07:03:21.437825	2024-09-18 07:03:21.437825	\N	4	remark : Lead 313 updated by Naf	Dhanmondi	admin	1
825	2024-09-18 07:03:21.442608	2024-09-18 07:03:21.442608	\N	4	remark : Lead 311 updated by Naf	Dhanmondi	admin	1
826	2024-09-18 07:04:06.43163	2024-09-18 07:04:06.43163	\N	3	Lead 314 assigned to Farzana	Dhanmondi	admin	1
827	2024-09-18 07:04:06.440299	2024-09-18 07:04:06.440299	\N	3	Lead 318 assigned to Farzana	Dhanmondi	admin	1
828	2024-09-18 07:04:06.443435	2024-09-18 07:04:06.443435	\N	3	Lead 319 assigned to Farzana	Dhanmondi	admin	1
829	2024-09-18 07:04:06.444342	2024-09-18 07:04:06.444342	\N	3	Lead 317 assigned to Farzana	Dhanmondi	admin	1
830	2024-09-18 07:04:06.44379	2024-09-18 07:04:06.44379	\N	3	Lead 315 assigned to Farzana	Dhanmondi	admin	1
831	2024-09-18 07:04:06.443793	2024-09-18 07:04:06.443793	\N	3	Lead 316 assigned to Farzana	Dhanmondi	admin	1
1433	2024-09-21 16:17:50.004903	2024-09-21 16:17:50.004903	\N	4	remark : bad	Dhanmondi	counsellor	14
1434	2024-09-21 16:17:50.00839	2024-09-21 16:17:50.00839	\N	5	Status changed from new to not-interested of lead 198 by Farzana	Dhanmondi	counsellor	14
1482	2024-09-21 18:27:02.037433	2024-09-21 18:27:02.037433	\N	4	remark : no number	Dhanmondi	counsellor	13
1483	2024-09-21 18:27:02.056979	2024-09-21 18:27:02.056979	\N	5	Status changed from new to unreachable of lead 266 by Jarin	Dhanmondi	counsellor	13
1516	2024-09-21 18:55:48.676604	2024-09-21 18:55:48.676604	\N	4	remark : When office will ready 	Dhanmondi	counsellor	13
1517	2024-09-21 18:55:48.694967	2024-09-21 18:55:48.694967	\N	5	Status changed from new to appointment-book of lead 295 by Jarin	Dhanmondi	counsellor	13
1518	2024-09-21 18:55:54.606089	2024-09-21 18:55:54.606089	\N	4	remark : Lead 295 updated by Jarin	Dhanmondi	counsellor	13
1561	2024-09-22 05:40:08.600845	2024-09-22 05:40:08.600845	\N	4	remark : Switched Off	Dhanmondi	counsellor	13
1562	2024-09-22 05:40:08.61614	2024-09-22 05:40:08.61614	\N	5	Status changed from new to unreachable of lead 253 by Jarin	Dhanmondi	counsellor	13
1605	2024-09-22 06:08:11.584711	2024-09-22 06:08:11.584711	\N	4	remark : No answer	Dhanmondi	counsellor	13
1606	2024-09-22 06:08:11.60107	2024-09-22 06:08:11.60107	\N	5	Status changed from new to unreachable of lead 228 by Jarin	Dhanmondi	counsellor	13
1645	2024-09-22 06:34:18.348709	2024-09-22 06:34:18.348709	\N	4	remark : Waiting for Hsc result	Dhanmondi	counsellor	13
1646	2024-09-22 06:34:18.361306	2024-09-22 06:34:18.361306	\N	5	Status changed from new to future-interest of lead 343 by Jarin	Dhanmondi	counsellor	13
1678	2024-09-24 13:06:38.403123	2024-09-24 13:06:38.403123	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
1679	2024-09-24 13:06:38.421	2024-09-24 13:06:38.421	\N	5	Status changed from not-interested to course-new of lead 337 by Naf	Dhanmondi	admin	1
1714	2024-09-26 14:05:52.203131	2024-09-26 14:05:52.203131	\N	1	Logged in	Dhanmondi	counsellor	14
1742	2024-09-30 06:12:10.419076	2024-09-30 06:12:10.419076	\N	4	remark : Lead 355 updated by Jarin	Dhanmondi	counsellor	13
1767	2024-10-10 10:52:38.380329	2024-10-10 10:52:38.380329	\N	4	remark : He will take ielts within December	Dhanmondi	counsellor	14
1768	2024-10-10 10:52:38.399704	2024-10-10 10:52:38.399704	\N	5	Status changed from new to future-interest of lead 289 by Farzana	Dhanmondi	counsellor	14
1779	2024-11-03 19:39:36.691181	2024-11-03 19:39:36.691181	\N	1	Logged in	Dhanmondi	admin	1
1809	2024-11-24 12:45:49.911514	2024-11-24 12:45:49.911514	\N	4	remark : Lead 340 updated by Farzana	Dhanmondi	counsellor	14
1810	2024-11-24 12:45:49.916619	2024-11-24 12:45:49.916619	\N	5	Status changed from course-new to new of lead 340 by Farzana	Dhanmondi	counsellor	14
832	2024-09-18 07:04:06.45148	2024-09-18 07:04:06.45148	\N	4	remark : Lead 318 updated by Naf	Dhanmondi	admin	1
841	2024-09-18 07:04:06.652242	2024-09-18 07:04:06.652242	\N	4	remark : Lead 311 updated by Naf	Dhanmondi	admin	1
1437	2024-09-21 16:18:14.682363	2024-09-21 16:18:14.682363	\N	4	remark : phone off	Dhanmondi	counsellor	14
1438	2024-09-21 16:18:14.696139	2024-09-21 16:18:14.696139	\N	5	Status changed from new to unreachable of lead 196 by Farzana	Dhanmondi	counsellor	14
1484	2024-09-21 18:28:25.546072	2024-09-21 18:28:25.546072	\N	4	remark : Lead 268 updated by Jarin	Dhanmondi	counsellor	13
1519	2024-09-22 05:05:12.800296	2024-09-22 05:05:12.800296	\N	1	Logged in	Dhanmondi	counsellor	13
1563	2024-09-22 05:41:00.141552	2024-09-22 05:41:00.141552	\N	4	remark : Wrong Number 	Dhanmondi	counsellor	13
1564	2024-09-22 05:41:00.154123	2024-09-22 05:41:00.154123	\N	5	Status changed from new to unreachable of lead 252 by Jarin	Dhanmondi	counsellor	13
1607	2024-09-22 06:14:17.060474	2024-09-22 06:14:17.060474	\N	1	Logged in	Dhanmondi	admin	1
1647	2024-09-22 06:35:22.355524	2024-09-22 06:35:22.355524	\N	4	remark : Lead 343 updated by Jarin	Dhanmondi	counsellor	13
1680	2024-09-24 13:06:47.833552	2024-09-24 13:06:47.833552	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
1681	2024-09-24 13:06:47.838768	2024-09-24 13:06:47.838768	\N	5	Status changed from course-new to new of lead 337 by Naf	Dhanmondi	admin	1
1715	2024-09-26 14:20:05.581404	2024-09-26 14:20:05.581404	\N	2	Lead created	Dhanmondi	counsellor	14
1743	2024-09-30 17:17:23.159029	2024-09-30 17:17:23.159029	\N	1	Logged in	Dhanmondi	admin	1
1769	2024-10-11 06:07:06.957975	2024-10-11 06:07:06.957975	\N	1	Logged in	Dhanmondi	counsellor	13
1780	2024-11-10 05:45:02.631908	2024-11-10 05:45:02.631908	\N	1	Logged in	Dhanmondi	admin	1
1811	2024-11-24 12:53:30.562607	2024-11-24 12:53:30.562607	\N	1	Logged in	Dhanmondi	admin	1
833	2024-09-18 07:04:06.455312	2024-09-18 07:04:06.455312	\N	4	remark : Lead 317 updated by Naf	Dhanmondi	admin	1
834	2024-09-18 07:04:06.467723	2024-09-18 07:04:06.467723	\N	4	remark : Lead 314 updated by Naf	Dhanmondi	admin	1
835	2024-09-18 07:04:06.479347	2024-09-18 07:04:06.479347	\N	4	remark : Lead 316 updated by Naf	Dhanmondi	admin	1
836	2024-09-18 07:04:06.485435	2024-09-18 07:04:06.485435	\N	4	remark : Lead 315 updated by Naf	Dhanmondi	admin	1
837	2024-09-18 07:04:06.486815	2024-09-18 07:04:06.486815	\N	4	remark : Lead 319 updated by Naf	Dhanmondi	admin	1
838	2024-09-18 07:04:06.623567	2024-09-18 07:04:06.623567	\N	3	Lead 311 assigned to Farzana	Dhanmondi	admin	1
839	2024-09-18 07:04:06.635506	2024-09-18 07:04:06.635506	\N	3	Lead 310 assigned to Farzana	Dhanmondi	admin	1
840	2024-09-18 07:04:06.642353	2024-09-18 07:04:06.642353	\N	3	Lead 313 assigned to Farzana	Dhanmondi	admin	1
842	2024-09-18 07:04:06.661597	2024-09-18 07:04:06.661597	\N	4	remark : Lead 310 updated by Naf	Dhanmondi	admin	1
843	2024-09-18 07:04:06.659087	2024-09-18 07:04:06.659087	\N	4	remark : Lead 313 updated by Naf	Dhanmondi	admin	1
844	2024-09-18 07:04:06.667604	2024-09-18 07:04:06.667604	\N	3	Lead 312 assigned to Farzana	Dhanmondi	admin	1
845	2024-09-18 07:04:06.6714	2024-09-18 07:04:06.6714	\N	4	remark : Lead 312 updated by Naf	Dhanmondi	admin	1
846	2024-09-18 07:04:51.931981	2024-09-18 07:04:51.931981	\N	3	Lead 305 assigned to Farzana	Dhanmondi	admin	1
847	2024-09-18 07:04:51.932968	2024-09-18 07:04:51.932968	\N	3	Lead 309 assigned to Farzana	Dhanmondi	admin	1
848	2024-09-18 07:04:51.932667	2024-09-18 07:04:51.932667	\N	3	Lead 304 assigned to Farzana	Dhanmondi	admin	1
849	2024-09-18 07:04:51.9379	2024-09-18 07:04:51.9379	\N	3	Lead 308 assigned to Farzana	Dhanmondi	admin	1
850	2024-09-18 07:04:51.941274	2024-09-18 07:04:51.941274	\N	3	Lead 306 assigned to Farzana	Dhanmondi	admin	1
851	2024-09-18 07:04:51.944742	2024-09-18 07:04:51.944742	\N	3	Lead 307 assigned to Farzana	Dhanmondi	admin	1
852	2024-09-18 07:04:51.948938	2024-09-18 07:04:51.948938	\N	4	remark : Lead 306 updated by Naf	Dhanmondi	admin	1
853	2024-09-18 07:04:51.952866	2024-09-18 07:04:51.952866	\N	4	remark : Lead 307 updated by Naf	Dhanmondi	admin	1
854	2024-09-18 07:04:51.963634	2024-09-18 07:04:51.963634	\N	4	remark : Lead 308 updated by Naf	Dhanmondi	admin	1
855	2024-09-18 07:04:51.969004	2024-09-18 07:04:51.969004	\N	4	remark : Lead 309 updated by Naf	Dhanmondi	admin	1
856	2024-09-18 07:04:51.96843	2024-09-18 07:04:51.96843	\N	4	remark : Lead 304 updated by Naf	Dhanmondi	admin	1
857	2024-09-18 07:04:51.972314	2024-09-18 07:04:51.972314	\N	4	remark : Lead 305 updated by Naf	Dhanmondi	admin	1
858	2024-09-18 07:04:52.093651	2024-09-18 07:04:52.093651	\N	3	Lead 303 assigned to Farzana	Dhanmondi	admin	1
859	2024-09-18 07:04:52.099623	2024-09-18 07:04:52.099623	\N	3	Lead 301 assigned to Farzana	Dhanmondi	admin	1
860	2024-09-18 07:04:52.104112	2024-09-18 07:04:52.104112	\N	4	remark : Lead 303 updated by Naf	Dhanmondi	admin	1
861	2024-09-18 07:04:52.106394	2024-09-18 07:04:52.106394	\N	3	Lead 302 assigned to Farzana	Dhanmondi	admin	1
862	2024-09-18 07:04:52.10618	2024-09-18 07:04:52.10618	\N	4	remark : Lead 301 updated by Naf	Dhanmondi	admin	1
863	2024-09-18 07:04:52.11316	2024-09-18 07:04:52.11316	\N	4	remark : Lead 302 updated by Naf	Dhanmondi	admin	1
864	2024-09-18 07:04:52.113397	2024-09-18 07:04:52.113397	\N	3	Lead 300 assigned to Farzana	Dhanmondi	admin	1
865	2024-09-18 07:04:52.115788	2024-09-18 07:04:52.115788	\N	4	remark : Lead 300 updated by Naf	Dhanmondi	admin	1
866	2024-09-18 07:05:12.366309	2024-09-18 07:05:12.366309	\N	3	Lead 299 assigned to Jarin	Dhanmondi	admin	1
867	2024-09-18 07:05:12.368538	2024-09-18 07:05:12.368538	\N	3	Lead 294 assigned to Jarin	Dhanmondi	admin	1
868	2024-09-18 07:05:12.368688	2024-09-18 07:05:12.368688	\N	3	Lead 296 assigned to Jarin	Dhanmondi	admin	1
869	2024-09-18 07:05:12.373108	2024-09-18 07:05:12.373108	\N	3	Lead 295 assigned to Jarin	Dhanmondi	admin	1
870	2024-09-18 07:05:12.374633	2024-09-18 07:05:12.374633	\N	3	Lead 298 assigned to Jarin	Dhanmondi	admin	1
871	2024-09-18 07:05:12.374708	2024-09-18 07:05:12.374708	\N	3	Lead 297 assigned to Jarin	Dhanmondi	admin	1
872	2024-09-18 07:05:12.381418	2024-09-18 07:05:12.381418	\N	4	remark : Lead 298 updated by Naf	Dhanmondi	admin	1
873	2024-09-18 07:05:12.384466	2024-09-18 07:05:12.384466	\N	4	remark : Lead 297 updated by Naf	Dhanmondi	admin	1
874	2024-09-18 07:05:12.397415	2024-09-18 07:05:12.397415	\N	4	remark : Lead 299 updated by Naf	Dhanmondi	admin	1
875	2024-09-18 07:05:12.411139	2024-09-18 07:05:12.411139	\N	4	remark : Lead 294 updated by Naf	Dhanmondi	admin	1
876	2024-09-18 07:05:12.413516	2024-09-18 07:05:12.413516	\N	4	remark : Lead 295 updated by Naf	Dhanmondi	admin	1
877	2024-09-18 07:05:12.414478	2024-09-18 07:05:12.414478	\N	4	remark : Lead 296 updated by Naf	Dhanmondi	admin	1
878	2024-09-18 07:05:12.501277	2024-09-18 07:05:12.501277	\N	3	Lead 293 assigned to Jarin	Dhanmondi	admin	1
879	2024-09-18 07:05:12.503745	2024-09-18 07:05:12.503745	\N	4	remark : Lead 293 updated by Naf	Dhanmondi	admin	1
880	2024-09-18 07:05:12.533966	2024-09-18 07:05:12.533966	\N	3	Lead 292 assigned to Jarin	Dhanmondi	admin	1
881	2024-09-18 07:05:12.536668	2024-09-18 07:05:12.536668	\N	3	Lead 291 assigned to Jarin	Dhanmondi	admin	1
882	2024-09-18 07:05:12.540307	2024-09-18 07:05:12.540307	\N	4	remark : Lead 292 updated by Naf	Dhanmondi	admin	1
883	2024-09-18 07:05:12.540369	2024-09-18 07:05:12.540369	\N	3	Lead 290 assigned to Jarin	Dhanmondi	admin	1
884	2024-09-18 07:05:12.552012	2024-09-18 07:05:12.552012	\N	4	remark : Lead 291 updated by Naf	Dhanmondi	admin	1
885	2024-09-18 07:05:12.554893	2024-09-18 07:05:12.554893	\N	4	remark : Lead 290 updated by Naf	Dhanmondi	admin	1
886	2024-09-18 07:05:36.661078	2024-09-18 07:05:36.661078	\N	3	Lead 287 assigned to Jarin	Dhanmondi	admin	1
887	2024-09-18 07:05:36.666037	2024-09-18 07:05:36.666037	\N	3	Lead 285 assigned to Jarin	Dhanmondi	admin	1
888	2024-09-18 07:05:36.71716	2024-09-18 07:05:36.71716	\N	4	remark : Lead 287 updated by Naf	Dhanmondi	admin	1
889	2024-09-18 07:05:36.720851	2024-09-18 07:05:36.720851	\N	4	remark : Lead 285 updated by Naf	Dhanmondi	admin	1
890	2024-09-18 07:05:36.724804	2024-09-18 07:05:36.724804	\N	3	Lead 284 assigned to Jarin	Dhanmondi	admin	1
891	2024-09-18 07:05:36.733363	2024-09-18 07:05:36.733363	\N	3	Lead 286 assigned to Jarin	Dhanmondi	admin	1
892	2024-09-18 07:05:36.736987	2024-09-18 07:05:36.736987	\N	3	Lead 289 assigned to Jarin	Dhanmondi	admin	1
893	2024-09-18 07:05:36.740888	2024-09-18 07:05:36.740888	\N	3	Lead 288 assigned to Jarin	Dhanmondi	admin	1
894	2024-09-18 07:05:36.743966	2024-09-18 07:05:36.743966	\N	4	remark : Lead 286 updated by Naf	Dhanmondi	admin	1
895	2024-09-18 07:05:36.749789	2024-09-18 07:05:36.749789	\N	4	remark : Lead 289 updated by Naf	Dhanmondi	admin	1
896	2024-09-18 07:05:36.750566	2024-09-18 07:05:36.750566	\N	4	remark : Lead 288 updated by Naf	Dhanmondi	admin	1
897	2024-09-18 07:05:36.762446	2024-09-18 07:05:36.762446	\N	4	remark : Lead 284 updated by Naf	Dhanmondi	admin	1
898	2024-09-18 07:05:36.923543	2024-09-18 07:05:36.923543	\N	3	Lead 282 assigned to Jarin	Dhanmondi	admin	1
899	2024-09-18 07:05:36.94003	2024-09-18 07:05:36.94003	\N	4	remark : Lead 282 updated by Naf	Dhanmondi	admin	1
900	2024-09-18 07:05:36.942325	2024-09-18 07:05:36.942325	\N	3	Lead 283 assigned to Jarin	Dhanmondi	admin	1
901	2024-09-18 07:05:36.949046	2024-09-18 07:05:36.949046	\N	3	Lead 281 assigned to Jarin	Dhanmondi	admin	1
902	2024-09-18 07:05:36.950343	2024-09-18 07:05:36.950343	\N	3	Lead 280 assigned to Jarin	Dhanmondi	admin	1
1439	2024-09-21 16:18:27.260685	2024-09-21 16:18:27.260685	\N	4	remark : no response	Dhanmondi	counsellor	14
1440	2024-09-21 16:18:27.279022	2024-09-21 16:18:27.279022	\N	5	Status changed from new to unreachable of lead 195 by Farzana	Dhanmondi	counsellor	14
1485	2024-09-21 18:29:00.602517	2024-09-21 18:29:00.602517	\N	4	remark : No answer	Dhanmondi	counsellor	13
1486	2024-09-21 18:29:00.616642	2024-09-21 18:29:00.616642	\N	5	Status changed from new to not-interested of lead 268 by Jarin	Dhanmondi	counsellor	13
1520	2024-09-22 05:09:48.260743	2024-09-22 05:09:48.260743	\N	1	Logged in	Dhanmondi	counsellor	14
1565	2024-09-22 05:41:58.735143	2024-09-22 05:41:58.735143	\N	4	remark : No	Dhanmondi	counsellor	13
1566	2024-09-22 05:41:58.747533	2024-09-22 05:41:58.747533	\N	5	Status changed from new to not-interested of lead 251 by Jarin	Dhanmondi	counsellor	13
1567	2024-09-22 05:41:58.800083	2024-09-22 05:41:58.800083	\N	4	remark : No	Dhanmondi	counsellor	13
1608	2024-09-22 06:15:09.129645	2024-09-22 06:15:09.129645	\N	3	Lead 311 assigned to Jarin	Dhanmondi	admin	1
1619	2024-09-22 06:15:09.194605	2024-09-22 06:15:09.194605	\N	4	remark : Lead 309 updated by Naf	Dhanmondi	admin	1
1622	2024-09-22 06:15:09.28546	2024-09-22 06:15:09.28546	\N	3	Lead 305 assigned to Jarin	Dhanmondi	admin	1
1648	2024-09-22 06:43:18.819516	2024-09-22 06:43:18.819516	\N	4	remark : Number missing	Dhanmondi	counsellor	13
1649	2024-09-22 06:43:18.83541	2024-09-22 06:43:18.83541	\N	5	Status changed from new to unreachable of lead 312 by Jarin	Dhanmondi	counsellor	13
1682	2024-09-24 13:13:09.355613	2024-09-24 13:13:09.355613	\N	4	remark : on 24th	Dhanmondi	admin	1
1683	2024-09-24 13:13:09.371984	2024-09-24 13:13:09.371984	\N	5	Status changed from new to appointment-book of lead 337 by Naf	Dhanmondi	admin	1
1716	2024-09-26 14:20:41.784776	2024-09-26 14:20:41.784776	\N	4	remark : Lead 345 updated by Farzana	Dhanmondi	counsellor	14
1744	2024-10-01 07:36:22.431369	2024-10-01 07:36:22.431369	\N	1	Logged in	Dhanmondi	admin	1
1770	2024-10-11 18:20:11.329204	2024-10-11 18:20:11.329204	\N	1	Logged in	Dhanmondi	admin	1
1781	2024-11-12 15:52:10.548433	2024-11-12 15:52:10.548433	\N	1	Logged in	Dhanmondi	admin	1
1812	2024-11-24 13:02:21.142647	2024-11-24 13:02:21.142647	\N	1	Logged in	Dhanmondi	admin	1
903	2024-09-18 07:05:36.957527	2024-09-18 07:05:36.957527	\N	4	remark : Lead 283 updated by Naf	Dhanmondi	admin	1
905	2024-09-18 07:05:36.965319	2024-09-18 07:05:36.965319	\N	4	remark : Lead 280 updated by Naf	Dhanmondi	admin	1
1441	2024-09-21 16:18:57.070702	2024-09-21 16:18:57.070702	\N	4	remark : bad	Dhanmondi	counsellor	14
1442	2024-09-21 16:18:57.085375	2024-09-21 16:18:57.085375	\N	5	Status changed from new to not-interested of lead 194 by Farzana	Dhanmondi	counsellor	14
1445	2024-09-21 16:19:13.725537	2024-09-21 16:19:13.725537	\N	4	remark : no response	Dhanmondi	counsellor	14
1446	2024-09-21 16:19:13.728866	2024-09-21 16:19:13.728866	\N	5	Status changed from new to unreachable of lead 192 by Farzana	Dhanmondi	counsellor	14
1487	2024-09-21 18:31:02.408699	2024-09-21 18:31:02.408699	\N	4	remark : no answer	Dhanmondi	counsellor	13
1488	2024-09-21 18:31:02.427426	2024-09-21 18:31:02.427426	\N	5	Status changed from new to unreachable of lead 269 by Jarin	Dhanmondi	counsellor	13
1489	2024-09-21 18:31:06.304057	2024-09-21 18:31:06.304057	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1490	2024-09-21 18:31:15.922803	2024-09-21 18:31:15.922803	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1521	2024-09-22 05:09:56.996193	2024-09-22 05:09:56.996193	\N	4	remark : Wrong Number 	Dhanmondi	counsellor	13
1522	2024-09-22 05:09:57.009767	2024-09-22 05:09:57.009767	\N	5	Status changed from new to unreachable of lead 302 by Jarin	Dhanmondi	counsellor	13
1523	2024-09-22 05:09:59.878183	2024-09-22 05:09:59.878183	\N	4	remark : Lead 302 updated by Jarin	Dhanmondi	counsellor	13
1568	2024-09-22 05:42:51.457092	2024-09-22 05:42:51.457092	\N	4	remark : Switched Off	Dhanmondi	counsellor	13
1569	2024-09-22 05:42:51.472125	2024-09-22 05:42:51.472125	\N	5	Status changed from new to unreachable of lead 250 by Jarin	Dhanmondi	counsellor	13
1609	2024-09-22 06:15:09.131073	2024-09-22 06:15:09.131073	\N	3	Lead 308 assigned to Jarin	Dhanmondi	admin	1
1650	2024-09-22 06:46:53.962178	2024-09-22 06:46:53.962178	\N	4	remark : Busy	Dhanmondi	counsellor	13
1651	2024-09-22 06:46:53.975729	2024-09-22 06:46:53.975729	\N	5	Status changed from new to unreachable of lead 310 by Jarin	Dhanmondi	counsellor	13
1684	2024-09-24 13:13:24.881357	2024-09-24 13:13:24.881357	\N	4	remark : rec	Dhanmondi	admin	1
1685	2024-09-24 13:13:24.89771	2024-09-24 13:13:24.89771	\N	5	Status changed from appointment-book to waiting-for-document of lead 337 by Naf	Dhanmondi	admin	1
1717	2024-09-26 14:23:49.773288	2024-09-26 14:23:49.773288	\N	4	remark : Lead 345 updated by Farzana	Dhanmondi	counsellor	14
1745	2024-10-02 05:19:51.549845	2024-10-02 05:19:51.549845	\N	1	Logged in	Dhanmondi	counsellor	13
1771	2024-10-12 17:45:10.183171	2024-10-12 17:45:10.183171	\N	1	Logged in	Dhanmondi	counsellor	14
1782	2024-11-20 08:02:00.712849	2024-11-20 08:02:00.712849	\N	1	Logged in	Dhanmondi	admin	1
1813	2024-11-24 13:09:48.352135	2024-11-24 13:09:48.352135	\N	2	Lead created	Dhanmondi	admin	1
1819	2024-11-24 13:09:48.367531	2024-11-24 13:09:48.367531	\N	2	Lead created	Dhanmondi	admin	1
1831	2024-11-24 13:09:48.381583	2024-11-24 13:09:48.381583	\N	2	Lead created	Dhanmondi	admin	1
1841	2024-11-24 13:09:48.405169	2024-11-24 13:09:48.405169	\N	2	Lead created	Dhanmondi	admin	1
1850	2024-11-24 13:09:48.425955	2024-11-24 13:09:48.425955	\N	2	Lead created	Dhanmondi	admin	1
1858	2024-11-24 13:09:48.439627	2024-11-24 13:09:48.439627	\N	2	Lead created	Dhanmondi	admin	1
1866	2024-11-24 13:09:48.445281	2024-11-24 13:09:48.445281	\N	2	Lead created	Dhanmondi	admin	1
1875	2024-11-24 13:09:48.451637	2024-11-24 13:09:48.451637	\N	2	Lead created	Dhanmondi	admin	1
1884	2024-11-24 13:09:48.456954	2024-11-24 13:09:48.456954	\N	2	Lead created	Dhanmondi	admin	1
1895	2024-11-24 13:09:48.462357	2024-11-24 13:09:48.462357	\N	2	Lead created	Dhanmondi	admin	1
1904	2024-11-24 13:09:48.47155	2024-11-24 13:09:48.47155	\N	2	Lead created	Dhanmondi	admin	1
1915	2024-11-24 13:09:48.479411	2024-11-24 13:09:48.479411	\N	2	Lead created	Dhanmondi	admin	1
1926	2024-11-24 13:09:48.487217	2024-11-24 13:09:48.487217	\N	2	Lead created	Dhanmondi	admin	1
1935	2024-11-24 13:09:48.491697	2024-11-24 13:09:48.491697	\N	2	Lead created	Dhanmondi	admin	1
1949	2024-11-24 13:09:48.502074	2024-11-24 13:09:48.502074	\N	2	Lead created	Dhanmondi	admin	1
1957	2024-11-24 13:09:48.508708	2024-11-24 13:09:48.508708	\N	2	Lead created	Dhanmondi	admin	1
1965	2024-11-24 13:09:48.516773	2024-11-24 13:09:48.516773	\N	2	Lead created	Dhanmondi	admin	1
1973	2024-11-24 13:09:48.524268	2024-11-24 13:09:48.524268	\N	2	Lead created	Dhanmondi	admin	1
1982	2024-11-24 13:09:48.531615	2024-11-24 13:09:48.531615	\N	2	Lead created	Dhanmondi	admin	1
1990	2024-11-24 13:09:48.541199	2024-11-24 13:09:48.541199	\N	2	Lead created	Dhanmondi	admin	1
1998	2024-11-24 13:09:48.550682	2024-11-24 13:09:48.550682	\N	2	Lead created	Dhanmondi	admin	1
2006	2024-11-24 13:09:48.556611	2024-11-24 13:09:48.556611	\N	2	Lead created	Dhanmondi	admin	1
2018	2024-11-24 13:09:48.566619	2024-11-24 13:09:48.566619	\N	2	Lead created	Dhanmondi	admin	1
904	2024-09-18 07:05:36.955312	2024-09-18 07:05:36.955312	\N	4	remark : Lead 281 updated by Naf	Dhanmondi	admin	1
906	2024-09-18 07:06:08.976329	2024-09-18 07:06:08.976329	\N	3	Lead 276 assigned to Farzana	Dhanmondi	admin	1
907	2024-09-18 07:06:08.976761	2024-09-18 07:06:08.976761	\N	3	Lead 278 assigned to Farzana	Dhanmondi	admin	1
908	2024-09-18 07:06:08.97715	2024-09-18 07:06:08.97715	\N	3	Lead 277 assigned to Farzana	Dhanmondi	admin	1
909	2024-09-18 07:06:08.979837	2024-09-18 07:06:08.979837	\N	3	Lead 275 assigned to Farzana	Dhanmondi	admin	1
910	2024-09-18 07:06:08.981211	2024-09-18 07:06:08.981211	\N	3	Lead 279 assigned to Farzana	Dhanmondi	admin	1
911	2024-09-18 07:06:08.98754	2024-09-18 07:06:08.98754	\N	3	Lead 274 assigned to Farzana	Dhanmondi	admin	1
912	2024-09-18 07:06:08.988534	2024-09-18 07:06:08.988534	\N	4	remark : Lead 279 updated by Naf	Dhanmondi	admin	1
913	2024-09-18 07:06:08.994138	2024-09-18 07:06:08.994138	\N	4	remark : Lead 274 updated by Naf	Dhanmondi	admin	1
914	2024-09-18 07:06:09.011188	2024-09-18 07:06:09.011188	\N	4	remark : Lead 277 updated by Naf	Dhanmondi	admin	1
915	2024-09-18 07:06:09.011806	2024-09-18 07:06:09.011806	\N	4	remark : Lead 278 updated by Naf	Dhanmondi	admin	1
916	2024-09-18 07:06:09.018394	2024-09-18 07:06:09.018394	\N	4	remark : Lead 275 updated by Naf	Dhanmondi	admin	1
917	2024-09-18 07:06:09.019563	2024-09-18 07:06:09.019563	\N	4	remark : Lead 276 updated by Naf	Dhanmondi	admin	1
918	2024-09-18 07:06:09.139566	2024-09-18 07:06:09.139566	\N	3	Lead 272 assigned to Farzana	Dhanmondi	admin	1
919	2024-09-18 07:06:09.140926	2024-09-18 07:06:09.140926	\N	3	Lead 273 assigned to Farzana	Dhanmondi	admin	1
920	2024-09-18 07:06:09.140625	2024-09-18 07:06:09.140625	\N	3	Lead 271 assigned to Farzana	Dhanmondi	admin	1
921	2024-09-18 07:06:09.147279	2024-09-18 07:06:09.147279	\N	4	remark : Lead 272 updated by Naf	Dhanmondi	admin	1
922	2024-09-18 07:06:09.154182	2024-09-18 07:06:09.154182	\N	4	remark : Lead 271 updated by Naf	Dhanmondi	admin	1
923	2024-09-18 07:06:09.162618	2024-09-18 07:06:09.162618	\N	4	remark : Lead 273 updated by Naf	Dhanmondi	admin	1
924	2024-09-18 07:06:09.175145	2024-09-18 07:06:09.175145	\N	3	Lead 270 assigned to Farzana	Dhanmondi	admin	1
925	2024-09-18 07:06:09.181594	2024-09-18 07:06:09.181594	\N	4	remark : Lead 270 updated by Naf	Dhanmondi	admin	1
926	2024-09-18 07:06:25.445583	2024-09-18 07:06:25.445583	\N	3	Lead 267 assigned to Farzana	Dhanmondi	admin	1
927	2024-09-18 07:06:25.445183	2024-09-18 07:06:25.445183	\N	3	Lead 265 assigned to Farzana	Dhanmondi	admin	1
928	2024-09-18 07:06:25.486418	2024-09-18 07:06:25.486418	\N	3	Lead 264 assigned to Farzana	Dhanmondi	admin	1
929	2024-09-18 07:06:25.484872	2024-09-18 07:06:25.484872	\N	4	remark : Lead 267 updated by Naf	Dhanmondi	admin	1
930	2024-09-18 07:06:25.498336	2024-09-18 07:06:25.498336	\N	3	Lead 269 assigned to Farzana	Dhanmondi	admin	1
931	2024-09-18 07:06:25.492146	2024-09-18 07:06:25.492146	\N	3	Lead 268 assigned to Farzana	Dhanmondi	admin	1
932	2024-09-18 07:06:25.511007	2024-09-18 07:06:25.511007	\N	3	Lead 266 assigned to Farzana	Dhanmondi	admin	1
933	2024-09-18 07:06:25.510565	2024-09-18 07:06:25.510565	\N	4	remark : Lead 269 updated by Naf	Dhanmondi	admin	1
934	2024-09-18 07:06:25.512338	2024-09-18 07:06:25.512338	\N	4	remark : Lead 264 updated by Naf	Dhanmondi	admin	1
935	2024-09-18 07:06:25.522181	2024-09-18 07:06:25.522181	\N	4	remark : Lead 266 updated by Naf	Dhanmondi	admin	1
936	2024-09-18 07:06:25.526869	2024-09-18 07:06:25.526869	\N	4	remark : Lead 265 updated by Naf	Dhanmondi	admin	1
937	2024-09-18 07:06:25.535007	2024-09-18 07:06:25.535007	\N	4	remark : Lead 268 updated by Naf	Dhanmondi	admin	1
938	2024-09-18 07:06:25.622902	2024-09-18 07:06:25.622902	\N	3	Lead 263 assigned to Farzana	Dhanmondi	admin	1
939	2024-09-18 07:06:25.62338	2024-09-18 07:06:25.62338	\N	3	Lead 262 assigned to Farzana	Dhanmondi	admin	1
940	2024-09-18 07:06:25.64252	2024-09-18 07:06:25.64252	\N	4	remark : Lead 263 updated by Naf	Dhanmondi	admin	1
941	2024-09-18 07:06:25.660328	2024-09-18 07:06:25.660328	\N	4	remark : Lead 262 updated by Naf	Dhanmondi	admin	1
942	2024-09-18 07:06:25.663091	2024-09-18 07:06:25.663091	\N	3	Lead 261 assigned to Farzana	Dhanmondi	admin	1
943	2024-09-18 07:06:25.669446	2024-09-18 07:06:25.669446	\N	4	remark : Lead 261 updated by Naf	Dhanmondi	admin	1
944	2024-09-18 07:06:25.671325	2024-09-18 07:06:25.671325	\N	3	Lead 260 assigned to Farzana	Dhanmondi	admin	1
945	2024-09-18 07:06:25.678709	2024-09-18 07:06:25.678709	\N	4	remark : Lead 260 updated by Naf	Dhanmondi	admin	1
946	2024-09-18 07:06:39.852344	2024-09-18 07:06:39.852344	\N	3	Lead 256 assigned to Jarin	Dhanmondi	admin	1
947	2024-09-18 07:06:39.855541	2024-09-18 07:06:39.855541	\N	3	Lead 254 assigned to Jarin	Dhanmondi	admin	1
948	2024-09-18 07:06:39.887627	2024-09-18 07:06:39.887627	\N	4	remark : Lead 256 updated by Naf	Dhanmondi	admin	1
949	2024-09-18 07:06:39.889461	2024-09-18 07:06:39.889461	\N	4	remark : Lead 254 updated by Naf	Dhanmondi	admin	1
950	2024-09-18 07:06:39.905562	2024-09-18 07:06:39.905562	\N	3	Lead 257 assigned to Jarin	Dhanmondi	admin	1
951	2024-09-18 07:06:39.906246	2024-09-18 07:06:39.906246	\N	3	Lead 255 assigned to Jarin	Dhanmondi	admin	1
952	2024-09-18 07:06:39.906847	2024-09-18 07:06:39.906847	\N	3	Lead 258 assigned to Jarin	Dhanmondi	admin	1
953	2024-09-18 07:06:39.907438	2024-09-18 07:06:39.907438	\N	3	Lead 259 assigned to Jarin	Dhanmondi	admin	1
954	2024-09-18 07:06:39.910504	2024-09-18 07:06:39.910504	\N	4	remark : Lead 255 updated by Naf	Dhanmondi	admin	1
955	2024-09-18 07:06:39.915243	2024-09-18 07:06:39.915243	\N	4	remark : Lead 259 updated by Naf	Dhanmondi	admin	1
956	2024-09-18 07:06:39.915696	2024-09-18 07:06:39.915696	\N	4	remark : Lead 258 updated by Naf	Dhanmondi	admin	1
957	2024-09-18 07:06:39.926278	2024-09-18 07:06:39.926278	\N	4	remark : Lead 257 updated by Naf	Dhanmondi	admin	1
958	2024-09-18 07:06:40.040817	2024-09-18 07:06:40.040817	\N	3	Lead 252 assigned to Jarin	Dhanmondi	admin	1
959	2024-09-18 07:06:40.043084	2024-09-18 07:06:40.043084	\N	3	Lead 253 assigned to Jarin	Dhanmondi	admin	1
960	2024-09-18 07:06:40.049386	2024-09-18 07:06:40.049386	\N	3	Lead 251 assigned to Jarin	Dhanmondi	admin	1
961	2024-09-18 07:06:40.049796	2024-09-18 07:06:40.049796	\N	4	remark : Lead 252 updated by Naf	Dhanmondi	admin	1
962	2024-09-18 07:06:40.052997	2024-09-18 07:06:40.052997	\N	4	remark : Lead 253 updated by Naf	Dhanmondi	admin	1
963	2024-09-18 07:06:40.056782	2024-09-18 07:06:40.056782	\N	4	remark : Lead 251 updated by Naf	Dhanmondi	admin	1
964	2024-09-18 07:06:40.057531	2024-09-18 07:06:40.057531	\N	3	Lead 250 assigned to Jarin	Dhanmondi	admin	1
965	2024-09-18 07:06:40.063547	2024-09-18 07:06:40.063547	\N	4	remark : Lead 250 updated by Naf	Dhanmondi	admin	1
966	2024-09-18 07:07:02.102771	2024-09-18 07:07:02.102771	\N	3	Lead 248 assigned to Farzana	Dhanmondi	admin	1
967	2024-09-18 07:07:02.104934	2024-09-18 07:07:02.104934	\N	3	Lead 244 assigned to Farzana	Dhanmondi	admin	1
968	2024-09-18 07:07:02.110747	2024-09-18 07:07:02.110747	\N	3	Lead 247 assigned to Farzana	Dhanmondi	admin	1
969	2024-09-18 07:07:02.119183	2024-09-18 07:07:02.119183	\N	3	Lead 246 assigned to Farzana	Dhanmondi	admin	1
970	2024-09-18 07:07:02.119553	2024-09-18 07:07:02.119553	\N	3	Lead 245 assigned to Farzana	Dhanmondi	admin	1
971	2024-09-18 07:07:02.118633	2024-09-18 07:07:02.118633	\N	4	remark : Lead 247 updated by Naf	Dhanmondi	admin	1
972	2024-09-18 07:07:02.12303	2024-09-18 07:07:02.12303	\N	3	Lead 249 assigned to Farzana	Dhanmondi	admin	1
973	2024-09-18 07:07:02.134622	2024-09-18 07:07:02.134622	\N	4	remark : Lead 249 updated by Naf	Dhanmondi	admin	1
975	2024-09-18 07:07:02.150218	2024-09-18 07:07:02.150218	\N	4	remark : Lead 244 updated by Naf	Dhanmondi	admin	1
1443	2024-09-21 16:19:03.925973	2024-09-21 16:19:03.925973	\N	4	remark : bad	Dhanmondi	counsellor	14
1444	2024-09-21 16:19:03.931026	2024-09-21 16:19:03.931026	\N	5	Status changed from new to not-interested of lead 193 by Farzana	Dhanmondi	counsellor	14
1447	2024-09-21 16:19:20.765756	2024-09-21 16:19:20.765756	\N	4	remark : bad	Dhanmondi	counsellor	14
1448	2024-09-21 16:19:20.7681	2024-09-21 16:19:20.7681	\N	5	Status changed from new to not-interested of lead 191 by Farzana	Dhanmondi	counsellor	14
1491	2024-09-21 18:32:54.085252	2024-09-21 18:32:54.085252	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1524	2024-09-22 05:10:23.940324	2024-09-22 05:10:23.940324	\N	1	Logged in	Dhanmondi	admin	1
1570	2024-09-22 05:44:49.342243	2024-09-22 05:44:49.342243	\N	4	remark : No answer	Dhanmondi	counsellor	13
1571	2024-09-22 05:44:49.35616	2024-09-22 05:44:49.35616	\N	5	Status changed from new to unreachable of lead 217 by Jarin	Dhanmondi	counsellor	13
1610	2024-09-22 06:15:09.130335	2024-09-22 06:15:09.130335	\N	3	Lead 312 assigned to Jarin	Dhanmondi	admin	1
1616	2024-09-22 06:15:09.178044	2024-09-22 06:15:09.178044	\N	4	remark : Lead 312 updated by Naf	Dhanmondi	admin	1
1617	2024-09-22 06:15:09.187562	2024-09-22 06:15:09.187562	\N	4	remark : Lead 308 updated by Naf	Dhanmondi	admin	1
1652	2024-09-22 06:49:52.079541	2024-09-22 06:49:52.079541	\N	4	remark : He wants to go europe ,Japan or south korea	Dhanmondi	counsellor	13
1653	2024-09-22 06:49:52.095117	2024-09-22 06:49:52.095117	\N	5	Status changed from new to future-interest of lead 311 by Jarin	Dhanmondi	counsellor	13
1686	2024-09-24 13:13:39.04589	2024-09-24 13:13:39.04589	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
1718	2024-09-26 14:24:53.80869	2024-09-26 14:24:53.80869	\N	4	remark : Lead 345 updated by Farzana	Dhanmondi	counsellor	14
1746	2024-10-03 07:56:27.100104	2024-10-03 07:56:27.100104	\N	1	Logged in	Dhanmondi	admin	1
1772	2024-10-12 23:39:08.854977	2024-10-12 23:39:08.854977	\N	1	Logged in	Dhanmondi	admin	1
1783	2024-11-22 06:57:15.600922	2024-11-22 06:57:15.600922	\N	1	Logged in	Dhanmondi	admin	1
1814	2024-11-24 13:09:48.352947	2024-11-24 13:09:48.352947	\N	2	Lead created	Dhanmondi	admin	1
1821	2024-11-24 13:09:48.370897	2024-11-24 13:09:48.370897	\N	2	Lead created	Dhanmondi	admin	1
1825	2024-11-24 13:09:48.376393	2024-11-24 13:09:48.376393	\N	2	Lead created	Dhanmondi	admin	1
1833	2024-11-24 13:09:48.38342	2024-11-24 13:09:48.38342	\N	2	Lead created	Dhanmondi	admin	1
1839	2024-11-24 13:09:48.403233	2024-11-24 13:09:48.403233	\N	2	Lead created	Dhanmondi	admin	1
1848	2024-11-24 13:09:48.424631	2024-11-24 13:09:48.424631	\N	2	Lead created	Dhanmondi	admin	1
1856	2024-11-24 13:09:48.438768	2024-11-24 13:09:48.438768	\N	2	Lead created	Dhanmondi	admin	1
1864	2024-11-24 13:09:48.444712	2024-11-24 13:09:48.444712	\N	2	Lead created	Dhanmondi	admin	1
1872	2024-11-24 13:09:48.449194	2024-11-24 13:09:48.449194	\N	2	Lead created	Dhanmondi	admin	1
1880	2024-11-24 13:09:48.453328	2024-11-24 13:09:48.453328	\N	2	Lead created	Dhanmondi	admin	1
1887	2024-11-24 13:09:48.457212	2024-11-24 13:09:48.457212	\N	2	Lead created	Dhanmondi	admin	1
1898	2024-11-24 13:09:48.465326	2024-11-24 13:09:48.465326	\N	2	Lead created	Dhanmondi	admin	1
1912	2024-11-24 13:09:48.476333	2024-11-24 13:09:48.476333	\N	2	Lead created	Dhanmondi	admin	1
1925	2024-11-24 13:09:48.487085	2024-11-24 13:09:48.487085	\N	2	Lead created	Dhanmondi	admin	1
1934	2024-11-24 13:09:48.491599	2024-11-24 13:09:48.491599	\N	2	Lead created	Dhanmondi	admin	1
1944	2024-11-24 13:09:48.499059	2024-11-24 13:09:48.499059	\N	2	Lead created	Dhanmondi	admin	1
1955	2024-11-24 13:09:48.507253	2024-11-24 13:09:48.507253	\N	2	Lead created	Dhanmondi	admin	1
1963	2024-11-24 13:09:48.51465	2024-11-24 13:09:48.51465	\N	2	Lead created	Dhanmondi	admin	1
1977	2024-11-24 13:09:48.524906	2024-11-24 13:09:48.524906	\N	2	Lead created	Dhanmondi	admin	1
1985	2024-11-24 13:09:48.535907	2024-11-24 13:09:48.535907	\N	2	Lead created	Dhanmondi	admin	1
1993	2024-11-24 13:09:48.546152	2024-11-24 13:09:48.546152	\N	2	Lead created	Dhanmondi	admin	1
2002	2024-11-24 13:09:48.552656	2024-11-24 13:09:48.552656	\N	2	Lead created	Dhanmondi	admin	1
2015	2024-11-24 13:09:48.560076	2024-11-24 13:09:48.560076	\N	2	Lead created	Dhanmondi	admin	1
2025	2024-11-24 13:09:48.571408	2024-11-24 13:09:48.571408	\N	2	Lead created	Dhanmondi	admin	1
974	2024-09-18 07:07:02.14771	2024-09-18 07:07:02.14771	\N	4	remark : Lead 248 updated by Naf	Dhanmondi	admin	1
987	2024-09-18 07:07:14.931139	2024-09-18 07:07:14.931139	\N	3	Lead 235 assigned to Farzana	Dhanmondi	admin	1
991	2024-09-18 07:07:14.995667	2024-09-18 07:07:14.995667	\N	4	remark : Lead 236 updated by Naf	Dhanmondi	admin	1
999	2024-09-18 07:07:15.076015	2024-09-18 07:07:15.076015	\N	4	remark : Lead 233 updated by Naf	Dhanmondi	admin	1
1001	2024-09-18 07:07:15.137186	2024-09-18 07:07:15.137186	\N	3	Lead 230 assigned to Farzana	Dhanmondi	admin	1
1449	2024-09-21 16:19:32.267487	2024-09-21 16:19:32.267487	\N	4	remark : bad	Dhanmondi	counsellor	14
1450	2024-09-21 16:19:32.280514	2024-09-21 16:19:32.280514	\N	5	Status changed from new to not-interested of lead 190 by Farzana	Dhanmondi	counsellor	14
1492	2024-09-21 18:33:15.94134	2024-09-21 18:33:15.94134	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1525	2024-09-22 05:11:42.721845	2024-09-22 05:11:42.721845	\N	4	remark : Wrong number	Dhanmondi	counsellor	13
1526	2024-09-22 05:11:42.735775	2024-09-22 05:11:42.735775	\N	5	Status changed from new to unreachable of lead 301 by Jarin	Dhanmondi	counsellor	13
1527	2024-09-22 05:11:47.689084	2024-09-22 05:11:47.689084	\N	4	remark : Lead 301 updated by Jarin	Dhanmondi	counsellor	13
1572	2024-09-22 05:46:53.623924	2024-09-22 05:46:53.623924	\N	4	remark : Wrong Number	Dhanmondi	counsellor	13
1573	2024-09-22 05:46:53.637189	2024-09-22 05:46:53.637189	\N	5	Status changed from new to unreachable of lead 227 by Jarin	Dhanmondi	counsellor	13
1611	2024-09-22 06:15:09.131877	2024-09-22 06:15:09.131877	\N	3	Lead 309 assigned to Jarin	Dhanmondi	admin	1
1614	2024-09-22 06:15:09.146034	2024-09-22 06:15:09.146034	\N	4	remark : Lead 310 updated by Naf	Dhanmondi	admin	1
1654	2024-09-22 07:01:45.00722	2024-09-22 07:01:45.00722	\N	4	remark : No answer	Dhanmondi	counsellor	13
1655	2024-09-22 07:01:45.021925	2024-09-22 07:01:45.021925	\N	5	Status changed from new to unreachable of lead 309 by Jarin	Dhanmondi	counsellor	13
1687	2024-09-24 13:13:45.99952	2024-09-24 13:13:45.99952	\N	4	remark : Lead 337 updated by Naf	Dhanmondi	admin	1
1719	2024-09-26 14:25:28.823787	2024-09-26 14:25:28.823787	\N	4	remark : she sends all documents	Dhanmondi	counsellor	14
1720	2024-09-26 14:25:28.842876	2024-09-26 14:25:28.842876	\N	5	Status changed from new to appointment-book of lead 345 by Farzana	Dhanmondi	counsellor	14
1747	2024-10-04 13:53:33.295322	2024-10-04 13:53:33.295322	\N	1	Logged in	Dhanmondi	counsellor	13
1773	2024-10-15 15:40:23.454837	2024-10-15 15:40:23.454837	\N	1	Logged in	Dhanmondi	admin	1
1784	2024-11-24 06:06:00.04394	2024-11-24 06:06:00.04394	\N	1	Logged in	Dhanmondi	admin	1
1815	2024-11-24 13:09:48.361574	2024-11-24 13:09:48.361574	\N	2	Lead created	Dhanmondi	admin	1
1823	2024-11-24 13:09:48.375243	2024-11-24 13:09:48.375243	\N	2	Lead created	Dhanmondi	admin	1
1830	2024-11-24 13:09:48.382007	2024-11-24 13:09:48.382007	\N	2	Lead created	Dhanmondi	admin	1
1836	2024-11-24 13:09:48.389993	2024-11-24 13:09:48.389993	\N	2	Lead created	Dhanmondi	admin	1
1845	2024-11-24 13:09:48.421669	2024-11-24 13:09:48.421669	\N	2	Lead created	Dhanmondi	admin	1
1854	2024-11-24 13:09:48.435814	2024-11-24 13:09:48.435814	\N	2	Lead created	Dhanmondi	admin	1
1861	2024-11-24 13:09:48.443522	2024-11-24 13:09:48.443522	\N	2	Lead created	Dhanmondi	admin	1
1869	2024-11-24 13:09:48.448179	2024-11-24 13:09:48.448179	\N	2	Lead created	Dhanmondi	admin	1
1876	2024-11-24 13:09:48.452165	2024-11-24 13:09:48.452165	\N	2	Lead created	Dhanmondi	admin	1
1883	2024-11-24 13:09:48.456391	2024-11-24 13:09:48.456391	\N	2	Lead created	Dhanmondi	admin	1
1890	2024-11-24 13:09:48.46044	2024-11-24 13:09:48.46044	\N	2	Lead created	Dhanmondi	admin	1
1899	2024-11-24 13:09:48.465851	2024-11-24 13:09:48.465851	\N	2	Lead created	Dhanmondi	admin	1
1907	2024-11-24 13:09:48.472334	2024-11-24 13:09:48.472334	\N	2	Lead created	Dhanmondi	admin	1
1913	2024-11-24 13:09:48.477812	2024-11-24 13:09:48.477812	\N	2	Lead created	Dhanmondi	admin	1
1921	2024-11-24 13:09:48.484954	2024-11-24 13:09:48.484954	\N	2	Lead created	Dhanmondi	admin	1
1930	2024-11-24 13:09:48.489165	2024-11-24 13:09:48.489165	\N	2	Lead created	Dhanmondi	admin	1
1938	2024-11-24 13:09:48.493983	2024-11-24 13:09:48.493983	\N	2	Lead created	Dhanmondi	admin	1
1946	2024-11-24 13:09:48.499749	2024-11-24 13:09:48.499749	\N	2	Lead created	Dhanmondi	admin	1
1953	2024-11-24 13:09:48.506288	2024-11-24 13:09:48.506288	\N	2	Lead created	Dhanmondi	admin	1
1961	2024-11-24 13:09:48.513839	2024-11-24 13:09:48.513839	\N	2	Lead created	Dhanmondi	admin	1
1970	2024-11-24 13:09:48.519981	2024-11-24 13:09:48.519981	\N	2	Lead created	Dhanmondi	admin	1
1978	2024-11-24 13:09:48.526674	2024-11-24 13:09:48.526674	\N	2	Lead created	Dhanmondi	admin	1
1986	2024-11-24 13:09:48.53718	2024-11-24 13:09:48.53718	\N	2	Lead created	Dhanmondi	admin	1
1995	2024-11-24 13:09:48.547354	2024-11-24 13:09:48.547354	\N	2	Lead created	Dhanmondi	admin	1
2003	2024-11-24 13:09:48.553858	2024-11-24 13:09:48.553858	\N	2	Lead created	Dhanmondi	admin	1
2011	2024-11-24 13:09:48.558767	2024-11-24 13:09:48.558767	\N	2	Lead created	Dhanmondi	admin	1
2019	2024-11-24 13:09:48.567075	2024-11-24 13:09:48.567075	\N	2	Lead created	Dhanmondi	admin	1
2027	2024-11-24 13:09:48.572067	2024-11-24 13:09:48.572067	\N	2	Lead created	Dhanmondi	admin	1
976	2024-09-18 07:07:02.151065	2024-09-18 07:07:02.151065	\N	4	remark : Lead 246 updated by Naf	Dhanmondi	admin	1
982	2024-09-18 07:07:02.288944	2024-09-18 07:07:02.288944	\N	4	remark : Lead 243 updated by Naf	Dhanmondi	admin	1
1451	2024-09-21 16:19:42.046667	2024-09-21 16:19:42.046667	\N	4	remark : bad bad	Dhanmondi	counsellor	14
1452	2024-09-21 16:19:42.050025	2024-09-21 16:19:42.050025	\N	5	Status changed from new to not-interested of lead 189 by Farzana	Dhanmondi	counsellor	14
1493	2024-09-21 18:33:18.43018	2024-09-21 18:33:18.43018	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1528	2024-09-22 05:12:39.368799	2024-09-22 05:12:39.368799	\N	1	Logged in	Dhanmondi	counsellor	14
1574	2024-09-22 05:47:46.50068	2024-09-22 05:47:46.50068	\N	4	remark : Busy	Dhanmondi	counsellor	13
1575	2024-09-22 05:47:46.514171	2024-09-22 05:47:46.514171	\N	5	Status changed from new to unreachable of lead 226 by Jarin	Dhanmondi	counsellor	13
1612	2024-09-22 06:15:09.137992	2024-09-22 06:15:09.137992	\N	3	Lead 310 assigned to Jarin	Dhanmondi	admin	1
1615	2024-09-22 06:15:09.150318	2024-09-22 06:15:09.150318	\N	4	remark : Lead 307 updated by Naf	Dhanmondi	admin	1
1618	2024-09-22 06:15:09.189076	2024-09-22 06:15:09.189076	\N	4	remark : Lead 311 updated by Naf	Dhanmondi	admin	1
1656	2024-09-22 07:02:05.234117	2024-09-22 07:02:05.234117	\N	4	remark : Number Missing	Dhanmondi	counsellor	13
1657	2024-09-22 07:02:05.248764	2024-09-22 07:02:05.248764	\N	5	Status changed from new to unreachable of lead 308 by Jarin	Dhanmondi	counsellor	13
1688	2024-09-24 13:18:04.162089	2024-09-24 13:18:04.162089	\N	4	remark : Lead 300 updated by Naf	Dhanmondi	admin	1
1689	2024-09-24 13:18:04.168342	2024-09-24 13:18:04.168342	\N	5	Status changed from unreachable to course-new of lead 300 by Naf	Dhanmondi	admin	1
1721	2024-09-26 14:26:22.983077	2024-09-26 14:26:22.983077	\N	4	remark : she sends all documents	Dhanmondi	counsellor	14
1722	2024-09-26 14:26:22.999478	2024-09-26 14:26:22.999478	\N	5	Status changed from appointment-book to waiting-for-document of lead 345 by Farzana	Dhanmondi	counsellor	14
1748	2024-10-06 11:33:30.685905	2024-10-06 11:33:30.685905	\N	1	Logged in	Dhanmondi	admin	1
1774	2024-10-16 12:00:42.953074	2024-10-16 12:00:42.953074	\N	1	Logged in	Dhanmondi	admin	1
1785	2024-11-24 06:06:18.807022	2024-11-24 06:06:18.807022	\N	1	Logged in	Dhanmondi	counsellor	14
1816	2024-11-24 13:09:48.362176	2024-11-24 13:09:48.362176	\N	2	Lead created	Dhanmondi	admin	1
1829	2024-11-24 13:09:48.378557	2024-11-24 13:09:48.378557	\N	2	Lead created	Dhanmondi	admin	1
1842	2024-11-24 13:09:48.405356	2024-11-24 13:09:48.405356	\N	2	Lead created	Dhanmondi	admin	1
1851	2024-11-24 13:09:48.426181	2024-11-24 13:09:48.426181	\N	2	Lead created	Dhanmondi	admin	1
1859	2024-11-24 13:09:48.439733	2024-11-24 13:09:48.439733	\N	2	Lead created	Dhanmondi	admin	1
1870	2024-11-24 13:09:48.447752	2024-11-24 13:09:48.447752	\N	2	Lead created	Dhanmondi	admin	1
1885	2024-11-24 13:09:48.455971	2024-11-24 13:09:48.455971	\N	2	Lead created	Dhanmondi	admin	1
1892	2024-11-24 13:09:48.461003	2024-11-24 13:09:48.461003	\N	2	Lead created	Dhanmondi	admin	1
1900	2024-11-24 13:09:48.466042	2024-11-24 13:09:48.466042	\N	2	Lead created	Dhanmondi	admin	1
1910	2024-11-24 13:09:48.475794	2024-11-24 13:09:48.475794	\N	2	Lead created	Dhanmondi	admin	1
1918	2024-11-24 13:09:48.481201	2024-11-24 13:09:48.481201	\N	2	Lead created	Dhanmondi	admin	1
1928	2024-11-24 13:09:48.488757	2024-11-24 13:09:48.488757	\N	2	Lead created	Dhanmondi	admin	1
1942	2024-11-24 13:09:48.495452	2024-11-24 13:09:48.495452	\N	2	Lead created	Dhanmondi	admin	1
1958	2024-11-24 13:09:48.507744	2024-11-24 13:09:48.507744	\N	2	Lead created	Dhanmondi	admin	1
1966	2024-11-24 13:09:48.517482	2024-11-24 13:09:48.517482	\N	2	Lead created	Dhanmondi	admin	1
1974	2024-11-24 13:09:48.524364	2024-11-24 13:09:48.524364	\N	2	Lead created	Dhanmondi	admin	1
1988	2024-11-24 13:09:48.539129	2024-11-24 13:09:48.539129	\N	2	Lead created	Dhanmondi	admin	1
1999	2024-11-24 13:09:48.55118	2024-11-24 13:09:48.55118	\N	2	Lead created	Dhanmondi	admin	1
2009	2024-11-24 13:09:48.558022	2024-11-24 13:09:48.558022	\N	2	Lead created	Dhanmondi	admin	1
2017	2024-11-24 13:09:48.565843	2024-11-24 13:09:48.565843	\N	2	Lead created	Dhanmondi	admin	1
2030	2024-11-24 13:09:48.573753	2024-11-24 13:09:48.573753	\N	2	Lead created	Dhanmondi	admin	1
977	2024-09-18 07:07:02.151745	2024-09-18 07:07:02.151745	\N	4	remark : Lead 245 updated by Naf	Dhanmondi	admin	1
978	2024-09-18 07:07:02.270317	2024-09-18 07:07:02.270317	\N	3	Lead 243 assigned to Farzana	Dhanmondi	admin	1
979	2024-09-18 07:07:02.276119	2024-09-18 07:07:02.276119	\N	3	Lead 242 assigned to Farzana	Dhanmondi	admin	1
980	2024-09-18 07:07:02.28727	2024-09-18 07:07:02.28727	\N	3	Lead 240 assigned to Farzana	Dhanmondi	admin	1
981	2024-09-18 07:07:02.287924	2024-09-18 07:07:02.287924	\N	4	remark : Lead 242 updated by Naf	Dhanmondi	admin	1
983	2024-09-18 07:07:02.294308	2024-09-18 07:07:02.294308	\N	4	remark : Lead 240 updated by Naf	Dhanmondi	admin	1
984	2024-09-18 07:07:02.296795	2024-09-18 07:07:02.296795	\N	3	Lead 241 assigned to Farzana	Dhanmondi	admin	1
985	2024-09-18 07:07:02.302916	2024-09-18 07:07:02.302916	\N	4	remark : Lead 241 updated by Naf	Dhanmondi	admin	1
986	2024-09-18 07:07:14.928069	2024-09-18 07:07:14.928069	\N	3	Lead 236 assigned to Farzana	Dhanmondi	admin	1
988	2024-09-18 07:07:14.950941	2024-09-18 07:07:14.950941	\N	3	Lead 239 assigned to Farzana	Dhanmondi	admin	1
989	2024-09-18 07:07:14.954746	2024-09-18 07:07:14.954746	\N	4	remark : Lead 239 updated by Naf	Dhanmondi	admin	1
990	2024-09-18 07:07:14.995546	2024-09-18 07:07:14.995546	\N	3	Lead 238 assigned to Farzana	Dhanmondi	admin	1
992	2024-09-18 07:07:14.999656	2024-09-18 07:07:14.999656	\N	3	Lead 234 assigned to Farzana	Dhanmondi	admin	1
993	2024-09-18 07:07:15.001597	2024-09-18 07:07:15.001597	\N	4	remark : Lead 238 updated by Naf	Dhanmondi	admin	1
994	2024-09-18 07:07:15.001634	2024-09-18 07:07:15.001634	\N	3	Lead 237 assigned to Farzana	Dhanmondi	admin	1
995	2024-09-18 07:07:15.0097	2024-09-18 07:07:15.0097	\N	4	remark : Lead 237 updated by Naf	Dhanmondi	admin	1
996	2024-09-18 07:07:15.018962	2024-09-18 07:07:15.018962	\N	4	remark : Lead 234 updated by Naf	Dhanmondi	admin	1
997	2024-09-18 07:07:15.028853	2024-09-18 07:07:15.028853	\N	4	remark : Lead 235 updated by Naf	Dhanmondi	admin	1
998	2024-09-18 07:07:15.073684	2024-09-18 07:07:15.073684	\N	3	Lead 233 assigned to Farzana	Dhanmondi	admin	1
1000	2024-09-18 07:07:15.136898	2024-09-18 07:07:15.136898	\N	3	Lead 232 assigned to Farzana	Dhanmondi	admin	1
1002	2024-09-18 07:07:15.144687	2024-09-18 07:07:15.144687	\N	3	Lead 231 assigned to Farzana	Dhanmondi	admin	1
1003	2024-09-18 07:07:15.145602	2024-09-18 07:07:15.145602	\N	4	remark : Lead 232 updated by Naf	Dhanmondi	admin	1
1004	2024-09-18 07:07:15.148736	2024-09-18 07:07:15.148736	\N	4	remark : Lead 230 updated by Naf	Dhanmondi	admin	1
1005	2024-09-18 07:07:15.150917	2024-09-18 07:07:15.150917	\N	4	remark : Lead 231 updated by Naf	Dhanmondi	admin	1
1006	2024-09-18 07:07:35.788806	2024-09-18 07:07:35.788806	\N	3	Lead 226 assigned to Jarin	Dhanmondi	admin	1
1007	2024-09-18 07:07:35.797002	2024-09-18 07:07:35.797002	\N	3	Lead 225 assigned to Jarin	Dhanmondi	admin	1
1008	2024-09-18 07:07:35.804315	2024-09-18 07:07:35.804315	\N	4	remark : Lead 225 updated by Naf	Dhanmondi	admin	1
1009	2024-09-18 07:07:35.844796	2024-09-18 07:07:35.844796	\N	3	Lead 224 assigned to Jarin	Dhanmondi	admin	1
1010	2024-09-18 07:07:35.850772	2024-09-18 07:07:35.850772	\N	3	Lead 228 assigned to Jarin	Dhanmondi	admin	1
1011	2024-09-18 07:07:35.856282	2024-09-18 07:07:35.856282	\N	4	remark : Lead 226 updated by Naf	Dhanmondi	admin	1
1012	2024-09-18 07:07:35.862162	2024-09-18 07:07:35.862162	\N	4	remark : Lead 228 updated by Naf	Dhanmondi	admin	1
1013	2024-09-18 07:07:35.864916	2024-09-18 07:07:35.864916	\N	3	Lead 229 assigned to Jarin	Dhanmondi	admin	1
1014	2024-09-18 07:07:35.867	2024-09-18 07:07:35.867	\N	3	Lead 227 assigned to Jarin	Dhanmondi	admin	1
1015	2024-09-18 07:07:35.869957	2024-09-18 07:07:35.869957	\N	4	remark : Lead 229 updated by Naf	Dhanmondi	admin	1
1016	2024-09-18 07:07:35.872725	2024-09-18 07:07:35.872725	\N	4	remark : Lead 227 updated by Naf	Dhanmondi	admin	1
1017	2024-09-18 07:07:35.874701	2024-09-18 07:07:35.874701	\N	4	remark : Lead 224 updated by Naf	Dhanmondi	admin	1
1018	2024-09-18 07:07:35.929392	2024-09-18 07:07:35.929392	\N	3	Lead 223 assigned to Jarin	Dhanmondi	admin	1
1019	2024-09-18 07:07:35.931872	2024-09-18 07:07:35.931872	\N	4	remark : Lead 223 updated by Naf	Dhanmondi	admin	1
1020	2024-09-18 07:07:35.987863	2024-09-18 07:07:35.987863	\N	3	Lead 221 assigned to Jarin	Dhanmondi	admin	1
1021	2024-09-18 07:07:35.991882	2024-09-18 07:07:35.991882	\N	3	Lead 222 assigned to Jarin	Dhanmondi	admin	1
1022	2024-09-18 07:07:36.001888	2024-09-18 07:07:36.001888	\N	4	remark : Lead 221 updated by Naf	Dhanmondi	admin	1
1023	2024-09-18 07:07:36.00677	2024-09-18 07:07:36.00677	\N	3	Lead 220 assigned to Jarin	Dhanmondi	admin	1
1024	2024-09-18 07:07:36.009482	2024-09-18 07:07:36.009482	\N	4	remark : Lead 222 updated by Naf	Dhanmondi	admin	1
1025	2024-09-18 07:07:36.016046	2024-09-18 07:07:36.016046	\N	4	remark : Lead 220 updated by Naf	Dhanmondi	admin	1
1026	2024-09-18 07:07:51.670587	2024-09-18 07:07:51.670587	\N	3	Lead 216 assigned to Jarin	Dhanmondi	admin	1
1027	2024-09-18 07:07:51.689961	2024-09-18 07:07:51.689961	\N	3	Lead 215 assigned to Jarin	Dhanmondi	admin	1
1028	2024-09-18 07:07:51.695982	2024-09-18 07:07:51.695982	\N	4	remark : Lead 215 updated by Naf	Dhanmondi	admin	1
1029	2024-09-18 07:07:51.722724	2024-09-18 07:07:51.722724	\N	4	remark : Lead 216 updated by Naf	Dhanmondi	admin	1
1030	2024-09-18 07:07:51.723655	2024-09-18 07:07:51.723655	\N	3	Lead 217 assigned to Jarin	Dhanmondi	admin	1
1031	2024-09-18 07:07:51.723787	2024-09-18 07:07:51.723787	\N	3	Lead 214 assigned to Jarin	Dhanmondi	admin	1
1032	2024-09-18 07:07:51.73246	2024-09-18 07:07:51.73246	\N	3	Lead 219 assigned to Jarin	Dhanmondi	admin	1
1033	2024-09-18 07:07:51.734806	2024-09-18 07:07:51.734806	\N	3	Lead 218 assigned to Jarin	Dhanmondi	admin	1
1034	2024-09-18 07:07:51.735705	2024-09-18 07:07:51.735705	\N	4	remark : Lead 217 updated by Naf	Dhanmondi	admin	1
1035	2024-09-18 07:07:51.740727	2024-09-18 07:07:51.740727	\N	4	remark : Lead 219 updated by Naf	Dhanmondi	admin	1
1036	2024-09-18 07:07:51.746715	2024-09-18 07:07:51.746715	\N	4	remark : Lead 218 updated by Naf	Dhanmondi	admin	1
1037	2024-09-18 07:07:51.760444	2024-09-18 07:07:51.760444	\N	4	remark : Lead 214 updated by Naf	Dhanmondi	admin	1
1038	2024-09-18 07:07:51.816269	2024-09-18 07:07:51.816269	\N	3	Lead 213 assigned to Jarin	Dhanmondi	admin	1
1039	2024-09-18 07:07:51.819024	2024-09-18 07:07:51.819024	\N	4	remark : Lead 213 updated by Naf	Dhanmondi	admin	1
1040	2024-09-18 07:07:51.842992	2024-09-18 07:07:51.842992	\N	3	Lead 212 assigned to Jarin	Dhanmondi	admin	1
1041	2024-09-18 07:07:51.847168	2024-09-18 07:07:51.847168	\N	4	remark : Lead 212 updated by Naf	Dhanmondi	admin	1
1042	2024-09-18 07:07:51.867589	2024-09-18 07:07:51.867589	\N	3	Lead 210 assigned to Jarin	Dhanmondi	admin	1
1043	2024-09-18 07:07:51.870517	2024-09-18 07:07:51.870517	\N	3	Lead 211 assigned to Jarin	Dhanmondi	admin	1
1044	2024-09-18 07:07:51.871959	2024-09-18 07:07:51.871959	\N	4	remark : Lead 210 updated by Naf	Dhanmondi	admin	1
1045	2024-09-18 07:07:51.877147	2024-09-18 07:07:51.877147	\N	4	remark : Lead 211 updated by Naf	Dhanmondi	admin	1
1046	2024-09-18 07:08:05.914872	2024-09-18 07:08:05.914872	\N	3	Lead 205 assigned to Farzana	Dhanmondi	admin	1
1047	2024-09-18 07:08:05.9181	2024-09-18 07:08:05.9181	\N	3	Lead 208 assigned to Farzana	Dhanmondi	admin	1
1048	2024-09-18 07:08:05.985088	2024-09-18 07:08:05.985088	\N	3	Lead 206 assigned to Farzana	Dhanmondi	admin	1
1049	2024-09-18 07:08:05.985148	2024-09-18 07:08:05.985148	\N	3	Lead 204 assigned to Farzana	Dhanmondi	admin	1
1050	2024-09-18 07:08:05.985684	2024-09-18 07:08:05.985684	\N	3	Lead 209 assigned to Farzana	Dhanmondi	admin	1
1053	2024-09-18 07:08:05.99959	2024-09-18 07:08:05.99959	\N	4	remark : Lead 204 updated by Naf	Dhanmondi	admin	1
1453	2024-09-21 16:21:10.078432	2024-09-21 16:21:10.078432	\N	1	Logged in	Dhanmondi	admin	1
1494	2024-09-21 18:33:56.245412	2024-09-21 18:33:56.245412	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1529	2024-09-22 05:12:58.206507	2024-09-22 05:12:58.206507	\N	4	remark : Wrong umber	Dhanmondi	counsellor	13
1530	2024-09-22 05:12:58.220904	2024-09-22 05:12:58.220904	\N	5	Status changed from new to unreachable of lead 300 by Jarin	Dhanmondi	counsellor	13
1576	2024-09-22 05:48:30.135686	2024-09-22 05:48:30.135686	\N	4	remark : NO Answer	Dhanmondi	counsellor	13
1577	2024-09-22 05:48:30.150618	2024-09-22 05:48:30.150618	\N	5	Status changed from new to unreachable of lead 225 by Jarin	Dhanmondi	counsellor	13
1613	2024-09-22 06:15:09.14055	2024-09-22 06:15:09.14055	\N	3	Lead 307 assigned to Jarin	Dhanmondi	admin	1
1658	2024-09-22 07:02:51.423446	2024-09-22 07:02:51.423446	\N	4	remark : No answer	Dhanmondi	counsellor	13
1659	2024-09-22 07:02:51.437454	2024-09-22 07:02:51.437454	\N	5	Status changed from new to not-interested of lead 307 by Jarin	Dhanmondi	counsellor	13
1690	2024-09-24 13:18:10.292095	2024-09-24 13:18:10.292095	\N	4	remark : Lead 300 updated by Naf	Dhanmondi	admin	1
1691	2024-09-24 13:18:10.297106	2024-09-24 13:18:10.297106	\N	5	Status changed from course-new to new of lead 300 by Naf	Dhanmondi	admin	1
1723	2024-09-26 15:16:46.546336	2024-09-26 15:16:46.546336	\N	1	Logged in	Dhanmondi	admin	1
1749	2024-10-07 04:20:51.275837	2024-10-07 04:20:51.275837	\N	1	Logged in	Dhanmondi	admin	1
1775	2024-10-19 06:44:32.261588	2024-10-19 06:44:32.261588	\N	1	Logged in	Dhanmondi	admin	1
1786	2024-11-24 06:08:38.765967	2024-11-24 06:08:38.765967	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1787	2024-11-24 06:08:38.790309	2024-11-24 06:08:38.790309	\N	5	Status changed from waiting-for-document to course-new of lead 337 by Farzana	Dhanmondi	counsellor	14
1817	2024-11-24 13:09:48.364735	2024-11-24 13:09:48.364735	\N	2	Lead created	Dhanmondi	admin	1
1828	2024-11-24 13:09:48.378308	2024-11-24 13:09:48.378308	\N	2	Lead created	Dhanmondi	admin	1
1835	2024-11-24 13:09:48.388449	2024-11-24 13:09:48.388449	\N	2	Lead created	Dhanmondi	admin	1
1846	2024-11-24 13:09:48.423781	2024-11-24 13:09:48.423781	\N	2	Lead created	Dhanmondi	admin	1
1862	2024-11-24 13:09:48.444355	2024-11-24 13:09:48.444355	\N	2	Lead created	Dhanmondi	admin	1
1878	2024-11-24 13:09:48.45178	2024-11-24 13:09:48.45178	\N	2	Lead created	Dhanmondi	admin	1
1893	2024-11-24 13:09:48.460396	2024-11-24 13:09:48.460396	\N	2	Lead created	Dhanmondi	admin	1
1908	2024-11-24 13:09:48.471816	2024-11-24 13:09:48.471816	\N	2	Lead created	Dhanmondi	admin	1
1923	2024-11-24 13:09:48.484533	2024-11-24 13:09:48.484533	\N	2	Lead created	Dhanmondi	admin	1
1932	2024-11-24 13:09:48.489674	2024-11-24 13:09:48.489674	\N	2	Lead created	Dhanmondi	admin	1
1940	2024-11-24 13:09:48.494623	2024-11-24 13:09:48.494623	\N	2	Lead created	Dhanmondi	admin	1
1952	2024-11-24 13:09:48.50495	2024-11-24 13:09:48.50495	\N	2	Lead created	Dhanmondi	admin	1
1969	2024-11-24 13:09:48.51795	2024-11-24 13:09:48.51795	\N	2	Lead created	Dhanmondi	admin	1
1980	2024-11-24 13:09:48.529127	2024-11-24 13:09:48.529127	\N	2	Lead created	Dhanmondi	admin	1
1994	2024-11-24 13:09:48.543059	2024-11-24 13:09:48.543059	\N	2	Lead created	Dhanmondi	admin	1
2010	2024-11-24 13:09:48.556771	2024-11-24 13:09:48.556771	\N	2	Lead created	Dhanmondi	admin	1
2026	2024-11-24 13:09:48.570142	2024-11-24 13:09:48.570142	\N	2	Lead created	Dhanmondi	admin	1
1051	2024-09-18 07:08:05.99625	2024-09-18 07:08:05.99625	\N	4	remark : Lead 206 updated by Naf	Dhanmondi	admin	1
1454	2024-09-21 17:23:36.542153	2024-09-21 17:23:36.542153	\N	4	remark : Lead 209 updated by Jarin	Dhanmondi	counsellor	13
1495	2024-09-21 18:35:05.735038	2024-09-21 18:35:05.735038	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1531	2024-09-22 05:13:37.622034	2024-09-22 05:13:37.622034	\N	4	remark : Wrong number	Dhanmondi	counsellor	13
1532	2024-09-22 05:13:37.634584	2024-09-22 05:13:37.634584	\N	5	Status changed from new to unreachable of lead 299 by Jarin	Dhanmondi	counsellor	13
1578	2024-09-22 05:49:21.621982	2024-09-22 05:49:21.621982	\N	4	remark : Lead 218 updated by Jarin	Dhanmondi	counsellor	13
1620	2024-09-22 06:15:09.279189	2024-09-22 06:15:09.279189	\N	3	Lead 306 assigned to Jarin	Dhanmondi	admin	1
1660	2024-09-22 07:05:14.839394	2024-09-22 07:05:14.839394	\N	4	remark : No answer	Dhanmondi	counsellor	13
1661	2024-09-22 07:05:14.853641	2024-09-22 07:05:14.853641	\N	5	Status changed from new to unreachable of lead 306 by Jarin	Dhanmondi	counsellor	13
1692	2024-09-24 13:18:35.303559	2024-09-24 13:18:35.303559	\N	4	remark : interested	Dhanmondi	admin	1
1693	2024-09-24 13:18:35.318203	2024-09-24 13:18:35.318203	\N	5	Status changed from new to appointment-book of lead 300 by Naf	Dhanmondi	admin	1
1724	2024-09-26 15:20:59.964545	2024-09-26 15:20:59.964545	\N	1	Logged in	Dhanmondi	counsellor	14
1750	2024-10-07 06:04:37.476996	2024-10-07 06:04:37.476996	\N	1	Logged in	Dhanmondi	admin	1
1776	2024-10-19 08:42:04.641538	2024-10-19 08:42:04.641538	\N	1	Logged in	Dhanmondi	counsellor	13
1788	2024-11-24 06:08:44.509399	2024-11-24 06:08:44.509399	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1789	2024-11-24 06:08:44.516577	2024-11-24 06:08:44.516577	\N	5	Status changed from course-new to new of lead 337 by Farzana	Dhanmondi	counsellor	14
1818	2024-11-24 13:09:48.366987	2024-11-24 13:09:48.366987	\N	2	Lead created	Dhanmondi	admin	1
1837	2024-11-24 13:09:48.389954	2024-11-24 13:09:48.389954	\N	2	Lead created	Dhanmondi	admin	1
1853	2024-11-24 13:09:48.435069	2024-11-24 13:09:48.435069	\N	2	Lead created	Dhanmondi	admin	1
1868	2024-11-24 13:09:48.445725	2024-11-24 13:09:48.445725	\N	2	Lead created	Dhanmondi	admin	1
1874	2024-11-24 13:09:48.451265	2024-11-24 13:09:48.451265	\N	2	Lead created	Dhanmondi	admin	1
1882	2024-11-24 13:09:48.45543	2024-11-24 13:09:48.45543	\N	2	Lead created	Dhanmondi	admin	1
1891	2024-11-24 13:09:48.459167	2024-11-24 13:09:48.459167	\N	2	Lead created	Dhanmondi	admin	1
1906	2024-11-24 13:09:48.469973	2024-11-24 13:09:48.469973	\N	2	Lead created	Dhanmondi	admin	1
1920	2024-11-24 13:09:48.482561	2024-11-24 13:09:48.482561	\N	2	Lead created	Dhanmondi	admin	1
1937	2024-11-24 13:09:48.491968	2024-11-24 13:09:48.491968	\N	2	Lead created	Dhanmondi	admin	1
1950	2024-11-24 13:09:48.502124	2024-11-24 13:09:48.502124	\N	2	Lead created	Dhanmondi	admin	1
1967	2024-11-24 13:09:48.515624	2024-11-24 13:09:48.515624	\N	2	Lead created	Dhanmondi	admin	1
1983	2024-11-24 13:09:48.530088	2024-11-24 13:09:48.530088	\N	2	Lead created	Dhanmondi	admin	1
2000	2024-11-24 13:09:48.549685	2024-11-24 13:09:48.549685	\N	2	Lead created	Dhanmondi	admin	1
2013	2024-11-24 13:09:48.558411	2024-11-24 13:09:48.558411	\N	2	Lead created	Dhanmondi	admin	1
2021	2024-11-24 13:09:48.568101	2024-11-24 13:09:48.568101	\N	2	Lead created	Dhanmondi	admin	1
1052	2024-09-18 07:08:05.996856	2024-09-18 07:08:05.996856	\N	4	remark : Lead 208 updated by Naf	Dhanmondi	admin	1
1054	2024-09-18 07:08:06.01062	2024-09-18 07:08:06.01062	\N	3	Lead 207 assigned to Farzana	Dhanmondi	admin	1
1055	2024-09-18 07:08:06.018022	2024-09-18 07:08:06.018022	\N	4	remark : Lead 207 updated by Naf	Dhanmondi	admin	1
1056	2024-09-18 07:08:06.024646	2024-09-18 07:08:06.024646	\N	4	remark : Lead 205 updated by Naf	Dhanmondi	admin	1
1057	2024-09-18 07:08:06.031004	2024-09-18 07:08:06.031004	\N	4	remark : Lead 209 updated by Naf	Dhanmondi	admin	1
1058	2024-09-18 07:08:06.130035	2024-09-18 07:08:06.130035	\N	3	Lead 201 assigned to Farzana	Dhanmondi	admin	1
1059	2024-09-18 07:08:06.137141	2024-09-18 07:08:06.137141	\N	3	Lead 203 assigned to Farzana	Dhanmondi	admin	1
1062	2024-09-18 07:08:06.143468	2024-09-18 07:08:06.143468	\N	3	Lead 202 assigned to Farzana	Dhanmondi	admin	1
1063	2024-09-18 07:08:06.146647	2024-09-18 07:08:06.146647	\N	4	remark : Lead 200 updated by Naf	Dhanmondi	admin	1
1065	2024-09-18 07:08:06.151413	2024-09-18 07:08:06.151413	\N	4	remark : Lead 202 updated by Naf	Dhanmondi	admin	1
1066	2024-09-18 07:08:19.29916	2024-09-18 07:08:19.29916	\N	3	Lead 194 assigned to Jarin	Dhanmondi	admin	1
1070	2024-09-18 07:08:19.331219	2024-09-18 07:08:19.331219	\N	4	remark : Lead 197 updated by Naf	Dhanmondi	admin	1
1072	2024-09-18 07:08:19.337623	2024-09-18 07:08:19.337623	\N	4	remark : Lead 194 updated by Naf	Dhanmondi	admin	1
1455	2024-09-21 17:24:31.485013	2024-09-21 17:24:31.485013	\N	4	remark : wrong Number 	Dhanmondi	counsellor	13
1456	2024-09-21 17:24:31.49829	2024-09-21 17:24:31.49829	\N	5	Status changed from new to unreachable of lead 209 by Jarin	Dhanmondi	counsellor	13
1496	2024-09-21 18:35:10.365606	2024-09-21 18:35:10.365606	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1533	2024-09-22 05:17:40.02751	2024-09-22 05:17:40.02751	\N	4	remark : wrong number	Dhanmondi	counsellor	13
1534	2024-09-22 05:17:40.042854	2024-09-22 05:17:40.042854	\N	5	Status changed from new to unreachable of lead 298 by Jarin	Dhanmondi	counsellor	13
1579	2024-09-22 05:49:35.130209	2024-09-22 05:49:35.130209	\N	4	remark : Busy	Dhanmondi	counsellor	13
1580	2024-09-22 05:49:35.14692	2024-09-22 05:49:35.14692	\N	5	Status changed from new to unreachable of lead 224 by Jarin	Dhanmondi	counsellor	13
1581	2024-09-22 05:49:55.285437	2024-09-22 05:49:55.285437	\N	4	remark : Number missing	Dhanmondi	counsellor	13
1582	2024-09-22 05:49:55.297249	2024-09-22 05:49:55.297249	\N	5	Status changed from new to unreachable of lead 218 by Jarin	Dhanmondi	counsellor	13
1583	2024-09-22 05:50:02.967174	2024-09-22 05:50:02.967174	\N	4	remark : Lead 218 updated by Jarin	Dhanmondi	counsellor	13
1621	2024-09-22 06:15:09.282564	2024-09-22 06:15:09.282564	\N	4	remark : Lead 306 updated by Naf	Dhanmondi	admin	1
1662	2024-09-22 07:09:28.575671	2024-09-22 07:09:28.575671	\N	4	remark : No answer	Dhanmondi	counsellor	13
1663	2024-09-22 07:09:28.591357	2024-09-22 07:09:28.591357	\N	5	Status changed from new to unreachable of lead 305 by Jarin	Dhanmondi	counsellor	13
1694	2024-09-24 14:24:16.939308	2024-09-24 14:24:16.939308	\N	1	Logged in	Dhanmondi	admin	1
1725	2024-09-26 15:29:52.803764	2024-09-26 15:29:52.803764	\N	3	Lead 345 assigned to Naf	Dhanmondi	counsellor	14
1790	2024-11-24 06:09:04.277816	2024-11-24 06:09:04.277816	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1820	2024-11-24 13:09:48.36913	2024-11-24 13:09:48.36913	\N	2	Lead created	Dhanmondi	admin	1
1824	2024-11-24 13:09:48.37627	2024-11-24 13:09:48.37627	\N	2	Lead created	Dhanmondi	admin	1
1832	2024-11-24 13:09:48.38311	2024-11-24 13:09:48.38311	\N	2	Lead created	Dhanmondi	admin	1
1838	2024-11-24 13:09:48.400399	2024-11-24 13:09:48.400399	\N	2	Lead created	Dhanmondi	admin	1
1847	2024-11-24 13:09:48.424496	2024-11-24 13:09:48.424496	\N	2	Lead created	Dhanmondi	admin	1
1855	2024-11-24 13:09:48.438486	2024-11-24 13:09:48.438486	\N	2	Lead created	Dhanmondi	admin	1
1863	2024-11-24 13:09:48.444596	2024-11-24 13:09:48.444596	\N	2	Lead created	Dhanmondi	admin	1
1871	2024-11-24 13:09:48.449073	2024-11-24 13:09:48.449073	\N	2	Lead created	Dhanmondi	admin	1
1879	2024-11-24 13:09:48.453238	2024-11-24 13:09:48.453238	\N	2	Lead created	Dhanmondi	admin	1
1886	2024-11-24 13:09:48.457122	2024-11-24 13:09:48.457122	\N	2	Lead created	Dhanmondi	admin	1
1894	2024-11-24 13:09:48.461928	2024-11-24 13:09:48.461928	\N	2	Lead created	Dhanmondi	admin	1
1902	2024-11-24 13:09:48.467903	2024-11-24 13:09:48.467903	\N	2	Lead created	Dhanmondi	admin	1
1909	2024-11-24 13:09:48.47438	2024-11-24 13:09:48.47438	\N	2	Lead created	Dhanmondi	admin	1
1917	2024-11-24 13:09:48.480217	2024-11-24 13:09:48.480217	\N	2	Lead created	Dhanmondi	admin	1
1924	2024-11-24 13:09:48.486077	2024-11-24 13:09:48.486077	\N	2	Lead created	Dhanmondi	admin	1
1933	2024-11-24 13:09:48.490618	2024-11-24 13:09:48.490618	\N	2	Lead created	Dhanmondi	admin	1
1941	2024-11-24 13:09:48.49563	2024-11-24 13:09:48.49563	\N	2	Lead created	Dhanmondi	admin	1
1948	2024-11-24 13:09:48.502514	2024-11-24 13:09:48.502514	\N	2	Lead created	Dhanmondi	admin	1
1956	2024-11-24 13:09:48.507802	2024-11-24 13:09:48.507802	\N	2	Lead created	Dhanmondi	admin	1
1964	2024-11-24 13:09:48.515724	2024-11-24 13:09:48.515724	\N	2	Lead created	Dhanmondi	admin	1
1972	2024-11-24 13:09:48.522107	2024-11-24 13:09:48.522107	\N	2	Lead created	Dhanmondi	admin	1
1981	2024-11-24 13:09:48.530314	2024-11-24 13:09:48.530314	\N	2	Lead created	Dhanmondi	admin	1
1989	2024-11-24 13:09:48.539645	2024-11-24 13:09:48.539645	\N	2	Lead created	Dhanmondi	admin	1
1997	2024-11-24 13:09:48.549801	2024-11-24 13:09:48.549801	\N	2	Lead created	Dhanmondi	admin	1
2005	2024-11-24 13:09:48.555411	2024-11-24 13:09:48.555411	\N	2	Lead created	Dhanmondi	admin	1
2014	2024-11-24 13:09:48.560175	2024-11-24 13:09:48.560175	\N	2	Lead created	Dhanmondi	admin	1
2022	2024-11-24 13:09:48.56886	2024-11-24 13:09:48.56886	\N	2	Lead created	Dhanmondi	admin	1
2029	2024-11-24 13:09:48.573678	2024-11-24 13:09:48.573678	\N	2	Lead created	Dhanmondi	admin	1
1060	2024-09-18 07:08:06.138315	2024-09-18 07:08:06.138315	\N	3	Lead 200 assigned to Farzana	Dhanmondi	admin	1
1064	2024-09-18 07:08:06.144886	2024-09-18 07:08:06.144886	\N	4	remark : Lead 203 updated by Naf	Dhanmondi	admin	1
1457	2024-09-21 17:24:57.74091	2024-09-21 17:24:57.74091	\N	4	remark : Lead 209 updated by Jarin	Dhanmondi	counsellor	13
1497	2024-09-21 18:36:12.835319	2024-09-21 18:36:12.835319	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1535	2024-09-22 05:21:19.01661	2024-09-22 05:21:19.01661	\N	4	remark : Need Fllowup	Dhanmondi	counsellor	13
1536	2024-09-22 05:21:19.035366	2024-09-22 05:21:19.035366	\N	5	Status changed from new to future-interest of lead 297 by Jarin	Dhanmondi	counsellor	13
1584	2024-09-22 05:50:22.177344	2024-09-22 05:50:22.177344	\N	4	remark : NO Answer	Dhanmondi	counsellor	13
1585	2024-09-22 05:50:22.19054	2024-09-22 05:50:22.19054	\N	5	Status changed from new to unreachable of lead 223 by Jarin	Dhanmondi	counsellor	13
1623	2024-09-22 06:15:09.289813	2024-09-22 06:15:09.289813	\N	4	remark : Lead 305 updated by Naf	Dhanmondi	admin	1
1624	2024-09-22 06:15:09.320825	2024-09-22 06:15:09.320825	\N	3	Lead 304 assigned to Jarin	Dhanmondi	admin	1
1625	2024-09-22 06:15:09.325938	2024-09-22 06:15:09.325938	\N	4	remark : Lead 304 updated by Naf	Dhanmondi	admin	1
1664	2024-09-22 07:09:54.304006	2024-09-22 07:09:54.304006	\N	4	remark : Busy	Dhanmondi	counsellor	13
1665	2024-09-22 07:09:54.318954	2024-09-22 07:09:54.318954	\N	5	Status changed from new to unreachable of lead 304 by Jarin	Dhanmondi	counsellor	13
1695	2024-09-25 04:37:29.002095	2024-09-25 04:37:29.002095	\N	1	Logged in	Dhanmondi	admin	1
1726	2024-09-26 15:29:52.986081	2024-09-26 15:29:52.986081	\N	4	remark : already all documents have been send to the application team	Dhanmondi	counsellor	14
1727	2024-09-26 15:29:53.000096	2024-09-26 15:29:53.000096	\N	5	Status changed from waiting-for-document to start-application of lead 345 by Farzana	Dhanmondi	counsellor	14
1791	2024-11-24 06:11:40.753847	2024-11-24 06:11:40.753847	\N	4	remark : she did not pick my calls	Dhanmondi	counsellor	14
1792	2024-11-24 06:11:40.769733	2024-11-24 06:11:40.769733	\N	5	Status changed from new to unreachable of lead 337 by Farzana	Dhanmondi	counsellor	14
1793	2024-11-24 06:11:44.104812	2024-11-24 06:11:44.104812	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1794	2024-11-24 06:11:46.577908	2024-11-24 06:11:46.577908	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1822	2024-11-24 13:09:48.373664	2024-11-24 13:09:48.373664	\N	2	Lead created	Dhanmondi	admin	1
1834	2024-11-24 13:09:48.385494	2024-11-24 13:09:48.385494	\N	2	Lead created	Dhanmondi	admin	1
1840	2024-11-24 13:09:48.404494	2024-11-24 13:09:48.404494	\N	2	Lead created	Dhanmondi	admin	1
1849	2024-11-24 13:09:48.425593	2024-11-24 13:09:48.425593	\N	2	Lead created	Dhanmondi	admin	1
1857	2024-11-24 13:09:48.439464	2024-11-24 13:09:48.439464	\N	2	Lead created	Dhanmondi	admin	1
1865	2024-11-24 13:09:48.445139	2024-11-24 13:09:48.445139	\N	2	Lead created	Dhanmondi	admin	1
1881	2024-11-24 13:09:48.453152	2024-11-24 13:09:48.453152	\N	2	Lead created	Dhanmondi	admin	1
1896	2024-11-24 13:09:48.461312	2024-11-24 13:09:48.461312	\N	2	Lead created	Dhanmondi	admin	1
1905	2024-11-24 13:09:48.471649	2024-11-24 13:09:48.471649	\N	2	Lead created	Dhanmondi	admin	1
1914	2024-11-24 13:09:48.479091	2024-11-24 13:09:48.479091	\N	2	Lead created	Dhanmondi	admin	1
1922	2024-11-24 13:09:48.485628	2024-11-24 13:09:48.485628	\N	2	Lead created	Dhanmondi	admin	1
1931	2024-11-24 13:09:48.489668	2024-11-24 13:09:48.489668	\N	2	Lead created	Dhanmondi	admin	1
1939	2024-11-24 13:09:48.49453	2024-11-24 13:09:48.49453	\N	2	Lead created	Dhanmondi	admin	1
1947	2024-11-24 13:09:48.501397	2024-11-24 13:09:48.501397	\N	2	Lead created	Dhanmondi	admin	1
1954	2024-11-24 13:09:48.506824	2024-11-24 13:09:48.506824	\N	2	Lead created	Dhanmondi	admin	1
1962	2024-11-24 13:09:48.514389	2024-11-24 13:09:48.514389	\N	2	Lead created	Dhanmondi	admin	1
1971	2024-11-24 13:09:48.520432	2024-11-24 13:09:48.520432	\N	2	Lead created	Dhanmondi	admin	1
1979	2024-11-24 13:09:48.528187	2024-11-24 13:09:48.528187	\N	2	Lead created	Dhanmondi	admin	1
1987	2024-11-24 13:09:48.537736	2024-11-24 13:09:48.537736	\N	2	Lead created	Dhanmondi	admin	1
1996	2024-11-24 13:09:48.548108	2024-11-24 13:09:48.548108	\N	2	Lead created	Dhanmondi	admin	1
2004	2024-11-24 13:09:48.554322	2024-11-24 13:09:48.554322	\N	2	Lead created	Dhanmondi	admin	1
2012	2024-11-24 13:09:48.559237	2024-11-24 13:09:48.559237	\N	2	Lead created	Dhanmondi	admin	1
2020	2024-11-24 13:09:48.567596	2024-11-24 13:09:48.567596	\N	2	Lead created	Dhanmondi	admin	1
2028	2024-11-24 13:09:48.572493	2024-11-24 13:09:48.572493	\N	2	Lead created	Dhanmondi	admin	1
1061	2024-09-18 07:08:06.138051	2024-09-18 07:08:06.138051	\N	4	remark : Lead 201 updated by Naf	Dhanmondi	admin	1
1067	2024-09-18 07:08:19.299559	2024-09-18 07:08:19.299559	\N	3	Lead 197 assigned to Jarin	Dhanmondi	admin	1
1068	2024-09-18 07:08:19.328262	2024-09-18 07:08:19.328262	\N	3	Lead 196 assigned to Jarin	Dhanmondi	admin	1
1069	2024-09-18 07:08:19.332174	2024-09-18 07:08:19.332174	\N	3	Lead 198 assigned to Jarin	Dhanmondi	admin	1
1071	2024-09-18 07:08:19.336927	2024-09-18 07:08:19.336927	\N	3	Lead 195 assigned to Jarin	Dhanmondi	admin	1
1073	2024-09-18 07:08:19.337899	2024-09-18 07:08:19.337899	\N	3	Lead 199 assigned to Jarin	Dhanmondi	admin	1
1074	2024-09-18 07:08:19.348815	2024-09-18 07:08:19.348815	\N	4	remark : Lead 195 updated by Naf	Dhanmondi	admin	1
1075	2024-09-18 07:08:19.360266	2024-09-18 07:08:19.360266	\N	4	remark : Lead 199 updated by Naf	Dhanmondi	admin	1
1076	2024-09-18 07:08:19.375161	2024-09-18 07:08:19.375161	\N	4	remark : Lead 196 updated by Naf	Dhanmondi	admin	1
1077	2024-09-18 07:08:19.380194	2024-09-18 07:08:19.380194	\N	4	remark : Lead 198 updated by Naf	Dhanmondi	admin	1
1078	2024-09-18 07:08:19.460159	2024-09-18 07:08:19.460159	\N	3	Lead 193 assigned to Jarin	Dhanmondi	admin	1
1079	2024-09-18 07:08:19.470208	2024-09-18 07:08:19.470208	\N	4	remark : Lead 193 updated by Naf	Dhanmondi	admin	1
1080	2024-09-18 07:08:19.493569	2024-09-18 07:08:19.493569	\N	3	Lead 192 assigned to Jarin	Dhanmondi	admin	1
1081	2024-09-18 07:08:19.497639	2024-09-18 07:08:19.497639	\N	3	Lead 190 assigned to Jarin	Dhanmondi	admin	1
1082	2024-09-18 07:08:19.508713	2024-09-18 07:08:19.508713	\N	4	remark : Lead 192 updated by Naf	Dhanmondi	admin	1
1084	2024-09-18 07:08:19.509708	2024-09-18 07:08:19.509708	\N	4	remark : Lead 190 updated by Naf	Dhanmondi	admin	1
1083	2024-09-18 07:08:19.509283	2024-09-18 07:08:19.509283	\N	3	Lead 191 assigned to Jarin	Dhanmondi	admin	1
1085	2024-09-18 07:08:19.513312	2024-09-18 07:08:19.513312	\N	4	remark : Lead 191 updated by Naf	Dhanmondi	admin	1
1086	2024-09-18 07:08:34.142237	2024-09-18 07:08:34.142237	\N	3	Lead 189 assigned to Farzana	Dhanmondi	admin	1
1087	2024-09-18 07:08:34.145669	2024-09-18 07:08:34.145669	\N	4	remark : Lead 189 updated by Naf	Dhanmondi	admin	1
1088	2024-09-18 07:08:54.134244	2024-09-18 07:08:54.134244	\N	1	Logged in	Dhanmondi	counsellor	14
1089	2024-09-18 07:51:04.158076	2024-09-18 07:51:04.158076	\N	4	remark : phone off	Dhanmondi	counsellor	14
1090	2024-09-18 07:51:04.17622	2024-09-18 07:51:04.17622	\N	5	Status changed from new to unreachable of lead 340 by Farzana	Dhanmondi	counsellor	14
1091	2024-09-18 08:22:52.772833	2024-09-18 08:22:52.772833	\N	1	Logged in	Dhanmondi	admin	1
1092	2024-09-18 14:20:23.834873	2024-09-18 14:20:23.834873	\N	4	remark : Lead 341 updated by Naf	Dhanmondi	admin	1
1093	2024-09-20 11:54:42.839989	2024-09-20 11:54:42.839989	\N	1	Logged in	Dhanmondi	admin	1
1094	2024-09-20 16:24:18.705327	2024-09-20 16:24:18.705327	\N	1	Logged in	Dhanmondi	admin	1
1095	2024-09-21 06:33:43.172612	2024-09-21 06:33:43.172612	\N	1	Logged in	Dhanmondi	counsellor	14
1096	2024-09-21 06:36:53.204018	2024-09-21 06:36:53.204018	\N	4	remark : Lead 340 updated by Farzana	Dhanmondi	counsellor	14
1097	2024-09-21 06:38:15.58916	2024-09-21 06:38:15.58916	\N	4	remark : phone was switch off	Dhanmondi	counsellor	14
1098	2024-09-21 06:38:15.605733	2024-09-21 06:38:15.605733	\N	5	Status changed from new to unreachable of lead 338 by Farzana	Dhanmondi	counsellor	14
1099	2024-09-21 06:42:09.447782	2024-09-21 06:42:09.447782	\N	4	remark : mistake	Dhanmondi	counsellor	14
1100	2024-09-21 06:42:09.464005	2024-09-21 06:42:09.464005	\N	5	Status changed from new to not-interested of lead 337 by Farzana	Dhanmondi	counsellor	14
1101	2024-09-21 06:42:09.79617	2024-09-21 06:42:09.79617	\N	4	remark : mistake	Dhanmondi	counsellor	14
1102	2024-09-21 06:42:11.08843	2024-09-21 06:42:11.08843	\N	4	remark : mistake	Dhanmondi	counsellor	14
1103	2024-09-21 06:52:12.942174	2024-09-21 06:52:12.942174	\N	4	remark : he will come to our office	Dhanmondi	counsellor	14
1104	2024-09-21 06:52:13.116257	2024-09-21 06:52:13.116257	\N	5	Status changed from new to appointment-book of lead 317 by Farzana	Dhanmondi	counsellor	14
1105	2024-09-21 06:55:22.876116	2024-09-21 06:55:22.876116	\N	4	remark : non sense	Dhanmondi	counsellor	14
1106	2024-09-21 06:55:22.891689	2024-09-21 06:55:22.891689	\N	5	Status changed from new to not-interested of lead 314 by Farzana	Dhanmondi	counsellor	14
1107	2024-09-21 06:58:15.507871	2024-09-21 06:58:15.507871	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1108	2024-09-21 07:04:02.442758	2024-09-21 07:04:02.442758	\N	4	remark : number is not valid	Dhanmondi	counsellor	14
1109	2024-09-21 07:04:02.464197	2024-09-21 07:04:02.464197	\N	5	Status changed from new to unreachable of lead 336 by Farzana	Dhanmondi	counsellor	14
1110	2024-09-21 07:07:31.572117	2024-09-21 07:07:31.572117	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1111	2024-09-21 07:07:31.589458	2024-09-21 07:07:31.589458	\N	5	Status changed from new to unreachable of lead 335 by Farzana	Dhanmondi	counsellor	14
1112	2024-09-21 07:07:33.091074	2024-09-21 07:07:33.091074	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1113	2024-09-21 07:07:34.238701	2024-09-21 07:07:34.238701	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1114	2024-09-21 07:07:37.322613	2024-09-21 07:07:37.322613	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1115	2024-09-21 07:07:37.642273	2024-09-21 07:07:37.642273	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1116	2024-09-21 07:07:37.656904	2024-09-21 07:07:37.656904	\N	4	remark : 5th times i called him	Dhanmondi	counsellor	14
1117	2024-09-21 07:08:51.800276	2024-09-21 07:08:51.800276	\N	4	remark : work visa	Dhanmondi	counsellor	14
1118	2024-09-21 07:08:51.813393	2024-09-21 07:08:51.813393	\N	5	Status changed from new to not-interested of lead 334 by Farzana	Dhanmondi	counsellor	14
1119	2024-09-21 07:09:21.718513	2024-09-21 07:09:21.718513	\N	4	remark : nonsense	Dhanmondi	counsellor	14
1120	2024-09-21 07:09:21.734074	2024-09-21 07:09:21.734074	\N	5	Status changed from new to not-interested of lead 332 by Farzana	Dhanmondi	counsellor	14
1121	2024-09-21 07:11:37.156839	2024-09-21 07:11:37.156839	\N	4	remark : phone off	Dhanmondi	counsellor	14
1122	2024-09-21 07:11:37.170785	2024-09-21 07:11:37.170785	\N	5	Status changed from new to unreachable of lead 331 by Farzana	Dhanmondi	counsellor	14
1123	2024-09-21 07:11:51.341103	2024-09-21 07:11:51.341103	\N	4	remark : Lead 331 updated by Farzana	Dhanmondi	counsellor	14
1124	2024-09-21 07:12:13.509555	2024-09-21 07:12:13.509555	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1125	2024-09-21 07:12:20.592155	2024-09-21 07:12:20.592155	\N	4	remark : Lead 337 updated by Farzana	Dhanmondi	counsellor	14
1126	2024-09-21 07:13:05.287112	2024-09-21 07:13:05.287112	\N	4	remark : phone off	Dhanmondi	counsellor	14
1127	2024-09-21 07:13:05.309723	2024-09-21 07:13:05.309723	\N	5	Status changed from new to unreachable of lead 330 by Farzana	Dhanmondi	counsellor	14
1128	2024-09-21 07:14:17.479683	2024-09-21 07:14:17.479683	\N	4	remark : unqualified and non-sense 	Dhanmondi	counsellor	14
1129	2024-09-21 07:14:17.49617	2024-09-21 07:14:17.49617	\N	5	Status changed from new to not-interested of lead 329 by Farzana	Dhanmondi	counsellor	14
1130	2024-09-21 07:15:17.142357	2024-09-21 07:15:17.142357	\N	4	remark : he sends me CV and he wants to visit our office	Dhanmondi	counsellor	14
1131	2024-09-21 07:15:17.156782	2024-09-21 07:15:17.156782	\N	5	Status changed from new to appointment-book of lead 328 by Farzana	Dhanmondi	counsellor	14
1132	2024-09-21 07:15:20.21485	2024-09-21 07:15:20.21485	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1133	2024-09-21 07:15:43.783444	2024-09-21 07:15:43.783444	\N	4	remark : Lead 328 updated by Farzana	Dhanmondi	counsellor	14
1134	2024-09-21 08:12:17.890909	2024-09-21 08:12:17.890909	\N	4	remark : not qualified 	Dhanmondi	counsellor	14
1135	2024-09-21 08:12:17.907106	2024-09-21 08:12:17.907106	\N	5	Status changed from new to not-interested of lead 327 by Farzana	Dhanmondi	counsellor	14
1136	2024-09-21 08:12:20.6193	2024-09-21 08:12:20.6193	\N	4	remark : Lead 327 updated by Farzana	Dhanmondi	counsellor	14
1137	2024-09-21 08:19:06.881952	2024-09-21 08:19:06.881952	\N	4	remark : No phone number	Dhanmondi	counsellor	14
1138	2024-09-21 08:19:06.897558	2024-09-21 08:19:06.897558	\N	5	Status changed from new to unreachable of lead 326 by Farzana	Dhanmondi	counsellor	14
1139	2024-09-21 08:19:09.454537	2024-09-21 08:19:09.454537	\N	4	remark : Lead 326 updated by Farzana	Dhanmondi	counsellor	14
1140	2024-09-21 08:28:47.072211	2024-09-21 08:28:47.072211	\N	4	remark : Cut my phone several time	Dhanmondi	counsellor	14
1141	2024-09-21 08:28:47.099585	2024-09-21 08:28:47.099585	\N	5	Status changed from new to not-interested of lead 325 by Farzana	Dhanmondi	counsellor	14
1142	2024-09-21 08:28:58.224785	2024-09-21 08:28:58.224785	\N	4	remark : Lead 325 updated by Farzana	Dhanmondi	counsellor	14
1143	2024-09-21 08:31:36.035363	2024-09-21 08:31:36.035363	\N	4	remark : he is connected with whats app	Dhanmondi	counsellor	14
1144	2024-09-21 08:31:36.052793	2024-09-21 08:31:36.052793	\N	5	Status changed from new to future-interest of lead 324 by Farzana	Dhanmondi	counsellor	14
1145	2024-09-21 08:33:46.603756	2024-09-21 08:33:46.603756	\N	4	remark : connected with whats app	Dhanmondi	counsellor	14
1146	2024-09-21 08:33:46.616863	2024-09-21 08:33:46.616863	\N	5	Status changed from new to future-interest of lead 323 by Farzana	Dhanmondi	counsellor	14
1147	2024-09-21 08:41:31.997293	2024-09-21 08:41:31.997293	\N	4	remark : His ielts exam will be held on 28th September	Dhanmondi	counsellor	14
1148	2024-09-21 08:41:32.012907	2024-09-21 08:41:32.012907	\N	5	Status changed from new to first of lead 322 by Farzana	Dhanmondi	counsellor	14
1149	2024-09-21 08:43:42.466201	2024-09-21 08:43:42.466201	\N	4	remark : mistake	Dhanmondi	counsellor	14
1150	2024-09-21 08:43:42.482366	2024-09-21 08:43:42.482366	\N	5	Status changed from new to not-interested of lead 320 by Farzana	Dhanmondi	counsellor	14
1151	2024-09-21 08:46:22.521351	2024-09-21 08:46:22.521351	\N	4	remark : work visa	Dhanmondi	counsellor	14
1152	2024-09-21 08:46:22.536334	2024-09-21 08:46:22.536334	\N	5	Status changed from new to not-interested of lead 321 by Farzana	Dhanmondi	counsellor	14
1153	2024-09-21 08:46:24.328537	2024-09-21 08:46:24.328537	\N	4	remark : Lead 321 updated by Farzana	Dhanmondi	counsellor	14
1154	2024-09-21 08:47:17.423733	2024-09-21 08:47:17.423733	\N	4	remark : Phone off	Dhanmondi	counsellor	14
1155	2024-09-21 08:47:17.440339	2024-09-21 08:47:17.440339	\N	5	Status changed from new to unreachable of lead 318 by Farzana	Dhanmondi	counsellor	14
1156	2024-09-21 08:47:19.696599	2024-09-21 08:47:19.696599	\N	4	remark : Lead 318 updated by Farzana	Dhanmondi	counsellor	14
1157	2024-09-21 09:07:41.775975	2024-09-21 09:07:41.775975	\N	4	remark : bad profile	Dhanmondi	counsellor	14
1158	2024-09-21 09:07:41.790972	2024-09-21 09:07:41.790972	\N	5	Status changed from new to not-interested of lead 319 by Farzana	Dhanmondi	counsellor	14
1159	2024-09-21 09:09:58.681912	2024-09-21 09:09:58.681912	\N	4	remark : No ielts, he wants PHD program and connected with whats app	Dhanmondi	counsellor	14
1160	2024-09-21 09:09:58.695466	2024-09-21 09:09:58.695466	\N	5	Status changed from new to future-interest of lead 316 by Farzana	Dhanmondi	counsellor	14
1161	2024-09-21 09:10:44.741413	2024-09-21 09:10:44.741413	\N	4	remark : Bad profile	Dhanmondi	counsellor	14
1162	2024-09-21 09:10:44.753937	2024-09-21 09:10:44.753937	\N	5	Status changed from new to not-interested of lead 315 by Farzana	Dhanmondi	counsellor	14
1163	2024-09-21 09:11:40.810556	2024-09-21 09:11:40.810556	\N	4	remark : several times i called her	Dhanmondi	counsellor	14
1164	2024-09-21 09:11:40.825214	2024-09-21 09:11:40.825214	\N	5	Status changed from new to unreachable of lead 313 by Farzana	Dhanmondi	counsellor	14
1165	2024-09-21 09:16:53.546861	2024-09-21 09:16:53.546861	\N	1	Logged in	Dhanmondi	admin	1
1166	2024-09-21 09:19:48.271399	2024-09-21 09:19:48.271399	\N	4	remark : Lead 279 updated by Naf	Dhanmondi	admin	1
1167	2024-09-21 09:23:26.249648	2024-09-21 09:23:26.249648	\N	4	remark : Lead 296 updated by Naf	Dhanmondi	admin	1
1168	2024-09-21 09:23:26.252898	2024-09-21 09:23:26.252898	\N	4	remark : Lead 297 updated by Naf	Dhanmondi	admin	1
1169	2024-09-21 09:23:26.389922	2024-09-21 09:23:26.389922	\N	4	remark : Lead 294 updated by Naf	Dhanmondi	admin	1
1170	2024-09-21 09:23:26.39418	2024-09-21 09:23:26.39418	\N	4	remark : Lead 295 updated by Naf	Dhanmondi	admin	1
1171	2024-09-21 09:23:26.689953	2024-09-21 09:23:26.689953	\N	4	remark : Lead 298 updated by Naf	Dhanmondi	admin	1
1172	2024-09-21 09:23:26.704303	2024-09-21 09:23:26.704303	\N	4	remark : Lead 299 updated by Naf	Dhanmondi	admin	1
1173	2024-09-21 09:23:26.715892	2024-09-21 09:23:26.715892	\N	3	Lead 303 assigned to Jarin	Dhanmondi	admin	1
1174	2024-09-21 09:23:26.71566	2024-09-21 09:23:26.71566	\N	3	Lead 300 assigned to Jarin	Dhanmondi	admin	1
1175	2024-09-21 09:23:26.717368	2024-09-21 09:23:26.717368	\N	3	Lead 302 assigned to Jarin	Dhanmondi	admin	1
1176	2024-09-21 09:23:26.721042	2024-09-21 09:23:26.721042	\N	4	remark : Lead 300 updated by Naf	Dhanmondi	admin	1
1177	2024-09-21 09:23:26.723363	2024-09-21 09:23:26.723363	\N	3	Lead 301 assigned to Jarin	Dhanmondi	admin	1
1178	2024-09-21 09:23:26.723019	2024-09-21 09:23:26.723019	\N	4	remark : Lead 303 updated by Naf	Dhanmondi	admin	1
1179	2024-09-21 09:23:26.746749	2024-09-21 09:23:26.746749	\N	4	remark : Lead 302 updated by Naf	Dhanmondi	admin	1
1180	2024-09-21 09:23:26.748618	2024-09-21 09:23:26.748618	\N	4	remark : Lead 301 updated by Naf	Dhanmondi	admin	1
1181	2024-09-21 09:24:00.34146	2024-09-21 09:24:00.34146	\N	4	remark : Lead 295 updated by Naf	Dhanmondi	admin	1
1182	2024-09-21 09:24:00.342712	2024-09-21 09:24:00.342712	\N	4	remark : Lead 294 updated by Naf	Dhanmondi	admin	1
1183	2024-09-21 09:25:00.393455	2024-09-21 09:25:00.393455	\N	4	remark : Lead 293 updated by Naf	Dhanmondi	admin	1
1184	2024-09-21 09:25:00.404392	2024-09-21 09:25:00.404392	\N	4	remark : Lead 292 updated by Naf	Dhanmondi	admin	1
1185	2024-09-21 09:25:00.405469	2024-09-21 09:25:00.405469	\N	4	remark : Lead 291 updated by Naf	Dhanmondi	admin	1
1186	2024-09-21 09:25:38.526157	2024-09-21 09:25:38.526157	\N	3	Lead 289 assigned to Farzana	Dhanmondi	admin	1
1187	2024-09-21 09:25:38.530531	2024-09-21 09:25:38.530531	\N	3	Lead 286 assigned to Farzana	Dhanmondi	admin	1
1188	2024-09-21 09:25:38.53116	2024-09-21 09:25:38.53116	\N	3	Lead 288 assigned to Farzana	Dhanmondi	admin	1
1189	2024-09-21 09:25:38.530135	2024-09-21 09:25:38.530135	\N	3	Lead 290 assigned to Farzana	Dhanmondi	admin	1
1190	2024-09-21 09:25:38.536076	2024-09-21 09:25:38.536076	\N	3	Lead 287 assigned to Farzana	Dhanmondi	admin	1
1191	2024-09-21 09:25:38.539663	2024-09-21 09:25:38.539663	\N	3	Lead 285 assigned to Farzana	Dhanmondi	admin	1
1192	2024-09-21 09:25:38.544549	2024-09-21 09:25:38.544549	\N	4	remark : Lead 287 updated by Naf	Dhanmondi	admin	1
1193	2024-09-21 09:25:38.548794	2024-09-21 09:25:38.548794	\N	4	remark : Lead 285 updated by Naf	Dhanmondi	admin	1
1666	2024-09-22 09:04:03.440406	2024-09-22 09:04:03.440406	\N	1	Logged in	Dhanmondi	admin	1
1194	2024-09-21 09:25:38.554266	2024-09-21 09:25:38.554266	\N	4	remark : Lead 289 updated by Naf	Dhanmondi	admin	1
1195	2024-09-21 09:25:38.56932	2024-09-21 09:25:38.56932	\N	4	remark : Lead 290 updated by Naf	Dhanmondi	admin	1
1196	2024-09-21 09:25:38.569285	2024-09-21 09:25:38.569285	\N	4	remark : Lead 288 updated by Naf	Dhanmondi	admin	1
1458	2024-09-21 17:42:59.642512	2024-09-21 17:42:59.642512	\N	4	remark : He wants to go in September 2025 intake	Dhanmondi	counsellor	13
1459	2024-09-21 17:42:59.655907	2024-09-21 17:42:59.655907	\N	5	Status changed from new to future-interest of lead 261 by Jarin	Dhanmondi	counsellor	13
1498	2024-09-21 18:37:30.640309	2024-09-21 18:37:30.640309	\N	4	remark : Lead 269 updated by Jarin	Dhanmondi	counsellor	13
1537	2024-09-22 05:21:30.714872	2024-09-22 05:21:30.714872	\N	4	remark : Lead 297 updated by Jarin	Dhanmondi	counsellor	13
1586	2024-09-22 05:51:07.196155	2024-09-22 05:51:07.196155	\N	4	remark : Busy	Dhanmondi	counsellor	13
1587	2024-09-22 05:51:07.211763	2024-09-22 05:51:07.211763	\N	5	Status changed from new to unreachable of lead 222 by Jarin	Dhanmondi	counsellor	13
1626	2024-09-22 06:15:26.640183	2024-09-22 06:15:26.640183	\N	2	Lead created	Dhanmondi	counsellor	13
1627	2024-09-22 06:15:27.085333	2024-09-22 06:15:27.085333	\N	1	Logged in	Dhanmondi	admin	1
1667	2024-09-22 10:39:44.861803	2024-09-22 10:39:44.861803	\N	1	Logged in	Dhanmondi	admin	1
1696	2024-09-25 04:38:08.597581	2024-09-25 04:38:08.597581	\N	1	Logged in	Dhanmondi	counsellor	14
1728	2024-09-26 20:08:47.817275	2024-09-26 20:08:47.817275	\N	1	Logged in	Dhanmondi	admin	1
1795	2024-11-24 06:12:21.238048	2024-11-24 06:12:21.238048	\N	1	Logged in	Dhanmondi	counsellor	14
1826	2024-11-24 13:09:48.375791	2024-11-24 13:09:48.375791	\N	2	Lead created	Dhanmondi	admin	1
1843	2024-11-24 13:09:48.400296	2024-11-24 13:09:48.400296	\N	2	Lead created	Dhanmondi	admin	1
1860	2024-11-24 13:09:48.438512	2024-11-24 13:09:48.438512	\N	2	Lead created	Dhanmondi	admin	1
1873	2024-11-24 13:09:48.448964	2024-11-24 13:09:48.448964	\N	2	Lead created	Dhanmondi	admin	1
1888	2024-11-24 13:09:48.457058	2024-11-24 13:09:48.457058	\N	2	Lead created	Dhanmondi	admin	1
1897	2024-11-24 13:09:48.463684	2024-11-24 13:09:48.463684	\N	2	Lead created	Dhanmondi	admin	1
1903	2024-11-24 13:09:48.471308	2024-11-24 13:09:48.471308	\N	2	Lead created	Dhanmondi	admin	1
1911	2024-11-24 13:09:48.476859	2024-11-24 13:09:48.476859	\N	2	Lead created	Dhanmondi	admin	1
1919	2024-11-24 13:09:48.483315	2024-11-24 13:09:48.483315	\N	2	Lead created	Dhanmondi	admin	1
1927	2024-11-24 13:09:48.487772	2024-11-24 13:09:48.487772	\N	2	Lead created	Dhanmondi	admin	1
1936	2024-11-24 13:09:48.49253	2024-11-24 13:09:48.49253	\N	2	Lead created	Dhanmondi	admin	1
1943	2024-11-24 13:09:48.497774	2024-11-24 13:09:48.497774	\N	2	Lead created	Dhanmondi	admin	1
1951	2024-11-24 13:09:48.505056	2024-11-24 13:09:48.505056	\N	2	Lead created	Dhanmondi	admin	1
1959	2024-11-24 13:09:48.510975	2024-11-24 13:09:48.510975	\N	2	Lead created	Dhanmondi	admin	1
1968	2024-11-24 13:09:48.51849	2024-11-24 13:09:48.51849	\N	2	Lead created	Dhanmondi	admin	1
1976	2024-11-24 13:09:48.525443	2024-11-24 13:09:48.525443	\N	2	Lead created	Dhanmondi	admin	1
1984	2024-11-24 13:09:48.534675	2024-11-24 13:09:48.534675	\N	2	Lead created	Dhanmondi	admin	1
1992	2024-11-24 13:09:48.544855	2024-11-24 13:09:48.544855	\N	2	Lead created	Dhanmondi	admin	1
2001	2024-11-24 13:09:48.552002	2024-11-24 13:09:48.552002	\N	2	Lead created	Dhanmondi	admin	1
2008	2024-11-24 13:09:48.557347	2024-11-24 13:09:48.557347	\N	2	Lead created	Dhanmondi	admin	1
2016	2024-11-24 13:09:48.565424	2024-11-24 13:09:48.565424	\N	2	Lead created	Dhanmondi	admin	1
2024	2024-11-24 13:09:48.570745	2024-11-24 13:09:48.570745	\N	2	Lead created	Dhanmondi	admin	1
1197	2024-09-21 09:25:38.569597	2024-09-21 09:25:38.569597	\N	4	remark : Lead 286 updated by Naf	Dhanmondi	admin	1
1198	2024-09-21 09:25:38.703524	2024-09-21 09:25:38.703524	\N	3	Lead 284 assigned to Farzana	Dhanmondi	admin	1
1199	2024-09-21 09:25:38.706242	2024-09-21 09:25:38.706242	\N	4	remark : Lead 284 updated by Naf	Dhanmondi	admin	1
1200	2024-09-21 09:26:52.527962	2024-09-21 09:26:52.527962	\N	4	remark : Lead 278 updated by Naf	Dhanmondi	admin	1
1201	2024-09-21 09:26:52.529977	2024-09-21 09:26:52.529977	\N	3	Lead 280 assigned to Farzana	Dhanmondi	admin	1
1202	2024-09-21 09:26:52.532853	2024-09-21 09:26:52.532853	\N	3	Lead 282 assigned to Farzana	Dhanmondi	admin	1
1203	2024-09-21 09:26:52.540426	2024-09-21 09:26:52.540426	\N	4	remark : Lead 282 updated by Naf	Dhanmondi	admin	1
1204	2024-09-21 09:26:52.543578	2024-09-21 09:26:52.543578	\N	4	remark : Lead 279 updated by Naf	Dhanmondi	admin	1
1205	2024-09-21 09:26:52.546882	2024-09-21 09:26:52.546882	\N	3	Lead 283 assigned to Farzana	Dhanmondi	admin	1
1206	2024-09-21 09:26:52.553065	2024-09-21 09:26:52.553065	\N	3	Lead 281 assigned to Farzana	Dhanmondi	admin	1
1207	2024-09-21 09:26:52.555447	2024-09-21 09:26:52.555447	\N	4	remark : Lead 283 updated by Naf	Dhanmondi	admin	1
1208	2024-09-21 09:26:52.558525	2024-09-21 09:26:52.558525	\N	4	remark : Lead 281 updated by Naf	Dhanmondi	admin	1
1209	2024-09-21 09:26:52.564831	2024-09-21 09:26:52.564831	\N	4	remark : Lead 280 updated by Naf	Dhanmondi	admin	1
1210	2024-09-21 09:26:52.761063	2024-09-21 09:26:52.761063	\N	4	remark : Lead 274 updated by Naf	Dhanmondi	admin	1
1211	2024-09-21 09:26:52.764077	2024-09-21 09:26:52.764077	\N	4	remark : Lead 277 updated by Naf	Dhanmondi	admin	1
1212	2024-09-21 09:26:52.765128	2024-09-21 09:26:52.765128	\N	4	remark : Lead 276 updated by Naf	Dhanmondi	admin	1
1213	2024-09-21 09:26:52.771576	2024-09-21 09:26:52.771576	\N	4	remark : Lead 275 updated by Naf	Dhanmondi	admin	1
1214	2024-09-21 09:28:19.956322	2024-09-21 09:28:19.956322	\N	4	remark : Lead 273 updated by Naf	Dhanmondi	admin	1
1215	2024-09-21 09:28:19.964489	2024-09-21 09:28:19.964489	\N	4	remark : Lead 272 updated by Naf	Dhanmondi	admin	1
1216	2024-09-21 09:28:20.184488	2024-09-21 09:28:20.184488	\N	4	remark : Lead 271 updated by Naf	Dhanmondi	admin	1
1217	2024-09-21 09:28:20.196249	2024-09-21 09:28:20.196249	\N	4	remark : Lead 270 updated by Naf	Dhanmondi	admin	1
1218	2024-09-21 09:28:46.501646	2024-09-21 09:28:46.501646	\N	3	Lead 269 assigned to Jarin	Dhanmondi	admin	1
1219	2024-09-21 09:28:46.502111	2024-09-21 09:28:46.502111	\N	3	Lead 265 assigned to Jarin	Dhanmondi	admin	1
1220	2024-09-21 09:28:46.504117	2024-09-21 09:28:46.504117	\N	3	Lead 268 assigned to Jarin	Dhanmondi	admin	1
1221	2024-09-21 09:28:46.50574	2024-09-21 09:28:46.50574	\N	3	Lead 266 assigned to Jarin	Dhanmondi	admin	1
1222	2024-09-21 09:28:46.506079	2024-09-21 09:28:46.506079	\N	3	Lead 264 assigned to Jarin	Dhanmondi	admin	1
1223	2024-09-21 09:28:46.505299	2024-09-21 09:28:46.505299	\N	3	Lead 267 assigned to Jarin	Dhanmondi	admin	1
1224	2024-09-21 09:28:46.511819	2024-09-21 09:28:46.511819	\N	4	remark : Lead 266 updated by Naf	Dhanmondi	admin	1
1225	2024-09-21 09:28:46.517386	2024-09-21 09:28:46.517386	\N	4	remark : Lead 264 updated by Naf	Dhanmondi	admin	1
1226	2024-09-21 09:28:46.541407	2024-09-21 09:28:46.541407	\N	4	remark : Lead 267 updated by Naf	Dhanmondi	admin	1
1227	2024-09-21 09:28:46.54312	2024-09-21 09:28:46.54312	\N	4	remark : Lead 269 updated by Naf	Dhanmondi	admin	1
1228	2024-09-21 09:28:46.544712	2024-09-21 09:28:46.544712	\N	4	remark : Lead 265 updated by Naf	Dhanmondi	admin	1
1229	2024-09-21 09:28:46.546068	2024-09-21 09:28:46.546068	\N	4	remark : Lead 268 updated by Naf	Dhanmondi	admin	1
1230	2024-09-21 09:29:57.539648	2024-09-21 09:29:57.539648	\N	3	Lead 263 assigned to Jarin	Dhanmondi	admin	1
1231	2024-09-21 09:29:57.559366	2024-09-21 09:29:57.559366	\N	3	Lead 260 assigned to Jarin	Dhanmondi	admin	1
1232	2024-09-21 09:29:57.558991	2024-09-21 09:29:57.558991	\N	4	remark : Lead 259 updated by Naf	Dhanmondi	admin	1
1233	2024-09-21 09:29:57.567765	2024-09-21 09:29:57.567765	\N	3	Lead 261 assigned to Jarin	Dhanmondi	admin	1
1234	2024-09-21 09:29:57.571177	2024-09-21 09:29:57.571177	\N	3	Lead 262 assigned to Jarin	Dhanmondi	admin	1
1235	2024-09-21 09:29:57.574423	2024-09-21 09:29:57.574423	\N	4	remark : Lead 261 updated by Naf	Dhanmondi	admin	1
1236	2024-09-21 09:29:57.579689	2024-09-21 09:29:57.579689	\N	4	remark : Lead 262 updated by Naf	Dhanmondi	admin	1
1238	2024-09-21 09:29:57.580525	2024-09-21 09:29:57.580525	\N	4	remark : Lead 263 updated by Naf	Dhanmondi	admin	1
1237	2024-09-21 09:29:57.580957	2024-09-21 09:29:57.580957	\N	4	remark : Lead 258 updated by Naf	Dhanmondi	admin	1
1239	2024-09-21 09:29:57.587343	2024-09-21 09:29:57.587343	\N	4	remark : Lead 260 updated by Naf	Dhanmondi	admin	1
1240	2024-09-21 09:29:57.793762	2024-09-21 09:29:57.793762	\N	4	remark : Lead 254 updated by Naf	Dhanmondi	admin	1
1241	2024-09-21 09:29:57.799655	2024-09-21 09:29:57.799655	\N	4	remark : Lead 256 updated by Naf	Dhanmondi	admin	1
1242	2024-09-21 09:29:57.802532	2024-09-21 09:29:57.802532	\N	4	remark : Lead 257 updated by Naf	Dhanmondi	admin	1
1243	2024-09-21 09:29:57.803986	2024-09-21 09:29:57.803986	\N	4	remark : Lead 255 updated by Naf	Dhanmondi	admin	1
1244	2024-09-21 09:30:29.25129	2024-09-21 09:30:29.25129	\N	3	Lead 249 assigned to Jarin	Dhanmondi	admin	1
1245	2024-09-21 09:30:29.268236	2024-09-21 09:30:29.268236	\N	4	remark : Lead 253 updated by Naf	Dhanmondi	admin	1
1246	2024-09-21 09:30:29.275872	2024-09-21 09:30:29.275872	\N	4	remark : Lead 250 updated by Naf	Dhanmondi	admin	1
1247	2024-09-21 09:30:29.277814	2024-09-21 09:30:29.277814	\N	4	remark : Lead 252 updated by Naf	Dhanmondi	admin	1
1248	2024-09-21 09:30:29.278549	2024-09-21 09:30:29.278549	\N	4	remark : Lead 251 updated by Naf	Dhanmondi	admin	1
1249	2024-09-21 09:30:29.287573	2024-09-21 09:30:29.287573	\N	4	remark : Lead 249 updated by Naf	Dhanmondi	admin	1
1250	2024-09-21 09:30:54.318332	2024-09-21 09:30:54.318332	\N	4	remark : Lead 248 updated by Naf	Dhanmondi	admin	1
1251	2024-09-21 09:30:54.319908	2024-09-21 09:30:54.319908	\N	4	remark : Lead 244 updated by Naf	Dhanmondi	admin	1
1252	2024-09-21 09:30:54.327827	2024-09-21 09:30:54.327827	\N	4	remark : Lead 246 updated by Naf	Dhanmondi	admin	1
1253	2024-09-21 09:30:54.32838	2024-09-21 09:30:54.32838	\N	4	remark : Lead 245 updated by Naf	Dhanmondi	admin	1
1254	2024-09-21 09:30:54.334304	2024-09-21 09:30:54.334304	\N	4	remark : Lead 247 updated by Naf	Dhanmondi	admin	1
1255	2024-09-21 09:31:37.974005	2024-09-21 09:31:37.974005	\N	4	remark : Lead 242 updated by Naf	Dhanmondi	admin	1
1256	2024-09-21 09:31:37.971439	2024-09-21 09:31:37.971439	\N	4	remark : Lead 240 updated by Naf	Dhanmondi	admin	1
1257	2024-09-21 09:31:37.9833	2024-09-21 09:31:37.9833	\N	4	remark : Lead 239 updated by Naf	Dhanmondi	admin	1
1258	2024-09-21 09:31:37.984731	2024-09-21 09:31:37.984731	\N	4	remark : Lead 241 updated by Naf	Dhanmondi	admin	1
1259	2024-09-21 09:31:37.988138	2024-09-21 09:31:37.988138	\N	4	remark : Lead 243 updated by Naf	Dhanmondi	admin	1
1260	2024-09-21 09:31:38.152948	2024-09-21 09:31:38.152948	\N	4	remark : Lead 234 updated by Naf	Dhanmondi	admin	1
1261	2024-09-21 09:31:38.156894	2024-09-21 09:31:38.156894	\N	4	remark : Lead 236 updated by Naf	Dhanmondi	admin	1
1262	2024-09-21 09:31:38.15903	2024-09-21 09:31:38.15903	\N	4	remark : Lead 237 updated by Naf	Dhanmondi	admin	1
1628	2024-09-22 06:15:39.177482	2024-09-22 06:15:39.177482	\N	1	Logged in	Dhanmondi	counsellor	14
1263	2024-09-21 09:31:38.165935	2024-09-21 09:31:38.165935	\N	4	remark : Lead 235 updated by Naf	Dhanmondi	admin	1
1264	2024-09-21 09:31:38.171654	2024-09-21 09:31:38.171654	\N	4	remark : Lead 238 updated by Naf	Dhanmondi	admin	1
1266	2024-09-21 09:31:41.717074	2024-09-21 09:31:41.717074	\N	4	remark : Lead 243 updated by Naf	Dhanmondi	admin	1
1269	2024-09-21 09:31:42.106688	2024-09-21 09:31:42.106688	\N	4	remark : Lead 236 updated by Naf	Dhanmondi	admin	1
1272	2024-09-21 09:31:42.119142	2024-09-21 09:31:42.119142	\N	4	remark : Lead 239 updated by Naf	Dhanmondi	admin	1
1460	2024-09-21 17:44:34.11018	2024-09-21 17:44:34.11018	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1462	2024-09-21 17:44:43.417078	2024-09-21 17:44:43.417078	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1464	2024-09-21 17:44:46.454287	2024-09-21 17:44:46.454287	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1499	2024-09-21 18:41:42.649121	2024-09-21 18:41:42.649121	\N	4	remark : No answer	Dhanmondi	counsellor	13
1500	2024-09-21 18:41:42.667094	2024-09-21 18:41:42.667094	\N	5	Status changed from new to unreachable of lead 210 by Jarin	Dhanmondi	counsellor	13
1538	2024-09-22 05:24:03.03532	2024-09-22 05:24:03.03532	\N	4	remark : No Answer	Dhanmondi	counsellor	13
1539	2024-09-22 05:24:03.051951	2024-09-22 05:24:03.051951	\N	5	Status changed from new to unreachable of lead 294 by Jarin	Dhanmondi	counsellor	13
1540	2024-09-22 05:24:04.622217	2024-09-22 05:24:04.622217	\N	4	remark : Lead 294 updated by Jarin	Dhanmondi	counsellor	13
1588	2024-09-22 05:52:08.529318	2024-09-22 05:52:08.529318	\N	4	remark : Not Interested	Dhanmondi	counsellor	13
1589	2024-09-22 05:52:08.544444	2024-09-22 05:52:08.544444	\N	5	Status changed from new to not-interested of lead 221 by Jarin	Dhanmondi	counsellor	13
1629	2024-09-22 06:16:13.169443	2024-09-22 06:16:13.169443	\N	1	Logged in	Dhanmondi	admin	1
1668	2024-09-23 06:18:38.989808	2024-09-23 06:18:38.989808	\N	1	Logged in	Dhanmondi	counsellor	14
1697	2024-09-25 06:35:18.939521	2024-09-25 06:35:18.939521	\N	4	remark : Lead 322 updated by Farzana	Dhanmondi	counsellor	14
1698	2024-09-25 06:35:18.962064	2024-09-25 06:35:18.962064	\N	5	Status changed from first to course-new of lead 322 by Farzana	Dhanmondi	counsellor	14
1729	2024-09-27 15:58:05.35727	2024-09-27 15:58:05.35727	\N	1	Logged in	Dhanmondi	counsellor	13
1751	2024-10-08 03:31:38.783761	2024-10-08 03:31:38.783761	\N	1	Logged in	Dhanmondi	admin	1
1796	2024-11-24 06:12:33.391549	2024-11-24 06:12:33.391549	\N	1	Logged in	Dhanmondi	admin	1
1827	2024-11-24 13:09:48.378085	2024-11-24 13:09:48.378085	\N	2	Lead created	Dhanmondi	admin	1
1844	2024-11-24 13:09:48.405495	2024-11-24 13:09:48.405495	\N	2	Lead created	Dhanmondi	admin	1
1852	2024-11-24 13:09:48.434563	2024-11-24 13:09:48.434563	\N	2	Lead created	Dhanmondi	admin	1
1867	2024-11-24 13:09:48.444465	2024-11-24 13:09:48.444465	\N	2	Lead created	Dhanmondi	admin	1
1877	2024-11-24 13:09:48.45304	2024-11-24 13:09:48.45304	\N	2	Lead created	Dhanmondi	admin	1
1889	2024-11-24 13:09:48.458361	2024-11-24 13:09:48.458361	\N	2	Lead created	Dhanmondi	admin	1
1901	2024-11-24 13:09:48.467005	2024-11-24 13:09:48.467005	\N	2	Lead created	Dhanmondi	admin	1
1916	2024-11-24 13:09:48.477917	2024-11-24 13:09:48.477917	\N	2	Lead created	Dhanmondi	admin	1
1929	2024-11-24 13:09:48.487325	2024-11-24 13:09:48.487325	\N	2	Lead created	Dhanmondi	admin	1
1945	2024-11-24 13:09:48.497098	2024-11-24 13:09:48.497098	\N	2	Lead created	Dhanmondi	admin	1
1960	2024-11-24 13:09:48.509906	2024-11-24 13:09:48.509906	\N	2	Lead created	Dhanmondi	admin	1
1975	2024-11-24 13:09:48.521861	2024-11-24 13:09:48.521861	\N	2	Lead created	Dhanmondi	admin	1
1991	2024-11-24 13:09:48.539389	2024-11-24 13:09:48.539389	\N	2	Lead created	Dhanmondi	admin	1
2007	2024-11-24 13:09:48.555344	2024-11-24 13:09:48.555344	\N	2	Lead created	Dhanmondi	admin	1
2023	2024-11-24 13:09:48.568825	2024-11-24 13:09:48.568825	\N	2	Lead created	Dhanmondi	admin	1
1265	2024-09-21 09:31:41.709859	2024-09-21 09:31:41.709859	\N	4	remark : Lead 240 updated by Naf	Dhanmondi	admin	1
1267	2024-09-21 09:31:41.717635	2024-09-21 09:31:41.717635	\N	4	remark : Lead 241 updated by Naf	Dhanmondi	admin	1
1270	2024-09-21 09:31:42.114542	2024-09-21 09:31:42.114542	\N	4	remark : Lead 237 updated by Naf	Dhanmondi	admin	1
1273	2024-09-21 09:31:42.124365	2024-09-21 09:31:42.124365	\N	4	remark : Lead 235 updated by Naf	Dhanmondi	admin	1
1274	2024-09-21 09:31:42.128506	2024-09-21 09:31:42.128506	\N	4	remark : Lead 234 updated by Naf	Dhanmondi	admin	1
1461	2024-09-21 17:44:43.321052	2024-09-21 17:44:43.321052	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1463	2024-09-21 17:44:44.691606	2024-09-21 17:44:44.691606	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1465	2024-09-21 17:44:47.286406	2024-09-21 17:44:47.286406	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1466	2024-09-21 17:44:49.141078	2024-09-21 17:44:49.141078	\N	4	remark : Lead 261 updated by Jarin	Dhanmondi	counsellor	13
1501	2024-09-21 18:43:53.706992	2024-09-21 18:43:53.706992	\N	4	remark : no answer	Dhanmondi	counsellor	13
1502	2024-09-21 18:43:53.722005	2024-09-21 18:43:53.722005	\N	5	Status changed from new to unreachable of lead 211 by Jarin	Dhanmondi	counsellor	13
1541	2024-09-22 05:25:20.130361	2024-09-22 05:25:20.130361	\N	4	remark : Wrong Number 	Dhanmondi	counsellor	13
1542	2024-09-22 05:25:20.144163	2024-09-22 05:25:20.144163	\N	5	Status changed from new to unreachable of lead 293 by Jarin	Dhanmondi	counsellor	13
1590	2024-09-22 05:53:02.044613	2024-09-22 05:53:02.044613	\N	4	remark : Number missing	Dhanmondi	counsellor	13
1591	2024-09-22 05:53:02.061389	2024-09-22 05:53:02.061389	\N	5	Status changed from new to unreachable of lead 291 by Jarin	Dhanmondi	counsellor	13
1594	2024-09-22 05:53:08.751532	2024-09-22 05:53:08.751532	\N	4	remark : Lead 220 updated by Jarin	Dhanmondi	counsellor	13
1630	2024-09-22 06:16:53.587383	2024-09-22 06:16:53.587383	\N	4	remark : Lead 311 updated by Naf	Dhanmondi	admin	1
1633	2024-09-22 06:16:53.713537	2024-09-22 06:16:53.713537	\N	4	remark : Lead 307 updated by Naf	Dhanmondi	admin	1
1635	2024-09-22 06:16:53.716474	2024-09-22 06:16:53.716474	\N	4	remark : Lead 309 updated by Naf	Dhanmondi	admin	1
1637	2024-09-22 06:16:53.749673	2024-09-22 06:16:53.749673	\N	4	remark : Lead 304 updated by Naf	Dhanmondi	admin	1
1669	2024-09-23 08:36:38.4743	2024-09-23 08:36:38.4743	\N	1	Logged in	Dhanmondi	admin	1
1699	2024-09-25 06:37:05.217453	2024-09-25 06:37:05.217453	\N	4	remark : 28th September exam. i will call him 13th October	Dhanmondi	counsellor	14
1700	2024-09-25 06:37:05.231015	2024-09-25 06:37:05.231015	\N	5	Status changed from course-new to exam of lead 322 by Farzana	Dhanmondi	counsellor	14
1730	2024-09-28 06:35:08.807845	2024-09-28 06:35:08.807845	\N	2	Lead created	Dhanmondi	counsellor	13
1752	2024-10-08 08:18:18.681928	2024-10-08 08:18:18.681928	\N	1	Logged in	Dhanmondi	admin	1
1797	2024-11-24 06:18:19.669557	2024-11-24 06:18:19.669557	\N	1	Logged in	Dhanmondi	counsellor	14
2031	2024-11-24 13:10:41.398682	2024-11-24 13:10:41.398682	\N	1	Logged in	Dhanmondi	admin	1
1268	2024-09-21 09:31:41.71963	2024-09-21 09:31:41.71963	\N	4	remark : Lead 242 updated by Naf	Dhanmondi	admin	1
1271	2024-09-21 09:31:42.117967	2024-09-21 09:31:42.117967	\N	4	remark : Lead 238 updated by Naf	Dhanmondi	admin	1
1275	2024-09-21 09:32:41.915053	2024-09-21 09:32:41.915053	\N	4	remark : Lead 231 updated by Naf	Dhanmondi	admin	1
1276	2024-09-21 09:32:41.938332	2024-09-21 09:32:41.938332	\N	4	remark : Lead 233 updated by Naf	Dhanmondi	admin	1
1278	2024-09-21 09:32:41.942775	2024-09-21 09:32:41.942775	\N	4	remark : Lead 232 updated by Naf	Dhanmondi	admin	1
1277	2024-09-21 09:32:41.942607	2024-09-21 09:32:41.942607	\N	4	remark : Lead 230 updated by Naf	Dhanmondi	admin	1
1279	2024-09-21 09:33:06.870636	2024-09-21 09:33:06.870636	\N	4	remark : Lead 229 updated by Naf	Dhanmondi	admin	1
1280	2024-09-21 09:33:06.87084	2024-09-21 09:33:06.87084	\N	4	remark : Lead 228 updated by Naf	Dhanmondi	admin	1
1281	2024-09-21 09:33:06.879259	2024-09-21 09:33:06.879259	\N	4	remark : Lead 226 updated by Naf	Dhanmondi	admin	1
1282	2024-09-21 09:33:06.880247	2024-09-21 09:33:06.880247	\N	4	remark : Lead 227 updated by Naf	Dhanmondi	admin	1
1283	2024-09-21 09:33:07.111682	2024-09-21 09:33:07.111682	\N	4	remark : Lead 224 updated by Naf	Dhanmondi	admin	1
1284	2024-09-21 09:33:07.118837	2024-09-21 09:33:07.118837	\N	4	remark : Lead 225 updated by Naf	Dhanmondi	admin	1
1285	2024-09-21 09:34:08.960826	2024-09-21 09:34:08.960826	\N	4	remark : Lead 220 updated by Naf	Dhanmondi	admin	1
1286	2024-09-21 09:34:08.967399	2024-09-21 09:34:08.967399	\N	4	remark : Lead 222 updated by Naf	Dhanmondi	admin	1
1287	2024-09-21 09:34:08.96693	2024-09-21 09:34:08.96693	\N	4	remark : Lead 223 updated by Naf	Dhanmondi	admin	1
1288	2024-09-21 09:34:08.974108	2024-09-21 09:34:08.974108	\N	4	remark : Lead 221 updated by Naf	Dhanmondi	admin	1
1289	2024-09-21 09:34:09.477208	2024-09-21 09:34:09.477208	\N	4	remark : Lead 219 updated by Naf	Dhanmondi	admin	1
1290	2024-09-21 09:34:09.478174	2024-09-21 09:34:09.478174	\N	4	remark : Lead 218 updated by Naf	Dhanmondi	admin	1
1291	2024-09-21 09:34:09.48517	2024-09-21 09:34:09.48517	\N	4	remark : Lead 217 updated by Naf	Dhanmondi	admin	1
1292	2024-09-21 09:34:09.491796	2024-09-21 09:34:09.491796	\N	4	remark : Lead 216 updated by Naf	Dhanmondi	admin	1
1293	2024-09-21 09:34:09.902117	2024-09-21 09:34:09.902117	\N	4	remark : Lead 214 updated by Naf	Dhanmondi	admin	1
1294	2024-09-21 09:34:09.908722	2024-09-21 09:34:09.908722	\N	4	remark : Lead 215 updated by Naf	Dhanmondi	admin	1
1295	2024-09-21 09:34:38.303091	2024-09-21 09:34:38.303091	\N	4	remark : Lead 210 updated by Naf	Dhanmondi	admin	1
1296	2024-09-21 09:34:38.308308	2024-09-21 09:34:38.308308	\N	3	Lead 209 assigned to Jarin	Dhanmondi	admin	1
1297	2024-09-21 09:34:38.309814	2024-09-21 09:34:38.309814	\N	4	remark : Lead 211 updated by Naf	Dhanmondi	admin	1
1298	2024-09-21 09:34:38.320873	2024-09-21 09:34:38.320873	\N	4	remark : Lead 213 updated by Naf	Dhanmondi	admin	1
1299	2024-09-21 09:34:38.32561	2024-09-21 09:34:38.32561	\N	4	remark : Lead 209 updated by Naf	Dhanmondi	admin	1
1300	2024-09-21 09:34:38.32653	2024-09-21 09:34:38.32653	\N	4	remark : Lead 212 updated by Naf	Dhanmondi	admin	1
1301	2024-09-21 09:35:05.12355	2024-09-21 09:35:05.12355	\N	4	remark : Lead 208 updated by Naf	Dhanmondi	admin	1
1302	2024-09-21 09:35:05.126858	2024-09-21 09:35:05.126858	\N	4	remark : Lead 204 updated by Naf	Dhanmondi	admin	1
1303	2024-09-21 09:35:05.130823	2024-09-21 09:35:05.130823	\N	4	remark : Lead 205 updated by Naf	Dhanmondi	admin	1
1304	2024-09-21 09:35:05.131231	2024-09-21 09:35:05.131231	\N	4	remark : Lead 206 updated by Naf	Dhanmondi	admin	1
1305	2024-09-21 09:35:05.136039	2024-09-21 09:35:05.136039	\N	4	remark : Lead 207 updated by Naf	Dhanmondi	admin	1
1306	2024-09-21 09:36:00.166928	2024-09-21 09:36:00.166928	\N	3	Lead 199 assigned to Farzana	Dhanmondi	admin	1
1307	2024-09-21 09:36:00.182475	2024-09-21 09:36:00.182475	\N	4	remark : Lead 203 updated by Naf	Dhanmondi	admin	1
1308	2024-09-21 09:36:00.193107	2024-09-21 09:36:00.193107	\N	4	remark : Lead 201 updated by Naf	Dhanmondi	admin	1
1309	2024-09-21 09:36:00.194563	2024-09-21 09:36:00.194563	\N	4	remark : Lead 199 updated by Naf	Dhanmondi	admin	1
1310	2024-09-21 09:36:00.195512	2024-09-21 09:36:00.195512	\N	4	remark : Lead 202 updated by Naf	Dhanmondi	admin	1
1311	2024-09-21 09:36:00.199356	2024-09-21 09:36:00.199356	\N	4	remark : Lead 200 updated by Naf	Dhanmondi	admin	1
1312	2024-09-21 09:36:00.395	2024-09-21 09:36:00.395	\N	3	Lead 195 assigned to Farzana	Dhanmondi	admin	1
1313	2024-09-21 09:36:00.400529	2024-09-21 09:36:00.400529	\N	3	Lead 198 assigned to Farzana	Dhanmondi	admin	1
1314	2024-09-21 09:36:00.403918	2024-09-21 09:36:00.403918	\N	3	Lead 196 assigned to Farzana	Dhanmondi	admin	1
1315	2024-09-21 09:36:00.414951	2024-09-21 09:36:00.414951	\N	3	Lead 194 assigned to Farzana	Dhanmondi	admin	1
1316	2024-09-21 09:36:00.41659	2024-09-21 09:36:00.41659	\N	4	remark : Lead 196 updated by Naf	Dhanmondi	admin	1
1317	2024-09-21 09:36:00.414212	2024-09-21 09:36:00.414212	\N	3	Lead 197 assigned to Farzana	Dhanmondi	admin	1
1318	2024-09-21 09:36:00.424866	2024-09-21 09:36:00.424866	\N	4	remark : Lead 197 updated by Naf	Dhanmondi	admin	1
1319	2024-09-21 09:36:00.425425	2024-09-21 09:36:00.425425	\N	4	remark : Lead 194 updated by Naf	Dhanmondi	admin	1
1320	2024-09-21 09:36:00.429291	2024-09-21 09:36:00.429291	\N	4	remark : Lead 195 updated by Naf	Dhanmondi	admin	1
1321	2024-09-21 09:36:00.431161	2024-09-21 09:36:00.431161	\N	4	remark : Lead 198 updated by Naf	Dhanmondi	admin	1
1322	2024-09-21 09:36:29.411371	2024-09-21 09:36:29.411371	\N	3	Lead 191 assigned to Farzana	Dhanmondi	admin	1
1323	2024-09-21 09:36:29.412678	2024-09-21 09:36:29.412678	\N	3	Lead 193 assigned to Farzana	Dhanmondi	admin	1
1324	2024-09-21 09:36:29.420443	2024-09-21 09:36:29.420443	\N	3	Lead 190 assigned to Farzana	Dhanmondi	admin	1
1325	2024-09-21 09:36:29.423878	2024-09-21 09:36:29.423878	\N	3	Lead 192 assigned to Farzana	Dhanmondi	admin	1
1326	2024-09-21 09:36:29.429974	2024-09-21 09:36:29.429974	\N	4	remark : Lead 189 updated by Naf	Dhanmondi	admin	1
1327	2024-09-21 09:36:29.435171	2024-09-21 09:36:29.435171	\N	4	remark : Lead 192 updated by Naf	Dhanmondi	admin	1
1328	2024-09-21 09:36:29.441875	2024-09-21 09:36:29.441875	\N	4	remark : Lead 191 updated by Naf	Dhanmondi	admin	1
1329	2024-09-21 09:36:29.443088	2024-09-21 09:36:29.443088	\N	4	remark : Lead 190 updated by Naf	Dhanmondi	admin	1
1330	2024-09-21 09:36:29.44557	2024-09-21 09:36:29.44557	\N	4	remark : Lead 193 updated by Naf	Dhanmondi	admin	1
1331	2024-09-21 09:36:53.801975	2024-09-21 09:36:53.801975	\N	1	Logged in	Dhanmondi	counsellor	14
1332	2024-09-21 10:43:04.711558	2024-09-21 10:43:04.711558	\N	4	remark : Bad	Dhanmondi	counsellor	14
1333	2024-09-21 10:43:04.725025	2024-09-21 10:43:04.725025	\N	5	Status changed from new to not-interested of lead 290 by Farzana	Dhanmondi	counsellor	14
1334	2024-09-21 11:22:27.532392	2024-09-21 11:22:27.532392	\N	4	remark : masters 2018, teaching profession, ielts overall 6, wanna apply linguistics tesol	Dhanmondi	counsellor	14
1335	2024-09-21 11:22:27.548346	2024-09-21 11:22:27.548346	\N	5	Status changed from new to first of lead 289 by Farzana	Dhanmondi	counsellor	14
1336	2024-09-21 13:33:13.992413	2024-09-21 13:33:13.992413	\N	4	remark : graduation18, job running, in the next month he will give ielts	Dhanmondi	counsellor	14
1337	2024-09-21 13:33:14.012421	2024-09-21 13:33:14.012421	\N	5	Status changed from new to first of lead 288 by Farzana	Dhanmondi	counsellor	14
1338	2024-09-21 13:34:14.158527	2024-09-21 13:34:14.158527	\N	4	remark : Long study gap. HSC 2008	Dhanmondi	counsellor	14
1339	2024-09-21 13:34:14.170708	2024-09-21 13:34:14.170708	\N	5	Status changed from new to not-interested of lead 287 by Farzana	Dhanmondi	counsellor	14
1340	2024-09-21 13:36:30.463781	2024-09-21 13:36:30.463781	\N	4	remark : No response. 4 times i called him	Dhanmondi	counsellor	14
1341	2024-09-21 13:36:30.477443	2024-09-21 13:36:30.477443	\N	5	Status changed from new to unreachable of lead 286 by Farzana	Dhanmondi	counsellor	14
1342	2024-09-21 13:39:11.621354	2024-09-21 13:39:11.621354	\N	4	remark : he wants arabic language studies and preparing for ielts	Dhanmondi	counsellor	14
1343	2024-09-21 13:39:11.636089	2024-09-21 13:39:11.636089	\N	5	Status changed from new to first of lead 285 by Farzana	Dhanmondi	counsellor	14
1344	2024-09-21 13:42:12.330793	2024-09-21 13:42:12.330793	\N	4	remark : no response, several times called him	Dhanmondi	counsellor	14
1345	2024-09-21 13:42:12.347831	2024-09-21 13:42:12.347831	\N	5	Status changed from new to unreachable of lead 283 by Farzana	Dhanmondi	counsellor	14
1346	2024-09-21 13:45:27.978224	2024-09-21 13:45:27.978224	\N	4	remark : bad profile, long long long study gap	Dhanmondi	counsellor	14
1347	2024-09-21 13:45:27.992319	2024-09-21 13:45:27.992319	\N	5	Status changed from new to not-interested of lead 284 by Farzana	Dhanmondi	counsellor	14
1348	2024-09-21 13:47:59.789527	2024-09-21 13:47:59.789527	\N	4	remark : she will take preparation for ielts	Dhanmondi	counsellor	14
1349	2024-09-21 13:47:59.804441	2024-09-21 13:47:59.804441	\N	5	Status changed from new to future-interest of lead 282 by Farzana	Dhanmondi	counsellor	14
1350	2024-09-21 13:50:09.624352	2024-09-21 13:50:09.624352	\N	4	remark : no phone number	Dhanmondi	counsellor	14
1351	2024-09-21 13:50:09.638074	2024-09-21 13:50:09.638074	\N	5	Status changed from new to unreachable of lead 281 by Farzana	Dhanmondi	counsellor	14
1352	2024-09-21 13:51:12.514791	2024-09-21 13:51:12.514791	\N	4	remark : no phone number	Dhanmondi	counsellor	14
1353	2024-09-21 13:51:12.527681	2024-09-21 13:51:12.527681	\N	5	Status changed from new to unreachable of lead 280 by Farzana	Dhanmondi	counsellor	14
1354	2024-09-21 14:48:13.566354	2024-09-21 14:48:13.566354	\N	1	Logged in	Dhanmondi	counsellor	13
1355	2024-09-21 15:48:28.970742	2024-09-21 15:48:28.970742	\N	4	remark : he did MBBS 1994	Dhanmondi	counsellor	14
1356	2024-09-21 15:48:28.98516	2024-09-21 15:48:28.98516	\N	5	Status changed from new to future-interest of lead 279 by Farzana	Dhanmondi	counsellor	14
1357	2024-09-21 15:49:47.569817	2024-09-21 15:49:47.569817	\N	4	remark : several times i called him but he cut my phone	Dhanmondi	counsellor	14
1358	2024-09-21 15:49:47.584124	2024-09-21 15:49:47.584124	\N	5	Status changed from new to unreachable of lead 278 by Farzana	Dhanmondi	counsellor	14
1359	2024-09-21 15:51:04.708001	2024-09-21 15:51:04.708001	\N	4	remark : she was busy	Dhanmondi	counsellor	14
1360	2024-09-21 15:51:04.721654	2024-09-21 15:51:04.721654	\N	5	Status changed from new to first of lead 277 by Farzana	Dhanmondi	counsellor	14
1361	2024-09-21 15:55:10.069968	2024-09-21 15:55:10.069968	\N	4	remark : mistake	Dhanmondi	counsellor	14
1362	2024-09-21 15:55:10.084412	2024-09-21 15:55:10.084412	\N	5	Status changed from new to not-interested of lead 276 by Farzana	Dhanmondi	counsellor	14
1363	2024-09-21 15:55:59.179214	2024-09-21 15:55:59.179214	\N	4	remark : He wants PHD, has some research paper and preparing for ielts	Dhanmondi	counsellor	14
1364	2024-09-21 15:55:59.194364	2024-09-21 15:55:59.194364	\N	5	Status changed from new to first of lead 275 by Farzana	Dhanmondi	counsellor	14
1365	2024-09-21 15:56:58.0894	2024-09-21 15:56:58.0894	\N	4	remark : nonsense 	Dhanmondi	counsellor	14
1366	2024-09-21 15:56:58.10321	2024-09-21 15:56:58.10321	\N	5	Status changed from new to not-interested of lead 274 by Farzana	Dhanmondi	counsellor	14
1367	2024-09-21 15:57:13.083469	2024-09-21 15:57:13.083469	\N	4	remark : nonsense	Dhanmondi	counsellor	14
1368	2024-09-21 15:57:13.099861	2024-09-21 15:57:13.099861	\N	5	Status changed from new to not-interested of lead 273 by Farzana	Dhanmondi	counsellor	14
1369	2024-09-21 15:57:51.826297	2024-09-21 15:57:51.826297	\N	4	remark : phone off	Dhanmondi	counsellor	14
1370	2024-09-21 15:57:51.84027	2024-09-21 15:57:51.84027	\N	5	Status changed from new to unreachable of lead 272 by Farzana	Dhanmondi	counsellor	14
1371	2024-09-21 15:58:10.881027	2024-09-21 15:58:10.881027	\N	4	remark : he did not pick my call	Dhanmondi	counsellor	14
1372	2024-09-21 15:58:10.922732	2024-09-21 15:58:10.922732	\N	5	Status changed from new to unreachable of lead 271 by Farzana	Dhanmondi	counsellor	14
1373	2024-09-21 15:58:42.716791	2024-09-21 15:58:42.716791	\N	4	remark : bad profile	Dhanmondi	counsellor	14
1374	2024-09-21 15:58:42.732524	2024-09-21 15:58:42.732524	\N	5	Status changed from new to not-interested of lead 270 by Farzana	Dhanmondi	counsellor	14
1375	2024-09-21 15:59:33.68361	2024-09-21 15:59:33.68361	\N	4	remark : bad	Dhanmondi	counsellor	14
1376	2024-09-21 15:59:33.696503	2024-09-21 15:59:33.696503	\N	5	Status changed from new to not-interested of lead 248 by Farzana	Dhanmondi	counsellor	14
1377	2024-09-21 15:59:43.368827	2024-09-21 15:59:43.368827	\N	4	remark : bad	Dhanmondi	counsellor	14
1378	2024-09-21 15:59:43.372532	2024-09-21 15:59:43.372532	\N	5	Status changed from new to not-interested of lead 247 by Farzana	Dhanmondi	counsellor	14
1379	2024-09-21 15:59:52.617748	2024-09-21 15:59:52.617748	\N	4	remark : bad	Dhanmondi	counsellor	14
1380	2024-09-21 15:59:52.620034	2024-09-21 15:59:52.620034	\N	5	Status changed from new to not-interested of lead 246 by Farzana	Dhanmondi	counsellor	14
1381	2024-09-21 16:00:02.572857	2024-09-21 16:00:02.572857	\N	4	remark : bad	Dhanmondi	counsellor	14
1382	2024-09-21 16:00:02.599107	2024-09-21 16:00:02.599107	\N	5	Status changed from new to not-interested of lead 245 by Farzana	Dhanmondi	counsellor	14
1383	2024-09-21 16:00:20.974671	2024-09-21 16:00:20.974671	\N	4	remark : call her tomorrow	Dhanmondi	counsellor	14
1384	2024-09-21 16:00:20.989517	2024-09-21 16:00:20.989517	\N	5	Status changed from new to first of lead 244 by Farzana	Dhanmondi	counsellor	14
1385	2024-09-21 16:00:58.424069	2024-09-21 16:00:58.424069	\N	4	remark : he did not pick my call	Dhanmondi	counsellor	14
1386	2024-09-21 16:00:58.437341	2024-09-21 16:00:58.437341	\N	5	Status changed from new to unreachable of lead 243 by Farzana	Dhanmondi	counsellor	14
1387	2024-09-21 16:01:05.768343	2024-09-21 16:01:05.768343	\N	4	remark : bad	Dhanmondi	counsellor	14
1388	2024-09-21 16:01:05.771487	2024-09-21 16:01:05.771487	\N	5	Status changed from new to not-interested of lead 242 by Farzana	Dhanmondi	counsellor	14
1389	2024-09-21 16:03:14.490899	2024-09-21 16:03:14.490899	\N	4	remark : phone off	Dhanmondi	counsellor	14
1390	2024-09-21 16:03:14.506081	2024-09-21 16:03:14.506081	\N	5	Status changed from new to unreachable of lead 241 by Farzana	Dhanmondi	counsellor	14
1391	2024-09-21 16:03:29.550847	2024-09-21 16:03:29.550847	\N	4	remark : no response	Dhanmondi	counsellor	14
1392	2024-09-21 16:03:29.565251	2024-09-21 16:03:29.565251	\N	5	Status changed from new to unreachable of lead 240 by Farzana	Dhanmondi	counsellor	14
1393	2024-09-21 16:04:21.296858	2024-09-21 16:04:21.296858	\N	4	remark : bad	Dhanmondi	counsellor	14
1394	2024-09-21 16:04:21.3139	2024-09-21 16:04:21.3139	\N	5	Status changed from new to not-interested of lead 239 by Farzana	Dhanmondi	counsellor	14
1395	2024-09-21 16:04:51.803411	2024-09-21 16:04:51.803411	\N	4	remark : no response	Dhanmondi	counsellor	14
1396	2024-09-21 16:04:51.815719	2024-09-21 16:04:51.815719	\N	5	Status changed from new to unreachable of lead 238 by Farzana	Dhanmondi	counsellor	14
1397	2024-09-21 16:05:05.549621	2024-09-21 16:05:05.549621	\N	4	remark : wrong number	Dhanmondi	counsellor	14
1398	2024-09-21 16:05:05.561013	2024-09-21 16:05:05.561013	\N	5	Status changed from new to unreachable of lead 237 by Farzana	Dhanmondi	counsellor	14
1399	2024-09-21 16:05:55.724648	2024-09-21 16:05:55.724648	\N	4	remark : waiting for result	Dhanmondi	counsellor	14
1400	2024-09-21 16:05:55.740063	2024-09-21 16:05:55.740063	\N	5	Status changed from new to future-interest of lead 236 by Farzana	Dhanmondi	counsellor	14
1401	2024-09-21 16:06:11.493253	2024-09-21 16:06:11.493253	\N	4	remark : waiting for result	Dhanmondi	counsellor	14
1402	2024-09-21 16:06:11.506474	2024-09-21 16:06:11.506474	\N	5	Status changed from new to future-interest of lead 235 by Farzana	Dhanmondi	counsellor	14
1403	2024-09-21 16:06:41.642934	2024-09-21 16:06:41.642934	\N	4	remark : bad	Dhanmondi	counsellor	14
1404	2024-09-21 16:06:41.654919	2024-09-21 16:06:41.654919	\N	5	Status changed from new to not-interested of lead 234 by Farzana	Dhanmondi	counsellor	14
1405	2024-09-21 16:06:52.836234	2024-09-21 16:06:52.836234	\N	4	remark : no response	Dhanmondi	counsellor	14
1406	2024-09-21 16:06:52.850755	2024-09-21 16:06:52.850755	\N	5	Status changed from new to unreachable of lead 233 by Farzana	Dhanmondi	counsellor	14
1407	2024-09-21 16:07:49.525297	2024-09-21 16:07:49.525297	\N	4	remark : preparing for ielts	Dhanmondi	counsellor	14
1408	2024-09-21 16:07:49.539576	2024-09-21 16:07:49.539576	\N	5	Status changed from new to first of lead 232 by Farzana	Dhanmondi	counsellor	14
1409	2024-09-21 16:08:01.117966	2024-09-21 16:08:01.117966	\N	4	remark : no number	Dhanmondi	counsellor	14
1410	2024-09-21 16:08:01.130065	2024-09-21 16:08:01.130065	\N	5	Status changed from new to unreachable of lead 231 by Farzana	Dhanmondi	counsellor	14
1411	2024-09-21 16:08:23.023914	2024-09-21 16:08:23.023914	\N	4	remark : no response	Dhanmondi	counsellor	14
1412	2024-09-21 16:08:23.037508	2024-09-21 16:08:23.037508	\N	5	Status changed from new to unreachable of lead 230 by Farzana	Dhanmondi	counsellor	14
1413	2024-09-21 16:13:09.226518	2024-09-21 16:13:09.226518	\N	4	remark : interested	Dhanmondi	counsellor	14
1414	2024-09-21 16:13:09.239697	2024-09-21 16:13:09.239697	\N	5	Status changed from new to first of lead 208 by Farzana	Dhanmondi	counsellor	14
1415	2024-09-21 16:13:19.865883	2024-09-21 16:13:19.865883	\N	4	remark : interested	Dhanmondi	counsellor	14
1416	2024-09-21 16:13:19.881684	2024-09-21 16:13:19.881684	\N	5	Status changed from new to first of lead 207 by Farzana	Dhanmondi	counsellor	14
1417	2024-09-21 16:13:58.345535	2024-09-21 16:13:58.345535	\N	4	remark : phone off	Dhanmondi	counsellor	14
1418	2024-09-21 16:13:58.357305	2024-09-21 16:13:58.357305	\N	5	Status changed from new to unreachable of lead 206 by Farzana	Dhanmondi	counsellor	14
1419	2024-09-21 16:14:13.336504	2024-09-21 16:14:13.336504	\N	4	remark : interested	Dhanmondi	counsellor	14
1420	2024-09-21 16:14:13.352121	2024-09-21 16:14:13.352121	\N	5	Status changed from new to first of lead 205 by Farzana	Dhanmondi	counsellor	14
1467	2024-09-21 17:50:53.892867	2024-09-21 17:50:53.892867	\N	4	remark : Lead 303 updated by Jarin	Dhanmondi	counsellor	13
1503	2024-09-21 18:45:18.003899	2024-09-21 18:45:18.003899	\N	4	remark : Busy	Dhanmondi	counsellor	13
1504	2024-09-21 18:45:18.016997	2024-09-21 18:45:18.016997	\N	5	Status changed from new to first of lead 212 by Jarin	Dhanmondi	counsellor	13
1543	2024-09-22 05:26:27.599911	2024-09-22 05:26:27.599911	\N	4	remark : No Answer	Dhanmondi	counsellor	13
1544	2024-09-22 05:26:27.613567	2024-09-22 05:26:27.613567	\N	5	Status changed from new to unreachable of lead 292 by Jarin	Dhanmondi	counsellor	13
1592	2024-09-22 05:53:05.186189	2024-09-22 05:53:05.186189	\N	4	remark : Not Interested	Dhanmondi	counsellor	13
1631	2024-09-22 06:16:53.589987	2024-09-22 06:16:53.589987	\N	4	remark : Lead 310 updated by Naf	Dhanmondi	admin	1
1634	2024-09-22 06:16:53.715981	2024-09-22 06:16:53.715981	\N	4	remark : Lead 308 updated by Naf	Dhanmondi	admin	1
1670	2024-09-23 11:04:57.247909	2024-09-23 11:04:57.247909	\N	1	Logged in	Dhanmondi	admin	1
1701	2024-09-25 06:37:37.697427	2024-09-25 06:37:37.697427	\N	4	remark : Lead 322 updated by Farzana	Dhanmondi	counsellor	14
1702	2024-09-25 06:37:37.715889	2024-09-25 06:37:37.715889	\N	5	Status changed from exam to course-new of lead 322 by Farzana	Dhanmondi	counsellor	14
1731	2024-09-28 06:35:12.135674	2024-09-28 06:35:12.135674	\N	4	remark : Lead 354 updated by Jarin	Dhanmondi	counsellor	13
1753	2024-10-09 18:07:27.165685	2024-10-09 18:07:27.165685	\N	1	Logged in	Dhanmondi	admin	1
1798	2024-11-24 06:21:22.173546	2024-11-24 06:21:22.173546	\N	4	remark : Lead 317 updated by Farzana	Dhanmondi	counsellor	14
1799	2024-11-24 06:21:22.191205	2024-11-24 06:21:22.191205	\N	5	Status changed from appointment-book to course-new of lead 317 by Farzana	Dhanmondi	counsellor	14
2032	2024-11-25 10:33:06.680119	2024-11-25 10:33:06.680119	\N	1	Logged in	Dhanmondi	counsellor	13
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application (id, created_at, updated_at, deleted_at, course_label, application_status, intake_year, intake_month, course_details, "universityId", "leadId") FROM stdin;
4	2024-09-26 15:29:52.84607	2024-09-26 15:29:53.006514	\N	Masters	pending	2024	September	MRes on public health	135	345
\.


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (id, created_at, updated_at, deleted_at, details, branch) FROM stdin;
5	2024-09-13 19:40:09.958118	2024-09-13 19:44:55.648527	\N	Bangladesh	Dhanmondi
6	2024-09-13 19:43:59.131872	2024-09-13 19:45:07.184013	\N	United Kingdom	London
7	2024-09-13 19:45:35.672516	2024-09-13 19:45:35.672516	\N	Pakistan 	Lahore 
8	2024-09-13 19:45:56.753072	2024-09-13 19:45:56.753072	\N	Albania 	Tirana
9	2024-09-13 19:46:17.438671	2024-09-13 19:46:17.438671	\N	Nigeria 	Lagos 
\.


--
-- Data for Name: cats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cats (id, created_at, updated_at, deleted_at, parent, label, value) FROM stdin;
\.


--
-- Data for Name: coachingclass; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coachingclass (id, created_at, updated_at, deleted_at, name, c_type, class_date, is_present, "leadId") FROM stdin;
\.


--
-- Data for Name: kpi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kpi (id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead (id, created_at, updated_at, deleted_at, fullname, email, phone_no, country, application_country, state, address_details, branch_name, previous_educations, last_education, english_proficiency, english_proficiency_result, purpose, stage, sub_stage, source, has_account, classes, exams, last_remark, "assignedId", interested_country) FROM stdin;
335	2024-09-14 18:37:47.505625	2024-11-24 13:44:57.96744	2024-11-24 13:44:57.96744	Arfin Islam	rashelarfin@gmail.com	1817123328	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	5th times i called him	14	\N
366	2024-11-24 13:09:47.014407	2024-11-24 13:44:57.704631	2024-11-24 13:44:57.704631	11/01/2024 7:31am	Raihan Kabir	mdraihankabir51@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
377	2024-11-24 13:09:47.040612	2024-11-24 13:42:10.664102	2024-11-24 13:42:10.664102	11/01/2024 3:09am	Md. Anisuzzaman	mazzaman9000@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
370	2024-11-24 13:09:47.019404	2024-11-24 13:44:57.622167	2024-11-24 13:44:57.622167	11/01/2024 6:47am	Razaul Karim Razu, assist Manager	RazaulKarim@gmil.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
381	2024-11-24 13:09:47.051137	2024-11-24 13:42:10.648415	2024-11-24 13:42:10.648415	11/01/2024 2:26am	Ishfad Robin	ishfadrobin@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
389	2024-11-24 13:09:47.06505	2024-11-24 13:42:10.538938	2024-11-24 13:42:10.538938	10/31/2024 10:50pm	JA HI D	jahidariyan653@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
397	2024-11-24 13:09:47.085456	2024-11-24 13:42:10.472165	2024-11-24 13:42:10.472165	10/31/2024 2:07pm	Tilak Barua	tilakbarua2006@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
275	2024-09-14 18:37:47.019615	2024-11-24 13:44:58.921685	2024-11-24 13:44:58.921685	Tareque Bin Atique	tarequebinatique@gmail.com	1715124275	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	He wants PHD, has some research paper and preparing for ielts	14	\N
231	2024-09-14 18:37:46.657187	2024-11-24 13:46:43.690137	2024-11-24 13:46:43.690137	Md Sharia	shariamdsharia5@gmail.com	2580	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no number	14	\N
391	2024-11-24 13:09:47.06941	2024-11-24 13:42:10.53537	2024-11-24 13:42:10.53537	10/31/2024 10:16pm	Md Ashikur Rahman Raju	ashikur3857@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
332	2024-09-14 18:37:47.484604	2024-11-24 13:44:58.067366	2024-11-24 13:44:58.067366	Cawsar Hossan	cawsarhossan@gmail.com	1603822913	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	nonsense	14	\N
401	2024-11-24 13:09:47.0907	2024-11-24 13:42:10.418611	2024-11-24 13:42:10.418611	10/31/2024 12:27pm	Abdullah Al Muhit	a.almuhit11@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
409	2024-11-24 13:09:47.09883	2024-11-24 13:42:10.357736	2024-11-24 13:42:10.357736	10/31/2024 10:19am	Rejawnul Hoque	ronymd7809@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
419	2024-11-24 13:09:47.109455	2024-11-24 13:42:10.247517	2024-11-24 13:42:10.247517	10/31/2024 4:26am	Shah Alam Shadin	ronykhi1995@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
424	2024-11-24 13:09:47.114287	2024-11-24 13:42:10.172731	2024-11-24 13:42:10.172731	10/31/2024 1:38am	عبير حسين	arunnuraj143@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
300	2024-09-14 18:37:47.22639	2024-11-24 13:44:58.573985	2024-11-24 13:44:58.573985	Nayeem Hossain	nayeem78785@gmail.com	1913425045	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	potential	appointment-book	internal	f	\N	\N	interested	13	\N
441	2024-11-24 13:09:47.130524	2024-11-24 13:42:10.047645	2024-11-24 13:42:10.047645	10/30/2024 11:48am	Best-life Best-life	jm4251097@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
434	2024-11-24 13:09:47.122259	2024-11-24 13:42:10.111335	2024-11-24 13:42:10.111335	10/30/2024 8:04pm	Ariful Islam	arifshovon44@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
442	2024-11-24 13:09:47.131933	2024-11-24 13:42:10.02689	2024-11-24 13:42:10.02689	11/01/2024 9:51am	RK Rakib	rh406331@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
454	2024-11-24 13:09:47.148709	2024-11-24 13:42:09.914487	2024-11-24 13:42:09.914487	10/30/2024 10:09am	Yeash Mahi	yeashmahi658@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
460	2024-11-24 13:09:47.157824	2024-11-24 13:42:09.847348	2024-11-24 13:42:09.847348	10/30/2024 9:18am	জুয়েল রানা	mdjuewlrana111@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
463	2024-11-24 13:09:47.161776	2024-11-24 13:42:09.802784	2024-11-24 13:42:09.802784	10/30/2024 7:24am	B B Somrat Babor	crp9096@gimail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
470	2024-11-24 13:09:47.175987	2024-11-24 13:42:09.717737	2024-11-24 13:42:09.717737	10/30/2024 8:49am	MRK Masum ッ	mrkmasumkhan240@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
477	2024-11-24 13:09:47.180379	2024-11-24 13:41:43.442058	2024-11-24 13:41:43.442058	10/30/2024 3:44am	Shoyeb Hasan Rudro	khanrodro820@gmail.con	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
469	2024-11-24 13:09:47.171957	2024-11-24 13:42:09.741232	2024-11-24 13:42:09.741232	10/30/2024 7:58am	Md Ashik Mean	ashik.mean007@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
480	2024-11-24 13:09:47.18426	2024-11-24 13:41:43.420561	2024-11-24 13:41:43.420561	10/30/2024 2:39am	Md Ajmir	azmir5664@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
487	2024-11-24 13:09:47.192913	2024-11-24 13:41:43.339891	2024-11-24 13:41:43.339891	10/29/2024 4:59pm	Sayed Ahmed	ha5750779@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
488	2024-11-24 13:09:47.197414	2024-11-24 13:41:43.330813	2024-11-24 13:41:43.330813	10/29/2024 2:25pm	Nahid Hasan Bhuiyan	nahidhasanbhuiyan4@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
496	2024-11-24 13:09:47.207451	2024-11-24 13:41:43.262246	2024-11-24 13:41:43.262246	10/29/2024 8:44am	Jakir Islam	labonijakirislam31@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
497	2024-11-24 13:09:47.217148	2024-11-24 13:41:43.233267	2024-11-24 13:41:43.233267	10/29/2024 7:03am	Ziarul Islam	ziarulkhan246@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
504	2024-11-24 13:09:47.227975	2024-11-24 13:41:43.167352	2024-11-24 13:41:43.167352	10/29/2024 11:56am	Sagar Sen	sagersen2156@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
354	2024-09-28 06:35:08.743101	2024-11-24 13:44:57.815212	2024-11-24 13:44:57.815212	Md .Rafiqul Islam	mdrafiqulislam1211@gmail.com	+8801734053929	Bangladesh	\N	Dhaka District	Manikgang	Dhanmondi	\N	\N	\N	\N	study-abroad	potential	waiting-for-document	internal	f	\N	\N	He will send documents	13	\N
356	2024-11-24 13:09:47.002822	2024-11-24 13:44:57.780557	2024-11-24 13:44:57.780557	11/01/2024 11:31am	টাকার বিনিময়ে সেক্স করি	mdnirobkhan782282@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
361	2024-11-24 13:09:47.003657	2024-11-24 13:44:57.765183	2024-11-24 13:44:57.765183	11/01/2024 8:35am	Mohammad Ashraful	ashrafulm621@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
371	2024-11-24 13:09:47.021347	2024-11-24 13:44:57.606351	2024-11-24 13:44:57.606351	11/01/2024 6:29am	Mohammad Foisal	mohammadfoisal183@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
276	2024-09-14 18:37:47.028387	2024-11-24 13:44:58.927018	2024-11-24 13:44:58.927018	MD Sorker Rakib	ahnafrakib1212@gmail.com	1838353284	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	mistake	14	\N
268	2024-09-14 18:37:46.958109	2024-11-24 13:44:59.033538	2024-11-24 13:44:59.033538	Chameli Akter	aktersweety93@gmail.com	+8801719878704	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	No answer	13	\N
219	2024-09-14 18:37:46.554444	2024-11-24 13:46:43.892767	2024-11-24 13:46:43.892767	Md Naim Howlader	naimkhan01757@gmail.com	1757728095	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	BUSY	13	\N
337	2024-09-14 18:37:47.519533	2024-11-24 13:44:57.965222	2024-11-24 13:44:57.965222	Riya	19203099@uap-bd.edu	+8801768441614	Bangladesh	\N	Dhaka District	dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Farzana	14	\N
368	2024-11-24 13:09:47.01805	2024-11-24 13:44:57.625372	2024-11-24 13:44:57.625372	11/01/2024 6:53am	Muktar Hossion	hossionmuktar@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
379	2024-11-24 13:09:47.050281	2024-11-24 13:42:10.658892	2024-11-24 13:42:10.658892	11/01/2024 3:05am	MD.Shahalam	sarakib03@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
376	2024-11-24 13:09:47.03529	2024-11-24 13:42:10.666564	2024-11-24 13:42:10.666564	11/01/2024 4:19am	Sazal Hossain	sazal2804hossain@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
384	2024-11-24 13:09:47.058764	2024-11-24 13:42:10.594303	2024-11-24 13:42:10.594303	11/01/2024 1:14am	MD Rimon Biswas	rimonsingrayhan@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
393	2024-11-24 13:09:47.079179	2024-11-24 13:42:10.492962	2024-11-24 13:42:10.492962	10/31/2024 7:20pm	HM Siam Ul Islam	hmsiamulislam@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
387	2024-11-24 13:09:47.064455	2024-11-24 13:42:10.588124	2024-11-24 13:42:10.588124	10/31/2024 11:41pm	Rahman Saymon	mdsaymon200300@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
403	2024-11-24 13:09:47.094083	2024-11-24 13:42:10.415261	2024-11-24 13:42:10.415261	10/31/2024 11:53am	R M Mahadi	mahadihasan5247@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
395	2024-11-24 13:09:47.084968	2024-11-24 13:42:10.474914	2024-11-24 13:42:10.474914	10/31/2024 5:57pm	mst:hasna akter dilruba	mdarifulislam232500@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
418	2024-11-24 13:09:47.105557	2024-11-24 13:42:10.296739	2024-11-24 13:42:10.296739	10/31/2024 8:03am	Chondon Murmu	chondonmurmu@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
406	2024-11-24 13:09:47.097026	2024-11-24 13:42:10.369278	2024-11-24 13:42:10.369278	10/31/2024 10:42am	Amanullah Aman	amanullah29802@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
416	2024-11-24 13:09:47.106632	2024-11-24 13:42:10.294514	2024-11-24 13:42:10.294514	10/31/2024 5:22am	D K Shobuj BatBoy	roxshobuj12@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
427	2024-11-24 13:09:47.117008	2024-11-24 13:42:10.181655	2024-11-24 13:42:10.181655	10/30/2024 11:43pm	Msmoju Rahaman	mojurahaman9@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
431	2024-11-24 13:09:47.12097	2024-11-24 13:42:10.120182	2024-11-24 13:42:10.120182	11/01/2024 10:01am	Abul Kalam	makalam1988@yahoo.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
436	2024-11-24 13:09:47.126518	2024-11-24 13:42:10.079741	2024-11-24 13:42:10.079741	10/30/2024 4:25pm	Rafid Adrive	adrivehprodhan2019@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
443	2024-11-24 13:09:47.131984	2024-11-24 13:42:10.013961	2024-11-24 13:42:10.013961	10/30/2024 11:00am	Tapon Chakraborty	simsrinikachakroborty@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
446	2024-11-24 13:09:47.135041	2024-11-24 13:42:09.990204	2024-11-24 13:42:09.990204	10/30/2024 11:12am	Mohammad Khan	mohammedazamkhan672@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
453	2024-11-24 13:09:47.147831	2024-11-24 13:42:09.923907	2024-11-24 13:42:09.923907	10/30/2024 10:15am	MD Munna Mostakin	mostakinmdmunna@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
457	2024-11-24 13:09:47.15365	2024-11-24 13:42:09.873089	2024-11-24 13:42:09.873089	10/30/2024 10:00am	maisha nusrat	kashemhaque1968@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
466	2024-11-24 13:09:47.169112	2024-11-24 13:42:09.77886	2024-11-24 13:42:09.77886	10/30/2024 7:45am	Md. Samiul Islam	rafiq2617@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
479	2024-11-24 13:09:47.182305	2024-11-24 13:41:43.427426	2024-11-24 13:41:43.427426	10/30/2024 2:40am	Premio Rano	chrpremio@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
471	2024-11-24 13:09:47.176659	2024-11-24 13:42:09.715123	2024-11-24 13:42:09.715123	10/30/2024 6:54am	Samira Haque	haquesamira733@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
489	2024-11-24 13:09:47.197709	2024-11-24 13:41:43.319551	2024-11-24 13:41:43.319551	10/29/2024 1:33pm	HaBib Al BashAr	habibalbashar1@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
481	2024-11-24 13:09:47.184465	2024-11-24 13:41:43.395703	2024-11-24 13:41:43.395703	10/30/2024 1:25am	Akmol Hossain	Akmolhossin1957@gamil.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
493	2024-11-24 13:09:47.204107	2024-11-24 13:41:43.283348	2024-11-24 13:41:43.283348	10/29/2024 12:28pm	Shimu Rahman	sashimaakter2021@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
506	2024-11-24 13:09:47.229974	2024-11-24 13:41:43.154656	2024-11-24 13:41:43.154656	10/29/2024 3:04am	Monir Hossain	monirdu90@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
498	2024-11-24 13:09:47.21822	2024-11-24 13:41:43.226178	2024-11-24 13:41:43.226178	10/29/2024 5:29am	Gazi Shakibul Hasan	shakibulh175@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
508	2024-11-24 13:09:47.233617	2024-11-24 13:41:43.143972	2024-11-24 13:41:43.143972	10/29/2024 2:53am	Zabir Mahmud Usaid	nusratjabir@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
320	2024-09-14 18:37:47.395669	2024-11-24 13:44:58.253051	2024-11-24 13:44:58.253051	Shojol Ahmed Faisal	faisal43026@gmail.com	1944123378	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	mistake	14	\N
297	2024-09-14 18:37:47.203623	2024-11-24 13:44:58.581501	2024-11-24 13:44:58.581501	𝐌𝐔𝐌𝐓𝐀𝐇𝐈𝐍𝐀	mumtahina358@gmail.com	+8801304763871	Bangladesh	\N	Dhaka District	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	Lead updated by Jarin	13	\N
257	2024-09-14 18:37:46.859729	2024-11-24 13:46:43.211978	2024-11-24 13:46:43.211978	Sãgør Khäñ	kssagor054@gmail.com	+880308936753	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
206	2024-09-14 18:37:46.440428	2024-11-24 13:46:44.101985	2024-11-24 13:46:44.101985	Rony Md Rony Sardar	mdronysardar1600@gmail.com	1787418945	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone off	14	\N
329	2024-09-14 18:37:47.46227	2024-11-24 13:44:58.084789	2024-11-24 13:44:58.084789	MD Emran Khan	imrankhankhan3300769@gmail.com	1775051124	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	unqualified and non-sense 	14	\N
355	2024-09-30 06:09:54.742653	2024-11-24 13:44:57.812214	2024-11-24 13:44:57.812214	Rokaiya	rokaiyamohammodi@gmail.com	+8801743078033	Bangladesh	\N	\N	Cumilla	Dhanmondi	[{"name":"Ispahani public school and college","year":"2023","result":"4.92"}]	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	Lead updated by Jarin	13	\N
369	2024-11-24 13:09:47.021939	2024-11-24 13:44:57.616794	2024-11-24 13:44:57.616794	11/01/2024 6:04am	Jannatul Raima	jannatulferdaws11838561@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
380	2024-11-24 13:09:47.050447	2024-11-24 13:42:10.652212	2024-11-24 13:42:10.652212	11/01/2024 2:32am	imran shykot	imransam932@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
362	2024-11-24 13:09:47.004023	2024-11-24 13:44:57.705011	2024-11-24 13:44:57.705011	11/01/2024 8:34am	রেঁজুঁওঁয়াঁনাঁ ফেঁরঁদাঁউঁসঁ তঁন্নিঁ	tonnirejuwanaferdaush@gmali.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
388	2024-11-24 13:09:47.064816	2024-11-24 13:42:10.548305	2024-11-24 13:42:10.548305	10/31/2024 11:00pm	Md Suruj Jaman	surujjaman016@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
383	2024-11-24 13:09:47.058264	2024-11-24 13:42:10.597859	2024-11-24 13:42:10.597859	11/01/2024 1:32am	MD Shamim Mia	182125.mgt@student.just.edu.bd	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
396	2024-11-24 13:09:47.08524	2024-11-24 13:42:10.477291	2024-11-24 13:42:10.477291	10/31/2024 4:45pm	Abdullah Al Imran	alimran420562@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
392	2024-11-24 13:09:47.077604	2024-11-24 13:42:10.531989	2024-11-24 13:42:10.531989	10/31/2024 8:52pm	Saiful Islam	seepfid@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
405	2024-11-24 13:09:47.095764	2024-11-24 13:42:10.412778	2024-11-24 13:42:10.412778	10/31/2024 10:58am	Nilimaa Jhuuma	tradernilu6@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
400	2024-11-24 13:09:47.089087	2024-11-24 13:42:10.420732	2024-11-24 13:42:10.420732	10/31/2024 12:37pm	Safiqul Islam	ishofik021@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
408	2024-11-24 13:09:47.09779	2024-11-24 13:42:10.363468	2024-11-24 13:42:10.363468	10/31/2024 10:21am	Foysal Ahmmed	foysalahmmed9900@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
414	2024-11-24 13:09:47.105495	2024-11-24 13:42:10.307859	2024-11-24 13:42:10.307859	10/31/2024 6:57am	Md Rabb I	mjan88562@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
415	2024-11-24 13:09:47.106171	2024-11-24 13:42:10.297122	2024-11-24 13:42:10.297122	10/31/2024 6:00am	Md Mahbubur Rahman	rafimahbub.kuet@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
422	2024-11-24 13:09:47.112969	2024-11-24 13:42:10.235832	2024-11-24 13:42:10.235832	10/31/2024 2:00am	Md. Anis Ahmmed	anispolychem@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
423	2024-11-24 13:09:47.113562	2024-11-24 13:42:10.186301	2024-11-24 13:42:10.186301	10/31/2024 1:54am	Suhel Ahmed	md7833035@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
432	2024-11-24 13:09:47.121252	2024-11-24 13:42:10.118616	2024-11-24 13:42:10.118616	10/30/2024 8:55pm	Biplabi Roy	biplabiroy22@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
433	2024-11-24 13:09:47.122094	2024-11-24 13:42:10.116356	2024-11-24 13:42:10.116356	10/30/2024 7:53pm	Shahed Biswas	bsajim122@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
439	2024-11-24 13:09:47.129543	2024-11-24 13:42:10.052046	2024-11-24 13:42:10.052046	10/30/2024 4:10pm	Jan Nat	amirkoli143@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
440	2024-11-24 13:09:47.130311	2024-11-24 13:42:10.047776	2024-11-24 13:42:10.047776	10/30/2024 1:04pm	ahmedshibliforkan	forkanshibli200@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
449	2024-11-24 13:09:47.141302	2024-11-24 13:42:09.963064	2024-11-24 13:42:09.963064	10/30/2024 10:28am	Prince Jumon Musha	officialmusha263@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
459	2024-11-24 13:09:47.157623	2024-11-24 13:42:09.850278	2024-11-24 13:42:09.850278	10/30/2024 10:15am	রাকিবুল হাসান সাদ	mdrakibulhasan1819@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
450	2024-11-24 13:09:47.14261	2024-11-24 13:42:09.934549	2024-11-24 13:42:09.934549	10/30/2024 10:20am	Md Sangit mia	sangitmiah@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
458	2024-11-24 13:09:47.1567	2024-11-24 13:42:09.837772	2024-11-24 13:42:09.837772	10/30/2024 10:18am	Ahim Uddin	ahimuddin@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
467	2024-11-24 13:09:47.169974	2024-11-24 13:42:09.772407	2024-11-24 13:42:09.772407	10/30/2024 8:40am	Ismail Hossain	ismailhossainvlogsbd@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
468	2024-11-24 13:09:47.171447	2024-11-24 13:42:09.739364	2024-11-24 13:42:09.739364	10/30/2024 8:24am	Md Nasim Hasan	nasimhasan992@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
476	2024-11-24 13:09:47.180131	2024-11-24 13:41:43.455355	2024-11-24 13:41:43.455355	10/30/2024 4:46am	MD.Rajib Hossain	rajibulhasanjoy@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
485	2024-11-24 13:09:47.19141	2024-11-24 13:41:43.361035	2024-11-24 13:41:43.361035	11/01/2024 10:04am	Md Shakowat Ahamed	mdsakowatislam959@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
494	2024-11-24 13:09:47.20451	2024-11-24 13:41:43.278089	2024-11-24 13:41:43.278089	10/30/2024 12:02am	Khan Arosh	muktamonibd2000@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
475	2024-11-24 13:09:47.179391	2024-11-24 13:41:43.457115	2024-11-24 13:41:43.457115	10/30/2024 5:06am	Md Yakub Mollah	mdyakubmollah2@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
251	2024-09-14 18:37:46.817878	2024-11-24 13:46:43.28072	2024-11-24 13:46:43.28072	Rizuyan Shifat	shifatrizuyan@gmail.com	1629018489	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	No	13	\N
204	2024-09-14 18:37:46.415329	2024-11-24 13:46:44.101622	2024-11-24 13:46:44.101622	MD Ak Ashikur	mdakashikur@gmail.com	1610719445	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	call him tomorrow	14	\N
461	2024-11-24 13:09:47.159541	2024-11-24 13:42:09.835542	2024-11-24 13:42:09.835542	10/30/2024 9:02am	Prince Shareiya	jaraqueen124@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
448	2024-11-24 13:09:47.140699	2024-11-24 13:42:09.973632	2024-11-24 13:42:09.973632	10/30/2024 10:47am	Mohsin Rajj	mdmohsinrajj3@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
438	2024-11-24 13:09:47.129278	2024-11-24 13:42:10.052925	2024-11-24 13:42:10.052925	11/01/2024 11:18am	Humaira Anjumi Maisha	maishahumaira45@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
429	2024-11-24 13:09:47.119631	2024-11-24 13:42:10.173147	2024-11-24 13:42:10.173147	10/30/2024 10:22pm	Prinec Rasel	mm3900736@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
425	2024-11-24 13:09:47.112531	2024-11-24 13:42:10.239	2024-11-24 13:42:10.239	10/31/2024 2:43am	bilkis akter	msabbirmia934@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
411	2024-11-24 13:09:47.100151	2024-11-24 13:42:10.35019	2024-11-24 13:42:10.35019	10/31/2024 9:36am	Ziauddin	gmziauddin1992@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
399	2024-11-24 13:09:47.086447	2024-11-24 13:42:10.468723	2024-11-24 13:42:10.468723	10/31/2024 1:41pm	Sholok Mia	sholokmia@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
385	2024-11-24 13:09:47.061426	2024-11-24 13:42:10.590331	2024-11-24 13:42:10.590331	11/01/2024 12:38am	Jannatun Nayma	jannatunnayma9@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
374	2024-11-24 13:09:47.022543	2024-11-24 13:44:57.57718	2024-11-24 13:44:57.57718	11/01/2024 5:39am	Shamim Mahmud	shamimmahmud101@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
574	2024-11-24 13:09:47.320797	2024-11-24 13:41:42.511545	2024-11-24 13:41:42.511545	10/25/2024 9:08pm	Ali Ajgar	md.aliajgar1989@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
562	2024-11-24 13:09:47.309331	2024-11-24 13:41:42.56569	2024-11-24 13:41:42.56569	10/26/2024 9:02am	Khairul Islam  Raju	khairulislamraju77@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
551	2024-11-24 13:09:47.295755	2024-11-24 13:41:42.646827	2024-11-24 13:41:42.646827	10/27/2024 5:27am	Roni Ahmed	roniahmed98856@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
537	2024-11-24 13:09:47.272297	2024-11-24 13:41:42.84098	2024-11-24 13:41:42.84098	10/28/2024 12:34pm	Md Jahid Rasul Adib	mdjahidrasuladib@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
524	2024-11-24 13:09:47.257306	2024-11-24 13:41:42.971759	2024-11-24 13:41:42.971759	10/28/2024 11:27pm	Abdul malek shekh	mdrana775202@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
514	2024-11-24 13:09:47.244936	2024-11-24 13:41:43.083507	2024-11-24 13:41:43.083507	10/29/2024 2:12am	MD RayHan Uddin	rayhanuddin0120@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
500	2024-11-24 13:09:47.213058	2024-11-24 13:41:43.255963	2024-11-24 13:41:43.255963	10/29/2024 7:41am	Sarder MD Mehedi Hasan	mehedihasan01827@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
484	2024-11-24 13:09:47.190806	2024-11-24 13:41:43.374468	2024-11-24 13:41:43.374468	10/29/2024 11:39pm	Mohammad Jahid Sheikh	mj4148490@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
474	2024-11-24 13:09:47.179137	2024-11-24 13:41:43.48242	2024-11-24 13:41:43.48242	10/30/2024 5:44am	MD Shofikul Islam	shofialom.bd1994@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
360	2024-11-24 13:09:47.003399	2024-11-24 13:44:57.75934	2024-11-24 13:44:57.75934	11/01/2024 8:46am	Md Lingkon	aghqqhh@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
312	2024-09-14 18:37:47.323934	2024-11-24 13:44:58.326478	2024-11-24 13:44:58.326478	Md Jahid Rasul Adib	mdjahidrasuladib@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Number missing	13	\N
311	2024-09-14 18:37:47.315631	2024-11-24 13:44:58.343772	2024-11-24 13:44:58.343772	Al Shahriar	alshahriar.as@gmail.com	1606496640	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	He wants to go europe ,Japan or south korea	13	\N
310	2024-09-14 18:37:47.307468	2024-11-24 13:44:58.365072	2024-11-24 13:44:58.365072	Quazi Ferdous Sadakat	quazisadakat18@gmail.com	1780167124	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
246	2024-09-14 18:37:46.780007	2024-11-24 13:46:43.388633	2024-11-24 13:46:43.388633	Mohammed Ayas	muhammadayazali890@gmail.com	1405446100	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
208	2024-09-14 18:37:46.469745	2024-11-24 13:46:44.103574	2024-11-24 13:46:44.103574	তরিকুল ইসলাম মামুন	mdmamunpon@gmail.com	1755366106	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	interested	14	\N
189	2024-09-14 18:37:46.288882	2024-11-24 13:46:44.398541	2024-11-24 13:46:44.398541	তৃপ্তি বাভো	brashcarolyne0@hotmail.com	md aminul	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad bad	14	\N
410	2024-11-24 13:09:47.099165	2024-11-24 13:42:10.355906	2024-11-24 13:42:10.355906	10/31/2024 10:01am	Ecb Ariyan Rizvi	ecbariyanrizvi@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
402	2024-11-24 13:09:47.088741	2024-11-24 13:42:10.436462	2024-11-24 13:42:10.436462	10/31/2024 12:37pm	Junayed Khan	junayedmiah603@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
386	2024-11-24 13:09:47.0584	2024-11-24 13:42:10.597504	2024-11-24 13:42:10.597504	11/01/2024 1:37am	MA ABDUL MOMEN	Amomen997@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
373	2024-11-24 13:09:47.026375	2024-11-24 13:42:10.716544	2024-11-24 13:42:10.716544	11/01/2024 4:58am	MA KS UD	maksudbd397@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
364	2024-11-24 13:09:47.004613	2024-11-24 13:44:57.700006	2024-11-24 13:44:57.700006	11/01/2024 8:33am	Arafat Ahamed Sikder	moshinsikder0@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
345	2024-09-26 14:20:05.556804	2024-11-24 13:44:57.819604	2024-11-24 13:44:57.819604	Shuvarthy Barua	drshuvarthybarua@gmail.com	+8801741965998	Bangladesh	\N	Dhaka Division	Mirpur-13, BSL Residential Complex Bakul-102, Dhaka (Bangladesh)	Dhanmondi	[{"name":"Secondary School Certificate","result":"5.00","year":"2009"},{"name":"Higher Secondary Certificate","result":"5.00","year":"2011"}]	{"degree":"Bachelor of Medicine Surgery ","institute":"Shahid Ziaur Rahman Medical","country":"Bangladesh","year":"2017","result":"pass","month":"November"}	IELTS	{"overall": 7, "reading": 7, "writing": 7, "speaking": 7, "listening": 7}	study-abroad	admission	start-application	internal	t	\N	\N	already all documents have been send to the application team	11	\N
342	2024-09-22 06:15:26.629146	2024-11-24 13:44:57.830853	2024-11-24 13:44:57.830853	Saiful Islam Bappy	bappyislam123@gmail.com	+8801751825741	Bangladesh	\N	\N	dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	He wants to go Malta	13	\N
333	2024-09-14 18:37:47.49132	2024-11-24 13:44:58.076079	2024-11-24 13:44:58.076079	MD Obaidul Islam	mdobydulhaque3677@gmail.com	1903235239	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	mistake	14	\N
520	2024-11-24 13:09:47.255592	2024-11-24 13:41:43.020683	2024-11-24 13:41:43.020683	10/29/2024 12:37am	Nur Islam	rm6143184@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
509	2024-11-24 13:09:47.234297	2024-11-24 13:41:43.143593	2024-11-24 13:41:43.143593	10/29/2024 2:52am	Maimuna Naina	maimunanainadot@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
499	2024-11-24 13:09:47.220151	2024-11-24 13:41:43.210141	2024-11-24 13:41:43.210141	10/29/2024 5:25am	Arif Ullah	arifmojumdar27@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
490	2024-11-24 13:09:47.199114	2024-11-24 13:41:43.319952	2024-11-24 13:41:43.319952	10/29/2024 1:25pm	Rakibul Hasan	rh73126175@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
567	2024-11-24 13:09:47.314819	2024-11-24 13:41:42.431922	2024-11-24 13:41:42.431922	10/26/2024 1:30am	Md Zihad Al Adil	mdzihadprodhan85@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
558	2024-11-24 13:09:47.305021	2024-11-24 13:41:42.582777	2024-11-24 13:41:42.582777	10/26/2024 7:32pm	MD Shuwaif	mdshuwaif2@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
548	2024-11-24 13:09:47.294507	2024-11-24 13:41:42.71717	2024-11-24 13:41:42.71717	10/27/2024 7:34am	abid	abiduulislamgihan@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
531	2024-11-24 13:09:47.263968	2024-11-24 13:41:42.904672	2024-11-24 13:41:42.904672	10/28/2024 9:03pm	Anika sultana	anikasultanasanjida@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
478	2024-11-24 13:09:47.182032	2024-11-24 13:41:43.43857	2024-11-24 13:41:43.43857	10/30/2024 6:54am	Md. Fahim Rana	fahimranafs420@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
465	2024-11-24 13:09:47.168133	2024-11-24 13:42:09.773099	2024-11-24 13:42:09.773099	11/01/2024 9:27am	Hafezur Rahman	hafzur1112@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
456	2024-11-24 13:09:47.154237	2024-11-24 13:42:09.868351	2024-11-24 13:42:09.868351	10/30/2024 9:55am	MD Abdullah	abdullah0199946@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
444	2024-11-24 13:09:47.132244	2024-11-24 13:42:09.992461	2024-11-24 13:42:09.992461	10/30/2024 11:14am	Israt Jerin Payel	isratjerinpayel333@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
430	2024-11-24 13:09:47.120099	2024-11-24 13:42:10.131598	2024-11-24 13:42:10.131598	10/30/2024 9:59pm	Sadmin Hayder Jesan	srabon.jesan420@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
420	2024-11-24 13:09:47.109946	2024-11-24 13:42:10.244713	2024-11-24 13:42:10.244713	10/31/2024 2:58am	Nuhela Tabassum	tneelaaa@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
295	2024-09-14 18:37:47.187663	2024-11-24 13:44:58.598982	2024-11-24 13:44:58.598982	Rajia Sultana Kamona	kamonasultana@gmail.com	+8801643250944	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	potential	appointment-book	internal	f	\N	\N	Lead updated by Jarin	13	\N
283	2024-09-14 18:37:47.087316	2024-11-24 13:44:58.826576	2024-11-24 13:44:58.826576	Kazol Hasan	kazoland45@gmail.com	1723146460	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response, several times called him	14	\N
245	2024-09-14 18:37:46.773157	2024-11-24 13:46:43.37213	2024-11-24 13:46:43.37213	Bike Lovel	dipuhossen501@gmail.com	1401464192	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
372	2024-11-24 13:09:47.023486	2024-11-24 13:44:57.620706	2024-11-24 13:44:57.620706	11/01/2024 5:05am	Rakib Hossain	rakibhossain66958@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
365	2024-11-24 13:09:47.012964	2024-11-24 13:44:57.703358	2024-11-24 13:44:57.703358	11/01/2024 7:42am	Md Bijoy Hasan	mdbabuhasan696@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
343	2024-09-22 06:33:47.091869	2024-11-24 13:44:57.829682	2024-11-24 13:44:57.829682	Purnota Diya	diyarahman123@gmail.com	+8801611673922	Bangladesh	\N	\N	dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	Lead updated by Jarin	13	\N
316	2024-09-14 18:37:47.362844	2024-11-24 13:44:58.304601	2024-11-24 13:44:58.304601	shajib amin	mshajimamin@gmail.com	1711157608	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	No ielts, he wants PHD program and connected with whats app	14	\N
195	2024-09-14 18:37:46.34637	2024-11-24 13:46:44.303009	2024-11-24 13:46:44.303009	Farhan Ahmed Siam	siyamaasj2016@gmail.com	1704454634	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
413	2024-11-24 13:09:47.104284	2024-11-24 13:42:10.31113	2024-11-24 13:42:10.31113	10/31/2024 8:31am	Mehedi Hasan	mehedihasan659379@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
404	2024-11-24 13:09:47.095017	2024-11-24 13:42:10.410466	2024-11-24 13:42:10.410466	10/31/2024 11:08am	Gazi Sohel	gazisohel731@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
398	2024-11-24 13:09:47.087282	2024-11-24 13:42:10.469109	2024-11-24 13:42:10.469109	10/31/2024 1:26pm	Md. Nafij Islam	nafiji825@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
390	2024-11-24 13:09:47.067204	2024-11-24 13:42:10.538496	2024-11-24 13:42:10.538496	10/31/2024 10:42pm	Dipu Chandra Bisswas	dipuchandrasarker48@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
382	2024-11-24 13:09:47.056729	2024-11-24 13:42:10.602529	2024-11-24 13:42:10.602529	11/01/2024 2:15am	Md Yousuf	mdyousuf0179285@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
455	2024-11-24 13:09:47.149241	2024-11-24 13:42:09.901426	2024-11-24 13:42:09.901426	10/30/2024 10:08am	Sarika Lameya	sorowar414711@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
447	2024-11-24 13:09:47.137919	2024-11-24 13:42:09.9864	2024-11-24 13:42:09.9864	11/01/2024 10:27am	Хасан Камрул	a01836386136@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
437	2024-11-24 13:09:47.127639	2024-11-24 13:42:10.067631	2024-11-24 13:42:10.067631	10/30/2024 7:35pm	Shovon Ahamed	shovonahamad246@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
428	2024-11-24 13:09:47.117504	2024-11-24 13:42:10.178259	2024-11-24 13:42:10.178259	10/30/2024 11:32pm	Saleh Ahmed	salehahmed5660@yahoo.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
421	2024-11-24 13:09:47.110445	2024-11-24 13:42:10.241744	2024-11-24 13:42:10.241744	10/31/2024 2:57am	Tumpa Islam	soniaakter01021993@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
501	2024-11-24 13:09:47.221234	2024-11-24 13:41:43.216257	2024-11-24 13:41:43.216257	10/29/2024 5:09am	PALASH HALDAR	shuvoray687@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
491	2024-11-24 13:09:47.200093	2024-11-24 13:41:43.308698	2024-11-24 13:41:43.308698	10/29/2024 1:13pm	SaYem Ahmed	rifanahmed34@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
482	2024-11-24 13:09:47.187495	2024-11-24 13:41:43.3945	2024-11-24 13:41:43.3945	10/30/2024 12:39am	Mohammad Nur Hossen	mnurhosen@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
472	2024-11-24 13:09:47.177581	2024-11-24 13:42:09.708609	2024-11-24 13:42:09.708609	10/30/2024 6:46am	ريفا سانزدا	rifasanzida1997@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
542	2024-11-24 13:09:47.274775	2024-11-24 13:41:42.785558	2024-11-24 13:41:42.785558	10/27/2024 3:17pm	MD Jalal	mdjalal3710@gmial.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
533	2024-11-24 13:09:47.269242	2024-11-24 13:41:42.85803	2024-11-24 13:41:42.85803	10/28/2024 7:49pm	Mohammed Subahan	subahan1313@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
532	2024-11-24 13:09:47.265275	2024-11-24 13:41:42.872295	2024-11-24 13:41:42.872295	10/28/2024 8:01pm	Tapan Kumaa NathMPH	tapanmdsajaf2020@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
566	2024-11-24 13:09:47.313993	2024-11-24 13:41:42.427906	2024-11-24 13:41:42.427906	10/26/2024 1:53am	Md Ra Bbi Hossain	mdrabbihossain127@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
557	2024-11-24 13:09:47.304094	2024-11-24 13:41:42.591061	2024-11-24 13:41:42.591061	10/26/2024 7:57pm	Tanvir Ahmed	tanvirahmed105@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
547	2024-11-24 13:09:47.293709	2024-11-24 13:41:42.724273	2024-11-24 13:41:42.724273	10/27/2024 9:19am	Kamrul Hasan	kamrulhasan157469@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
518	2024-11-24 13:09:47.252556	2024-11-24 13:41:43.037863	2024-11-24 13:41:43.037863	10/29/2024 1:08am	Emam Al Hossain	emamhossain199914@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
510	2024-11-24 13:09:47.237049	2024-11-24 13:41:43.106006	2024-11-24 13:41:43.106006	10/29/2024 2:47am	Rakibul Islam	md6472660@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
464	2024-11-24 13:09:47.163995	2024-11-24 13:42:09.775811	2024-11-24 13:42:09.775811	10/30/2024 7:10am	Md Roman Roman	mdromonshak10@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
235	2024-09-14 18:37:46.694503	2024-11-24 13:46:43.591311	2024-11-24 13:46:43.591311	Mahabub Hasan	mahabub15370@gmail.com	1780015370	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	waiting for result	14	\N
232	2024-09-14 18:37:46.667892	2024-11-24 13:46:43.695747	2024-11-24 13:46:43.695747	Md Sohel	shoialhossen587@gmail.com	1770842258	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	preparing for ielts	14	\N
190	2024-09-14 18:37:46.303366	2024-11-24 13:46:44.411569	2024-11-24 13:46:44.411569	অ্ঁজা্ঁনা্ঁ এ্ঁক্ঁ পা্ঁখি্ঁর্ঁ দে্ঁশ্ঁ	gfjbhvvhh@gamil.com	1756839732	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
407	2024-11-24 13:09:47.097365	2024-11-24 13:42:10.362359	2024-11-24 13:42:10.362359	10/31/2024 10:42am	Md Saidur Rahman	saidur4787@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
394	2024-11-24 13:09:47.069809	2024-11-24 13:42:10.528819	2024-11-24 13:42:10.528819	10/31/2024 10:13pm	Riduan Hossain	rafihossen067@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
378	2024-11-24 13:09:47.044255	2024-11-24 13:42:10.666084	2024-11-24 13:42:10.666084	11/01/2024 3:08am	Arfat Uddin Raihan	ashbvcxjo@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
363	2024-11-24 13:09:47.004344	2024-11-24 13:44:57.70875	2024-11-24 13:44:57.70875	11/01/2024 8:33am	umme habiba	sohagiummehabiba7@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
296	2024-09-14 18:37:47.195218	2024-11-24 13:44:58.586775	2024-11-24 13:44:58.586775	Sheikh Shorno	sheikhshorno24@gmail.com	1998221433	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	potential	appointment-book	internal	f	\N	\N	waiting for office visit	13	\N
294	2024-09-14 18:37:47.178558	2024-11-24 13:44:58.627588	2024-11-24 13:44:58.627588	Kamal Hossain	kamal_hossain@msn.com	+880304229265	Bangladesh	\N	Dhaka District	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
261	2024-09-14 18:37:46.892321	2024-11-24 13:46:43.173182	2024-11-24 13:46:43.173182	Johirul Islam	johirulislambd29@gmail.com	+8801679893216	Bangladesh	\N	Dhaka Division	Dhaka	Dhanmondi	[]	{"degree":"Bsc","institute":"world university Bangladesh","country":"Bangladesh","year":"2023","month":"June","result":"3"}	Other	{}	study-abroad	lead	future-interest	internal	f	\N	\N	Lead updated by Jarin	13	\N
473	2024-11-24 13:09:47.178839	2024-11-24 13:42:09.705655	2024-11-24 13:42:09.705655	10/30/2024 5:48am	一 Sajib Ray ː-Ꮗ T.T　o.O	sajibray843@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
462	2024-11-24 13:09:47.161551	2024-11-24 13:42:09.802392	2024-11-24 13:42:09.802392	11/01/2024 9:45am	Samsul Islam	samsul9181@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
452	2024-11-24 13:09:47.147517	2024-11-24 13:42:09.924454	2024-11-24 13:42:09.924454	10/30/2024 10:49am	Mostafijur Rahman Abir	m35804967@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
445	2024-11-24 13:09:47.134366	2024-11-24 13:42:09.993039	2024-11-24 13:42:09.993039	11/01/2024 10:11am	Enayetullah	jackfalahee83@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
435	2024-11-24 13:09:47.126134	2024-11-24 13:42:10.114135	2024-11-24 13:42:10.114135	10/30/2024 7:40pm	Md Kawser Talukder	mdkawsertalukder10@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
426	2024-11-24 13:09:47.11669	2024-11-24 13:42:10.180656	2024-11-24 13:42:10.180656	10/31/2024 1:29am	Mohammad Rahed	rahedmd17@gmail.con	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
417	2024-11-24 13:09:47.106763	2024-11-24 13:42:10.247095	2024-11-24 13:42:10.247095	10/31/2024 5:21am	Ashik Zehen	nasirhossin52996147@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
545	2024-11-24 13:09:47.282102	2024-11-24 13:41:42.733894	2024-11-24 13:41:42.733894	10/27/2024 11:11am	MD Rejaul Arafat Shawon	arafatshawon@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
535	2024-11-24 13:09:47.271278	2024-11-24 13:41:42.845902	2024-11-24 13:41:42.845902	10/28/2024 1:12pm	Md Younus Khan	mdyounuskhan723@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
526	2024-11-24 13:09:47.26202	2024-11-24 13:41:42.951706	2024-11-24 13:41:42.951706	10/28/2024 10:19pm	Arjun Das Partho	Pgandivdari@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
573	2024-11-24 13:09:47.319567	2024-11-24 13:41:42.506639	2024-11-24 13:41:42.506639	10/26/2024 2:16am	Nile chowdury	Arjumamarah256@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
564	2024-11-24 13:09:47.31058	2024-11-24 13:41:42.514325	2024-11-24 13:41:42.514325	10/26/2024 8:45pm	Engr Sakti Chandra Ghosh	engganik@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
555	2024-11-24 13:09:47.300802	2024-11-24 13:41:42.633427	2024-11-24 13:41:42.633427	10/26/2024 10:31pm	sing sing nue marma	singsingnue@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
516	2024-11-24 13:09:47.249127	2024-11-24 13:41:43.04343	2024-11-24 13:41:43.04343	10/29/2024 1:37am	Md Badol	mdbadolbadol877@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
505	2024-11-24 13:09:47.229529	2024-11-24 13:41:43.165978	2024-11-24 13:41:43.165978	10/29/2024 3:25am	মেহেদি শেখ	mdm866912@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
492	2024-11-24 13:09:47.202324	2024-11-24 13:41:43.294863	2024-11-24 13:41:43.294863	10/29/2024 1:05pm	Farzana Jahan Hridy	jahanfarjana94@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
483	2024-11-24 13:09:47.190577	2024-11-24 13:41:43.378972	2024-11-24 13:41:43.378972	10/30/2024 12:23am	Ahmed Taitul	taitulislamakash@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
519	2024-11-24 13:09:47.255353	2024-11-24 13:41:43.021011	2024-11-24 13:41:43.021011	10/29/2024 12:55am	MD Maruf	mdmaruif334@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
512	2024-11-24 13:09:47.242642	2024-11-24 13:41:43.09563	2024-11-24 13:41:43.09563	10/29/2024 2:21am	Md Momin	oabghvgh@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
503	2024-11-24 13:09:47.227641	2024-11-24 13:41:43.19931	2024-11-24 13:41:43.19931	10/29/2024 4:31am	Esariul Esirul	esirulesariul@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
495	2024-11-24 13:09:47.206441	2024-11-24 13:41:43.264637	2024-11-24 13:41:43.264637	10/29/2024 11:23pm	Ziyabul Ziyabul	ziyabulhuqueziyabul34@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
367	2024-11-24 13:09:47.017661	2024-11-24 13:44:57.696944	2024-11-24 13:44:57.696944	11/01/2024 7:23am	Md Zaker Zaker	mdzakerayup@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
341	2024-09-16 15:24:09.022149	2024-11-24 13:44:57.852904	2024-11-24 13:44:57.852904	SHAMMA SAIYARA	shammasaiyara50@gmail.com	+8801634341760	Bangladesh	\N	Dhaka District	Dhaka Bangladesh	Dhanmondi	[{"name":"A-levels","year":"2020","result":"BB"}]	{"degree":"BSc in English Literature","institute":"AIUB","country":"Bangladesh","year":"2024","result":"3.86/4","month":"April"}	IELTS	{"overall": 7, "reading": 6.5, "writing": 6.5, "speaking": 8, "listening": 7.5}	study-abroad	potential	waiting-for-document	internal	f	\N	\N	Lead updated by Naf	1	\N
285	2024-09-14 18:37:47.102752	2024-11-24 13:44:58.816484	2024-11-24 13:44:58.816484	Saifur Rahman	saifurmolla06@gmail.com	1787508999	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	he wants arabic language studies and preparing for ielts	14	\N
563	2024-11-24 13:09:47.309649	2024-11-24 13:41:42.496401	2024-11-24 13:41:42.496401	10/26/2024 2:42am	Mahmud Zaman Khan Fahim	Mahmud130115@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
572	2024-11-24 13:09:47.318809	2024-11-24 13:41:42.501564	2024-11-24 13:41:42.501564	10/26/2024 6:46am	Md RiAd Arefin	mdriadarefin123@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
554	2024-11-24 13:09:47.299766	2024-11-24 13:41:42.642632	2024-11-24 13:41:42.642632	10/27/2024 1:27am	A k	abidking1997@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
544	2024-11-24 13:09:47.280459	2024-11-24 13:41:42.77607	2024-11-24 13:41:42.77607	10/27/2024 11:14am	Ahmad	1988mohiuddinahmad@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
539	2024-11-24 13:09:47.272848	2024-11-24 13:41:42.79358	2024-11-24 13:41:42.79358	10/28/2024 12:15am	Ro Muhammad Noman	md1320906@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
529	2024-11-24 13:09:47.262795	2024-11-24 13:41:42.911637	2024-11-24 13:41:42.911637	10/29/2024 12:30am	Pritom kanti Sarker	pksdrubo440@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
522	2024-11-24 13:09:47.256421	2024-11-24 13:41:42.984853	2024-11-24 13:41:42.984853	10/29/2024 12:05am	Mst Sunzida Aktar	rumapervin@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
280	2024-09-14 18:37:47.063344	2024-11-24 13:44:58.819277	2024-11-24 13:44:58.819277	ZAHIDUL islam kaddus ALLI	jmd36662@gmail.com	972000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no phone number	14	\N
260	2024-09-14 18:37:46.883892	2024-11-24 13:46:43.209635	2024-11-24 13:46:43.209635	Ontor Hossian	mdimamhossian735@gmail.com	1804668119	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	wrong number	13	\N
234	2024-09-14 18:37:46.687005	2024-11-24 13:46:43.584136	2024-11-24 13:46:43.584136	Md. Sorif	msrf414591@gmail.com	1760421278	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
192	2024-09-14 18:37:46.322154	2024-11-24 13:46:44.295075	2024-11-24 13:46:44.295075	naju	juthi132@gmail.com	1625734343	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
571	2024-11-24 13:09:47.3183	2024-11-24 13:41:42.422129	2024-11-24 13:41:42.422129	10/25/2024 9:14pm	Munia	munia.haq50@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
561	2024-11-24 13:09:47.30942	2024-11-24 13:41:42.551854	2024-11-24 13:41:42.551854	10/26/2024 9:21am	Md Abdul Mannan	abdul.mannan1977@yahoo.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
550	2024-11-24 13:09:47.295494	2024-11-24 13:41:42.714423	2024-11-24 13:41:42.714423	10/27/2024 7:10am	Moon	chowdhurymoon992@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
538	2024-11-24 13:09:47.272529	2024-11-24 13:41:42.799821	2024-11-24 13:41:42.799821	10/28/2024 9:19pm	JR Jahidul Islam Hridoy	jahidulislam27899@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
536	2024-11-24 13:09:47.271503	2024-11-24 13:41:42.842357	2024-11-24 13:41:42.842357	10/28/2024 12:36pm	Mohammed Riyadh Hossain Aupi	riyadhhoss87@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
528	2024-11-24 13:09:47.262555	2024-11-24 13:41:42.920398	2024-11-24 13:41:42.920398	10/28/2024 9:44pm	Md sskibul islam rigan	mdabdullahatoz@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
521	2024-11-24 13:09:47.255865	2024-11-24 13:41:43.018309	2024-11-24 13:41:43.018309	10/29/2024 2:21am	Md Borhan Uddin	sulatanamirja055@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
511	2024-11-24 13:09:47.241785	2024-11-24 13:41:43.099565	2024-11-24 13:41:43.099565	10/29/2024 2:38am	H M Ismail Shikdar	hmismail131997@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
502	2024-11-24 13:09:47.226445	2024-11-24 13:41:43.201276	2024-11-24 13:41:43.201276	10/29/2024 4:40am	Lucky	md.rajwanc@gamil.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
451	2024-11-24 13:09:47.14306	2024-11-24 13:42:09.929257	2024-11-24 13:42:09.929257	11/01/2024 9:16am	Ador Babu	adorbabu3333@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
375	2024-11-24 13:09:47.033946	2024-11-24 13:42:10.708302	2024-11-24 13:42:10.708302	11/01/2024 4:44am	সুমাইয়া তানজুম তিথি	sumaiya.tanjum.2022@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
359	2024-11-24 13:09:47.003089	2024-11-24 13:44:57.765509	2024-11-24 13:44:57.765509	11/01/2024 8:48am	anonymous	seashoresailore@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
220	2024-09-14 18:37:46.562056	2024-11-24 13:46:43.903481	2024-11-24 13:46:43.903481	RS Akhy	akhynoyon@gmail.com	1782863707	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Lead updated by Jarin	13	\N
194	2024-09-14 18:37:46.339339	2024-11-24 13:46:44.306782	2024-11-24 13:46:44.306782	MD Obydullah Sabuj	sabujmdobydullah@gmail.com	1822949012	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
569	2024-11-24 13:09:47.317017	2024-11-24 13:41:42.424468	2024-11-24 13:41:42.424468	10/25/2024 11:00pm	Imran Hossain	imranhossain662610@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
559	2024-11-24 13:09:47.306466	2024-11-24 13:41:42.573721	2024-11-24 13:41:42.573721	10/26/2024 11:11am	Mijanur Rhaman	www.mijanurrhaman84482109@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
553	2024-11-24 13:09:47.296296	2024-11-24 13:41:42.647252	2024-11-24 13:41:42.647252	10/27/2024 4:08am	Rima Akter	rimaakter507@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
543	2024-11-24 13:09:47.279643	2024-11-24 13:41:42.77852	2024-11-24 13:41:42.77852	10/27/2024 2:07pm	Raj Talukdar	rajtalukdar20144@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
534	2024-11-24 13:09:47.270461	2024-11-24 13:41:42.861777	2024-11-24 13:41:42.861777	10/28/2024 2:48pm	Raza	raja.khan17.12@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
525	2024-11-24 13:09:47.261342	2024-11-24 13:41:42.964745	2024-11-24 13:41:42.964745	10/28/2024 11:05pm	MD Rakib	mdrakinhassan2021@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
515	2024-11-24 13:09:47.247348	2024-11-24 13:41:43.081941	2024-11-24 13:41:43.081941	10/29/2024 2:09am	Md Sawon Bepari	mdshawonbepari564@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
507	2024-11-24 13:09:47.233173	2024-11-24 13:41:43.154191	2024-11-24 13:41:43.154191	10/29/2024 2:54am	Saymul Mahi	saymulmahi89@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
570	2024-11-24 13:09:47.318079	2024-11-24 13:41:42.421086	2024-11-24 13:41:42.421086	10/25/2024 9:54pm	Saikat Kumar Roy	saikatkumarroy2006@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
560	2024-11-24 13:09:47.308971	2024-11-24 13:41:42.568581	2024-11-24 13:41:42.568581	10/26/2024 9:33am	Mohamed Ibrahim 8653	mohamedibrahim251770@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
549	2024-11-24 13:09:47.295548	2024-11-24 13:41:42.651633	2024-11-24 13:41:42.651633	10/27/2024 7:17am	Liza Afrose	zobayedsourav98@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
540	2024-11-24 13:09:47.273161	2024-11-24 13:41:42.792958	2024-11-24 13:41:42.792958	10/27/2024 6:53pm	Akther Shaila	shailaakther1991@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
530	2024-11-24 13:09:47.263261	2024-11-24 13:41:42.905449	2024-11-24 13:41:42.905449	10/29/2024 12:05am	Masum Billah	hridoymasum152@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
523	2024-11-24 13:09:47.256766	2024-11-24 13:41:42.972748	2024-11-24 13:41:42.972748	10/28/2024 11:44pm	Zara Trina	zaratrina2439@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
513	2024-11-24 13:09:47.243245	2024-11-24 13:41:43.100229	2024-11-24 13:41:43.100229	10/29/2024 3:55am	মোঃ সাগর খাঁন	mahedihasan123456mahedi@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
486	2024-11-24 13:09:47.192692	2024-11-24 13:41:43.360606	2024-11-24 13:41:43.360606	10/30/2024 3:37am	MD Mesbahul Mesket Siyam	mesbaulsiyam1424@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
191	2024-09-14 18:37:46.313535	2024-11-24 13:46:44.299428	2024-11-24 13:46:44.299428	Sazid Siddique	sazid.nsu@outlook.com	1682600276	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
412	2024-11-24 13:09:47.1015	2024-11-24 13:42:10.314982	2024-11-24 13:42:10.314982	10/31/2024 9:01am	Md Sah Hamim Rahman	smshikat9@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
207	2024-09-14 18:37:46.45204	2024-11-24 13:46:44.091772	2024-11-24 13:46:44.091772	KOHINOOR	mdmonuarh65@gmail.com	1313238914	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	interested	14	\N
517	2024-11-24 13:09:47.249677	2024-11-24 13:41:43.0371	2024-11-24 13:41:43.0371	10/29/2024 1:25am	ρπαητΦ Ϳιτ	jitpranto94@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
527	2024-11-24 13:09:47.262283	2024-11-24 13:41:42.951068	2024-11-24 13:41:42.951068	10/28/2024 9:59pm	Robul Islam Rabby	rinkuahmed12344@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
546	2024-11-24 13:09:47.291495	2024-11-24 13:41:42.73029	2024-11-24 13:41:42.73029	10/28/2024 11:28am	নবনীতা শেখ	nabanitasheikh@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
556	2024-11-24 13:09:47.301928	2024-11-24 13:41:42.614779	2024-11-24 13:41:42.614779	10/27/2024 9:52am	Md Woazid Ali	woazid0022@fmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
568	2024-11-24 13:09:47.316369	2024-11-24 13:41:42.428643	2024-11-24 13:41:42.428643	10/26/2024 12:08am	Aabid Ahmed Chowdhury	aabidchowdhury@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
357	2024-11-24 13:09:47.00293	2024-11-24 13:44:57.769181	2024-11-24 13:44:57.769181	11/01/2024 9:02am	Suman Sarkar	fahim21345yff@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
233	2024-09-14 18:37:46.677375	2024-11-24 13:46:43.592923	2024-11-24 13:46:43.592923	Afrina Irin	afrinairin52@gmail.com	1927383029	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
229	2024-09-14 18:37:46.63975	2024-11-24 13:46:43.678945	2024-11-24 13:46:43.678945	Md Shuvo	mda800270@gmail.com	1926592621	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
203	2024-09-14 18:37:46.40695	2024-11-24 13:46:44.096253	2024-11-24 13:46:44.096253	Nishan Chandra Roy	nissannishu4@gmail.com	1728039862	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response 	14	\N
217	2024-09-14 18:37:46.539305	2024-11-24 13:46:43.903041	2024-11-24 13:46:43.903041	Golam mustafa	mustafanov@gmail.com	1632760740	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
225	2024-09-14 18:37:46.604272	2024-11-24 13:46:43.801814	2024-11-24 13:46:43.801814	Laki Akter	mh.teacher.bd@gmail.com	1994907778	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	NO Answer	13	\N
216	2024-09-14 18:37:46.531957	2024-11-24 13:46:43.888361	2024-11-24 13:46:43.888361	Shwapan Mohonta	shwaponkumer@gmail.com	1762999624	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Wrong number	13	\N
228	2024-09-14 18:37:46.632295	2024-11-24 13:46:43.681656	2024-11-24 13:46:43.681656	Md Ahsan Habib	mdahsanhabib4976@gmail.com	1745164976	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
227	2024-09-14 18:37:46.621553	2024-11-24 13:46:43.689325	2024-11-24 13:46:43.689325	Md Kalam Khan	kalamkhan420920@gmail.com	1331575315	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Wrong Number	13	\N
224	2024-09-14 18:37:46.593468	2024-11-24 13:46:43.797546	2024-11-24 13:46:43.797546	Mdmaruf Zakir Hasan	mdmarufzakirj@gmail.com	1985040557	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
226	2024-09-14 18:37:46.613051	2024-11-24 13:46:43.793521	2024-11-24 13:46:43.793521	Lovelu Hossain Abir	loveluabir2020@gmail.com	1300778177	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
221	2024-09-14 18:37:46.568766	2024-11-24 13:46:43.782592	2024-11-24 13:46:43.782592	Md Sipon Khan	mdshiponk695@gmail.com	1316867015	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Not Interested	13	\N
222	2024-09-14 18:37:46.578812	2024-11-24 13:46:43.78942	2024-11-24 13:46:43.78942	Rony Miah	miayrony291@gmail.com	1314746251	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
215	2024-09-14 18:37:46.524917	2024-11-24 13:46:43.906527	2024-11-24 13:46:43.906527	Md Rezaul hoque Rajan	rh.reza84@yahoo.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	No number	13	\N
218	2024-09-14 18:37:46.546801	2024-11-24 13:46:43.897012	2024-11-24 13:46:43.897012	Khalid Hasan	khalidhasanbd2003@gmail.com	+8801734986	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
209	2024-09-14 18:37:46.478107	2024-11-24 13:46:43.984669	2024-11-24 13:46:43.984669	Parbez Hasan Tarak	parbezhasantarak@gmail.com	+8801823176469	Bangladesh	\N	\N	Dhaka	Dhanmondi	[]	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
223	2024-09-14 18:37:46.586236	2024-11-24 13:46:43.799232	2024-11-24 13:46:43.799232	Muhibbullah Hasan	muhibbullahodexp01@gmail.com	1568078409	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	NO Answer	13	\N
214	2024-09-14 18:37:46.517353	2024-11-24 13:46:43.987468	2024-11-24 13:46:43.987468	Faisal Mahmud	faisalmahmud204709@gmail.com	1993563919	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	no answer	13	\N
211	2024-09-14 18:37:46.493529	2024-11-24 13:46:43.990027	2024-11-24 13:46:43.990027	Al Amin	alaminturki1234@gmail.com	1753375373	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no answer	13	\N
210	2024-09-14 18:37:46.486235	2024-11-24 13:46:43.996698	2024-11-24 13:46:43.996698	Abu Sofeain Sorker	rojjamoni622@gmail.com	1317444337	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
212	2024-09-14 18:37:46.501191	2024-11-24 13:46:44.001271	2024-11-24 13:46:44.001271	S D Gupta	swekretaexam@gmail.com	1859067804	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	Busy	13	\N
213	2024-09-14 18:37:46.509738	2024-11-24 13:46:43.997237	2024-11-24 13:46:43.997237	Moumita Akther Mou	moumitaakthermou713@gmail.com	1992248297	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	wrong number	13	\N
205	2024-09-14 18:37:46.423843	2024-11-24 13:46:44.088315	2024-11-24 13:46:44.088315	FARJANA AFRIN UPOMA	harunpharmacy8130@gmail.com	1740919885	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	several time i called her father. no response	14	\N
199	2024-09-14 18:37:46.376162	2024-11-24 13:46:44.195226	2024-11-24 13:46:44.195226	Md Jahangir Alom	mdalomjahangir2021@gmail.com	1758799656	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
197	2024-09-14 18:37:46.360461	2024-11-24 13:46:44.199326	2024-11-24 13:46:44.199326	Abdullah Mamun	am7989135@gmail.com	1720096383	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
202	2024-09-14 18:37:46.399487	2024-11-24 13:46:44.219146	2024-11-24 13:46:44.219146	Meher Disha	meherdisha54@gmail.com	1644460511	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
201	2024-09-14 18:37:46.391754	2024-11-24 13:46:44.215205	2024-11-24 13:46:44.215205	Raju Barai	rathinbarai66@gmail.com	1968224979	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
200	2024-09-14 18:37:46.383752	2024-11-24 13:46:44.206751	2024-11-24 13:46:44.206751	NaSim Babu	nasimbabu145@gmail.com	1776485460	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response 	14	\N
193	2024-09-14 18:37:46.330665	2024-11-24 13:46:44.306395	2024-11-24 13:46:44.306395	সারোয়ার রহিম তালুকদার	rahimtalukder90@gmail.com	1724203982	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
198	2024-09-14 18:37:46.368707	2024-11-24 13:46:44.218488	2024-11-24 13:46:44.218488	Az Mark	azmark512@gmail.com	1633909774	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
196	2024-09-14 18:37:46.353696	2024-11-24 13:46:44.310163	2024-11-24 13:46:44.310163	Imtiaj Tahmid	zihadimtiaj@gmail.com	1961474996	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone off	14	\N
286	2024-09-14 18:37:47.109421	2024-11-24 13:44:58.683779	2024-11-24 13:44:58.683779	Sozan mahmud	mahamodur@7890gemil.com	1924895890	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No response. 4 times i called him	14	\N
282	2024-09-14 18:37:47.07919	2024-11-24 13:44:58.822989	2024-11-24 13:44:58.822989	Tanjina Jannat	tanjinajannat31@gmail.com	1882392439	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	she will take preparation for ielts	14	\N
284	2024-09-14 18:37:47.095233	2024-11-24 13:44:58.826249	2024-11-24 13:44:58.826249	SELIM AHMED	alorpothey3@gmail.com	1712182047	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad profile, long long long study gap	14	\N
277	2024-09-14 18:37:47.036576	2024-11-24 13:44:58.919205	2024-11-24 13:44:58.919205	Moymita Amelia	rontishen@gmail.com	1968134609	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	she was busy	14	\N
279	2024-09-14 18:37:47.054524	2024-11-24 13:44:58.924484	2024-11-24 13:44:58.924484	MD HabibullahBahar	drhabibullahbahar@gmail.com	1711155202	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	he did MBBS 1994	14	\N
278	2024-09-14 18:37:47.045846	2024-11-24 13:44:58.929437	2024-11-24 13:44:58.929437	Milon Mirdha	milonmerda1476@gmail.com	1766905569	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	several times i called him but he cut my phone	14	\N
274	2024-09-14 18:37:47.011305	2024-11-24 13:44:58.931607	2024-11-24 13:44:58.931607	Shamim Molla	shmimmollah789@gmail.com	1977899032	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	nonsense 	14	\N
271	2024-09-14 18:37:46.985298	2024-11-24 13:44:59.021566	2024-11-24 13:44:59.021566	Kazi Alamin	kazialamin10@gmail.com	1912145145	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	he did not pick my call	14	\N
273	2024-09-14 18:37:47.001139	2024-11-24 13:44:59.02436	2024-11-24 13:44:59.02436	মল্লিক মোঃ সাজিদ হোসেন	mallickmohadsazeedhossain13@gmail.com	1907048673	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	nonsense	14	\N
272	2024-09-14 18:37:46.992594	2024-11-24 13:44:59.027213	2024-11-24 13:44:59.027213	Md Dina Islam	Mddina588@gmail.com	1318059533	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone off	14	\N
270	2024-09-14 18:37:46.974837	2024-11-24 13:44:59.02951	2024-11-24 13:44:59.02951	Md Rashed Morol	mdjulhas200012@gmail.com	1785932621	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad profile	14	\N
269	2024-09-14 18:37:46.965543	2024-11-24 13:44:59.036493	2024-11-24 13:44:59.036493	Fahima Binte Faruk	hridoyerspondhon856@gmail.com	+8801944922378	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
267	2024-09-14 18:37:46.948891	2024-11-24 13:44:59.126756	2024-11-24 13:44:59.126756	Abdul Wadud Uddin Khan (Tanim)	tanim12132524@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no number	13	\N
259	2024-09-14 18:37:46.874889	2024-11-24 13:46:43.185531	2024-11-24 13:46:43.185531	Imran Ali Imran Ali	audhuduied004@gmail.com	+880772803164	Bangladesh	\N	Dhaka District	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
266	2024-09-14 18:37:46.940444	2024-11-24 13:44:59.131101	2024-11-24 13:44:59.131101	Md Sumon Rana	sumonmollik227@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no number	13	\N
265	2024-09-14 18:37:46.930929	2024-11-24 13:44:59.132812	2024-11-24 13:44:59.132812	Ariyan Ahmed Tanvir Shopon	mdrofiq6286@gmail.com	500	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Number missing	13	\N
264	2024-09-14 18:37:46.918194	2024-11-24 13:46:42.962294	2024-11-24 13:46:42.962294	Misty Bake	novabusra2@gmail.com	+8801930639665	Bangladesh	\N	Dhaka Division	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
263	2024-09-14 18:37:46.909837	2024-11-24 13:46:43.06877	2024-11-24 13:46:43.06877	Nasir Khan Md	nusiruddin.021@gmail.com	1838483370	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No Answer	13	\N
262	2024-09-14 18:37:46.900254	2024-11-24 13:46:43.209229	2024-11-24 13:46:43.209229	Md. Rubel Rana	rubelvip8090@gmail.com	+8801648942078	Bangladesh	\N	Barguna District	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
258	2024-09-14 18:37:46.867366	2024-11-24 13:46:43.21245	2024-11-24 13:46:43.21245	aminul	aminulislamasik06@gmail.com	+880608059276	Bangladesh	\N	\N	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Lead updated by Jarin	13	\N
256	2024-09-14 18:37:46.852634	2024-11-24 13:46:43.262646	2024-11-24 13:46:43.262646	Md Rakib Lx	mr7865691@gmail.com	1320458457	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	no	13	\N
239	2024-09-14 18:37:46.727142	2024-11-24 13:46:43.475107	2024-11-24 13:46:43.475107	MD Masud Mia	md.masudmia20@gmail.com	1959720571	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
254	2024-09-14 18:37:46.838233	2024-11-24 13:46:43.265559	2024-11-24 13:46:43.265559	হারুন অর-রশীদ ফরাজী	hmd836919@gmail.com	1891951261	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
255	2024-09-14 18:37:46.846033	2024-11-24 13:46:43.26758	2024-11-24 13:46:43.26758	Mdsiddek Md Enon	mds773049@gamil.com	mdsiddek	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Number missing	13	\N
253	2024-09-14 18:37:46.831352	2024-11-24 13:46:43.270096	2024-11-24 13:46:43.270096	Jobida Islam Ruma	aijislam@gmail.com	1611200614	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Switched Off	13	\N
252	2024-09-14 18:37:46.824706	2024-11-24 13:46:43.277639	2024-11-24 13:46:43.277639	Md Dalower Siddiki	mdalower500@gmail.com	1928643202	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Wrong Number 	13	\N
249	2024-09-14 18:37:46.804297	2024-11-24 13:46:43.377633	2024-11-24 13:46:43.377633	Maybe Hig	rahulahmed571@icloud.com	1727919719	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
247	2024-09-14 18:37:46.788068	2024-11-24 13:46:43.381679	2024-11-24 13:46:43.381679	Sk Tamim	sktamim3032@gmail.com	1717729186	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
250	2024-09-14 18:37:46.810914	2024-11-24 13:46:43.385266	2024-11-24 13:46:43.385266	Shimul	shimul.bd0936@gmail.com	1325814924	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Switched Off	13	\N
248	2024-09-14 18:37:46.796251	2024-11-24 13:46:43.388833	2024-11-24 13:46:43.388833	Md Mihir	k644889@gmail.com	1820723684	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
243	2024-09-14 18:37:46.759689	2024-11-24 13:46:43.48028	2024-11-24 13:46:43.48028	Md Hemal	md9324901@gmail.com	1628779098	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	he did not pick my call	14	\N
244	2024-09-14 18:37:46.766722	2024-11-24 13:46:43.484556	2024-11-24 13:46:43.484556	Samira Ahmed Mimi	sultanamiftaul56@gmail.com	1315812614	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	first	internal	f	\N	\N	call her tomorrow	14	\N
242	2024-09-14 18:37:46.752546	2024-11-24 13:46:43.491193	2024-11-24 13:46:43.491193	Shammo Das	Im6530434@gmail.com	1760242055	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad	14	\N
241	2024-09-14 18:37:46.744831	2024-11-24 13:46:43.493718	2024-11-24 13:46:43.493718	Md Aminul Islam	aminulislamarshad311@gmial.com	1728940288	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone off	14	\N
240	2024-09-14 18:37:46.736907	2024-11-24 13:46:43.49646	2024-11-24 13:46:43.49646	Faiyaz Khondakar	faiyazkhondakar@gmail.com	1992520564	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
236	2024-09-14 18:37:46.703241	2024-11-24 13:46:43.577398	2024-11-24 13:46:43.577398	Md Tushar Ahmed Panda	mdtusharahmedpanda@gmail.com	1814740182	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	waiting for result	14	\N
238	2024-09-14 18:37:46.719384	2024-11-24 13:46:43.581343	2024-11-24 13:46:43.581343	Md Rakiv Khan	mdrakivkhan211@gmail.com	1822254099	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
237	2024-09-14 18:37:46.711228	2024-11-24 13:46:43.588741	2024-11-24 13:46:43.588741	Md Sifat	mdsifatkhab@gmail.com	181468069	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	wrong number	14	\N
318	2024-09-14 18:37:47.378511	2024-11-24 13:44:58.271195	2024-11-24 13:44:58.271195	Fk Ferdous Khan	khanfkferdous@gmail.com	1892188661	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Farzana	14	\N
321	2024-09-14 18:37:47.402951	2024-11-24 13:44:58.247654	2024-11-24 13:44:58.247654	আম্মুর কলিজারটুকরা	md3971774@gmail.com	1874133816	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Lead updated by Farzana	14	\N
323	2024-09-14 18:37:47.41724	2024-11-24 13:44:58.185423	2024-11-24 13:44:58.185423	Hafsa moni	hafsariyan874@gmail.com	1844833273	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	connected with whats app	14	\N
288	2024-09-14 18:37:47.122919	2024-11-24 13:44:58.679992	2024-11-24 13:44:58.679992	Shakerul Islam	shakerul1205@diu.edu.bd	1751471731	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	potential	appointment-book	internal	f	\N	\N	he will come 	14	\N
322	2024-09-14 18:37:47.410264	2024-11-24 13:44:58.245509	2024-11-24 13:44:58.245509	Sharia Alam	Sharia986767@gamil.com	1746986767	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	courses	course-lead	course-first	internal	f	[]	[]	28th September exam. i will call him 13th October	14	\N
336	2024-09-14 18:37:47.512943	2024-11-24 13:44:57.960734	2024-11-24 13:44:57.960734	ruhul amin	ruhulamnr348@gmail.com	1794959489	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	number is not valid	14	\N
552	2024-11-24 13:09:47.292031	2024-11-24 13:41:42.730904	2024-11-24 13:41:42.730904	10/28/2024 7:31am	Shifat	saim6583461@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
565	2024-11-24 13:09:47.312273	2024-11-24 13:41:42.51843	2024-11-24 13:41:42.51843	10/26/2024 2:13am	Ikbal Hossain	istanrikhalal@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
331	2024-09-14 18:37:47.476973	2024-11-24 13:44:58.064914	2024-11-24 13:44:58.064914	Swapon Das Tonmoy	dasswapon498@gmail.com	1614855160	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Farzana	14	\N
334	2024-09-14 18:37:47.498325	2024-11-24 13:44:58.070562	2024-11-24 13:44:58.070562	Md Arsad Islam	mdarsadislam17@gmail.com	1868416283	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	work visa	14	\N
330	2024-09-14 18:37:47.469599	2024-11-24 13:44:58.074555	2024-11-24 13:44:58.074555	Emdad Hossain	hossainemdad050388@gmail.com	1866348847	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone off	14	\N
326	2024-09-14 18:37:47.440292	2024-11-24 13:44:58.189108	2024-11-24 13:44:58.189108	Md. Akash Miah	gajhsjgsibj@ghabsj.com	171000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Farzana	14	\N
325	2024-09-14 18:37:47.432284	2024-11-24 13:44:58.192757	2024-11-24 13:44:58.192757	Sheikh Sohel	sohel006699@gmail.com	1703315099	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Lead updated by Farzana	14	\N
324	2024-09-14 18:37:47.424846	2024-11-24 13:44:58.199554	2024-11-24 13:44:58.199554	Jubayer Khan	jubayerjannat213@gmail.com	1918371145	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	he is connected with whats app	14	\N
328	2024-09-14 18:37:47.455755	2024-11-24 13:44:58.201806	2024-11-24 13:44:58.201806	Muhammad Talha	md.talha.5015@gmail.com	1713588785	Bangladesh	\N	Dhaka District	dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Farzana	14	\N
319	2024-09-14 18:37:47.387417	2024-11-24 13:44:58.255072	2024-11-24 13:44:58.255072	Rumman Chowdhury	corporationsr@gmail.com	1828157021	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	bad profile	14	\N
317	2024-09-14 18:37:47.370004	2024-11-24 13:44:58.263695	2024-11-24 13:44:58.263695	Taposh Das	tkdofficial77@gmail.com	1687138133	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	i called him several time	14	\N
315	2024-09-14 18:37:47.355047	2024-11-24 13:44:58.30423	2024-11-24 13:44:58.30423	এম.এ.এইচ. মিলন	m.a.h.milon4042@gmail.com	1402815754	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Bad profile	14	\N
314	2024-09-14 18:37:47.343818	2024-11-24 13:44:58.309163	2024-11-24 13:44:58.309163	Tanveer Ahmed Siddiqui	tanjidahmed@gmail.com	1911325244	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	non sense	14	\N
313	2024-09-14 18:37:47.334673	2024-11-24 13:44:58.315824	2024-11-24 13:44:58.315824	Sumi Das	ssontushdas@gmail.com	1771121248	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	several times i called her	14	\N
309	2024-09-14 18:37:47.300043	2024-11-24 13:44:58.362153	2024-11-24 13:44:58.362153	Md Habiullah	mdhabib400553@gmail.com	1781843852	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
308	2024-09-14 18:37:47.293431	2024-11-24 13:44:58.365747	2024-11-24 13:44:58.365747	Irin Islam	irinsihab87@gmail.com	KAZI IRIN AZAD	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Number Missing	13	\N
307	2024-09-14 18:37:47.284905	2024-11-24 13:44:58.378063	2024-11-24 13:44:58.378063	Dr. S M Abu Mustafa	msm_abu1@hotmail.com	+44(0)7760586682	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	No answer	13	\N
302	2024-09-14 18:37:47.246172	2024-11-24 13:44:58.513015	2024-11-24 13:44:58.513015	M.A. Abdullah	abdullah1993new@gmail.com	1761355026	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
305	2024-09-14 18:37:47.269393	2024-11-24 13:44:58.517447	2024-11-24 13:44:58.517447	Imran Hossain	imranhossain662610@gmail.com	1715033777	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
303	2024-09-14 18:37:47.254436	2024-11-24 13:44:58.520176	2024-11-24 13:44:58.520176	Sneha	ac3270181@gmail.com	+8801625254307	Bangladesh	\N	Dhaka District	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
298	2024-09-14 18:37:47.210891	2024-11-24 13:44:58.579266	2024-11-24 13:44:58.579266	MD Toofan	rock.toofan@gmail.com	8635190	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	wrong number	13	\N
304	2024-09-14 18:37:47.261656	2024-11-24 13:44:58.52333	2024-11-24 13:44:58.52333	Arfin Islam	arfinislam@ymail.com	1676999652	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Busy	13	\N
301	2024-09-14 18:37:47.236328	2024-11-24 13:44:58.525864	2024-11-24 13:44:58.525864	Ahmed Shanto	ahmedshanto2312@gmail.com	1619164673	Bangladesh	\N	Bahadia	Dhaka	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Lead updated by Jarin	13	\N
306	2024-09-14 18:37:47.277182	2024-11-24 13:44:58.52751	2024-11-24 13:44:58.52751	Md. Rashed	creative.engr.bd@gmail.com	1874621251	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No answer	13	\N
299	2024-09-14 18:37:47.217874	2024-11-24 13:44:58.576051	2024-11-24 13:44:58.576051	Nasir Uudin	nasiruudin090@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Wrong number	13	\N
293	2024-09-14 18:37:47.170975	2024-11-24 13:44:58.6273	2024-11-24 13:44:58.6273	Sarbland Shiwan	sarbland.shiwan2022@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Wrong Number 	13	\N
292	2024-09-14 18:37:47.163214	2024-11-24 13:44:58.630812	2024-11-24 13:44:58.630812	Easmin Kabir Chy	easminkabir181@gmail.com	1602790164	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	No Answer	13	\N
291	2024-09-14 18:37:47.153365	2024-11-24 13:44:58.643094	2024-11-24 13:44:58.643094	Montazer Rahman	rahmanmontezar579@gmeil.com	1952424890	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	Number missing	13	\N
290	2024-09-14 18:37:47.141856	2024-11-24 13:44:58.650556	2024-11-24 13:44:58.650556	Uzzal PK	uzzalpk@gmail.com	1771574717	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Bad	14	\N
289	2024-09-14 18:37:47.13086	2024-11-24 13:44:58.672637	2024-11-24 13:44:58.672637	Biren Chandra Sen	birensen54@gmail.com	1874195471	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	future-interest	internal	f	\N	\N	He will take ielts within December	14	\N
287	2024-09-14 18:37:47.116482	2024-11-24 13:44:58.681634	2024-11-24 13:44:58.681634	Monalisa Shakh	monalisa857808@gmail.com	1741233010	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Long study gap. HSC 2008	14	\N
358	2024-11-24 13:09:47.003614	2024-11-24 13:44:57.75909	2024-11-24 13:44:57.75909	11/01/2024 9:10am	Adnan Habib Siyam	adnanhabib7678@gmail.com	Paid	\N	Education Doorway Dhanmondi AD	Email address	Mirpur	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	\N	6	\N
339	2024-09-14 18:37:47.535663	2024-11-24 13:44:57.952676	2024-11-24 13:44:57.952676	Tanvir Alam	tanviralamdnmc423@gmail.com	1951809458	Bangladesh	\N	Dhaka District	dhaka	Mirpur	\N	\N	\N	\N	study-abroad	potential	postponed	internal	f	\N	\N	he will visit office after ielts 	1	\N
340	2024-09-14 18:37:47.545746	2024-11-24 13:44:57.956672	2024-11-24 13:44:57.956672	Md Sha Kir NC	mdshakirsk705@gmail.com	10843162716	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	new	internal	f	\N	\N	Lead updated by Farzana	14	\N
338	2024-09-14 18:37:47.526801	2024-11-24 13:44:57.964814	2024-11-24 13:44:57.964814	Asadul Haque	19806126502000005@gmail.com	01876126810w	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	phone was switch off	14	\N
327	2024-09-14 18:37:47.448509	2024-11-24 13:44:58.200156	2024-11-24 13:44:58.200156	অবিশ্বাসী দের অবহেলার পাত্র	farukhislam33@gmail.com	1314296926	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	not-interested	internal	f	\N	\N	Lead updated by Farzana	14	\N
281	2024-09-14 18:37:47.071664	2024-11-24 13:44:58.828447	2024-11-24 13:44:58.828447	Sazzad Hossain Noyon	sazzadbuft152@gmail.com	8800000000000	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no phone number	14	\N
230	2024-09-14 18:37:46.647667	2024-11-24 13:46:43.685339	2024-11-24 13:46:43.685339	Fahi Zaber	fahipriya2406@gmail.com	1765496894	\N	\N	\N	\N	Dhanmondi	\N	\N	\N	\N	study-abroad	lead	unreachable	internal	f	\N	\N	no response	14	\N
\.


--
-- Data for Name: lead_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead_document (id, created_at, updated_at, deleted_at, document_name, document_link, "leadId") FROM stdin;
5	2024-09-18 14:20:23.766033	2024-09-18 14:20:23.821963	\N	Offer Letter	itsnextbigthing/educationdoorway/d9e31b94-df95-436d-b372-845d6d296fa9-Shamma Saiyara-UOH Offer.pdf	341
8	2024-09-26 15:29:52.833357	2024-09-26 15:29:53.006514	\N	Passport	itsnextbigthing/educationdoorway/882df2f9-3cc1-4ae8-be96-b64ddad4e2e8-passport.pdf	345
6	2024-09-26 15:29:52.829807	2024-09-26 15:29:53.006514	\N	CV	itsnextbigthing/educationdoorway/cd955f0c-967c-4f0c-8cb9-e89ade5e58c9-Shuva Revised CV.pdf	345
7	2024-09-26 15:29:52.830963	2024-09-26 15:29:53.006514	\N	SOP	itsnextbigthing/educationdoorway/371bfbc9-b672-459a-bb51-31ca71077150-Statement of Purpose1.pdf	345
11	2024-09-26 15:29:52.83777	2024-09-26 15:29:53.006514	\N	SSC/O-Level	itsnextbigthing/educationdoorway/041fe3df-4d44-4304-851d-95f5f2a87069-Secondary School Certificate (SSC).pdf	345
10	2024-09-26 15:29:52.836892	2024-09-26 15:29:53.006514	\N	HSC/A-Level	itsnextbigthing/educationdoorway/bd48b8fe-d8e3-4f83-8245-572e035956eb-Higher Secondary School Certificate (HSC).pdf	345
9	2024-09-26 15:29:52.834244	2024-09-26 15:29:53.006514	\N	Bachelor	itsnextbigthing/educationdoorway/19a0fc31-e891-4129-b2c3-818fa146bb53-MBBS_Certificate_University of Rajshahi.pdf	345
\.


--
-- Data for Name: mail_cred; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mail_cred (id, created_at, updated_at, deleted_at, smtp_host, smtp_port, smtp_from, smtp_user, smtp_password) FROM stdin;
\.


--
-- Data for Name: metacridential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metacridential (id, created_at, updated_at, deleted_at, app_id, app_secret, page_id, page_access_token) FROM stdin;
\.


--
-- Data for Name: module_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.module_permission (id, name, created_at, updated_at, deleted_at, "moduleId", "permissionId") FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, created_at, updated_at, deleted_at, "userId", message, "isRead", url) FROM stdin;
63	2024-09-18 06:45:40.486678	2024-09-18 06:45:40.486678	\N	13	Naf assigned you a new lead	f	lead-create/336
64	2024-09-18 06:45:40.532943	2024-09-18 06:45:40.532943	\N	13	Naf assigned you a new lead	f	lead-create/335
65	2024-09-18 06:45:40.533621	2024-09-18 06:45:40.533621	\N	13	Naf assigned you a new lead	f	lead-create/340
66	2024-09-18 06:45:40.535409	2024-09-18 06:45:40.535409	\N	13	Naf assigned you a new lead	f	lead-create/337
67	2024-09-18 06:45:40.535588	2024-09-18 06:45:40.535588	\N	13	Naf assigned you a new lead	f	lead-create/338
40	2024-09-14 10:09:00.941313	2024-09-14 14:48:41.897545	\N	1	Naf assigned you a new lead	t	lead-create/188
41	2024-09-16 15:30:51.516063	2024-09-16 17:07:21.399411	\N	1	Naf assigned you a new lead	t	lead-create/341
42	2024-09-18 06:40:36.539774	2024-09-18 06:40:36.539774	\N	14	Naf 'assigned you a new task '	f	tasks
43	2024-09-18 06:42:16.312564	2024-09-18 06:42:16.312564	\N	14	Naf assigned you a new lead	f	lead-create/337
44	2024-09-18 06:42:16.313151	2024-09-18 06:42:16.313151	\N	14	Naf assigned you a new lead	f	lead-create/336
45	2024-09-18 06:42:16.323439	2024-09-18 06:42:16.323439	\N	14	Naf assigned you a new lead	f	lead-create/335
46	2024-09-18 06:42:16.327141	2024-09-18 06:42:16.327141	\N	14	Naf assigned you a new lead	f	lead-create/338
47	2024-09-18 06:42:16.337066	2024-09-18 06:42:16.337066	\N	14	Naf assigned you a new lead	f	lead-create/334
48	2024-09-18 06:42:16.338563	2024-09-18 06:42:16.338563	\N	14	Naf assigned you a new lead	f	lead-create/340
50	2024-09-18 06:42:16.479992	2024-09-18 06:42:16.479992	\N	14	Naf assigned you a new lead	f	lead-create/332
49	2024-09-18 06:42:16.479767	2024-09-18 06:42:16.479767	\N	14	Naf assigned you a new lead	f	lead-create/333
51	2024-09-18 06:42:16.487009	2024-09-18 06:42:16.487009	\N	14	Naf assigned you a new lead	f	lead-create/331
52	2024-09-18 06:42:16.505276	2024-09-18 06:42:16.505276	\N	14	Naf assigned you a new lead	f	lead-create/330
53	2024-09-18 06:43:05.16055	2024-09-18 06:43:05.16055	\N	14	Naf assigned you a new lead	f	lead-create/329
54	2024-09-18 06:43:05.161511	2024-09-18 06:43:05.161511	\N	14	Naf assigned you a new lead	f	lead-create/328
55	2024-09-18 06:43:05.164144	2024-09-18 06:43:05.164144	\N	14	Naf assigned you a new lead	f	lead-create/324
56	2024-09-18 06:43:05.17391	2024-09-18 06:43:05.17391	\N	14	Naf assigned you a new lead	f	lead-create/327
57	2024-09-18 06:43:05.17413	2024-09-18 06:43:05.17413	\N	14	Naf assigned you a new lead	f	lead-create/325
58	2024-09-18 06:43:05.176261	2024-09-18 06:43:05.176261	\N	14	Naf assigned you a new lead	f	lead-create/326
59	2024-09-18 06:43:05.260078	2024-09-18 06:43:05.260078	\N	14	Naf assigned you a new lead	f	lead-create/323
60	2024-09-18 06:43:05.260275	2024-09-18 06:43:05.260275	\N	14	Naf assigned you a new lead	f	lead-create/322
61	2024-09-18 06:43:05.283722	2024-09-18 06:43:05.283722	\N	14	Naf assigned you a new lead	f	lead-create/321
62	2024-09-18 06:43:05.287124	2024-09-18 06:43:05.287124	\N	14	Naf assigned you a new lead	f	lead-create/320
68	2024-09-18 06:45:40.538043	2024-09-18 06:45:40.538043	\N	13	Naf assigned you a new lead	f	lead-create/334
69	2024-09-18 06:45:40.659827	2024-09-18 06:45:40.659827	\N	13	Naf assigned you a new lead	f	lead-create/333
70	2024-09-18 06:45:40.66542	2024-09-18 06:45:40.66542	\N	13	Naf assigned you a new lead	f	lead-create/332
71	2024-09-18 06:45:40.667706	2024-09-18 06:45:40.667706	\N	13	Naf assigned you a new lead	f	lead-create/331
72	2024-09-18 06:45:40.693893	2024-09-18 06:45:40.693893	\N	13	Naf assigned you a new lead	f	lead-create/330
73	2024-09-18 06:46:00.509121	2024-09-18 06:46:00.509121	\N	14	Naf assigned you a new lead	f	lead-create/334
74	2024-09-18 06:46:00.512327	2024-09-18 06:46:00.512327	\N	14	Naf assigned you a new lead	f	lead-create/338
75	2024-09-18 06:46:00.51582	2024-09-18 06:46:00.51582	\N	14	Naf assigned you a new lead	f	lead-create/335
76	2024-09-18 06:46:00.518436	2024-09-18 06:46:00.518436	\N	14	Naf assigned you a new lead	f	lead-create/337
77	2024-09-18 06:46:00.525908	2024-09-18 06:46:00.525908	\N	14	Naf assigned you a new lead	f	lead-create/336
78	2024-09-18 06:46:00.526079	2024-09-18 06:46:00.526079	\N	14	Naf assigned you a new lead	f	lead-create/340
79	2024-09-18 06:46:00.657406	2024-09-18 06:46:00.657406	\N	14	Naf assigned you a new lead	f	lead-create/332
80	2024-09-18 06:46:00.659905	2024-09-18 06:46:00.659905	\N	14	Naf assigned you a new lead	f	lead-create/331
81	2024-09-18 06:46:00.664896	2024-09-18 06:46:00.664896	\N	14	Naf assigned you a new lead	f	lead-create/333
82	2024-09-18 06:46:00.672674	2024-09-18 06:46:00.672674	\N	14	Naf assigned you a new lead	f	lead-create/330
83	2024-09-18 06:54:16.11831	2024-09-18 06:54:16.11831	\N	13	Naf assigned you a new lead	f	lead-create/340
84	2024-09-18 06:54:16.125182	2024-09-18 06:54:16.125182	\N	13	Naf assigned you a new lead	f	lead-create/338
85	2024-09-18 06:54:16.247296	2024-09-18 06:54:16.247296	\N	13	Naf assigned you a new lead	f	lead-create/336
86	2024-09-18 06:54:16.248957	2024-09-18 06:54:16.248957	\N	13	Naf assigned you a new lead	f	lead-create/337
87	2024-09-18 06:54:16.266476	2024-09-18 06:54:16.266476	\N	13	Naf assigned you a new lead	f	lead-create/335
88	2024-09-18 06:54:16.282641	2024-09-18 06:54:16.282641	\N	13	Naf assigned you a new lead	f	lead-create/333
89	2024-09-18 06:54:16.294982	2024-09-18 06:54:16.294982	\N	13	Naf assigned you a new lead	f	lead-create/332
90	2024-09-18 06:54:16.318295	2024-09-18 06:54:16.318295	\N	13	Naf assigned you a new lead	f	lead-create/334
91	2024-09-18 06:54:16.366448	2024-09-18 06:54:16.366448	\N	13	Naf assigned you a new lead	f	lead-create/331
92	2024-09-18 06:54:16.401781	2024-09-18 06:54:16.401781	\N	13	Naf assigned you a new lead	f	lead-create/330
93	2024-09-18 06:54:31.278153	2024-09-18 06:54:31.278153	\N	14	Naf assigned you a new lead	f	lead-create/334
94	2024-09-18 06:54:31.288197	2024-09-18 06:54:31.288197	\N	14	Naf assigned you a new lead	f	lead-create/337
95	2024-09-18 06:54:31.296314	2024-09-18 06:54:31.296314	\N	14	Naf assigned you a new lead	f	lead-create/338
96	2024-09-18 06:54:31.301485	2024-09-18 06:54:31.301485	\N	14	Naf assigned you a new lead	f	lead-create/340
97	2024-09-18 06:54:31.309031	2024-09-18 06:54:31.309031	\N	14	Naf assigned you a new lead	f	lead-create/336
98	2024-09-18 06:54:31.31429	2024-09-18 06:54:31.31429	\N	14	Naf assigned you a new lead	f	lead-create/335
99	2024-09-18 06:54:31.443712	2024-09-18 06:54:31.443712	\N	14	Naf assigned you a new lead	f	lead-create/333
100	2024-09-18 06:54:31.463909	2024-09-18 06:54:31.463909	\N	14	Naf assigned you a new lead	f	lead-create/331
101	2024-09-18 06:54:31.466661	2024-09-18 06:54:31.466661	\N	14	Naf assigned you a new lead	f	lead-create/332
102	2024-09-18 06:54:31.482614	2024-09-18 06:54:31.482614	\N	14	Naf assigned you a new lead	f	lead-create/330
103	2024-09-18 07:03:04.410026	2024-09-18 07:03:04.410026	\N	13	Naf assigned you a new lead	f	lead-create/314
104	2024-09-18 07:03:04.411534	2024-09-18 07:03:04.411534	\N	13	Naf assigned you a new lead	f	lead-create/315
105	2024-09-18 07:03:04.433328	2024-09-18 07:03:04.433328	\N	13	Naf assigned you a new lead	f	lead-create/316
106	2024-09-18 07:03:04.436469	2024-09-18 07:03:04.436469	\N	13	Naf assigned you a new lead	f	lead-create/317
107	2024-09-18 07:03:04.466954	2024-09-18 07:03:04.466954	\N	13	Naf assigned you a new lead	f	lead-create/319
108	2024-09-18 07:03:04.481105	2024-09-18 07:03:04.481105	\N	13	Naf assigned you a new lead	f	lead-create/318
109	2024-09-18 07:03:04.57507	2024-09-18 07:03:04.57507	\N	13	Naf assigned you a new lead	f	lead-create/312
110	2024-09-18 07:03:04.576138	2024-09-18 07:03:04.576138	\N	13	Naf assigned you a new lead	f	lead-create/313
111	2024-09-18 07:03:04.600601	2024-09-18 07:03:04.600601	\N	13	Naf assigned you a new lead	f	lead-create/310
112	2024-09-18 07:03:04.603112	2024-09-18 07:03:04.603112	\N	13	Naf assigned you a new lead	f	lead-create/311
113	2024-09-18 07:04:06.423942	2024-09-18 07:04:06.423942	\N	14	Naf assigned you a new lead	f	lead-create/314
115	2024-09-18 07:04:06.429983	2024-09-18 07:04:06.429983	\N	14	Naf assigned you a new lead	f	lead-create/318
116	2024-09-18 07:04:06.434801	2024-09-18 07:04:06.434801	\N	14	Naf assigned you a new lead	f	lead-create/319
114	2024-09-18 07:04:06.428992	2024-09-18 07:04:06.428992	\N	14	Naf assigned you a new lead	f	lead-create/316
117	2024-09-18 07:04:06.436094	2024-09-18 07:04:06.436094	\N	14	Naf assigned you a new lead	f	lead-create/315
118	2024-09-18 07:04:06.438354	2024-09-18 07:04:06.438354	\N	14	Naf assigned you a new lead	f	lead-create/317
119	2024-09-18 07:04:06.607563	2024-09-18 07:04:06.607563	\N	14	Naf assigned you a new lead	f	lead-create/311
120	2024-09-18 07:04:06.61944	2024-09-18 07:04:06.61944	\N	14	Naf assigned you a new lead	f	lead-create/310
121	2024-09-18 07:04:06.62523	2024-09-18 07:04:06.62523	\N	14	Naf assigned you a new lead	f	lead-create/313
122	2024-09-18 07:04:06.653087	2024-09-18 07:04:06.653087	\N	14	Naf assigned you a new lead	f	lead-create/312
123	2024-09-18 07:04:51.927003	2024-09-18 07:04:51.927003	\N	14	Naf assigned you a new lead	f	lead-create/304
124	2024-09-18 07:04:51.926543	2024-09-18 07:04:51.926543	\N	14	Naf assigned you a new lead	f	lead-create/305
125	2024-09-18 07:04:51.929157	2024-09-18 07:04:51.929157	\N	14	Naf assigned you a new lead	f	lead-create/309
126	2024-09-18 07:04:51.932261	2024-09-18 07:04:51.932261	\N	14	Naf assigned you a new lead	f	lead-create/308
127	2024-09-18 07:04:51.936459	2024-09-18 07:04:51.936459	\N	14	Naf assigned you a new lead	f	lead-create/306
128	2024-09-18 07:04:51.938944	2024-09-18 07:04:51.938944	\N	14	Naf assigned you a new lead	f	lead-create/307
129	2024-09-18 07:04:52.07681	2024-09-18 07:04:52.07681	\N	14	Naf assigned you a new lead	f	lead-create/303
130	2024-09-18 07:04:52.093893	2024-09-18 07:04:52.093893	\N	14	Naf assigned you a new lead	f	lead-create/301
131	2024-09-18 07:04:52.099337	2024-09-18 07:04:52.099337	\N	14	Naf assigned you a new lead	f	lead-create/302
132	2024-09-18 07:04:52.104467	2024-09-18 07:04:52.104467	\N	14	Naf assigned you a new lead	f	lead-create/300
133	2024-09-18 07:05:12.35759	2024-09-18 07:05:12.35759	\N	13	Naf assigned you a new lead	f	lead-create/299
134	2024-09-18 07:05:12.362354	2024-09-18 07:05:12.362354	\N	13	Naf assigned you a new lead	f	lead-create/294
135	2024-09-18 07:05:12.363829	2024-09-18 07:05:12.363829	\N	13	Naf assigned you a new lead	f	lead-create/296
136	2024-09-18 07:05:12.365156	2024-09-18 07:05:12.365156	\N	13	Naf assigned you a new lead	f	lead-create/295
138	2024-09-18 07:05:12.36805	2024-09-18 07:05:12.36805	\N	13	Naf assigned you a new lead	f	lead-create/297
137	2024-09-18 07:05:12.366556	2024-09-18 07:05:12.366556	\N	13	Naf assigned you a new lead	f	lead-create/298
139	2024-09-18 07:05:12.499339	2024-09-18 07:05:12.499339	\N	13	Naf assigned you a new lead	f	lead-create/293
140	2024-09-18 07:05:12.522112	2024-09-18 07:05:12.522112	\N	13	Naf assigned you a new lead	f	lead-create/292
141	2024-09-18 07:05:12.528864	2024-09-18 07:05:12.528864	\N	13	Naf assigned you a new lead	f	lead-create/291
142	2024-09-18 07:05:12.536422	2024-09-18 07:05:12.536422	\N	13	Naf assigned you a new lead	f	lead-create/290
143	2024-09-18 07:05:36.650438	2024-09-18 07:05:36.650438	\N	13	Naf assigned you a new lead	f	lead-create/287
144	2024-09-18 07:05:36.65983	2024-09-18 07:05:36.65983	\N	13	Naf assigned you a new lead	f	lead-create/285
145	2024-09-18 07:05:36.716038	2024-09-18 07:05:36.716038	\N	13	Naf assigned you a new lead	f	lead-create/284
146	2024-09-18 07:05:36.721859	2024-09-18 07:05:36.721859	\N	13	Naf assigned you a new lead	f	lead-create/286
147	2024-09-18 07:05:36.725442	2024-09-18 07:05:36.725442	\N	13	Naf assigned you a new lead	f	lead-create/289
148	2024-09-18 07:05:36.728184	2024-09-18 07:05:36.728184	\N	13	Naf assigned you a new lead	f	lead-create/288
149	2024-09-18 07:05:36.912643	2024-09-18 07:05:36.912643	\N	13	Naf assigned you a new lead	f	lead-create/282
150	2024-09-18 07:05:36.929085	2024-09-18 07:05:36.929085	\N	13	Naf assigned you a new lead	f	lead-create/283
151	2024-09-18 07:05:36.937135	2024-09-18 07:05:36.937135	\N	13	Naf assigned you a new lead	f	lead-create/281
152	2024-09-18 07:05:36.943418	2024-09-18 07:05:36.943418	\N	13	Naf assigned you a new lead	f	lead-create/280
153	2024-09-18 07:06:08.961752	2024-09-18 07:06:08.961752	\N	14	Naf assigned you a new lead	f	lead-create/275
156	2024-09-18 07:06:08.9683	2024-09-18 07:06:08.9683	\N	14	Naf assigned you a new lead	f	lead-create/276
157	2024-09-18 07:06:08.968366	2024-09-18 07:06:08.968366	\N	14	Naf assigned you a new lead	f	lead-create/278
155	2024-09-18 07:06:08.968287	2024-09-18 07:06:08.968287	\N	14	Naf assigned you a new lead	f	lead-create/279
154	2024-09-18 07:06:08.968174	2024-09-18 07:06:08.968174	\N	14	Naf assigned you a new lead	f	lead-create/277
158	2024-09-18 07:06:08.977713	2024-09-18 07:06:08.977713	\N	14	Naf assigned you a new lead	f	lead-create/274
159	2024-09-18 07:06:09.135316	2024-09-18 07:06:09.135316	\N	14	Naf assigned you a new lead	f	lead-create/272
160	2024-09-18 07:06:09.136341	2024-09-18 07:06:09.136341	\N	14	Naf assigned you a new lead	f	lead-create/271
161	2024-09-18 07:06:09.138683	2024-09-18 07:06:09.138683	\N	14	Naf assigned you a new lead	f	lead-create/273
162	2024-09-18 07:06:09.16517	2024-09-18 07:06:09.16517	\N	14	Naf assigned you a new lead	f	lead-create/270
163	2024-09-18 07:06:25.440178	2024-09-18 07:06:25.440178	\N	14	Naf assigned you a new lead	f	lead-create/265
164	2024-09-18 07:06:25.43995	2024-09-18 07:06:25.43995	\N	14	Naf assigned you a new lead	f	lead-create/267
165	2024-09-18 07:06:25.478636	2024-09-18 07:06:25.478636	\N	14	Naf assigned you a new lead	f	lead-create/264
166	2024-09-18 07:06:25.479596	2024-09-18 07:06:25.479596	\N	14	Naf assigned you a new lead	f	lead-create/268
167	2024-09-18 07:06:25.480859	2024-09-18 07:06:25.480859	\N	14	Naf assigned you a new lead	f	lead-create/269
168	2024-09-18 07:06:25.501918	2024-09-18 07:06:25.501918	\N	14	Naf assigned you a new lead	f	lead-create/266
169	2024-09-18 07:06:25.617532	2024-09-18 07:06:25.617532	\N	14	Naf assigned you a new lead	f	lead-create/263
170	2024-09-18 07:06:25.618246	2024-09-18 07:06:25.618246	\N	14	Naf assigned you a new lead	f	lead-create/262
171	2024-09-18 07:06:25.643934	2024-09-18 07:06:25.643934	\N	14	Naf assigned you a new lead	f	lead-create/261
172	2024-09-18 07:06:25.663438	2024-09-18 07:06:25.663438	\N	14	Naf assigned you a new lead	f	lead-create/260
174	2024-09-18 07:06:39.845785	2024-09-18 07:06:39.845785	\N	13	Naf assigned you a new lead	f	lead-create/254
173	2024-09-18 07:06:39.845542	2024-09-18 07:06:39.845542	\N	13	Naf assigned you a new lead	f	lead-create/256
175	2024-09-18 07:06:39.90055	2024-09-18 07:06:39.90055	\N	13	Naf assigned you a new lead	f	lead-create/257
176	2024-09-18 07:06:39.900606	2024-09-18 07:06:39.900606	\N	13	Naf assigned you a new lead	f	lead-create/255
177	2024-09-18 07:06:39.90147	2024-09-18 07:06:39.90147	\N	13	Naf assigned you a new lead	f	lead-create/259
178	2024-09-18 07:06:39.90272	2024-09-18 07:06:39.90272	\N	13	Naf assigned you a new lead	f	lead-create/258
179	2024-09-18 07:06:40.028894	2024-09-18 07:06:40.028894	\N	13	Naf assigned you a new lead	f	lead-create/252
180	2024-09-18 07:06:40.033326	2024-09-18 07:06:40.033326	\N	13	Naf assigned you a new lead	f	lead-create/253
181	2024-09-18 07:06:40.041463	2024-09-18 07:06:40.041463	\N	13	Naf assigned you a new lead	f	lead-create/251
182	2024-09-18 07:06:40.054018	2024-09-18 07:06:40.054018	\N	13	Naf assigned you a new lead	f	lead-create/250
183	2024-09-18 07:07:02.095652	2024-09-18 07:07:02.095652	\N	14	Naf assigned you a new lead	f	lead-create/248
184	2024-09-18 07:07:02.097826	2024-09-18 07:07:02.097826	\N	14	Naf assigned you a new lead	f	lead-create/244
185	2024-09-18 07:07:02.103081	2024-09-18 07:07:02.103081	\N	14	Naf assigned you a new lead	f	lead-create/247
186	2024-09-18 07:07:02.106112	2024-09-18 07:07:02.106112	\N	14	Naf assigned you a new lead	f	lead-create/246
187	2024-09-18 07:07:02.108001	2024-09-18 07:07:02.108001	\N	14	Naf assigned you a new lead	f	lead-create/245
188	2024-09-18 07:07:02.109718	2024-09-18 07:07:02.109718	\N	14	Naf assigned you a new lead	f	lead-create/249
189	2024-09-18 07:07:02.262208	2024-09-18 07:07:02.262208	\N	14	Naf assigned you a new lead	f	lead-create/243
190	2024-09-18 07:07:02.266847	2024-09-18 07:07:02.266847	\N	14	Naf assigned you a new lead	f	lead-create/242
191	2024-09-18 07:07:02.276841	2024-09-18 07:07:02.276841	\N	14	Naf assigned you a new lead	f	lead-create/240
192	2024-09-18 07:07:02.290568	2024-09-18 07:07:02.290568	\N	14	Naf assigned you a new lead	f	lead-create/241
193	2024-09-18 07:07:14.919005	2024-09-18 07:07:14.919005	\N	14	Naf assigned you a new lead	f	lead-create/236
194	2024-09-18 07:07:14.925944	2024-09-18 07:07:14.925944	\N	14	Naf assigned you a new lead	f	lead-create/235
195	2024-09-18 07:07:14.947428	2024-09-18 07:07:14.947428	\N	14	Naf assigned you a new lead	f	lead-create/239
196	2024-09-18 07:07:14.986595	2024-09-18 07:07:14.986595	\N	14	Naf assigned you a new lead	f	lead-create/238
197	2024-09-18 07:07:14.990059	2024-09-18 07:07:14.990059	\N	14	Naf assigned you a new lead	f	lead-create/234
198	2024-09-18 07:07:14.995167	2024-09-18 07:07:14.995167	\N	14	Naf assigned you a new lead	f	lead-create/237
199	2024-09-18 07:07:15.071326	2024-09-18 07:07:15.071326	\N	14	Naf assigned you a new lead	f	lead-create/233
200	2024-09-18 07:07:15.132572	2024-09-18 07:07:15.132572	\N	14	Naf assigned you a new lead	f	lead-create/230
201	2024-09-18 07:07:15.132295	2024-09-18 07:07:15.132295	\N	14	Naf assigned you a new lead	f	lead-create/232
202	2024-09-18 07:07:15.13749	2024-09-18 07:07:15.13749	\N	14	Naf assigned you a new lead	f	lead-create/231
203	2024-09-18 07:07:35.780247	2024-09-18 07:07:35.780247	\N	13	Naf assigned you a new lead	f	lead-create/226
204	2024-09-18 07:07:35.790191	2024-09-18 07:07:35.790191	\N	13	Naf assigned you a new lead	f	lead-create/225
205	2024-09-18 07:07:35.840978	2024-09-18 07:07:35.840978	\N	13	Naf assigned you a new lead	f	lead-create/224
206	2024-09-18 07:07:35.843768	2024-09-18 07:07:35.843768	\N	13	Naf assigned you a new lead	f	lead-create/228
207	2024-09-18 07:07:35.859113	2024-09-18 07:07:35.859113	\N	13	Naf assigned you a new lead	f	lead-create/229
208	2024-09-18 07:07:35.8604	2024-09-18 07:07:35.8604	\N	13	Naf assigned you a new lead	f	lead-create/227
209	2024-09-18 07:07:35.926998	2024-09-18 07:07:35.926998	\N	13	Naf assigned you a new lead	f	lead-create/223
210	2024-09-18 07:07:35.978414	2024-09-18 07:07:35.978414	\N	13	Naf assigned you a new lead	f	lead-create/221
211	2024-09-18 07:07:35.981682	2024-09-18 07:07:35.981682	\N	13	Naf assigned you a new lead	f	lead-create/222
212	2024-09-18 07:07:35.993176	2024-09-18 07:07:35.993176	\N	13	Naf assigned you a new lead	f	lead-create/220
213	2024-09-18 07:07:51.663343	2024-09-18 07:07:51.663343	\N	13	Naf assigned you a new lead	f	lead-create/216
214	2024-09-18 07:07:51.686928	2024-09-18 07:07:51.686928	\N	13	Naf assigned you a new lead	f	lead-create/215
215	2024-09-18 07:07:51.719487	2024-09-18 07:07:51.719487	\N	13	Naf assigned you a new lead	f	lead-create/217
216	2024-09-18 07:07:51.717482	2024-09-18 07:07:51.717482	\N	13	Naf assigned you a new lead	f	lead-create/214
217	2024-09-18 07:07:51.723638	2024-09-18 07:07:51.723638	\N	13	Naf assigned you a new lead	f	lead-create/219
218	2024-09-18 07:07:51.728552	2024-09-18 07:07:51.728552	\N	13	Naf assigned you a new lead	f	lead-create/218
219	2024-09-18 07:07:51.813778	2024-09-18 07:07:51.813778	\N	13	Naf assigned you a new lead	f	lead-create/213
220	2024-09-18 07:07:51.841192	2024-09-18 07:07:51.841192	\N	13	Naf assigned you a new lead	f	lead-create/212
221	2024-09-18 07:07:51.860745	2024-09-18 07:07:51.860745	\N	13	Naf assigned you a new lead	f	lead-create/210
222	2024-09-18 07:07:51.867162	2024-09-18 07:07:51.867162	\N	13	Naf assigned you a new lead	f	lead-create/211
223	2024-09-18 07:08:05.907544	2024-09-18 07:08:05.907544	\N	14	Naf assigned you a new lead	f	lead-create/205
224	2024-09-18 07:08:05.912377	2024-09-18 07:08:05.912377	\N	14	Naf assigned you a new lead	f	lead-create/208
225	2024-09-18 07:08:05.975591	2024-09-18 07:08:05.975591	\N	14	Naf assigned you a new lead	f	lead-create/206
226	2024-09-18 07:08:05.97555	2024-09-18 07:08:05.97555	\N	14	Naf assigned you a new lead	f	lead-create/204
227	2024-09-18 07:08:05.979138	2024-09-18 07:08:05.979138	\N	14	Naf assigned you a new lead	f	lead-create/209
228	2024-09-18 07:08:06.00355	2024-09-18 07:08:06.00355	\N	14	Naf assigned you a new lead	f	lead-create/207
229	2024-09-18 07:08:06.12626	2024-09-18 07:08:06.12626	\N	14	Naf assigned you a new lead	f	lead-create/201
230	2024-09-18 07:08:06.131869	2024-09-18 07:08:06.131869	\N	14	Naf assigned you a new lead	f	lead-create/203
231	2024-09-18 07:08:06.134288	2024-09-18 07:08:06.134288	\N	14	Naf assigned you a new lead	f	lead-create/200
232	2024-09-18 07:08:06.137443	2024-09-18 07:08:06.137443	\N	14	Naf assigned you a new lead	f	lead-create/202
233	2024-09-18 07:08:19.291191	2024-09-18 07:08:19.291191	\N	13	Naf assigned you a new lead	f	lead-create/194
234	2024-09-18 07:08:19.293619	2024-09-18 07:08:19.293619	\N	13	Naf assigned you a new lead	f	lead-create/197
235	2024-09-18 07:08:19.32086	2024-09-18 07:08:19.32086	\N	13	Naf assigned you a new lead	f	lead-create/196
236	2024-09-18 07:08:19.326406	2024-09-18 07:08:19.326406	\N	13	Naf assigned you a new lead	f	lead-create/198
237	2024-09-18 07:08:19.327631	2024-09-18 07:08:19.327631	\N	13	Naf assigned you a new lead	f	lead-create/199
238	2024-09-18 07:08:19.330277	2024-09-18 07:08:19.330277	\N	13	Naf assigned you a new lead	f	lead-create/195
239	2024-09-18 07:08:19.457202	2024-09-18 07:08:19.457202	\N	13	Naf assigned you a new lead	f	lead-create/193
240	2024-09-18 07:08:19.483966	2024-09-18 07:08:19.483966	\N	13	Naf assigned you a new lead	f	lead-create/192
241	2024-09-18 07:08:19.491008	2024-09-18 07:08:19.491008	\N	13	Naf assigned you a new lead	f	lead-create/190
242	2024-09-18 07:08:19.501007	2024-09-18 07:08:19.501007	\N	13	Naf assigned you a new lead	f	lead-create/191
243	2024-09-18 07:08:34.13943	2024-09-18 07:08:34.13943	\N	14	Naf assigned you a new lead	f	lead-create/189
244	2024-09-21 09:23:26.707674	2024-09-21 09:23:26.707674	\N	13	Naf assigned you a new lead	f	lead-create/300
245	2024-09-21 09:23:26.712415	2024-09-21 09:23:26.712415	\N	13	Naf assigned you a new lead	f	lead-create/302
246	2024-09-21 09:23:26.712862	2024-09-21 09:23:26.712862	\N	13	Naf assigned you a new lead	f	lead-create/303
247	2024-09-21 09:23:26.719887	2024-09-21 09:23:26.719887	\N	13	Naf assigned you a new lead	f	lead-create/301
248	2024-09-21 09:25:38.518377	2024-09-21 09:25:38.518377	\N	14	Naf assigned you a new lead	f	lead-create/289
249	2024-09-21 09:25:38.523401	2024-09-21 09:25:38.523401	\N	14	Naf assigned you a new lead	f	lead-create/290
250	2024-09-21 09:25:38.525324	2024-09-21 09:25:38.525324	\N	14	Naf assigned you a new lead	f	lead-create/286
251	2024-09-21 09:25:38.525114	2024-09-21 09:25:38.525114	\N	14	Naf assigned you a new lead	f	lead-create/288
252	2024-09-21 09:25:38.529676	2024-09-21 09:25:38.529676	\N	14	Naf assigned you a new lead	f	lead-create/287
253	2024-09-21 09:25:38.534887	2024-09-21 09:25:38.534887	\N	14	Naf assigned you a new lead	f	lead-create/285
254	2024-09-21 09:25:38.697331	2024-09-21 09:25:38.697331	\N	14	Naf assigned you a new lead	f	lead-create/284
255	2024-09-21 09:26:52.525096	2024-09-21 09:26:52.525096	\N	14	Naf assigned you a new lead	f	lead-create/280
256	2024-09-21 09:26:52.527392	2024-09-21 09:26:52.527392	\N	14	Naf assigned you a new lead	f	lead-create/282
257	2024-09-21 09:26:52.543354	2024-09-21 09:26:52.543354	\N	14	Naf assigned you a new lead	f	lead-create/283
258	2024-09-21 09:26:52.544868	2024-09-21 09:26:52.544868	\N	14	Naf assigned you a new lead	f	lead-create/281
259	2024-09-21 09:28:46.495442	2024-09-21 09:28:46.495442	\N	13	Naf assigned you a new lead	f	lead-create/265
260	2024-09-21 09:28:46.49729	2024-09-21 09:28:46.49729	\N	13	Naf assigned you a new lead	f	lead-create/269
267	2024-09-21 09:29:57.55805	2024-09-21 18:14:31.44452	\N	13	Naf assigned you a new lead	t	lead-create/262
266	2024-09-21 09:29:57.554709	2024-09-21 18:18:30.048372	\N	13	Naf assigned you a new lead	t	lead-create/260
265	2024-09-21 09:29:57.533134	2024-09-21 18:20:16.074314	\N	13	Naf assigned you a new lead	t	lead-create/263
264	2024-09-21 09:28:46.500712	2024-09-21 18:22:56.051339	\N	13	Naf assigned you a new lead	t	lead-create/264
263	2024-09-21 09:28:46.499743	2024-09-21 18:25:09.377273	\N	13	Naf assigned you a new lead	t	lead-create/267
262	2024-09-21 09:28:46.498909	2024-09-21 18:26:24.839329	\N	13	Naf assigned you a new lead	t	lead-create/266
261	2024-09-21 09:28:46.498466	2024-09-21 18:27:15.127419	\N	13	Naf assigned you a new lead	t	lead-create/268
271	2024-09-21 09:36:00.162262	2024-09-21 09:36:00.162262	\N	14	Naf assigned you a new lead	f	lead-create/199
272	2024-09-21 09:36:00.385686	2024-09-21 09:36:00.385686	\N	14	Naf assigned you a new lead	f	lead-create/195
273	2024-09-21 09:36:00.392232	2024-09-21 09:36:00.392232	\N	14	Naf assigned you a new lead	f	lead-create/198
274	2024-09-21 09:36:00.395695	2024-09-21 09:36:00.395695	\N	14	Naf assigned you a new lead	f	lead-create/196
275	2024-09-21 09:36:00.405818	2024-09-21 09:36:00.405818	\N	14	Naf assigned you a new lead	f	lead-create/194
276	2024-09-21 09:36:00.406865	2024-09-21 09:36:00.406865	\N	14	Naf assigned you a new lead	f	lead-create/197
277	2024-09-21 09:36:29.405026	2024-09-21 09:36:29.405026	\N	14	Naf assigned you a new lead	f	lead-create/191
278	2024-09-21 09:36:29.407567	2024-09-21 09:36:29.407567	\N	14	Naf assigned you a new lead	f	lead-create/193
279	2024-09-21 09:36:29.414191	2024-09-21 09:36:29.414191	\N	14	Naf assigned you a new lead	f	lead-create/190
280	2024-09-21 09:36:29.418948	2024-09-21 09:36:29.418948	\N	14	Naf assigned you a new lead	f	lead-create/192
270	2024-09-21 09:34:38.303138	2024-09-21 17:25:11.220562	\N	13	Naf assigned you a new lead	t	lead-create/209
269	2024-09-21 09:30:29.247768	2024-09-21 17:25:57.816586	\N	13	Naf assigned you a new lead	t	lead-create/249
268	2024-09-21 09:29:57.558314	2024-09-21 17:27:49.907004	\N	13	Naf assigned you a new lead	t	lead-create/261
281	2024-09-22 06:15:09.118942	2024-09-22 06:15:09.118942	\N	13	Naf assigned you a new lead	f	lead-create/311
282	2024-09-22 06:15:09.121926	2024-09-22 06:15:09.121926	\N	13	Naf assigned you a new lead	f	lead-create/308
283	2024-09-22 06:15:09.122135	2024-09-22 06:15:09.122135	\N	13	Naf assigned you a new lead	f	lead-create/312
284	2024-09-22 06:15:09.126472	2024-09-22 06:15:09.126472	\N	13	Naf assigned you a new lead	f	lead-create/309
285	2024-09-22 06:15:09.128748	2024-09-22 06:15:09.128748	\N	13	Naf assigned you a new lead	f	lead-create/310
286	2024-09-22 06:15:09.129154	2024-09-22 06:15:09.129154	\N	13	Naf assigned you a new lead	f	lead-create/307
287	2024-09-22 06:15:09.273745	2024-09-22 06:15:09.273745	\N	13	Naf assigned you a new lead	f	lead-create/306
288	2024-09-22 06:15:09.28289	2024-09-22 06:15:09.28289	\N	13	Naf assigned you a new lead	f	lead-create/305
289	2024-09-22 06:15:09.317872	2024-09-22 06:15:09.317872	\N	13	Naf assigned you a new lead	f	lead-create/304
290	2024-09-26 15:29:52.799254	2024-09-26 15:29:52.799254	\N	11	Farzana assigned you a new lead	f	lead-details/345
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission (id, name, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: remark; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.remark (id, created_at, updated_at, deleted_at, previous_step, current_step, remark, "leadId", "assignedId") FROM stdin;
1153	2024-11-24 06:08:38.756567	2024-11-24 06:08:38.756567	\N	waiting-for-document	course-new	Lead updated by Farzana	337	14
1163	2024-11-24 12:45:49.908097	2024-11-24 12:45:49.908097	\N	course-new	new	Lead updated by Farzana	340	14
1173	2024-11-24 13:09:47.905577	2024-11-24 13:09:47.905577	\N	-	start	Lead created by Naf	364	1
1184	2024-11-24 13:09:47.918969	2024-11-24 13:09:47.918969	\N	-	start	Lead created by Naf	381	1
1193	2024-11-24 13:09:47.935565	2024-11-24 13:09:47.935565	\N	-	start	Lead created by Naf	385	1
1203	2024-11-24 13:09:47.942697	2024-11-24 13:09:47.942697	\N	-	start	Lead created by Naf	393	1
1217	2024-11-24 13:09:47.952481	2024-11-24 13:09:47.952481	\N	-	start	Lead created by Naf	413	1
1231	2024-11-24 13:09:47.968484	2024-11-24 13:09:47.968484	\N	-	start	Lead created by Naf	426	1
1241	2024-11-24 13:09:47.976629	2024-11-24 13:09:47.976629	\N	-	start	Lead created by Naf	428	1
1250	2024-11-24 13:09:47.986797	2024-11-24 13:09:47.986797	\N	-	start	Lead created by Naf	442	1
1262	2024-11-24 13:09:48.001751	2024-11-24 13:09:48.001751	\N	-	start	Lead created by Naf	454	1
1275	2024-11-24 13:09:48.014437	2024-11-24 13:09:48.014437	\N	-	start	Lead created by Naf	465	1
1282	2024-11-24 13:09:48.022283	2024-11-24 13:09:48.022283	\N	-	start	Lead created by Naf	477	1
1291	2024-11-24 13:09:48.028719	2024-11-24 13:09:48.028719	\N	-	start	Lead created by Naf	485	1
1301	2024-11-24 13:09:48.037379	2024-11-24 13:09:48.037379	\N	-	start	Lead created by Naf	496	1
1311	2024-11-24 13:09:48.049641	2024-11-24 13:09:48.049641	\N	-	start	Lead created by Naf	498	1
1328	2024-11-24 13:09:48.070408	2024-11-24 13:09:48.070408	\N	-	start	Lead created by Naf	521	1
1343	2024-11-24 13:09:48.081851	2024-11-24 13:09:48.081851	\N	-	start	Lead created by Naf	530	1
1353	2024-11-24 13:09:48.093249	2024-11-24 13:09:48.093249	\N	-	start	Lead created by Naf	553	1
1364	2024-11-24 13:09:48.102713	2024-11-24 13:09:48.102713	\N	-	start	Lead created by Naf	563	1
1375	2024-11-24 13:09:48.116972	2024-11-24 13:09:48.116972	\N	-	start	Lead created by Naf	564	1
1154	2024-11-24 06:08:44.504328	2024-11-24 06:08:44.504328	\N	course-new	new	Lead updated by Farzana	337	14
1164	2024-11-24 13:09:47.896348	2024-11-24 13:09:47.896348	\N	-	start	Lead created by Naf	358	1
1170	2024-11-24 13:09:47.904804	2024-11-24 13:09:47.904804	\N	-	start	Lead created by Naf	366	1
1180	2024-11-24 13:09:47.913786	2024-11-24 13:09:47.913786	\N	-	start	Lead created by Naf	363	1
1182	2024-11-24 13:09:47.912863	2024-11-24 13:09:47.912863	\N	-	start	Lead created by Naf	370	1
1190	2024-11-24 13:09:47.927993	2024-11-24 13:09:47.927993	\N	-	start	Lead created by Naf	369	1
1194	2024-11-24 13:09:47.936359	2024-11-24 13:09:47.936359	\N	-	start	Lead created by Naf	378	1
1198	2024-11-24 13:09:47.93969	2024-11-24 13:09:47.93969	\N	-	start	Lead created by Naf	387	1
1206	2024-11-24 13:09:47.944802	2024-11-24 13:09:47.944802	\N	-	start	Lead created by Naf	394	1
1207	2024-11-24 13:09:47.945686	2024-11-24 13:09:47.945686	\N	-	start	Lead created by Naf	397	1
1214	2024-11-24 13:09:47.950497	2024-11-24 13:09:47.950497	\N	-	start	Lead created by Naf	406	1
1223	2024-11-24 13:09:47.956416	2024-11-24 13:09:47.956416	\N	-	start	Lead created by Naf	414	1
1224	2024-11-24 13:09:47.961342	2024-11-24 13:09:47.961342	\N	-	start	Lead created by Naf	415	1
1232	2024-11-24 13:09:47.96985	2024-11-24 13:09:47.96985	\N	-	start	Lead created by Naf	424	1
1234	2024-11-24 13:09:47.972606	2024-11-24 13:09:47.972606	\N	-	start	Lead created by Naf	433	1
1239	2024-11-24 13:09:47.975922	2024-11-24 13:09:47.975922	\N	-	start	Lead created by Naf	431	1
1243	2024-11-24 13:09:47.980139	2024-11-24 13:09:47.980139	\N	-	start	Lead created by Naf	437	1
1248	2024-11-24 13:09:47.986008	2024-11-24 13:09:47.986008	\N	-	start	Lead created by Naf	440	1
1251	2024-11-24 13:09:47.989983	2024-11-24 13:09:47.989983	\N	-	start	Lead created by Naf	444	1
1256	2024-11-24 13:09:47.995189	2024-11-24 13:09:47.995189	\N	-	start	Lead created by Naf	449	1
1260	2024-11-24 13:09:48.000356	2024-11-24 13:09:48.000356	\N	-	start	Lead created by Naf	455	1
1266	2024-11-24 13:09:48.008859	2024-11-24 13:09:48.008859	\N	-	start	Lead created by Naf	460	1
1272	2024-11-24 13:09:48.014164	2024-11-24 13:09:48.014164	\N	-	start	Lead created by Naf	468	1
1274	2024-11-24 13:09:48.015504	2024-11-24 13:09:48.015504	\N	-	start	Lead created by Naf	463	1
1281	2024-11-24 13:09:48.022023	2024-11-24 13:09:48.022023	\N	-	start	Lead created by Naf	476	1
1287	2024-11-24 13:09:48.023221	2024-11-24 13:09:48.023221	\N	-	start	Lead created by Naf	481	1
1290	2024-11-24 13:09:48.02821	2024-11-24 13:09:48.02821	\N	-	start	Lead created by Naf	479	1
1294	2024-11-24 13:09:48.033744	2024-11-24 13:09:48.033744	\N	-	start	Lead created by Naf	488	1
1300	2024-11-24 13:09:48.037215	2024-11-24 13:09:48.037215	\N	-	start	Lead created by Naf	484	1
1304	2024-11-24 13:09:48.045624	2024-11-24 13:09:48.045624	\N	-	start	Lead created by Naf	499	1
1313	2024-11-24 13:09:48.049825	2024-11-24 13:09:48.049825	\N	-	start	Lead created by Naf	510	1
1314	2024-11-24 13:09:48.055513	2024-11-24 13:09:48.055513	\N	-	start	Lead created by Naf	505	1
1322	2024-11-24 13:09:48.065573	2024-11-24 13:09:48.065573	\N	-	start	Lead created by Naf	516	1
1327	2024-11-24 13:09:48.072752	2024-11-24 13:09:48.072752	\N	-	start	Lead created by Naf	518	1
1331	2024-11-24 13:09:48.075765	2024-11-24 13:09:48.075765	\N	-	start	Lead created by Naf	525	1
1337	2024-11-24 13:09:48.08134	2024-11-24 13:09:48.08134	\N	-	start	Lead created by Naf	532	1
1338	2024-11-24 13:09:48.081659	2024-11-24 13:09:48.081659	\N	-	start	Lead created by Naf	534	1
1348	2024-11-24 13:09:48.089426	2024-11-24 13:09:48.089426	\N	-	start	Lead created by Naf	544	1
1350	2024-11-24 13:09:48.089788	2024-11-24 13:09:48.089788	\N	-	start	Lead created by Naf	546	1
1357	2024-11-24 13:09:48.096723	2024-11-24 13:09:48.096723	\N	-	start	Lead created by Naf	550	1
1361	2024-11-24 13:09:48.099304	2024-11-24 13:09:48.099304	\N	-	start	Lead created by Naf	552	1
1366	2024-11-24 13:09:48.103691	2024-11-24 13:09:48.103691	\N	-	start	Lead created by Naf	556	1
1373	2024-11-24 13:09:48.115717	2024-11-24 13:09:48.115717	\N	-	start	Lead created by Naf	570	1
1376	2024-11-24 13:09:48.117292	2024-11-24 13:09:48.117292	\N	-	start	Lead created by Naf	566	1
1379	2024-11-24 13:09:48.124972	2024-11-24 13:09:48.124972	\N	-	start	Lead created by Naf	568	1
1155	2024-11-24 06:09:04.257663	2024-11-24 06:09:04.257663	\N	new	new	Lead updated by Farzana	337	14
1165	2024-11-24 13:09:47.896917	2024-11-24 13:09:47.896917	\N	-	start	Lead created by Naf	359	1
1186	2024-11-24 13:09:47.921458	2024-11-24 13:09:47.921458	\N	-	start	Lead created by Naf	371	1
1200	2024-11-24 13:09:47.940232	2024-11-24 13:09:47.940232	\N	-	start	Lead created by Naf	398	1
1209	2024-11-24 13:09:47.947554	2024-11-24 13:09:47.947554	\N	-	start	Lead created by Naf	396	1
1218	2024-11-24 13:09:47.954331	2024-11-24 13:09:47.954331	\N	-	start	Lead created by Naf	410	1
1226	2024-11-24 13:09:47.965581	2024-11-24 13:09:47.965581	\N	-	start	Lead created by Naf	421	1
1238	2024-11-24 13:09:47.973246	2024-11-24 13:09:47.973246	\N	-	start	Lead created by Naf	432	1
1247	2024-11-24 13:09:47.983922	2024-11-24 13:09:47.983922	\N	-	start	Lead created by Naf	439	1
1258	2024-11-24 13:09:47.998421	2024-11-24 13:09:47.998421	\N	-	start	Lead created by Naf	447	1
1268	2024-11-24 13:09:48.011777	2024-11-24 13:09:48.011777	\N	-	start	Lead created by Naf	462	1
1276	2024-11-24 13:09:48.018168	2024-11-24 13:09:48.018168	\N	-	start	Lead created by Naf	457	1
1284	2024-11-24 13:09:48.024121	2024-11-24 13:09:48.024121	\N	-	start	Lead created by Naf	470	1
1297	2024-11-24 13:09:48.034734	2024-11-24 13:09:48.034734	\N	-	start	Lead created by Naf	495	1
1305	2024-11-24 13:09:48.045851	2024-11-24 13:09:48.045851	\N	-	start	Lead created by Naf	501	1
1315	2024-11-24 13:09:48.055569	2024-11-24 13:09:48.055569	\N	-	start	Lead created by Naf	509	1
1323	2024-11-24 13:09:48.06567	2024-11-24 13:09:48.06567	\N	-	start	Lead created by Naf	513	1
1330	2024-11-24 13:09:48.07573	2024-11-24 13:09:48.07573	\N	-	start	Lead created by Naf	524	1
1342	2024-11-24 13:09:48.083919	2024-11-24 13:09:48.083919	\N	-	start	Lead created by Naf	536	1
1355	2024-11-24 13:09:48.092504	2024-11-24 13:09:48.092504	\N	-	start	Lead created by Naf	540	1
1370	2024-11-24 13:09:48.106935	2024-11-24 13:09:48.106935	\N	-	start	Lead created by Naf	562	1
1156	2024-11-24 06:11:40.749404	2024-11-24 06:11:40.749404	\N	new	unreachable	she did not pick my calls	337	14
1166	2024-11-24 13:09:47.896644	2024-11-24 13:09:47.896644	\N	-	start	Lead created by Naf	356	1
1176	2024-11-24 13:09:47.90848	2024-11-24 13:09:47.90848	\N	-	start	Lead created by Naf	372	1
1179	2024-11-24 13:09:47.913374	2024-11-24 13:09:47.913374	\N	-	start	Lead created by Naf	374	1
1189	2024-11-24 13:09:47.927604	2024-11-24 13:09:47.927604	\N	-	start	Lead created by Naf	384	1
1196	2024-11-24 13:09:47.938351	2024-11-24 13:09:47.938351	\N	-	start	Lead created by Naf	386	1
1204	2024-11-24 13:09:47.942862	2024-11-24 13:09:47.942862	\N	-	start	Lead created by Naf	400	1
1211	2024-11-24 13:09:47.948079	2024-11-24 13:09:47.948079	\N	-	start	Lead created by Naf	405	1
1220	2024-11-24 13:09:47.956451	2024-11-24 13:09:47.956451	\N	-	start	Lead created by Naf	409	1
1229	2024-11-24 13:09:47.966321	2024-11-24 13:09:47.966321	\N	-	start	Lead created by Naf	422	1
1236	2024-11-24 13:09:47.972993	2024-11-24 13:09:47.972993	\N	-	start	Lead created by Naf	434	1
1245	2024-11-24 13:09:47.983337	2024-11-24 13:09:47.983337	\N	-	start	Lead created by Naf	435	1
1253	2024-11-24 13:09:47.991399	2024-11-24 13:09:47.991399	\N	-	start	Lead created by Naf	450	1
1263	2024-11-24 13:09:48.002049	2024-11-24 13:09:48.002049	\N	-	start	Lead created by Naf	453	1
1270	2024-11-24 13:09:48.012208	2024-11-24 13:09:48.012208	\N	-	start	Lead created by Naf	467	1
1278	2024-11-24 13:09:48.019362	2024-11-24 13:09:48.019362	\N	-	start	Lead created by Naf	472	1
1288	2024-11-24 13:09:48.025405	2024-11-24 13:09:48.025405	\N	-	start	Lead created by Naf	482	1
1292	2024-11-24 13:09:48.032378	2024-11-24 13:09:48.032378	\N	-	start	Lead created by Naf	483	1
1302	2024-11-24 13:09:48.042995	2024-11-24 13:09:48.042995	\N	-	start	Lead created by Naf	492	1
1307	2024-11-24 13:09:48.046451	2024-11-24 13:09:48.046451	\N	-	start	Lead created by Naf	502	1
1317	2024-11-24 13:09:48.057355	2024-11-24 13:09:48.057355	\N	-	start	Lead created by Naf	504	1
1325	2024-11-24 13:09:48.070602	2024-11-24 13:09:48.070602	\N	-	start	Lead created by Naf	523	1
1334	2024-11-24 13:09:48.076672	2024-11-24 13:09:48.076672	\N	-	start	Lead created by Naf	529	1
1340	2024-11-24 13:09:48.082097	2024-11-24 13:09:48.082097	\N	-	start	Lead created by Naf	539	1
1346	2024-11-24 13:09:48.087919	2024-11-24 13:09:48.087919	\N	-	start	Lead created by Naf	543	1
1358	2024-11-24 13:09:48.097453	2024-11-24 13:09:48.097453	\N	-	start	Lead created by Naf	554	1
1367	2024-11-24 13:09:48.104385	2024-11-24 13:09:48.104385	\N	-	start	Lead created by Naf	555	1
1374	2024-11-24 13:09:48.116186	2024-11-24 13:09:48.116186	\N	-	start	Lead created by Naf	571	1
276	2024-09-14 18:37:46.296844	2024-09-14 18:37:46.296844	\N	-	start	Lead created by Naf	189	1
277	2024-09-14 18:37:46.308355	2024-09-14 18:37:46.308355	\N	-	start	Lead created by Naf	190	1
278	2024-09-14 18:37:46.318567	2024-09-14 18:37:46.318567	\N	-	start	Lead created by Naf	191	1
279	2024-09-14 18:37:46.326868	2024-09-14 18:37:46.326868	\N	-	start	Lead created by Naf	192	1
280	2024-09-14 18:37:46.335595	2024-09-14 18:37:46.335595	\N	-	start	Lead created by Naf	193	1
281	2024-09-14 18:37:46.342802	2024-09-14 18:37:46.342802	\N	-	start	Lead created by Naf	194	1
282	2024-09-14 18:37:46.350247	2024-09-14 18:37:46.350247	\N	-	start	Lead created by Naf	195	1
283	2024-09-14 18:37:46.357404	2024-09-14 18:37:46.357404	\N	-	start	Lead created by Naf	196	1
284	2024-09-14 18:37:46.365352	2024-09-14 18:37:46.365352	\N	-	start	Lead created by Naf	197	1
285	2024-09-14 18:37:46.372539	2024-09-14 18:37:46.372539	\N	-	start	Lead created by Naf	198	1
286	2024-09-14 18:37:46.380059	2024-09-14 18:37:46.380059	\N	-	start	Lead created by Naf	199	1
287	2024-09-14 18:37:46.388412	2024-09-14 18:37:46.388412	\N	-	start	Lead created by Naf	200	1
288	2024-09-14 18:37:46.396195	2024-09-14 18:37:46.396195	\N	-	start	Lead created by Naf	201	1
289	2024-09-14 18:37:46.403309	2024-09-14 18:37:46.403309	\N	-	start	Lead created by Naf	202	1
290	2024-09-14 18:37:46.411308	2024-09-14 18:37:46.411308	\N	-	start	Lead created by Naf	203	1
291	2024-09-14 18:37:46.420692	2024-09-14 18:37:46.420692	\N	-	start	Lead created by Naf	204	1
292	2024-09-14 18:37:46.431424	2024-09-14 18:37:46.431424	\N	-	start	Lead created by Naf	205	1
293	2024-09-14 18:37:46.447422	2024-09-14 18:37:46.447422	\N	-	start	Lead created by Naf	206	1
294	2024-09-14 18:37:46.466119	2024-09-14 18:37:46.466119	\N	-	start	Lead created by Naf	207	1
295	2024-09-14 18:37:46.47377	2024-09-14 18:37:46.47377	\N	-	start	Lead created by Naf	208	1
296	2024-09-14 18:37:46.482265	2024-09-14 18:37:46.482265	\N	-	start	Lead created by Naf	209	1
297	2024-09-14 18:37:46.49029	2024-09-14 18:37:46.49029	\N	-	start	Lead created by Naf	210	1
298	2024-09-14 18:37:46.497737	2024-09-14 18:37:46.497737	\N	-	start	Lead created by Naf	211	1
299	2024-09-14 18:37:46.506063	2024-09-14 18:37:46.506063	\N	-	start	Lead created by Naf	212	1
300	2024-09-14 18:37:46.513883	2024-09-14 18:37:46.513883	\N	-	start	Lead created by Naf	213	1
301	2024-09-14 18:37:46.521546	2024-09-14 18:37:46.521546	\N	-	start	Lead created by Naf	214	1
302	2024-09-14 18:37:46.528939	2024-09-14 18:37:46.528939	\N	-	start	Lead created by Naf	215	1
303	2024-09-14 18:37:46.53555	2024-09-14 18:37:46.53555	\N	-	start	Lead created by Naf	216	1
304	2024-09-14 18:37:46.54327	2024-09-14 18:37:46.54327	\N	-	start	Lead created by Naf	217	1
305	2024-09-14 18:37:46.550909	2024-09-14 18:37:46.550909	\N	-	start	Lead created by Naf	218	1
306	2024-09-14 18:37:46.558795	2024-09-14 18:37:46.558795	\N	-	start	Lead created by Naf	219	1
307	2024-09-14 18:37:46.565762	2024-09-14 18:37:46.565762	\N	-	start	Lead created by Naf	220	1
308	2024-09-14 18:37:46.574385	2024-09-14 18:37:46.574385	\N	-	start	Lead created by Naf	221	1
309	2024-09-14 18:37:46.582843	2024-09-14 18:37:46.582843	\N	-	start	Lead created by Naf	222	1
310	2024-09-14 18:37:46.590189	2024-09-14 18:37:46.590189	\N	-	start	Lead created by Naf	223	1
311	2024-09-14 18:37:46.599432	2024-09-14 18:37:46.599432	\N	-	start	Lead created by Naf	224	1
312	2024-09-14 18:37:46.60903	2024-09-14 18:37:46.60903	\N	-	start	Lead created by Naf	225	1
313	2024-09-14 18:37:46.617596	2024-09-14 18:37:46.617596	\N	-	start	Lead created by Naf	226	1
314	2024-09-14 18:37:46.62727	2024-09-14 18:37:46.62727	\N	-	start	Lead created by Naf	227	1
315	2024-09-14 18:37:46.636424	2024-09-14 18:37:46.636424	\N	-	start	Lead created by Naf	228	1
316	2024-09-14 18:37:46.643825	2024-09-14 18:37:46.643825	\N	-	start	Lead created by Naf	229	1
317	2024-09-14 18:37:46.652547	2024-09-14 18:37:46.652547	\N	-	start	Lead created by Naf	230	1
318	2024-09-14 18:37:46.662578	2024-09-14 18:37:46.662578	\N	-	start	Lead created by Naf	231	1
319	2024-09-14 18:37:46.672689	2024-09-14 18:37:46.672689	\N	-	start	Lead created by Naf	232	1
320	2024-09-14 18:37:46.68284	2024-09-14 18:37:46.68284	\N	-	start	Lead created by Naf	233	1
321	2024-09-14 18:37:46.690858	2024-09-14 18:37:46.690858	\N	-	start	Lead created by Naf	234	1
322	2024-09-14 18:37:46.699459	2024-09-14 18:37:46.699459	\N	-	start	Lead created by Naf	235	1
323	2024-09-14 18:37:46.707911	2024-09-14 18:37:46.707911	\N	-	start	Lead created by Naf	236	1
324	2024-09-14 18:37:46.715682	2024-09-14 18:37:46.715682	\N	-	start	Lead created by Naf	237	1
325	2024-09-14 18:37:46.72389	2024-09-14 18:37:46.72389	\N	-	start	Lead created by Naf	238	1
326	2024-09-14 18:37:46.732876	2024-09-14 18:37:46.732876	\N	-	start	Lead created by Naf	239	1
327	2024-09-14 18:37:46.741229	2024-09-14 18:37:46.741229	\N	-	start	Lead created by Naf	240	1
328	2024-09-14 18:37:46.748913	2024-09-14 18:37:46.748913	\N	-	start	Lead created by Naf	241	1
329	2024-09-14 18:37:46.756724	2024-09-14 18:37:46.756724	\N	-	start	Lead created by Naf	242	1
330	2024-09-14 18:37:46.763602	2024-09-14 18:37:46.763602	\N	-	start	Lead created by Naf	243	1
331	2024-09-14 18:37:46.770089	2024-09-14 18:37:46.770089	\N	-	start	Lead created by Naf	244	1
332	2024-09-14 18:37:46.776786	2024-09-14 18:37:46.776786	\N	-	start	Lead created by Naf	245	1
333	2024-09-14 18:37:46.783777	2024-09-14 18:37:46.783777	\N	-	start	Lead created by Naf	246	1
334	2024-09-14 18:37:46.792526	2024-09-14 18:37:46.792526	\N	-	start	Lead created by Naf	247	1
335	2024-09-14 18:37:46.801291	2024-09-14 18:37:46.801291	\N	-	start	Lead created by Naf	248	1
336	2024-09-14 18:37:46.807872	2024-09-14 18:37:46.807872	\N	-	start	Lead created by Naf	249	1
337	2024-09-14 18:37:46.814533	2024-09-14 18:37:46.814533	\N	-	start	Lead created by Naf	250	1
338	2024-09-14 18:37:46.821541	2024-09-14 18:37:46.821541	\N	-	start	Lead created by Naf	251	1
339	2024-09-14 18:37:46.828236	2024-09-14 18:37:46.828236	\N	-	start	Lead created by Naf	252	1
340	2024-09-14 18:37:46.834819	2024-09-14 18:37:46.834819	\N	-	start	Lead created by Naf	253	1
341	2024-09-14 18:37:46.842401	2024-09-14 18:37:46.842401	\N	-	start	Lead created by Naf	254	1
342	2024-09-14 18:37:46.849717	2024-09-14 18:37:46.849717	\N	-	start	Lead created by Naf	255	1
343	2024-09-14 18:37:46.856416	2024-09-14 18:37:46.856416	\N	-	start	Lead created by Naf	256	1
344	2024-09-14 18:37:46.863842	2024-09-14 18:37:46.863842	\N	-	start	Lead created by Naf	257	1
345	2024-09-14 18:37:46.87133	2024-09-14 18:37:46.87133	\N	-	start	Lead created by Naf	258	1
346	2024-09-14 18:37:46.879716	2024-09-14 18:37:46.879716	\N	-	start	Lead created by Naf	259	1
347	2024-09-14 18:37:46.888274	2024-09-14 18:37:46.888274	\N	-	start	Lead created by Naf	260	1
348	2024-09-14 18:37:46.896567	2024-09-14 18:37:46.896567	\N	-	start	Lead created by Naf	261	1
349	2024-09-14 18:37:46.905942	2024-09-14 18:37:46.905942	\N	-	start	Lead created by Naf	262	1
350	2024-09-14 18:37:46.914391	2024-09-14 18:37:46.914391	\N	-	start	Lead created by Naf	263	1
351	2024-09-14 18:37:46.925387	2024-09-14 18:37:46.925387	\N	-	start	Lead created by Naf	264	1
352	2024-09-14 18:37:46.936778	2024-09-14 18:37:46.936778	\N	-	start	Lead created by Naf	265	1
353	2024-09-14 18:37:46.944838	2024-09-14 18:37:46.944838	\N	-	start	Lead created by Naf	266	1
354	2024-09-14 18:37:46.954394	2024-09-14 18:37:46.954394	\N	-	start	Lead created by Naf	267	1
355	2024-09-14 18:37:46.962086	2024-09-14 18:37:46.962086	\N	-	start	Lead created by Naf	268	1
356	2024-09-14 18:37:46.97108	2024-09-14 18:37:46.97108	\N	-	start	Lead created by Naf	269	1
357	2024-09-14 18:37:46.980239	2024-09-14 18:37:46.980239	\N	-	start	Lead created by Naf	270	1
358	2024-09-14 18:37:46.989402	2024-09-14 18:37:46.989402	\N	-	start	Lead created by Naf	271	1
359	2024-09-14 18:37:46.996663	2024-09-14 18:37:46.996663	\N	-	start	Lead created by Naf	272	1
360	2024-09-14 18:37:47.006892	2024-09-14 18:37:47.006892	\N	-	start	Lead created by Naf	273	1
361	2024-09-14 18:37:47.016099	2024-09-14 18:37:47.016099	\N	-	start	Lead created by Naf	274	1
362	2024-09-14 18:37:47.024104	2024-09-14 18:37:47.024104	\N	-	start	Lead created by Naf	275	1
363	2024-09-14 18:37:47.032879	2024-09-14 18:37:47.032879	\N	-	start	Lead created by Naf	276	1
364	2024-09-14 18:37:47.042022	2024-09-14 18:37:47.042022	\N	-	start	Lead created by Naf	277	1
365	2024-09-14 18:37:47.050798	2024-09-14 18:37:47.050798	\N	-	start	Lead created by Naf	278	1
366	2024-09-14 18:37:47.058464	2024-09-14 18:37:47.058464	\N	-	start	Lead created by Naf	279	1
367	2024-09-14 18:37:47.06762	2024-09-14 18:37:47.06762	\N	-	start	Lead created by Naf	280	1
368	2024-09-14 18:37:47.07534	2024-09-14 18:37:47.07534	\N	-	start	Lead created by Naf	281	1
369	2024-09-14 18:37:47.083608	2024-09-14 18:37:47.083608	\N	-	start	Lead created by Naf	282	1
370	2024-09-14 18:37:47.091304	2024-09-14 18:37:47.091304	\N	-	start	Lead created by Naf	283	1
371	2024-09-14 18:37:47.099528	2024-09-14 18:37:47.099528	\N	-	start	Lead created by Naf	284	1
372	2024-09-14 18:37:47.106512	2024-09-14 18:37:47.106512	\N	-	start	Lead created by Naf	285	1
373	2024-09-14 18:37:47.113464	2024-09-14 18:37:47.113464	\N	-	start	Lead created by Naf	286	1
374	2024-09-14 18:37:47.119852	2024-09-14 18:37:47.119852	\N	-	start	Lead created by Naf	287	1
375	2024-09-14 18:37:47.126798	2024-09-14 18:37:47.126798	\N	-	start	Lead created by Naf	288	1
376	2024-09-14 18:37:47.13657	2024-09-14 18:37:47.13657	\N	-	start	Lead created by Naf	289	1
377	2024-09-14 18:37:47.148245	2024-09-14 18:37:47.148245	\N	-	start	Lead created by Naf	290	1
378	2024-09-14 18:37:47.158099	2024-09-14 18:37:47.158099	\N	-	start	Lead created by Naf	291	1
379	2024-09-14 18:37:47.167675	2024-09-14 18:37:47.167675	\N	-	start	Lead created by Naf	292	1
380	2024-09-14 18:37:47.174983	2024-09-14 18:37:47.174983	\N	-	start	Lead created by Naf	293	1
381	2024-09-14 18:37:47.182804	2024-09-14 18:37:47.182804	\N	-	start	Lead created by Naf	294	1
382	2024-09-14 18:37:47.191854	2024-09-14 18:37:47.191854	\N	-	start	Lead created by Naf	295	1
383	2024-09-14 18:37:47.199643	2024-09-14 18:37:47.199643	\N	-	start	Lead created by Naf	296	1
384	2024-09-14 18:37:47.207468	2024-09-14 18:37:47.207468	\N	-	start	Lead created by Naf	297	1
385	2024-09-14 18:37:47.214822	2024-09-14 18:37:47.214822	\N	-	start	Lead created by Naf	298	1
386	2024-09-14 18:37:47.222749	2024-09-14 18:37:47.222749	\N	-	start	Lead created by Naf	299	1
387	2024-09-14 18:37:47.231378	2024-09-14 18:37:47.231378	\N	-	start	Lead created by Naf	300	1
388	2024-09-14 18:37:47.241147	2024-09-14 18:37:47.241147	\N	-	start	Lead created by Naf	301	1
389	2024-09-14 18:37:47.251024	2024-09-14 18:37:47.251024	\N	-	start	Lead created by Naf	302	1
390	2024-09-14 18:37:47.258282	2024-09-14 18:37:47.258282	\N	-	start	Lead created by Naf	303	1
391	2024-09-14 18:37:47.265444	2024-09-14 18:37:47.265444	\N	-	start	Lead created by Naf	304	1
392	2024-09-14 18:37:47.273876	2024-09-14 18:37:47.273876	\N	-	start	Lead created by Naf	305	1
393	2024-09-14 18:37:47.28135	2024-09-14 18:37:47.28135	\N	-	start	Lead created by Naf	306	1
394	2024-09-14 18:37:47.290162	2024-09-14 18:37:47.290162	\N	-	start	Lead created by Naf	307	1
395	2024-09-14 18:37:47.297051	2024-09-14 18:37:47.297051	\N	-	start	Lead created by Naf	308	1
396	2024-09-14 18:37:47.303745	2024-09-14 18:37:47.303745	\N	-	start	Lead created by Naf	309	1
397	2024-09-14 18:37:47.311946	2024-09-14 18:37:47.311946	\N	-	start	Lead created by Naf	310	1
398	2024-09-14 18:37:47.320225	2024-09-14 18:37:47.320225	\N	-	start	Lead created by Naf	311	1
399	2024-09-14 18:37:47.330708	2024-09-14 18:37:47.330708	\N	-	start	Lead created by Naf	312	1
400	2024-09-14 18:37:47.339368	2024-09-14 18:37:47.339368	\N	-	start	Lead created by Naf	313	1
401	2024-09-14 18:37:47.350843	2024-09-14 18:37:47.350843	\N	-	start	Lead created by Naf	314	1
402	2024-09-14 18:37:47.359706	2024-09-14 18:37:47.359706	\N	-	start	Lead created by Naf	315	1
403	2024-09-14 18:37:47.366519	2024-09-14 18:37:47.366519	\N	-	start	Lead created by Naf	316	1
404	2024-09-14 18:37:47.374221	2024-09-14 18:37:47.374221	\N	-	start	Lead created by Naf	317	1
405	2024-09-14 18:37:47.38245	2024-09-14 18:37:47.38245	\N	-	start	Lead created by Naf	318	1
406	2024-09-14 18:37:47.392705	2024-09-14 18:37:47.392705	\N	-	start	Lead created by Naf	319	1
407	2024-09-14 18:37:47.399512	2024-09-14 18:37:47.399512	\N	-	start	Lead created by Naf	320	1
408	2024-09-14 18:37:47.406405	2024-09-14 18:37:47.406405	\N	-	start	Lead created by Naf	321	1
409	2024-09-14 18:37:47.413944	2024-09-14 18:37:47.413944	\N	-	start	Lead created by Naf	322	1
410	2024-09-14 18:37:47.42123	2024-09-14 18:37:47.42123	\N	-	start	Lead created by Naf	323	1
411	2024-09-14 18:37:47.428734	2024-09-14 18:37:47.428734	\N	-	start	Lead created by Naf	324	1
412	2024-09-14 18:37:47.436324	2024-09-14 18:37:47.436324	\N	-	start	Lead created by Naf	325	1
413	2024-09-14 18:37:47.445181	2024-09-14 18:37:47.445181	\N	-	start	Lead created by Naf	326	1
414	2024-09-14 18:37:47.45238	2024-09-14 18:37:47.45238	\N	-	start	Lead created by Naf	327	1
415	2024-09-14 18:37:47.459325	2024-09-14 18:37:47.459325	\N	-	start	Lead created by Naf	328	1
416	2024-09-14 18:37:47.466225	2024-09-14 18:37:47.466225	\N	-	start	Lead created by Naf	329	1
417	2024-09-14 18:37:47.47397	2024-09-14 18:37:47.47397	\N	-	start	Lead created by Naf	330	1
418	2024-09-14 18:37:47.481003	2024-09-14 18:37:47.481003	\N	-	start	Lead created by Naf	331	1
419	2024-09-14 18:37:47.488029	2024-09-14 18:37:47.488029	\N	-	start	Lead created by Naf	332	1
420	2024-09-14 18:37:47.495059	2024-09-14 18:37:47.495059	\N	-	start	Lead created by Naf	333	1
421	2024-09-14 18:37:47.502253	2024-09-14 18:37:47.502253	\N	-	start	Lead created by Naf	334	1
422	2024-09-14 18:37:47.509539	2024-09-14 18:37:47.509539	\N	-	start	Lead created by Naf	335	1
423	2024-09-14 18:37:47.516353	2024-09-14 18:37:47.516353	\N	-	start	Lead created by Naf	336	1
424	2024-09-14 18:37:47.523409	2024-09-14 18:37:47.523409	\N	-	start	Lead created by Naf	337	1
425	2024-09-14 18:37:47.531413	2024-09-14 18:37:47.531413	\N	-	start	Lead created by Naf	338	1
426	2024-09-14 18:37:47.541089	2024-09-14 18:37:47.541089	\N	-	start	Lead created by Naf	339	1
427	2024-09-14 18:37:47.551004	2024-09-14 18:37:47.551004	\N	-	start	Lead created by Naf	340	1
428	2024-09-16 15:24:09.034026	2024-09-16 15:24:09.034026	\N	-	start	Lead created by Naf	341	1
429	2024-09-16 15:25:21.700616	2024-09-16 15:25:21.700616	\N	new	new	Lead updated by Naf	341	1
430	2024-09-16 15:28:03.082612	2024-09-16 15:28:03.082612	\N	new	new	Lead updated by Naf	341	1
431	2024-09-16 15:28:46.783775	2024-09-16 15:28:46.783775	\N	new	new	Lead updated by Naf	341	1
432	2024-09-16 15:29:01.025886	2024-09-16 15:29:01.025886	\N	new	new	Lead updated by Naf	341	1
433	2024-09-16 15:30:32.140906	2024-09-16 15:30:32.140906	\N	new	new	Lead updated by Naf	341	1
434	2024-09-16 15:30:51.528862	2024-09-16 15:30:51.528862	\N	new	new	Lead updated by Naf	341	1
435	2024-09-16 15:31:24.669322	2024-09-16 15:31:24.669322	\N	new	appointment-book	N/A	341	1
436	2024-09-16 15:31:40.056762	2024-09-16 15:31:40.056762	\N	appointment-book	waiting-for-document	n/a	341	1
437	2024-09-18 06:37:48.462578	2024-09-18 06:37:48.462578	\N	new	new	Lead updated by Naf	339	1
438	2024-09-18 06:38:50.035431	2024-09-18 06:38:50.035431	\N	new	appointment-book	he will visit office on 25th september 	339	1
439	2024-09-18 06:39:30.483576	2024-09-18 06:39:30.483576	\N	appointment-book	postponed	he will visit office after ielts 	339	1
440	2024-09-18 06:42:16.335099	2024-09-18 06:42:16.335099	\N	new	new	Lead updated by Naf	335	1
441	2024-09-18 06:42:16.345703	2024-09-18 06:42:16.345703	\N	new	new	Lead updated by Naf	340	1
442	2024-09-18 06:42:16.346561	2024-09-18 06:42:16.346561	\N	new	new	Lead updated by Naf	334	1
443	2024-09-18 06:42:16.362681	2024-09-18 06:42:16.362681	\N	new	new	Lead updated by Naf	336	1
444	2024-09-18 06:42:16.361814	2024-09-18 06:42:16.361814	\N	new	new	Lead updated by Naf	337	1
445	2024-09-18 06:42:16.365294	2024-09-18 06:42:16.365294	\N	new	new	Lead updated by Naf	338	1
446	2024-09-18 06:42:16.488026	2024-09-18 06:42:16.488026	\N	new	new	Lead updated by Naf	333	1
447	2024-09-18 06:42:16.488372	2024-09-18 06:42:16.488372	\N	new	new	Lead updated by Naf	332	1
448	2024-09-18 06:42:16.496032	2024-09-18 06:42:16.496032	\N	new	new	Lead updated by Naf	331	1
449	2024-09-18 06:42:16.512984	2024-09-18 06:42:16.512984	\N	new	new	Lead updated by Naf	330	1
450	2024-09-18 06:42:41.014457	2024-09-18 06:42:41.014457	\N	new	new	Lead updated by Naf	340	1
451	2024-09-18 06:42:41.015273	2024-09-18 06:42:41.015273	\N	new	new	Lead updated by Naf	335	1
452	2024-09-18 06:42:41.020291	2024-09-18 06:42:41.020291	\N	new	new	Lead updated by Naf	336	1
453	2024-09-18 06:42:41.020715	2024-09-18 06:42:41.020715	\N	new	new	Lead updated by Naf	338	1
454	2024-09-18 06:42:41.023697	2024-09-18 06:42:41.023697	\N	new	new	Lead updated by Naf	337	1
455	2024-09-18 06:42:41.060713	2024-09-18 06:42:41.060713	\N	new	new	Lead updated by Naf	334	1
456	2024-09-18 06:42:41.076729	2024-09-18 06:42:41.076729	\N	new	new	Lead updated by Naf	333	1
457	2024-09-18 06:42:41.084514	2024-09-18 06:42:41.084514	\N	new	new	Lead updated by Naf	332	1
458	2024-09-18 06:42:41.093467	2024-09-18 06:42:41.093467	\N	new	new	Lead updated by Naf	330	1
459	2024-09-18 06:42:41.107189	2024-09-18 06:42:41.107189	\N	new	new	Lead updated by Naf	331	1
460	2024-09-18 06:43:05.185678	2024-09-18 06:43:05.185678	\N	new	new	Lead updated by Naf	326	1
461	2024-09-18 06:43:05.186202	2024-09-18 06:43:05.186202	\N	new	new	Lead updated by Naf	325	1
462	2024-09-18 06:43:05.205055	2024-09-18 06:43:05.205055	\N	new	new	Lead updated by Naf	328	1
463	2024-09-18 06:43:05.212021	2024-09-18 06:43:05.212021	\N	new	new	Lead updated by Naf	329	1
464	2024-09-18 06:43:05.216676	2024-09-18 06:43:05.216676	\N	new	new	Lead updated by Naf	324	1
465	2024-09-18 06:43:05.219013	2024-09-18 06:43:05.219013	\N	new	new	Lead updated by Naf	327	1
466	2024-09-18 06:43:05.263629	2024-09-18 06:43:05.263629	\N	new	new	Lead updated by Naf	323	1
467	2024-09-18 06:43:05.263986	2024-09-18 06:43:05.263986	\N	new	new	Lead updated by Naf	322	1
468	2024-09-18 06:43:05.290852	2024-09-18 06:43:05.290852	\N	new	new	Lead updated by Naf	321	1
469	2024-09-18 06:43:05.293095	2024-09-18 06:43:05.293095	\N	new	new	Lead updated by Naf	320	1
470	2024-09-18 06:45:29.472861	2024-09-18 06:45:29.472861	\N	new	new	Lead updated by Naf	338	1
471	2024-09-18 06:45:29.473876	2024-09-18 06:45:29.473876	\N	new	new	Lead updated by Naf	337	1
472	2024-09-18 06:45:29.479553	2024-09-18 06:45:29.479553	\N	new	new	Lead updated by Naf	340	1
473	2024-09-18 06:45:29.480244	2024-09-18 06:45:29.480244	\N	new	new	Lead updated by Naf	336	1
474	2024-09-18 06:45:29.606233	2024-09-18 06:45:29.606233	\N	new	new	Lead updated by Naf	334	1
475	2024-09-18 06:45:29.609408	2024-09-18 06:45:29.609408	\N	new	new	Lead updated by Naf	332	1
476	2024-09-18 06:45:29.611762	2024-09-18 06:45:29.611762	\N	new	new	Lead updated by Naf	335	1
477	2024-09-18 06:45:29.615967	2024-09-18 06:45:29.615967	\N	new	new	Lead updated by Naf	333	1
478	2024-09-18 06:45:29.64319	2024-09-18 06:45:29.64319	\N	new	new	Lead updated by Naf	331	1
479	2024-09-18 06:45:29.657021	2024-09-18 06:45:29.657021	\N	new	new	Lead updated by Naf	330	1
480	2024-09-18 06:45:40.530816	2024-09-18 06:45:40.530816	\N	new	new	Lead updated by Naf	336	1
481	2024-09-18 06:45:40.537811	2024-09-18 06:45:40.537811	\N	new	new	Lead updated by Naf	335	1
482	2024-09-18 06:45:40.543769	2024-09-18 06:45:40.543769	\N	new	new	Lead updated by Naf	337	1
483	2024-09-18 06:45:40.554894	2024-09-18 06:45:40.554894	\N	new	new	Lead updated by Naf	334	1
484	2024-09-18 06:45:40.575218	2024-09-18 06:45:40.575218	\N	new	new	Lead updated by Naf	338	1
485	2024-09-18 06:45:40.576787	2024-09-18 06:45:40.576787	\N	new	new	Lead updated by Naf	340	1
486	2024-09-18 06:45:40.66524	2024-09-18 06:45:40.66524	\N	new	new	Lead updated by Naf	333	1
487	2024-09-18 06:45:40.668009	2024-09-18 06:45:40.668009	\N	new	new	Lead updated by Naf	332	1
488	2024-09-18 06:45:40.671663	2024-09-18 06:45:40.671663	\N	new	new	Lead updated by Naf	331	1
489	2024-09-18 06:45:40.696048	2024-09-18 06:45:40.696048	\N	new	new	Lead updated by Naf	330	1
490	2024-09-18 06:45:51.326003	2024-09-18 06:45:51.326003	\N	new	new	Lead updated by Naf	336	1
491	2024-09-18 06:45:51.390579	2024-09-18 06:45:51.390579	\N	new	new	Lead updated by Naf	335	1
492	2024-09-18 06:45:51.39159	2024-09-18 06:45:51.39159	\N	new	new	Lead updated by Naf	334	1
493	2024-09-18 06:45:51.394801	2024-09-18 06:45:51.394801	\N	new	new	Lead updated by Naf	338	1
494	2024-09-18 06:45:51.39579	2024-09-18 06:45:51.39579	\N	new	new	Lead updated by Naf	337	1
495	2024-09-18 06:45:51.398599	2024-09-18 06:45:51.398599	\N	new	new	Lead updated by Naf	340	1
496	2024-09-18 06:45:51.437846	2024-09-18 06:45:51.437846	\N	new	new	Lead updated by Naf	333	1
497	2024-09-18 06:45:51.515947	2024-09-18 06:45:51.515947	\N	new	new	Lead updated by Naf	330	1
498	2024-09-18 06:45:51.518107	2024-09-18 06:45:51.518107	\N	new	new	Lead updated by Naf	332	1
499	2024-09-18 06:45:51.527382	2024-09-18 06:45:51.527382	\N	new	new	Lead updated by Naf	331	1
500	2024-09-18 06:46:00.517376	2024-09-18 06:46:00.517376	\N	new	new	Lead updated by Naf	334	1
501	2024-09-18 06:46:00.52514	2024-09-18 06:46:00.52514	\N	new	new	Lead updated by Naf	337	1
502	2024-09-18 06:46:00.530457	2024-09-18 06:46:00.530457	\N	new	new	Lead updated by Naf	336	1
503	2024-09-18 06:46:00.545275	2024-09-18 06:46:00.545275	\N	new	new	Lead updated by Naf	335	1
504	2024-09-18 06:46:00.548073	2024-09-18 06:46:00.548073	\N	new	new	Lead updated by Naf	338	1
505	2024-09-18 06:46:00.551728	2024-09-18 06:46:00.551728	\N	new	new	Lead updated by Naf	340	1
506	2024-09-18 06:46:00.664396	2024-09-18 06:46:00.664396	\N	new	new	Lead updated by Naf	332	1
507	2024-09-18 06:46:00.666375	2024-09-18 06:46:00.666375	\N	new	new	Lead updated by Naf	331	1
508	2024-09-18 06:46:00.671786	2024-09-18 06:46:00.671786	\N	new	new	Lead updated by Naf	333	1
509	2024-09-18 06:46:00.682623	2024-09-18 06:46:00.682623	\N	new	new	Lead updated by Naf	330	1
510	2024-09-18 06:46:08.434767	2024-09-18 06:46:08.434767	\N	new	new	Lead updated by Naf	337	1
511	2024-09-18 06:46:08.437946	2024-09-18 06:46:08.437946	\N	new	new	Lead updated by Naf	340	1
512	2024-09-18 06:46:08.441346	2024-09-18 06:46:08.441346	\N	new	new	Lead updated by Naf	336	1
513	2024-09-18 06:46:08.446577	2024-09-18 06:46:08.446577	\N	new	new	Lead updated by Naf	334	1
514	2024-09-18 06:46:08.457319	2024-09-18 06:46:08.457319	\N	new	new	Lead updated by Naf	338	1
515	2024-09-18 06:46:08.460696	2024-09-18 06:46:08.460696	\N	new	new	Lead updated by Naf	335	1
516	2024-09-18 06:46:08.719206	2024-09-18 06:46:08.719206	\N	new	new	Lead updated by Naf	332	1
517	2024-09-18 06:46:08.724371	2024-09-18 06:46:08.724371	\N	new	new	Lead updated by Naf	330	1
518	2024-09-18 06:46:08.735022	2024-09-18 06:46:08.735022	\N	new	new	Lead updated by Naf	333	1
519	2024-09-18 06:46:08.738143	2024-09-18 06:46:08.738143	\N	new	new	Lead updated by Naf	331	1
520	2024-09-18 06:54:16.12822	2024-09-18 06:54:16.12822	\N	new	new	Lead updated by Naf	338	1
521	2024-09-18 06:54:16.132991	2024-09-18 06:54:16.132991	\N	new	new	Lead updated by Naf	340	1
522	2024-09-18 06:54:16.250707	2024-09-18 06:54:16.250707	\N	new	new	Lead updated by Naf	336	1
523	2024-09-18 06:54:16.266615	2024-09-18 06:54:16.266615	\N	new	new	Lead updated by Naf	337	1
524	2024-09-18 06:54:16.272667	2024-09-18 06:54:16.272667	\N	new	new	Lead updated by Naf	335	1
525	2024-09-18 06:54:16.297253	2024-09-18 06:54:16.297253	\N	new	new	Lead updated by Naf	332	1
526	2024-09-18 06:54:16.319243	2024-09-18 06:54:16.319243	\N	new	new	Lead updated by Naf	333	1
527	2024-09-18 06:54:16.322356	2024-09-18 06:54:16.322356	\N	new	new	Lead updated by Naf	334	1
528	2024-09-18 06:54:16.368776	2024-09-18 06:54:16.368776	\N	new	new	Lead updated by Naf	331	1
529	2024-09-18 06:54:16.403649	2024-09-18 06:54:16.403649	\N	new	new	Lead updated by Naf	330	1
530	2024-09-18 06:54:23.777084	2024-09-18 06:54:23.777084	\N	new	new	Lead updated by Naf	338	1
531	2024-09-18 06:54:23.781863	2024-09-18 06:54:23.781863	\N	new	new	Lead updated by Naf	335	1
532	2024-09-18 06:54:23.785863	2024-09-18 06:54:23.785863	\N	new	new	Lead updated by Naf	334	1
533	2024-09-18 06:54:23.789959	2024-09-18 06:54:23.789959	\N	new	new	Lead updated by Naf	340	1
534	2024-09-18 06:54:23.796958	2024-09-18 06:54:23.796958	\N	new	new	Lead updated by Naf	336	1
535	2024-09-18 06:54:23.802132	2024-09-18 06:54:23.802132	\N	new	new	Lead updated by Naf	337	1
536	2024-09-18 06:54:23.899626	2024-09-18 06:54:23.899626	\N	new	new	Lead updated by Naf	331	1
537	2024-09-18 06:54:23.905357	2024-09-18 06:54:23.905357	\N	new	new	Lead updated by Naf	332	1
538	2024-09-18 06:54:23.905656	2024-09-18 06:54:23.905656	\N	new	new	Lead updated by Naf	333	1
539	2024-09-18 06:54:23.914007	2024-09-18 06:54:23.914007	\N	new	new	Lead updated by Naf	330	1
540	2024-09-18 06:54:31.300882	2024-09-18 06:54:31.300882	\N	new	new	Lead updated by Naf	334	1
541	2024-09-18 06:54:31.308455	2024-09-18 06:54:31.308455	\N	new	new	Lead updated by Naf	340	1
542	2024-09-18 06:54:31.322683	2024-09-18 06:54:31.322683	\N	new	new	Lead updated by Naf	336	1
543	2024-09-18 06:54:31.331108	2024-09-18 06:54:31.331108	\N	new	new	Lead updated by Naf	335	1
544	2024-09-18 06:54:31.347697	2024-09-18 06:54:31.347697	\N	new	new	Lead updated by Naf	338	1
545	2024-09-18 06:54:31.349562	2024-09-18 06:54:31.349562	\N	new	new	Lead updated by Naf	337	1
546	2024-09-18 06:54:31.446201	2024-09-18 06:54:31.446201	\N	new	new	Lead updated by Naf	333	1
547	2024-09-18 06:54:31.479136	2024-09-18 06:54:31.479136	\N	new	new	Lead updated by Naf	332	1
548	2024-09-18 06:54:31.479392	2024-09-18 06:54:31.479392	\N	new	new	Lead updated by Naf	331	1
549	2024-09-18 06:54:31.487261	2024-09-18 06:54:31.487261	\N	new	new	Lead updated by Naf	330	1
550	2024-09-18 06:54:40.794201	2024-09-18 06:54:40.794201	\N	new	new	Lead updated by Naf	338	1
551	2024-09-18 06:54:40.796961	2024-09-18 06:54:40.796961	\N	new	new	Lead updated by Naf	334	1
552	2024-09-18 06:54:40.800673	2024-09-18 06:54:40.800673	\N	new	new	Lead updated by Naf	340	1
553	2024-09-18 06:54:40.804412	2024-09-18 06:54:40.804412	\N	new	new	Lead updated by Naf	336	1
554	2024-09-18 06:54:40.812797	2024-09-18 06:54:40.812797	\N	new	new	Lead updated by Naf	335	1
555	2024-09-18 06:54:40.815076	2024-09-18 06:54:40.815076	\N	new	new	Lead updated by Naf	337	1
556	2024-09-18 06:54:40.934743	2024-09-18 06:54:40.934743	\N	new	new	Lead updated by Naf	331	1
557	2024-09-18 06:54:40.940434	2024-09-18 06:54:40.940434	\N	new	new	Lead updated by Naf	333	1
558	2024-09-18 06:54:40.952623	2024-09-18 06:54:40.952623	\N	new	new	Lead updated by Naf	332	1
559	2024-09-18 06:54:40.988597	2024-09-18 06:54:40.988597	\N	new	new	Lead updated by Naf	330	1
560	2024-09-18 07:00:18.422873	2024-09-18 07:00:18.422873	\N	new	new	Lead updated by Naf	340	1
561	2024-09-18 07:00:18.497198	2024-09-18 07:00:18.497198	\N	new	new	Lead updated by Naf	337	1
562	2024-09-18 07:00:18.497437	2024-09-18 07:00:18.497437	\N	new	new	Lead updated by Naf	338	1
563	2024-09-18 07:00:18.586427	2024-09-18 07:00:18.586427	\N	new	new	Lead updated by Naf	336	1
564	2024-09-18 07:00:18.589909	2024-09-18 07:00:18.589909	\N	new	new	Lead updated by Naf	334	1
565	2024-09-18 07:00:18.591665	2024-09-18 07:00:18.591665	\N	new	new	Lead updated by Naf	335	1
566	2024-09-18 07:00:18.674118	2024-09-18 07:00:18.674118	\N	new	new	Lead updated by Naf	333	1
567	2024-09-18 07:00:18.695461	2024-09-18 07:00:18.695461	\N	new	new	Lead updated by Naf	332	1
568	2024-09-18 07:00:18.686752	2024-09-18 07:00:18.686752	\N	new	new	Lead updated by Naf	331	1
569	2024-09-18 07:00:18.81068	2024-09-18 07:00:18.81068	\N	new	new	Lead updated by Naf	330	1
570	2024-09-18 07:00:53.705887	2024-09-18 07:00:53.705887	\N	new	new	Lead updated by Naf	326	1
571	2024-09-18 07:00:53.722335	2024-09-18 07:00:53.722335	\N	new	new	Lead updated by Naf	325	1
572	2024-09-18 07:00:53.725866	2024-09-18 07:00:53.725866	\N	new	new	Lead updated by Naf	324	1
573	2024-09-18 07:00:53.753185	2024-09-18 07:00:53.753185	\N	new	new	Lead updated by Naf	328	1
574	2024-09-18 07:00:53.764673	2024-09-18 07:00:53.764673	\N	new	new	Lead updated by Naf	327	1
575	2024-09-18 07:00:53.787482	2024-09-18 07:00:53.787482	\N	new	new	Lead updated by Naf	329	1
576	2024-09-18 07:00:53.845082	2024-09-18 07:00:53.845082	\N	new	new	Lead updated by Naf	323	1
577	2024-09-18 07:00:53.888851	2024-09-18 07:00:53.888851	\N	new	new	Lead updated by Naf	321	1
578	2024-09-18 07:00:53.886327	2024-09-18 07:00:53.886327	\N	new	new	Lead updated by Naf	322	1
579	2024-09-18 07:00:53.984175	2024-09-18 07:00:53.984175	\N	new	new	Lead updated by Naf	320	1
580	2024-09-18 07:02:22.23199	2024-09-18 07:02:22.23199	\N	new	new	Lead updated by Naf	340	1
581	2024-09-18 07:02:22.232607	2024-09-18 07:02:22.232607	\N	new	new	Lead updated by Naf	336	1
582	2024-09-18 07:02:22.235456	2024-09-18 07:02:22.235456	\N	new	new	Lead updated by Naf	335	1
583	2024-09-18 07:02:22.249532	2024-09-18 07:02:22.249532	\N	new	new	Lead updated by Naf	338	1
584	2024-09-18 07:02:22.250299	2024-09-18 07:02:22.250299	\N	new	new	Lead updated by Naf	334	1
585	2024-09-18 07:02:22.250885	2024-09-18 07:02:22.250885	\N	new	new	Lead updated by Naf	337	1
587	2024-09-18 07:02:22.511069	2024-09-18 07:02:22.511069	\N	new	new	Lead updated by Naf	331	1
586	2024-09-18 07:02:22.510806	2024-09-18 07:02:22.510806	\N	new	new	Lead updated by Naf	332	1
588	2024-09-18 07:02:22.512335	2024-09-18 07:02:22.512335	\N	new	new	Lead updated by Naf	330	1
589	2024-09-18 07:02:22.519225	2024-09-18 07:02:22.519225	\N	new	new	Lead updated by Naf	333	1
590	2024-09-18 07:02:47.523536	2024-09-18 07:02:47.523536	\N	new	new	Lead updated by Naf	328	1
591	2024-09-18 07:02:47.546476	2024-09-18 07:02:47.546476	\N	new	new	Lead updated by Naf	326	1
592	2024-09-18 07:02:47.550126	2024-09-18 07:02:47.550126	\N	new	new	Lead updated by Naf	324	1
593	2024-09-18 07:02:47.548796	2024-09-18 07:02:47.548796	\N	new	new	Lead updated by Naf	325	1
594	2024-09-18 07:02:47.560976	2024-09-18 07:02:47.560976	\N	new	new	Lead updated by Naf	329	1
595	2024-09-18 07:02:47.563893	2024-09-18 07:02:47.563893	\N	new	new	Lead updated by Naf	327	1
596	2024-09-18 07:02:47.634676	2024-09-18 07:02:47.634676	\N	new	new	Lead updated by Naf	323	1
597	2024-09-18 07:02:47.668538	2024-09-18 07:02:47.668538	\N	new	new	Lead updated by Naf	322	1
598	2024-09-18 07:02:47.671258	2024-09-18 07:02:47.671258	\N	new	new	Lead updated by Naf	321	1
599	2024-09-18 07:02:47.674457	2024-09-18 07:02:47.674457	\N	new	new	Lead updated by Naf	320	1
600	2024-09-18 07:03:04.437794	2024-09-18 07:03:04.437794	\N	new	new	Lead updated by Naf	316	1
601	2024-09-18 07:03:04.440251	2024-09-18 07:03:04.440251	\N	new	new	Lead updated by Naf	317	1
602	2024-09-18 07:03:04.463588	2024-09-18 07:03:04.463588	\N	new	new	Lead updated by Naf	314	1
603	2024-09-18 07:03:04.463725	2024-09-18 07:03:04.463725	\N	new	new	Lead updated by Naf	315	1
604	2024-09-18 07:03:04.475019	2024-09-18 07:03:04.475019	\N	new	new	Lead updated by Naf	319	1
605	2024-09-18 07:03:04.487445	2024-09-18 07:03:04.487445	\N	new	new	Lead updated by Naf	318	1
606	2024-09-18 07:03:04.578822	2024-09-18 07:03:04.578822	\N	new	new	Lead updated by Naf	312	1
607	2024-09-18 07:03:04.579259	2024-09-18 07:03:04.579259	\N	new	new	Lead updated by Naf	313	1
608	2024-09-18 07:03:04.60411	2024-09-18 07:03:04.60411	\N	new	new	Lead updated by Naf	310	1
609	2024-09-18 07:03:04.605734	2024-09-18 07:03:04.605734	\N	new	new	Lead updated by Naf	311	1
610	2024-09-18 07:03:21.250102	2024-09-18 07:03:21.250102	\N	new	new	Lead updated by Naf	317	1
611	2024-09-18 07:03:21.25038	2024-09-18 07:03:21.25038	\N	new	new	Lead updated by Naf	315	1
612	2024-09-18 07:03:21.250943	2024-09-18 07:03:21.250943	\N	new	new	Lead updated by Naf	319	1
613	2024-09-18 07:03:21.251035	2024-09-18 07:03:21.251035	\N	new	new	Lead updated by Naf	316	1
614	2024-09-18 07:03:21.258174	2024-09-18 07:03:21.258174	\N	new	new	Lead updated by Naf	318	1
615	2024-09-18 07:03:21.263693	2024-09-18 07:03:21.263693	\N	new	new	Lead updated by Naf	314	1
616	2024-09-18 07:03:21.391655	2024-09-18 07:03:21.391655	\N	new	new	Lead updated by Naf	310	1
617	2024-09-18 07:03:21.396306	2024-09-18 07:03:21.396306	\N	new	new	Lead updated by Naf	312	1
618	2024-09-18 07:03:21.430055	2024-09-18 07:03:21.430055	\N	new	new	Lead updated by Naf	313	1
619	2024-09-18 07:03:21.434975	2024-09-18 07:03:21.434975	\N	new	new	Lead updated by Naf	311	1
620	2024-09-18 07:04:06.440324	2024-09-18 07:04:06.440324	\N	new	new	Lead updated by Naf	318	1
621	2024-09-18 07:04:06.446563	2024-09-18 07:04:06.446563	\N	new	new	Lead updated by Naf	317	1
622	2024-09-18 07:04:06.460022	2024-09-18 07:04:06.460022	\N	new	new	Lead updated by Naf	314	1
623	2024-09-18 07:04:06.470912	2024-09-18 07:04:06.470912	\N	new	new	Lead updated by Naf	316	1
624	2024-09-18 07:04:06.476871	2024-09-18 07:04:06.476871	\N	new	new	Lead updated by Naf	315	1
625	2024-09-18 07:04:06.478022	2024-09-18 07:04:06.478022	\N	new	new	Lead updated by Naf	319	1
626	2024-09-18 07:04:06.623608	2024-09-18 07:04:06.623608	\N	new	new	Lead updated by Naf	311	1
627	2024-09-18 07:04:06.635574	2024-09-18 07:04:06.635574	\N	new	new	Lead updated by Naf	310	1
628	2024-09-18 07:04:06.642531	2024-09-18 07:04:06.642531	\N	new	new	Lead updated by Naf	313	1
629	2024-09-18 07:04:06.667636	2024-09-18 07:04:06.667636	\N	new	new	Lead updated by Naf	312	1
630	2024-09-18 07:04:51.938479	2024-09-18 07:04:51.938479	\N	new	new	Lead updated by Naf	308	1
631	2024-09-18 07:04:51.941265	2024-09-18 07:04:51.941265	\N	new	new	Lead updated by Naf	306	1
632	2024-09-18 07:04:51.944747	2024-09-18 07:04:51.944747	\N	new	new	Lead updated by Naf	307	1
633	2024-09-18 07:04:51.961682	2024-09-18 07:04:51.961682	\N	new	new	Lead updated by Naf	304	1
634	2024-09-18 07:04:51.962699	2024-09-18 07:04:51.962699	\N	new	new	Lead updated by Naf	309	1
635	2024-09-18 07:04:51.962786	2024-09-18 07:04:51.962786	\N	new	new	Lead updated by Naf	305	1
636	2024-09-18 07:04:52.093726	2024-09-18 07:04:52.093726	\N	new	new	Lead updated by Naf	303	1
637	2024-09-18 07:04:52.099657	2024-09-18 07:04:52.099657	\N	new	new	Lead updated by Naf	301	1
638	2024-09-18 07:04:52.106425	2024-09-18 07:04:52.106425	\N	new	new	Lead updated by Naf	302	1
639	2024-09-18 07:04:52.113426	2024-09-18 07:04:52.113426	\N	new	new	Lead updated by Naf	300	1
640	2024-09-18 07:05:12.3749	2024-09-18 07:05:12.3749	\N	new	new	Lead updated by Naf	298	1
641	2024-09-18 07:05:12.374743	2024-09-18 07:05:12.374743	\N	new	new	Lead updated by Naf	297	1
642	2024-09-18 07:05:12.390092	2024-09-18 07:05:12.390092	\N	new	new	Lead updated by Naf	299	1
643	2024-09-18 07:05:12.402982	2024-09-18 07:05:12.402982	\N	new	new	Lead updated by Naf	294	1
644	2024-09-18 07:05:12.404913	2024-09-18 07:05:12.404913	\N	new	new	Lead updated by Naf	296	1
645	2024-09-18 07:05:12.405098	2024-09-18 07:05:12.405098	\N	new	new	Lead updated by Naf	295	1
646	2024-09-18 07:05:12.501355	2024-09-18 07:05:12.501355	\N	new	new	Lead updated by Naf	293	1
647	2024-09-18 07:05:12.534039	2024-09-18 07:05:12.534039	\N	new	new	Lead updated by Naf	292	1
649	2024-09-18 07:05:12.540427	2024-09-18 07:05:12.540427	\N	new	new	Lead updated by Naf	290	1
1157	2024-11-24 06:11:44.099598	2024-11-24 06:11:44.099598	\N	unreachable	unreachable	Lead updated by Farzana	337	14
1158	2024-11-24 06:11:46.54318	2024-11-24 06:11:46.54318	\N	unreachable	unreachable	Lead updated by Farzana	337	14
1167	2024-11-24 13:09:47.900303	2024-11-24 13:09:47.900303	\N	-	start	Lead created by Naf	357	1
1175	2024-11-24 13:09:47.909616	2024-11-24 13:09:47.909616	\N	-	start	Lead created by Naf	373	1
1178	2024-11-24 13:09:47.913079	2024-11-24 13:09:47.913079	\N	-	start	Lead created by Naf	360	1
1188	2024-11-24 13:09:47.927325	2024-11-24 13:09:47.927325	\N	-	start	Lead created by Naf	383	1
1199	2024-11-24 13:09:47.940191	2024-11-24 13:09:47.940191	\N	-	start	Lead created by Naf	391	1
1210	2024-11-24 13:09:47.947651	2024-11-24 13:09:47.947651	\N	-	start	Lead created by Naf	408	1
1219	2024-11-24 13:09:47.954486	2024-11-24 13:09:47.954486	\N	-	start	Lead created by Naf	416	1
1227	2024-11-24 13:09:47.965808	2024-11-24 13:09:47.965808	\N	-	start	Lead created by Naf	419	1
1242	2024-11-24 13:09:47.975135	2024-11-24 13:09:47.975135	\N	-	start	Lead created by Naf	427	1
1255	2024-11-24 13:09:47.993654	2024-11-24 13:09:47.993654	\N	-	start	Lead created by Naf	448	1
1265	2024-11-24 13:09:48.00548	2024-11-24 13:09:48.00548	\N	-	start	Lead created by Naf	459	1
1280	2024-11-24 13:09:48.019278	2024-11-24 13:09:48.019278	\N	-	start	Lead created by Naf	471	1
1299	2024-11-24 13:09:48.032148	2024-11-24 13:09:48.032148	\N	-	start	Lead created by Naf	486	1
1309	2024-11-24 13:09:48.049114	2024-11-24 13:09:48.049114	\N	-	start	Lead created by Naf	497	1
1321	2024-11-24 13:09:48.061685	2024-11-24 13:09:48.061685	\N	-	start	Lead created by Naf	515	1
1333	2024-11-24 13:09:48.076464	2024-11-24 13:09:48.076464	\N	-	start	Lead created by Naf	522	1
1345	2024-11-24 13:09:48.086528	2024-11-24 13:09:48.086528	\N	-	start	Lead created by Naf	538	1
1351	2024-11-24 13:09:48.092316	2024-11-24 13:09:48.092316	\N	-	start	Lead created by Naf	548	1
1359	2024-11-24 13:09:48.097669	2024-11-24 13:09:48.097669	\N	-	start	Lead created by Naf	545	1
1368	2024-11-24 13:09:48.10797	2024-11-24 13:09:48.10797	\N	-	start	Lead created by Naf	557	1
648	2024-09-18 07:05:12.536693	2024-09-18 07:05:12.536693	\N	new	new	Lead updated by Naf	291	1
650	2024-09-18 07:05:36.703527	2024-09-18 07:05:36.703527	\N	new	new	Lead updated by Naf	287	1
651	2024-09-18 07:05:36.706457	2024-09-18 07:05:36.706457	\N	new	new	Lead updated by Naf	285	1
652	2024-09-18 07:05:36.733528	2024-09-18 07:05:36.733528	\N	new	new	Lead updated by Naf	286	1
653	2024-09-18 07:05:36.739556	2024-09-18 07:05:36.739556	\N	new	new	Lead updated by Naf	289	1
654	2024-09-18 07:05:36.740998	2024-09-18 07:05:36.740998	\N	new	new	Lead updated by Naf	288	1
655	2024-09-18 07:05:36.757256	2024-09-18 07:05:36.757256	\N	new	new	Lead updated by Naf	284	1
656	2024-09-18 07:05:36.923633	2024-09-18 07:05:36.923633	\N	new	new	Lead updated by Naf	282	1
657	2024-09-18 07:05:36.942311	2024-09-18 07:05:36.942311	\N	new	new	Lead updated by Naf	283	1
658	2024-09-18 07:05:36.949067	2024-09-18 07:05:36.949067	\N	new	new	Lead updated by Naf	281	1
659	2024-09-18 07:05:36.950373	2024-09-18 07:05:36.950373	\N	new	new	Lead updated by Naf	280	1
660	2024-09-18 07:06:08.983218	2024-09-18 07:06:08.983218	\N	new	new	Lead updated by Naf	279	1
661	2024-09-18 07:06:08.98766	2024-09-18 07:06:08.98766	\N	new	new	Lead updated by Naf	274	1
662	2024-09-18 07:06:09.001553	2024-09-18 07:06:09.001553	\N	new	new	Lead updated by Naf	277	1
663	2024-09-18 07:06:09.003574	2024-09-18 07:06:09.003574	\N	new	new	Lead updated by Naf	278	1
664	2024-09-18 07:06:09.008898	2024-09-18 07:06:09.008898	\N	new	new	Lead updated by Naf	275	1
665	2024-09-18 07:06:09.010372	2024-09-18 07:06:09.010372	\N	new	new	Lead updated by Naf	276	1
666	2024-09-18 07:06:09.139606	2024-09-18 07:06:09.139606	\N	new	new	Lead updated by Naf	272	1
667	2024-09-18 07:06:09.140668	2024-09-18 07:06:09.140668	\N	new	new	Lead updated by Naf	271	1
668	2024-09-18 07:06:09.140968	2024-09-18 07:06:09.140968	\N	new	new	Lead updated by Naf	273	1
669	2024-09-18 07:06:09.175854	2024-09-18 07:06:09.175854	\N	new	new	Lead updated by Naf	270	1
670	2024-09-18 07:06:25.470452	2024-09-18 07:06:25.470452	\N	new	new	Lead updated by Naf	265	1
671	2024-09-18 07:06:25.471544	2024-09-18 07:06:25.471544	\N	new	new	Lead updated by Naf	267	1
672	2024-09-18 07:06:25.486464	2024-09-18 07:06:25.486464	\N	new	new	Lead updated by Naf	264	1
673	2024-09-18 07:06:25.500354	2024-09-18 07:06:25.500354	\N	new	new	Lead updated by Naf	269	1
674	2024-09-18 07:06:25.511088	2024-09-18 07:06:25.511088	\N	new	new	Lead updated by Naf	266	1
675	2024-09-18 07:06:25.526751	2024-09-18 07:06:25.526751	\N	new	new	Lead updated by Naf	268	1
676	2024-09-18 07:06:25.622935	2024-09-18 07:06:25.622935	\N	new	new	Lead updated by Naf	263	1
677	2024-09-18 07:06:25.623412	2024-09-18 07:06:25.623412	\N	new	new	Lead updated by Naf	262	1
678	2024-09-18 07:06:25.663125	2024-09-18 07:06:25.663125	\N	new	new	Lead updated by Naf	261	1
679	2024-09-18 07:06:25.671369	2024-09-18 07:06:25.671369	\N	new	new	Lead updated by Naf	260	1
680	2024-09-18 07:06:39.87874	2024-09-18 07:06:39.87874	\N	new	new	Lead updated by Naf	256	1
681	2024-09-18 07:06:39.880855	2024-09-18 07:06:39.880855	\N	new	new	Lead updated by Naf	254	1
682	2024-09-18 07:06:39.905607	2024-09-18 07:06:39.905607	\N	new	new	Lead updated by Naf	257	1
683	2024-09-18 07:06:39.906293	2024-09-18 07:06:39.906293	\N	new	new	Lead updated by Naf	255	1
684	2024-09-18 07:06:39.906904	2024-09-18 07:06:39.906904	\N	new	new	Lead updated by Naf	258	1
685	2024-09-18 07:06:39.907469	2024-09-18 07:06:39.907469	\N	new	new	Lead updated by Naf	259	1
686	2024-09-18 07:06:40.040874	2024-09-18 07:06:40.040874	\N	new	new	Lead updated by Naf	252	1
687	2024-09-18 07:06:40.043085	2024-09-18 07:06:40.043085	\N	new	new	Lead updated by Naf	253	1
688	2024-09-18 07:06:40.049434	2024-09-18 07:06:40.049434	\N	new	new	Lead updated by Naf	251	1
689	2024-09-18 07:06:40.057574	2024-09-18 07:06:40.057574	\N	new	new	Lead updated by Naf	250	1
690	2024-09-18 07:07:02.110693	2024-09-18 07:07:02.110693	\N	new	new	Lead updated by Naf	247	1
691	2024-09-18 07:07:02.123092	2024-09-18 07:07:02.123092	\N	new	new	Lead updated by Naf	249	1
692	2024-09-18 07:07:02.141259	2024-09-18 07:07:02.141259	\N	new	new	Lead updated by Naf	248	1
693	2024-09-18 07:07:02.141485	2024-09-18 07:07:02.141485	\N	new	new	Lead updated by Naf	244	1
694	2024-09-18 07:07:02.143167	2024-09-18 07:07:02.143167	\N	new	new	Lead updated by Naf	246	1
695	2024-09-18 07:07:02.143318	2024-09-18 07:07:02.143318	\N	new	new	Lead updated by Naf	245	1
696	2024-09-18 07:07:02.270365	2024-09-18 07:07:02.270365	\N	new	new	Lead updated by Naf	243	1
697	2024-09-18 07:07:02.276174	2024-09-18 07:07:02.276174	\N	new	new	Lead updated by Naf	242	1
698	2024-09-18 07:07:02.287307	2024-09-18 07:07:02.287307	\N	new	new	Lead updated by Naf	240	1
699	2024-09-18 07:07:02.296834	2024-09-18 07:07:02.296834	\N	new	new	Lead updated by Naf	241	1
700	2024-09-18 07:07:14.950996	2024-09-18 07:07:14.950996	\N	new	new	Lead updated by Naf	239	1
701	2024-09-18 07:07:14.985937	2024-09-18 07:07:14.985937	\N	new	new	Lead updated by Naf	236	1
702	2024-09-18 07:07:14.989558	2024-09-18 07:07:14.989558	\N	new	new	Lead updated by Naf	235	1
703	2024-09-18 07:07:14.995616	2024-09-18 07:07:14.995616	\N	new	new	Lead updated by Naf	238	1
704	2024-09-18 07:07:14.999752	2024-09-18 07:07:14.999752	\N	new	new	Lead updated by Naf	234	1
705	2024-09-18 07:07:15.001677	2024-09-18 07:07:15.001677	\N	new	new	Lead updated by Naf	237	1
706	2024-09-18 07:07:15.073713	2024-09-18 07:07:15.073713	\N	new	new	Lead updated by Naf	233	1
707	2024-09-18 07:07:15.136963	2024-09-18 07:07:15.136963	\N	new	new	Lead updated by Naf	232	1
708	2024-09-18 07:07:15.137246	2024-09-18 07:07:15.137246	\N	new	new	Lead updated by Naf	230	1
709	2024-09-18 07:07:15.144735	2024-09-18 07:07:15.144735	\N	new	new	Lead updated by Naf	231	1
710	2024-09-18 07:07:35.797062	2024-09-18 07:07:35.797062	\N	new	new	Lead updated by Naf	225	1
711	2024-09-18 07:07:35.845106	2024-09-18 07:07:35.845106	\N	new	new	Lead updated by Naf	226	1
712	2024-09-18 07:07:35.846523	2024-09-18 07:07:35.846523	\N	new	new	Lead updated by Naf	224	1
713	2024-09-18 07:07:35.850836	2024-09-18 07:07:35.850836	\N	new	new	Lead updated by Naf	228	1
714	2024-09-18 07:07:35.864954	2024-09-18 07:07:35.864954	\N	new	new	Lead updated by Naf	229	1
715	2024-09-18 07:07:35.867047	2024-09-18 07:07:35.867047	\N	new	new	Lead updated by Naf	227	1
716	2024-09-18 07:07:35.929464	2024-09-18 07:07:35.929464	\N	new	new	Lead updated by Naf	223	1
717	2024-09-18 07:07:35.987898	2024-09-18 07:07:35.987898	\N	new	new	Lead updated by Naf	221	1
718	2024-09-18 07:07:35.992019	2024-09-18 07:07:35.992019	\N	new	new	Lead updated by Naf	222	1
719	2024-09-18 07:07:36.006848	2024-09-18 07:07:36.006848	\N	new	new	Lead updated by Naf	220	1
720	2024-09-18 07:07:51.689953	2024-09-18 07:07:51.689953	\N	new	new	Lead updated by Naf	215	1
721	2024-09-18 07:07:51.713756	2024-09-18 07:07:51.713756	\N	new	new	Lead updated by Naf	216	1
722	2024-09-18 07:07:51.723734	2024-09-18 07:07:51.723734	\N	new	new	Lead updated by Naf	217	1
723	2024-09-18 07:07:51.732536	2024-09-18 07:07:51.732536	\N	new	new	Lead updated by Naf	219	1
724	2024-09-18 07:07:51.734835	2024-09-18 07:07:51.734835	\N	new	new	Lead updated by Naf	218	1
725	2024-09-18 07:07:51.752283	2024-09-18 07:07:51.752283	\N	new	new	Lead updated by Naf	214	1
726	2024-09-18 07:07:51.816319	2024-09-18 07:07:51.816319	\N	new	new	Lead updated by Naf	213	1
727	2024-09-18 07:07:51.843046	2024-09-18 07:07:51.843046	\N	new	new	Lead updated by Naf	212	1
728	2024-09-18 07:07:51.867544	2024-09-18 07:07:51.867544	\N	new	new	Lead updated by Naf	210	1
729	2024-09-18 07:07:51.870567	2024-09-18 07:07:51.870567	\N	new	new	Lead updated by Naf	211	1
730	2024-09-18 07:08:05.97137	2024-09-18 07:08:05.97137	\N	new	new	Lead updated by Naf	205	1
731	2024-09-18 07:08:05.979296	2024-09-18 07:08:05.979296	\N	new	new	Lead updated by Naf	208	1
1159	2024-11-24 06:21:22.167604	2024-11-24 06:21:22.167604	\N	appointment-book	course-new	Lead updated by Farzana	317	14
1168	2024-11-24 13:09:47.900751	2024-11-24 13:09:47.900751	\N	-	start	Lead created by Naf	367	1
1174	2024-11-24 13:09:47.907464	2024-11-24 13:09:47.907464	\N	-	start	Lead created by Naf	362	1
1183	2024-11-24 13:09:47.918736	2024-11-24 13:09:47.918736	\N	-	start	Lead created by Naf	380	1
1192	2024-11-24 13:09:47.933256	2024-11-24 13:09:47.933256	\N	-	start	Lead created by Naf	389	1
1201	2024-11-24 13:09:47.942619	2024-11-24 13:09:47.942619	\N	-	start	Lead created by Naf	395	1
1213	2024-11-24 13:09:47.949617	2024-11-24 13:09:47.949617	\N	-	start	Lead created by Naf	402	1
1222	2024-11-24 13:09:47.959814	2024-11-24 13:09:47.959814	\N	-	start	Lead created by Naf	411	1
1235	2024-11-24 13:09:47.97123	2024-11-24 13:09:47.97123	\N	-	start	Lead created by Naf	425	1
1252	2024-11-24 13:09:47.988519	2024-11-24 13:09:47.988519	\N	-	start	Lead created by Naf	443	1
1261	2024-11-24 13:09:48.000553	2024-11-24 13:09:48.000553	\N	-	start	Lead created by Naf	456	1
1273	2024-11-24 13:09:48.014253	2024-11-24 13:09:48.014253	\N	-	start	Lead created by Naf	469	1
1286	2024-11-24 13:09:48.025194	2024-11-24 13:09:48.025194	\N	-	start	Lead created by Naf	478	1
1296	2024-11-24 13:09:48.034346	2024-11-24 13:09:48.034346	\N	-	start	Lead created by Naf	491	1
1310	2024-11-24 13:09:48.049571	2024-11-24 13:09:48.049571	\N	-	start	Lead created by Naf	500	1
1320	2024-11-24 13:09:48.061857	2024-11-24 13:09:48.061857	\N	-	start	Lead created by Naf	514	1
1335	2024-11-24 13:09:48.076399	2024-11-24 13:09:48.076399	\N	-	start	Lead created by Naf	526	1
1349	2024-11-24 13:09:48.087695	2024-11-24 13:09:48.087695	\N	-	start	Lead created by Naf	537	1
1365	2024-11-24 13:09:48.100017	2024-11-24 13:09:48.100017	\N	-	start	Lead created by Naf	559	1
1378	2024-11-24 13:09:48.121283	2024-11-24 13:09:48.121283	\N	-	start	Lead created by Naf	573	1
732	2024-09-18 07:08:05.983144	2024-09-18 07:08:05.983144	\N	new	new	Lead updated by Naf	206	1
739	2024-09-18 07:08:06.143529	2024-09-18 07:08:06.143529	\N	new	new	Lead updated by Naf	202	1
742	2024-09-18 07:08:19.328321	2024-09-18 07:08:19.328321	\N	new	new	Lead updated by Naf	196	1
1160	2024-11-24 06:21:26.839815	2024-11-24 06:21:26.839815	\N	course-new	new	Lead updated by Farzana	317	14
1169	2024-11-24 13:09:47.901242	2024-11-24 13:09:47.901242	\N	-	start	Lead created by Naf	368	1
1177	2024-11-24 13:09:47.91082	2024-11-24 13:09:47.91082	\N	-	start	Lead created by Naf	375	1
1185	2024-11-24 13:09:47.921397	2024-11-24 13:09:47.921397	\N	-	start	Lead created by Naf	377	1
1195	2024-11-24 13:09:47.936733	2024-11-24 13:09:47.936733	\N	-	start	Lead created by Naf	392	1
1208	2024-11-24 13:09:47.946429	2024-11-24 13:09:47.946429	\N	-	start	Lead created by Naf	404	1
1215	2024-11-24 13:09:47.950657	2024-11-24 13:09:47.950657	\N	-	start	Lead created by Naf	407	1
1225	2024-11-24 13:09:47.961575	2024-11-24 13:09:47.961575	\N	-	start	Lead created by Naf	412	1
1233	2024-11-24 13:09:47.970059	2024-11-24 13:09:47.970059	\N	-	start	Lead created by Naf	420	1
1240	2024-11-24 13:09:47.976133	2024-11-24 13:09:47.976133	\N	-	start	Lead created by Naf	430	1
1249	2024-11-24 13:09:47.986255	2024-11-24 13:09:47.986255	\N	-	start	Lead created by Naf	445	1
1257	2024-11-24 13:09:47.99524	2024-11-24 13:09:47.99524	\N	-	start	Lead created by Naf	441	1
1267	2024-11-24 13:09:48.009213	2024-11-24 13:09:48.009213	\N	-	start	Lead created by Naf	464	1
1277	2024-11-24 13:09:48.019026	2024-11-24 13:09:48.019026	\N	-	start	Lead created by Naf	466	1
1285	2024-11-24 13:09:48.024739	2024-11-24 13:09:48.024739	\N	-	start	Lead created by Naf	480	1
1295	2024-11-24 13:09:48.033991	2024-11-24 13:09:48.033991	\N	-	start	Lead created by Naf	490	1
1308	2024-11-24 13:09:48.048689	2024-11-24 13:09:48.048689	\N	-	start	Lead created by Naf	503	1
1318	2024-11-24 13:09:48.059002	2024-11-24 13:09:48.059002	\N	-	start	Lead created by Naf	512	1
1326	2024-11-24 13:09:48.072237	2024-11-24 13:09:48.072237	\N	-	start	Lead created by Naf	506	1
1339	2024-11-24 13:09:48.080528	2024-11-24 13:09:48.080528	\N	-	start	Lead created by Naf	531	1
1347	2024-11-24 13:09:48.089605	2024-11-24 13:09:48.089605	\N	-	start	Lead created by Naf	535	1
1356	2024-11-24 13:09:48.093767	2024-11-24 13:09:48.093767	\N	-	start	Lead created by Naf	549	1
1362	2024-11-24 13:09:48.100688	2024-11-24 13:09:48.100688	\N	-	start	Lead created by Naf	560	1
1371	2024-11-24 13:09:48.112217	2024-11-24 13:09:48.112217	\N	-	start	Lead created by Naf	567	1
1377	2024-11-24 13:09:48.122559	2024-11-24 13:09:48.122559	\N	-	start	Lead created by Naf	572	1
1380	2024-11-24 13:09:48.127719	2024-11-24 13:09:48.127719	\N	-	start	Lead created by Naf	565	1
1381	2024-11-24 13:09:48.137249	2024-11-24 13:09:48.137249	\N	-	start	Lead created by Naf	574	1
733	2024-09-18 07:08:05.983749	2024-09-18 07:08:05.983749	\N	new	new	Lead updated by Naf	204	1
734	2024-09-18 07:08:06.010639	2024-09-18 07:08:06.010639	\N	new	new	Lead updated by Naf	207	1
735	2024-09-18 07:08:06.024466	2024-09-18 07:08:06.024466	\N	new	new	Lead updated by Naf	209	1
736	2024-09-18 07:08:06.130023	2024-09-18 07:08:06.130023	\N	new	new	Lead updated by Naf	201	1
737	2024-09-18 07:08:06.137208	2024-09-18 07:08:06.137208	\N	new	new	Lead updated by Naf	203	1
738	2024-09-18 07:08:06.13839	2024-09-18 07:08:06.13839	\N	new	new	Lead updated by Naf	200	1
740	2024-09-18 07:08:19.31828	2024-09-18 07:08:19.31828	\N	new	new	Lead updated by Naf	197	1
741	2024-09-18 07:08:19.325886	2024-09-18 07:08:19.325886	\N	new	new	Lead updated by Naf	194	1
743	2024-09-18 07:08:19.337001	2024-09-18 07:08:19.337001	\N	new	new	Lead updated by Naf	195	1
744	2024-09-18 07:08:19.337947	2024-09-18 07:08:19.337947	\N	new	new	Lead updated by Naf	199	1
745	2024-09-18 07:08:19.374414	2024-09-18 07:08:19.374414	\N	new	new	Lead updated by Naf	198	1
746	2024-09-18 07:08:19.460236	2024-09-18 07:08:19.460236	\N	new	new	Lead updated by Naf	193	1
747	2024-09-18 07:08:19.493416	2024-09-18 07:08:19.493416	\N	new	new	Lead updated by Naf	192	1
748	2024-09-18 07:08:19.497727	2024-09-18 07:08:19.497727	\N	new	new	Lead updated by Naf	190	1
749	2024-09-18 07:08:19.509334	2024-09-18 07:08:19.509334	\N	new	new	Lead updated by Naf	191	1
750	2024-09-18 07:08:34.142321	2024-09-18 07:08:34.142321	\N	new	new	Lead updated by Naf	189	1
751	2024-09-18 07:51:04.149568	2024-09-18 07:51:04.149568	\N	new	unreachable	phone off	340	14
752	2024-09-18 14:20:23.789955	2024-09-18 14:20:23.789955	\N	waiting-for-document	waiting-for-document	Lead updated by Naf	341	1
753	2024-09-21 06:36:53.164141	2024-09-21 06:36:53.164141	\N	unreachable	unreachable	Lead updated by Farzana	340	14
754	2024-09-21 06:38:15.58447	2024-09-21 06:38:15.58447	\N	new	unreachable	phone was switch off	338	14
755	2024-09-21 06:42:09.443361	2024-09-21 06:42:09.443361	\N	new	not-interested	mistake	337	14
756	2024-09-21 06:42:09.793231	2024-09-21 06:42:09.793231	\N	not-interested	not-interested	mistake	337	14
757	2024-09-21 06:42:11.085353	2024-09-21 06:42:11.085353	\N	not-interested	not-interested	mistake	337	14
758	2024-09-21 06:52:12.938129	2024-09-21 06:52:12.938129	\N	new	appointment-book	he will come to our office	317	14
759	2024-09-21 06:55:22.871909	2024-09-21 06:55:22.871909	\N	new	not-interested	non sense	314	14
760	2024-09-21 06:58:15.494318	2024-09-21 06:58:15.494318	\N	not-interested	not-interested	Lead updated by Farzana	337	14
761	2024-09-21 07:04:02.436531	2024-09-21 07:04:02.436531	\N	new	unreachable	number is not valid	336	14
762	2024-09-21 07:07:31.567571	2024-09-21 07:07:31.567571	\N	new	unreachable	5th times i called him	335	14
763	2024-09-21 07:07:33.087748	2024-09-21 07:07:33.087748	\N	unreachable	unreachable	5th times i called him	335	14
764	2024-09-21 07:07:34.23602	2024-09-21 07:07:34.23602	\N	unreachable	unreachable	5th times i called him	335	14
765	2024-09-21 07:07:37.319457	2024-09-21 07:07:37.319457	\N	unreachable	unreachable	5th times i called him	335	14
766	2024-09-21 07:07:37.639346	2024-09-21 07:07:37.639346	\N	unreachable	unreachable	5th times i called him	335	14
767	2024-09-21 07:07:37.654823	2024-09-21 07:07:37.654823	\N	unreachable	unreachable	5th times i called him	335	14
768	2024-09-21 07:08:51.79696	2024-09-21 07:08:51.79696	\N	new	not-interested	work visa	334	14
769	2024-09-21 07:09:21.714831	2024-09-21 07:09:21.714831	\N	new	not-interested	nonsense	332	14
770	2024-09-21 07:11:37.153307	2024-09-21 07:11:37.153307	\N	new	unreachable	phone off	331	14
771	2024-09-21 07:11:51.328907	2024-09-21 07:11:51.328907	\N	unreachable	unreachable	Lead updated by Farzana	331	14
772	2024-09-21 07:12:13.497395	2024-09-21 07:12:13.497395	\N	not-interested	not-interested	Lead updated by Farzana	337	14
773	2024-09-21 07:12:20.589056	2024-09-21 07:12:20.589056	\N	not-interested	not-interested	Lead updated by Farzana	337	14
774	2024-09-21 07:13:05.280666	2024-09-21 07:13:05.280666	\N	new	unreachable	phone off	330	14
775	2024-09-21 07:14:17.475819	2024-09-21 07:14:17.475819	\N	new	not-interested	unqualified and non-sense 	329	14
776	2024-09-21 07:15:17.138581	2024-09-21 07:15:17.138581	\N	new	appointment-book	he sends me CV and he wants to visit our office	328	14
777	2024-09-21 07:15:20.211529	2024-09-21 07:15:20.211529	\N	appointment-book	appointment-book	Lead updated by Farzana	328	14
778	2024-09-21 07:15:43.7676	2024-09-21 07:15:43.7676	\N	appointment-book	appointment-book	Lead updated by Farzana	328	14
779	2024-09-21 08:12:17.886146	2024-09-21 08:12:17.886146	\N	new	not-interested	not qualified 	327	14
780	2024-09-21 08:12:20.615729	2024-09-21 08:12:20.615729	\N	not-interested	not-interested	Lead updated by Farzana	327	14
781	2024-09-21 08:19:06.875825	2024-09-21 08:19:06.875825	\N	new	unreachable	No phone number	326	14
782	2024-09-21 08:19:09.450924	2024-09-21 08:19:09.450924	\N	unreachable	unreachable	Lead updated by Farzana	326	14
783	2024-09-21 08:28:46.863425	2024-09-21 08:28:46.863425	\N	new	not-interested	Cut my phone several time	325	14
784	2024-09-21 08:28:57.728799	2024-09-21 08:28:57.728799	\N	not-interested	not-interested	Lead updated by Farzana	325	14
785	2024-09-21 08:31:36.031274	2024-09-21 08:31:36.031274	\N	new	future-interest	he is connected with whats app	324	14
786	2024-09-21 08:33:46.599255	2024-09-21 08:33:46.599255	\N	new	future-interest	connected with whats app	323	14
787	2024-09-21 08:41:31.992422	2024-09-21 08:41:31.992422	\N	new	first	His ielts exam will be held on 28th September	322	14
788	2024-09-21 08:43:42.461167	2024-09-21 08:43:42.461167	\N	new	not-interested	mistake	320	14
789	2024-09-21 08:46:22.517921	2024-09-21 08:46:22.517921	\N	new	not-interested	work visa	321	14
790	2024-09-21 08:46:24.325661	2024-09-21 08:46:24.325661	\N	not-interested	not-interested	Lead updated by Farzana	321	14
791	2024-09-21 08:47:17.419834	2024-09-21 08:47:17.419834	\N	new	unreachable	Phone off	318	14
792	2024-09-21 08:47:19.692341	2024-09-21 08:47:19.692341	\N	unreachable	unreachable	Lead updated by Farzana	318	14
793	2024-09-21 09:07:41.771346	2024-09-21 09:07:41.771346	\N	new	not-interested	bad profile	319	14
794	2024-09-21 09:09:58.678124	2024-09-21 09:09:58.678124	\N	new	future-interest	No ielts, he wants PHD program and connected with whats app	316	14
795	2024-09-21 09:10:44.737879	2024-09-21 09:10:44.737879	\N	new	not-interested	Bad profile	315	14
796	2024-09-21 09:11:40.807315	2024-09-21 09:11:40.807315	\N	new	unreachable	several times i called her	313	14
797	2024-09-21 09:19:48.266428	2024-09-21 09:19:48.266428	\N	new	new	Lead updated by Naf	279	1
798	2024-09-21 09:23:26.245168	2024-09-21 09:23:26.245168	\N	new	new	Lead updated by Naf	296	1
799	2024-09-21 09:23:26.247876	2024-09-21 09:23:26.247876	\N	new	new	Lead updated by Naf	297	1
800	2024-09-21 09:23:26.386947	2024-09-21 09:23:26.386947	\N	new	new	Lead updated by Naf	294	1
801	2024-09-21 09:23:26.390353	2024-09-21 09:23:26.390353	\N	new	new	Lead updated by Naf	295	1
802	2024-09-21 09:23:26.685725	2024-09-21 09:23:26.685725	\N	new	new	Lead updated by Naf	298	1
803	2024-09-21 09:23:26.69827	2024-09-21 09:23:26.69827	\N	new	new	Lead updated by Naf	299	1
804	2024-09-21 09:23:26.715663	2024-09-21 09:23:26.715663	\N	new	new	Lead updated by Naf	300	1
805	2024-09-21 09:23:26.715934	2024-09-21 09:23:26.715934	\N	new	new	Lead updated by Naf	303	1
806	2024-09-21 09:23:26.735623	2024-09-21 09:23:26.735623	\N	new	new	Lead updated by Naf	302	1
807	2024-09-21 09:23:26.738253	2024-09-21 09:23:26.738253	\N	new	new	Lead updated by Naf	301	1
808	2024-09-21 09:24:00.326108	2024-09-21 09:24:00.326108	\N	new	new	Lead updated by Naf	295	1
809	2024-09-21 09:24:00.326462	2024-09-21 09:24:00.326462	\N	new	new	Lead updated by Naf	294	1
810	2024-09-21 09:25:00.384205	2024-09-21 09:25:00.384205	\N	new	new	Lead updated by Naf	292	1
811	2024-09-21 09:25:00.38783	2024-09-21 09:25:00.38783	\N	new	new	Lead updated by Naf	293	1
812	2024-09-21 09:25:00.386606	2024-09-21 09:25:00.386606	\N	new	new	Lead updated by Naf	291	1
813	2024-09-21 09:25:38.536106	2024-09-21 09:25:38.536106	\N	new	new	Lead updated by Naf	287	1
814	2024-09-21 09:25:38.539703	2024-09-21 09:25:38.539703	\N	new	new	Lead updated by Naf	285	1
815	2024-09-21 09:25:38.546398	2024-09-21 09:25:38.546398	\N	new	new	Lead updated by Naf	289	1
816	2024-09-21 09:25:38.561166	2024-09-21 09:25:38.561166	\N	new	new	Lead updated by Naf	290	1
817	2024-09-21 09:25:38.561252	2024-09-21 09:25:38.561252	\N	new	new	Lead updated by Naf	288	1
818	2024-09-21 09:25:38.560123	2024-09-21 09:25:38.560123	\N	new	new	Lead updated by Naf	286	1
819	2024-09-21 09:25:38.703533	2024-09-21 09:25:38.703533	\N	new	new	Lead updated by Naf	284	1
820	2024-09-21 09:26:52.517409	2024-09-21 09:26:52.517409	\N	new	new	Lead updated by Naf	279	1
821	2024-09-21 09:26:52.517338	2024-09-21 09:26:52.517338	\N	new	new	Lead updated by Naf	278	1
822	2024-09-21 09:26:52.5329	2024-09-21 09:26:52.5329	\N	new	new	Lead updated by Naf	282	1
823	2024-09-21 09:26:52.546942	2024-09-21 09:26:52.546942	\N	new	new	Lead updated by Naf	283	1
824	2024-09-21 09:26:52.553152	2024-09-21 09:26:52.553152	\N	new	new	Lead updated by Naf	281	1
825	2024-09-21 09:26:52.556971	2024-09-21 09:26:52.556971	\N	new	new	Lead updated by Naf	280	1
826	2024-09-21 09:26:52.754424	2024-09-21 09:26:52.754424	\N	new	new	Lead updated by Naf	274	1
827	2024-09-21 09:26:52.754777	2024-09-21 09:26:52.754777	\N	new	new	Lead updated by Naf	277	1
828	2024-09-21 09:26:52.761389	2024-09-21 09:26:52.761389	\N	new	new	Lead updated by Naf	276	1
829	2024-09-21 09:26:52.766706	2024-09-21 09:26:52.766706	\N	new	new	Lead updated by Naf	275	1
830	2024-09-21 09:28:19.9486	2024-09-21 09:28:19.9486	\N	new	new	Lead updated by Naf	272	1
831	2024-09-21 09:28:19.952194	2024-09-21 09:28:19.952194	\N	new	new	Lead updated by Naf	273	1
832	2024-09-21 09:28:20.179587	2024-09-21 09:28:20.179587	\N	new	new	Lead updated by Naf	271	1
833	2024-09-21 09:28:20.181046	2024-09-21 09:28:20.181046	\N	new	new	Lead updated by Naf	270	1
834	2024-09-21 09:28:46.505845	2024-09-21 09:28:46.505845	\N	new	new	Lead updated by Naf	266	1
835	2024-09-21 09:28:46.50612	2024-09-21 09:28:46.50612	\N	new	new	Lead updated by Naf	264	1
836	2024-09-21 09:28:46.535081	2024-09-21 09:28:46.535081	\N	new	new	Lead updated by Naf	267	1
837	2024-09-21 09:28:46.536683	2024-09-21 09:28:46.536683	\N	new	new	Lead updated by Naf	269	1
838	2024-09-21 09:28:46.536931	2024-09-21 09:28:46.536931	\N	new	new	Lead updated by Naf	265	1
839	2024-09-21 09:28:46.537041	2024-09-21 09:28:46.537041	\N	new	new	Lead updated by Naf	268	1
840	2024-09-21 09:29:57.551044	2024-09-21 09:29:57.551044	\N	new	new	Lead updated by Naf	259	1
841	2024-09-21 09:29:57.55441	2024-09-21 09:29:57.55441	\N	new	new	Lead updated by Naf	258	1
842	2024-09-21 09:29:57.567819	2024-09-21 09:29:57.567819	\N	new	new	Lead updated by Naf	261	1
843	2024-09-21 09:29:57.570884	2024-09-21 09:29:57.570884	\N	new	new	Lead updated by Naf	263	1
844	2024-09-21 09:29:57.571214	2024-09-21 09:29:57.571214	\N	new	new	Lead updated by Naf	262	1
845	2024-09-21 09:29:57.579908	2024-09-21 09:29:57.579908	\N	new	new	Lead updated by Naf	260	1
846	2024-09-21 09:29:57.784444	2024-09-21 09:29:57.784444	\N	new	new	Lead updated by Naf	254	1
847	2024-09-21 09:29:57.790481	2024-09-21 09:29:57.790481	\N	new	new	Lead updated by Naf	256	1
848	2024-09-21 09:29:57.795121	2024-09-21 09:29:57.795121	\N	new	new	Lead updated by Naf	257	1
849	2024-09-21 09:29:57.799106	2024-09-21 09:29:57.799106	\N	new	new	Lead updated by Naf	255	1
850	2024-09-21 09:30:29.247432	2024-09-21 09:30:29.247432	\N	new	new	Lead updated by Naf	252	1
851	2024-09-21 09:30:29.262988	2024-09-21 09:30:29.262988	\N	new	new	Lead updated by Naf	253	1
852	2024-09-21 09:30:29.270876	2024-09-21 09:30:29.270876	\N	new	new	Lead updated by Naf	250	1
853	2024-09-21 09:30:29.2728	2024-09-21 09:30:29.2728	\N	new	new	Lead updated by Naf	251	1
854	2024-09-21 09:30:29.278403	2024-09-21 09:30:29.278403	\N	new	new	Lead updated by Naf	249	1
855	2024-09-21 09:30:54.289561	2024-09-21 09:30:54.289561	\N	new	new	Lead updated by Naf	248	1
856	2024-09-21 09:30:54.312105	2024-09-21 09:30:54.312105	\N	new	new	Lead updated by Naf	244	1
857	2024-09-21 09:30:54.321049	2024-09-21 09:30:54.321049	\N	new	new	Lead updated by Naf	246	1
858	2024-09-21 09:30:54.324205	2024-09-21 09:30:54.324205	\N	new	new	Lead updated by Naf	245	1
859	2024-09-21 09:30:54.328816	2024-09-21 09:30:54.328816	\N	new	new	Lead updated by Naf	247	1
860	2024-09-21 09:31:37.944031	2024-09-21 09:31:37.944031	\N	new	new	Lead updated by Naf	240	1
861	2024-09-21 09:31:37.966216	2024-09-21 09:31:37.966216	\N	new	new	Lead updated by Naf	242	1
862	2024-09-21 09:31:37.979418	2024-09-21 09:31:37.979418	\N	new	new	Lead updated by Naf	239	1
863	2024-09-21 09:31:37.980634	2024-09-21 09:31:37.980634	\N	new	new	Lead updated by Naf	241	1
864	2024-09-21 09:31:37.982612	2024-09-21 09:31:37.982612	\N	new	new	Lead updated by Naf	243	1
865	2024-09-21 09:31:38.146747	2024-09-21 09:31:38.146747	\N	new	new	Lead updated by Naf	234	1
866	2024-09-21 09:31:38.148524	2024-09-21 09:31:38.148524	\N	new	new	Lead updated by Naf	236	1
867	2024-09-21 09:31:38.155148	2024-09-21 09:31:38.155148	\N	new	new	Lead updated by Naf	237	1
868	2024-09-21 09:31:38.155351	2024-09-21 09:31:38.155351	\N	new	new	Lead updated by Naf	238	1
869	2024-09-21 09:31:38.159863	2024-09-21 09:31:38.159863	\N	new	new	Lead updated by Naf	235	1
870	2024-09-21 09:31:41.700773	2024-09-21 09:31:41.700773	\N	new	new	Lead updated by Naf	240	1
871	2024-09-21 09:31:41.712399	2024-09-21 09:31:41.712399	\N	new	new	Lead updated by Naf	243	1
872	2024-09-21 09:31:41.712813	2024-09-21 09:31:41.712813	\N	new	new	Lead updated by Naf	241	1
873	2024-09-21 09:31:41.716063	2024-09-21 09:31:41.716063	\N	new	new	Lead updated by Naf	242	1
874	2024-09-21 09:31:42.102485	2024-09-21 09:31:42.102485	\N	new	new	Lead updated by Naf	236	1
875	2024-09-21 09:31:42.106188	2024-09-21 09:31:42.106188	\N	new	new	Lead updated by Naf	237	1
876	2024-09-21 09:31:42.110863	2024-09-21 09:31:42.110863	\N	new	new	Lead updated by Naf	238	1
877	2024-09-21 09:31:42.111482	2024-09-21 09:31:42.111482	\N	new	new	Lead updated by Naf	239	1
878	2024-09-21 09:31:42.121842	2024-09-21 09:31:42.121842	\N	new	new	Lead updated by Naf	235	1
879	2024-09-21 09:31:42.12385	2024-09-21 09:31:42.12385	\N	new	new	Lead updated by Naf	234	1
880	2024-09-21 09:32:41.906796	2024-09-21 09:32:41.906796	\N	new	new	Lead updated by Naf	231	1
881	2024-09-21 09:32:41.906804	2024-09-21 09:32:41.906804	\N	new	new	Lead updated by Naf	232	1
882	2024-09-21 09:32:41.907959	2024-09-21 09:32:41.907959	\N	new	new	Lead updated by Naf	233	1
883	2024-09-21 09:32:41.908225	2024-09-21 09:32:41.908225	\N	new	new	Lead updated by Naf	230	1
884	2024-09-21 09:33:06.862212	2024-09-21 09:33:06.862212	\N	new	new	Lead updated by Naf	226	1
885	2024-09-21 09:33:06.862565	2024-09-21 09:33:06.862565	\N	new	new	Lead updated by Naf	227	1
886	2024-09-21 09:33:06.864513	2024-09-21 09:33:06.864513	\N	new	new	Lead updated by Naf	229	1
887	2024-09-21 09:33:06.866129	2024-09-21 09:33:06.866129	\N	new	new	Lead updated by Naf	228	1
888	2024-09-21 09:33:07.107485	2024-09-21 09:33:07.107485	\N	new	new	Lead updated by Naf	224	1
889	2024-09-21 09:33:07.116059	2024-09-21 09:33:07.116059	\N	new	new	Lead updated by Naf	225	1
890	2024-09-21 09:34:08.944804	2024-09-21 09:34:08.944804	\N	new	new	Lead updated by Naf	223	1
891	2024-09-21 09:34:08.956652	2024-09-21 09:34:08.956652	\N	new	new	Lead updated by Naf	220	1
892	2024-09-21 09:34:08.957125	2024-09-21 09:34:08.957125	\N	new	new	Lead updated by Naf	221	1
893	2024-09-21 09:34:08.961235	2024-09-21 09:34:08.961235	\N	new	new	Lead updated by Naf	222	1
897	2024-09-21 09:34:09.480803	2024-09-21 09:34:09.480803	\N	new	new	Lead updated by Naf	217	1
898	2024-09-21 09:34:09.89802	2024-09-21 09:34:09.89802	\N	new	new	Lead updated by Naf	214	1
899	2024-09-21 09:34:09.900364	2024-09-21 09:34:09.900364	\N	new	new	Lead updated by Naf	215	1
1161	2024-11-24 06:28:35.520912	2024-11-24 06:28:35.520912	\N	new	unreachable	i called him several time	317	14
1171	2024-11-24 13:09:47.905343	2024-11-24 13:09:47.905343	\N	-	start	Lead created by Naf	365	1
1187	2024-11-24 13:09:47.919243	2024-11-24 13:09:47.919243	\N	-	start	Lead created by Naf	382	1
1197	2024-11-24 13:09:47.938732	2024-11-24 13:09:47.938732	\N	-	start	Lead created by Naf	390	1
1205	2024-11-24 13:09:47.943186	2024-11-24 13:09:47.943186	\N	-	start	Lead created by Naf	401	1
1212	2024-11-24 13:09:47.948252	2024-11-24 13:09:47.948252	\N	-	start	Lead created by Naf	399	1
1221	2024-11-24 13:09:47.956848	2024-11-24 13:09:47.956848	\N	-	start	Lead created by Naf	403	1
1230	2024-11-24 13:09:47.966534	2024-11-24 13:09:47.966534	\N	-	start	Lead created by Naf	423	1
1237	2024-11-24 13:09:47.973162	2024-11-24 13:09:47.973162	\N	-	start	Lead created by Naf	429	1
1246	2024-11-24 13:09:47.984245	2024-11-24 13:09:47.984245	\N	-	start	Lead created by Naf	438	1
1254	2024-11-24 13:09:47.991849	2024-11-24 13:09:47.991849	\N	-	start	Lead created by Naf	451	1
1264	2024-11-24 13:09:48.002393	2024-11-24 13:09:48.002393	\N	-	start	Lead created by Naf	458	1
1271	2024-11-24 13:09:48.012421	2024-11-24 13:09:48.012421	\N	-	start	Lead created by Naf	452	1
1279	2024-11-24 13:09:48.019485	2024-11-24 13:09:48.019485	\N	-	start	Lead created by Naf	473	1
1289	2024-11-24 13:09:48.025574	2024-11-24 13:09:48.025574	\N	-	start	Lead created by Naf	474	1
1293	2024-11-24 13:09:48.03262	2024-11-24 13:09:48.03262	\N	-	start	Lead created by Naf	487	1
1303	2024-11-24 13:09:48.044583	2024-11-24 13:09:48.044583	\N	-	start	Lead created by Naf	493	1
1312	2024-11-24 13:09:48.050705	2024-11-24 13:09:48.050705	\N	-	start	Lead created by Naf	508	1
1319	2024-11-24 13:09:48.060192	2024-11-24 13:09:48.060192	\N	-	start	Lead created by Naf	507	1
1329	2024-11-24 13:09:48.07324	2024-11-24 13:09:48.07324	\N	-	start	Lead created by Naf	519	1
1336	2024-11-24 13:09:48.079818	2024-11-24 13:09:48.079818	\N	-	start	Lead created by Naf	520	1
1344	2024-11-24 13:09:48.084777	2024-11-24 13:09:48.084777	\N	-	start	Lead created by Naf	542	1
1352	2024-11-24 13:09:48.093027	2024-11-24 13:09:48.093027	\N	-	start	Lead created by Naf	547	1
1360	2024-11-24 13:09:48.098711	2024-11-24 13:09:48.098711	\N	-	start	Lead created by Naf	551	1
1369	2024-11-24 13:09:48.10997	2024-11-24 13:09:48.10997	\N	-	start	Lead created by Naf	558	1
894	2024-09-21 09:34:09.471677	2024-09-21 09:34:09.471677	\N	new	new	Lead updated by Naf	219	1
895	2024-09-21 09:34:09.471346	2024-09-21 09:34:09.471346	\N	new	new	Lead updated by Naf	218	1
896	2024-09-21 09:34:09.474031	2024-09-21 09:34:09.474031	\N	new	new	Lead updated by Naf	216	1
900	2024-09-21 09:34:38.292023	2024-09-21 09:34:38.292023	\N	new	new	Lead updated by Naf	213	1
901	2024-09-21 09:34:38.296099	2024-09-21 09:34:38.296099	\N	new	new	Lead updated by Naf	210	1
902	2024-09-21 09:34:38.305607	2024-09-21 09:34:38.305607	\N	new	new	Lead updated by Naf	211	1
903	2024-09-21 09:34:38.305941	2024-09-21 09:34:38.305941	\N	new	new	Lead updated by Naf	212	1
904	2024-09-21 09:34:38.308341	2024-09-21 09:34:38.308341	\N	new	new	Lead updated by Naf	209	1
905	2024-09-21 09:35:05.111178	2024-09-21 09:35:05.111178	\N	new	new	Lead updated by Naf	207	1
906	2024-09-21 09:35:05.114964	2024-09-21 09:35:05.114964	\N	new	new	Lead updated by Naf	208	1
907	2024-09-21 09:35:05.121121	2024-09-21 09:35:05.121121	\N	new	new	Lead updated by Naf	204	1
908	2024-09-21 09:35:05.124408	2024-09-21 09:35:05.124408	\N	new	new	Lead updated by Naf	205	1
909	2024-09-21 09:35:05.125461	2024-09-21 09:35:05.125461	\N	new	new	Lead updated by Naf	206	1
910	2024-09-21 09:36:00.16192	2024-09-21 09:36:00.16192	\N	new	new	Lead updated by Naf	203	1
911	2024-09-21 09:36:00.187295	2024-09-21 09:36:00.187295	\N	new	new	Lead updated by Naf	201	1
912	2024-09-21 09:36:00.188378	2024-09-21 09:36:00.188378	\N	new	new	Lead updated by Naf	199	1
913	2024-09-21 09:36:00.189819	2024-09-21 09:36:00.189819	\N	new	new	Lead updated by Naf	202	1
914	2024-09-21 09:36:00.191268	2024-09-21 09:36:00.191268	\N	new	new	Lead updated by Naf	200	1
915	2024-09-21 09:36:00.394983	2024-09-21 09:36:00.394983	\N	new	new	Lead updated by Naf	195	1
916	2024-09-21 09:36:00.400665	2024-09-21 09:36:00.400665	\N	new	new	Lead updated by Naf	198	1
917	2024-09-21 09:36:00.403974	2024-09-21 09:36:00.403974	\N	new	new	Lead updated by Naf	196	1
918	2024-09-21 09:36:00.414262	2024-09-21 09:36:00.414262	\N	new	new	Lead updated by Naf	197	1
919	2024-09-21 09:36:00.415081	2024-09-21 09:36:00.415081	\N	new	new	Lead updated by Naf	194	1
920	2024-09-21 09:36:29.417829	2024-09-21 09:36:29.417829	\N	new	new	Lead updated by Naf	189	1
921	2024-09-21 09:36:29.420365	2024-09-21 09:36:29.420365	\N	new	new	Lead updated by Naf	190	1
922	2024-09-21 09:36:29.423887	2024-09-21 09:36:29.423887	\N	new	new	Lead updated by Naf	192	1
923	2024-09-21 09:36:29.435117	2024-09-21 09:36:29.435117	\N	new	new	Lead updated by Naf	191	1
924	2024-09-21 09:36:29.437222	2024-09-21 09:36:29.437222	\N	new	new	Lead updated by Naf	193	1
925	2024-09-21 10:43:04.707382	2024-09-21 10:43:04.707382	\N	new	not-interested	Bad	290	14
926	2024-09-21 11:22:27.528083	2024-09-21 11:22:27.528083	\N	new	first	masters 2018, teaching profession, ielts overall 6, wanna apply linguistics tesol	289	14
927	2024-09-21 13:33:13.986938	2024-09-21 13:33:13.986938	\N	new	first	graduation18, job running, in the next month he will give ielts	288	14
928	2024-09-21 13:34:14.155448	2024-09-21 13:34:14.155448	\N	new	not-interested	Long study gap. HSC 2008	287	14
929	2024-09-21 13:36:30.459566	2024-09-21 13:36:30.459566	\N	new	unreachable	No response. 4 times i called him	286	14
930	2024-09-21 13:39:11.61697	2024-09-21 13:39:11.61697	\N	new	first	he wants arabic language studies and preparing for ielts	285	14
931	2024-09-21 13:42:12.322452	2024-09-21 13:42:12.322452	\N	new	unreachable	no response, several times called him	283	14
932	2024-09-21 13:45:27.974883	2024-09-21 13:45:27.974883	\N	new	not-interested	bad profile, long long long study gap	284	14
933	2024-09-21 13:47:59.781781	2024-09-21 13:47:59.781781	\N	new	future-interest	she will take preparation for ielts	282	14
934	2024-09-21 13:50:09.620871	2024-09-21 13:50:09.620871	\N	new	unreachable	no phone number	281	14
935	2024-09-21 13:51:12.511042	2024-09-21 13:51:12.511042	\N	new	unreachable	no phone number	280	14
936	2024-09-21 15:48:28.965545	2024-09-21 15:48:28.965545	\N	new	future-interest	he did MBBS 1994	279	14
937	2024-09-21 15:49:47.566388	2024-09-21 15:49:47.566388	\N	new	unreachable	several times i called him but he cut my phone	278	14
938	2024-09-21 15:51:04.703841	2024-09-21 15:51:04.703841	\N	new	first	she was busy	277	14
939	2024-09-21 15:55:10.066388	2024-09-21 15:55:10.066388	\N	new	not-interested	mistake	276	14
940	2024-09-21 15:55:59.174836	2024-09-21 15:55:59.174836	\N	new	first	He wants PHD, has some research paper and preparing for ielts	275	14
941	2024-09-21 15:56:58.08614	2024-09-21 15:56:58.08614	\N	new	not-interested	nonsense 	274	14
942	2024-09-21 15:57:13.077247	2024-09-21 15:57:13.077247	\N	new	not-interested	nonsense	273	14
943	2024-09-21 15:57:51.822239	2024-09-21 15:57:51.822239	\N	new	unreachable	phone off	272	14
944	2024-09-21 15:58:10.877519	2024-09-21 15:58:10.877519	\N	new	unreachable	he did not pick my call	271	14
945	2024-09-21 15:58:42.713687	2024-09-21 15:58:42.713687	\N	new	not-interested	bad profile	270	14
946	2024-09-21 15:59:33.680509	2024-09-21 15:59:33.680509	\N	new	not-interested	bad	248	14
947	2024-09-21 15:59:43.365856	2024-09-21 15:59:43.365856	\N	new	not-interested	bad	247	14
948	2024-09-21 15:59:52.615301	2024-09-21 15:59:52.615301	\N	new	not-interested	bad	246	14
949	2024-09-21 16:00:02.568124	2024-09-21 16:00:02.568124	\N	new	not-interested	bad	245	14
950	2024-09-21 16:00:20.971681	2024-09-21 16:00:20.971681	\N	new	first	call her tomorrow	244	14
951	2024-09-21 16:00:58.420732	2024-09-21 16:00:58.420732	\N	new	unreachable	he did not pick my call	243	14
952	2024-09-21 16:01:05.765351	2024-09-21 16:01:05.765351	\N	new	not-interested	bad	242	14
953	2024-09-21 16:03:14.486613	2024-09-21 16:03:14.486613	\N	new	unreachable	phone off	241	14
954	2024-09-21 16:03:29.54759	2024-09-21 16:03:29.54759	\N	new	unreachable	no response	240	14
955	2024-09-21 16:04:21.293428	2024-09-21 16:04:21.293428	\N	new	not-interested	bad	239	14
956	2024-09-21 16:04:51.800318	2024-09-21 16:04:51.800318	\N	new	unreachable	no response	238	14
957	2024-09-21 16:05:05.545922	2024-09-21 16:05:05.545922	\N	new	unreachable	wrong number	237	14
958	2024-09-21 16:05:55.72144	2024-09-21 16:05:55.72144	\N	new	future-interest	waiting for result	236	14
959	2024-09-21 16:06:11.489569	2024-09-21 16:06:11.489569	\N	new	future-interest	waiting for result	235	14
960	2024-09-21 16:06:41.639216	2024-09-21 16:06:41.639216	\N	new	not-interested	bad	234	14
961	2024-09-21 16:06:52.831248	2024-09-21 16:06:52.831248	\N	new	unreachable	no response	233	14
962	2024-09-21 16:07:49.52157	2024-09-21 16:07:49.52157	\N	new	first	preparing for ielts	232	14
963	2024-09-21 16:08:01.114241	2024-09-21 16:08:01.114241	\N	new	unreachable	no number	231	14
964	2024-09-21 16:08:23.020437	2024-09-21 16:08:23.020437	\N	new	unreachable	no response	230	14
965	2024-09-21 16:13:09.22244	2024-09-21 16:13:09.22244	\N	new	first	interested	208	14
966	2024-09-21 16:13:19.86213	2024-09-21 16:13:19.86213	\N	new	first	interested	207	14
967	2024-09-21 16:13:58.342165	2024-09-21 16:13:58.342165	\N	new	unreachable	phone off	206	14
968	2024-09-21 16:14:13.333582	2024-09-21 16:14:13.333582	\N	new	first	interested	205	14
969	2024-09-21 16:15:52.502866	2024-09-21 16:15:52.502866	\N	new	first	call him tomorrow	204	14
970	2024-09-21 16:16:49.57607	2024-09-21 16:16:49.57607	\N	new	unreachable	no response 	203	14
971	2024-09-21 16:17:00.083957	2024-09-21 16:17:00.083957	\N	new	not-interested	bad	202	14
972	2024-09-21 16:17:11.950644	2024-09-21 16:17:11.950644	\N	new	not-interested	bad	201	14
973	2024-09-21 16:17:28.550816	2024-09-21 16:17:28.550816	\N	new	unreachable	no response 	200	14
974	2024-09-21 16:17:42.565076	2024-09-21 16:17:42.565076	\N	new	not-interested	bad	199	14
975	2024-09-21 16:17:50.001946	2024-09-21 16:17:50.001946	\N	new	not-interested	bad	198	14
976	2024-09-21 16:17:57.120088	2024-09-21 16:17:57.120088	\N	new	not-interested	bad	197	14
977	2024-09-21 16:18:14.679172	2024-09-21 16:18:14.679172	\N	new	unreachable	phone off	196	14
978	2024-09-21 16:18:27.255943	2024-09-21 16:18:27.255943	\N	new	unreachable	no response	195	14
979	2024-09-21 16:18:57.066532	2024-09-21 16:18:57.066532	\N	new	not-interested	bad	194	14
980	2024-09-21 16:19:03.923544	2024-09-21 16:19:03.923544	\N	new	not-interested	bad	193	14
981	2024-09-21 16:19:13.722146	2024-09-21 16:19:13.722146	\N	new	unreachable	no response	192	14
982	2024-09-21 16:19:20.762871	2024-09-21 16:19:20.762871	\N	new	not-interested	bad	191	14
983	2024-09-21 16:19:32.264028	2024-09-21 16:19:32.264028	\N	new	not-interested	bad	190	14
984	2024-09-21 16:19:42.043732	2024-09-21 16:19:42.043732	\N	new	not-interested	bad bad	189	14
985	2024-09-21 17:23:36.530322	2024-09-21 17:23:36.530322	\N	new	new	Lead updated by Jarin	209	13
986	2024-09-21 17:24:31.481762	2024-09-21 17:24:31.481762	\N	new	unreachable	wrong Number 	209	13
987	2024-09-21 17:24:57.72898	2024-09-21 17:24:57.72898	\N	unreachable	unreachable	Lead updated by Jarin	209	13
988	2024-09-21 17:42:59.638925	2024-09-21 17:42:59.638925	\N	new	future-interest	He wants to go in September 2025 intake	261	13
989	2024-09-21 17:44:34.100404	2024-09-21 17:44:34.100404	\N	future-interest	future-interest	Lead updated by Jarin	261	13
990	2024-09-21 17:44:43.31846	2024-09-21 17:44:43.31846	\N	future-interest	future-interest	Lead updated by Jarin	261	13
991	2024-09-21 17:44:43.414776	2024-09-21 17:44:43.414776	\N	future-interest	future-interest	Lead updated by Jarin	261	13
992	2024-09-21 17:44:44.689511	2024-09-21 17:44:44.689511	\N	future-interest	future-interest	Lead updated by Jarin	261	13
993	2024-09-21 17:44:46.45207	2024-09-21 17:44:46.45207	\N	future-interest	future-interest	Lead updated by Jarin	261	13
994	2024-09-21 17:44:47.284128	2024-09-21 17:44:47.284128	\N	future-interest	future-interest	Lead updated by Jarin	261	13
995	2024-09-21 17:44:49.139023	2024-09-21 17:44:49.139023	\N	future-interest	future-interest	Lead updated by Jarin	261	13
996	2024-09-21 17:50:53.848037	2024-09-21 17:50:53.848037	\N	new	new	Lead updated by Jarin	303	13
997	2024-09-21 17:51:42.793369	2024-09-21 17:51:42.793369	\N	new	unreachable	no 	303	13
998	2024-09-21 17:51:50.657341	2024-09-21 17:51:50.657341	\N	unreachable	unreachable	Lead updated by Jarin	303	13
999	2024-09-21 17:51:53.485976	2024-09-21 17:51:53.485976	\N	unreachable	unreachable	Lead updated by Jarin	303	13
1000	2024-09-21 18:18:07.139201	2024-09-21 18:18:07.139201	\N	new	unreachable	busy	262	13
1001	2024-09-21 18:18:19.242369	2024-09-21 18:18:19.242369	\N	unreachable	unreachable	Lead updated by Jarin	262	13
1002	2024-09-21 18:20:09.72045	2024-09-21 18:20:09.72045	\N	new	not-interested	wrong number	260	13
1003	2024-09-21 18:24:53.349488	2024-09-21 18:24:53.349488	\N	new	unreachable	 	264	13
1004	2024-09-21 18:25:00.184436	2024-09-21 18:25:00.184436	\N	unreachable	unreachable	Lead updated by Jarin	264	13
1005	2024-09-21 18:26:18.148647	2024-09-21 18:26:18.148647	\N	new	unreachable	no number	267	13
1006	2024-09-21 18:27:02.031022	2024-09-21 18:27:02.031022	\N	new	unreachable	no number	266	13
1007	2024-09-21 18:28:25.533382	2024-09-21 18:28:25.533382	\N	new	new	Lead updated by Jarin	268	13
1008	2024-09-21 18:29:00.59892	2024-09-21 18:29:00.59892	\N	new	not-interested	No answer	268	13
1009	2024-09-21 18:31:02.404354	2024-09-21 18:31:02.404354	\N	new	unreachable	no answer	269	13
1010	2024-09-21 18:31:06.30039	2024-09-21 18:31:06.30039	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1011	2024-09-21 18:31:15.919992	2024-09-21 18:31:15.919992	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1012	2024-09-21 18:32:54.071237	2024-09-21 18:32:54.071237	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1013	2024-09-21 18:33:15.927215	2024-09-21 18:33:15.927215	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1014	2024-09-21 18:33:18.427086	2024-09-21 18:33:18.427086	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1015	2024-09-21 18:33:56.232374	2024-09-21 18:33:56.232374	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1016	2024-09-21 18:35:05.722557	2024-09-21 18:35:05.722557	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1017	2024-09-21 18:35:10.362114	2024-09-21 18:35:10.362114	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1018	2024-09-21 18:36:12.824512	2024-09-21 18:36:12.824512	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1019	2024-09-21 18:37:30.626675	2024-09-21 18:37:30.626675	\N	unreachable	unreachable	Lead updated by Jarin	269	13
1020	2024-09-21 18:41:42.644433	2024-09-21 18:41:42.644433	\N	new	unreachable	No answer	210	13
1021	2024-09-21 18:43:53.701118	2024-09-21 18:43:53.701118	\N	new	unreachable	no answer	211	13
1022	2024-09-21 18:45:17.999458	2024-09-21 18:45:17.999458	\N	new	first	Busy	212	13
1023	2024-09-21 18:47:05.875777	2024-09-21 18:47:05.875777	\N	new	not-interested	wrong number	213	13
1024	2024-09-21 18:48:23.170252	2024-09-21 18:48:23.170252	\N	new	first	no answer	214	13
1025	2024-09-21 18:49:17.872174	2024-09-21 18:49:17.872174	\N	new	not-interested	No number	215	13
1026	2024-09-21 18:51:00.546781	2024-09-21 18:51:00.546781	\N	new	not-interested	Wrong number	216	13
1027	2024-09-21 18:53:33.368549	2024-09-21 18:53:33.368549	\N	new	appointment-book	waiting for office visit	296	13
1028	2024-09-21 18:54:57.184691	2024-09-21 18:54:57.184691	\N	new	new	Lead updated by Jarin	295	13
1029	2024-09-21 18:55:48.673281	2024-09-21 18:55:48.673281	\N	new	appointment-book	When office will ready 	295	13
1030	2024-09-21 18:55:54.602727	2024-09-21 18:55:54.602727	\N	appointment-book	appointment-book	Lead updated by Jarin	295	13
1031	2024-09-22 05:09:56.987904	2024-09-22 05:09:56.987904	\N	new	unreachable	Wrong Number 	302	13
1032	2024-09-22 05:09:59.874546	2024-09-22 05:09:59.874546	\N	unreachable	unreachable	Lead updated by Jarin	302	13
1033	2024-09-22 05:11:42.717389	2024-09-22 05:11:42.717389	\N	new	unreachable	Wrong number	301	13
1034	2024-09-22 05:11:47.684795	2024-09-22 05:11:47.684795	\N	unreachable	unreachable	Lead updated by Jarin	301	13
1035	2024-09-22 05:12:58.197546	2024-09-22 05:12:58.197546	\N	new	unreachable	Wrong umber	300	13
1036	2024-09-22 05:13:37.6184	2024-09-22 05:13:37.6184	\N	new	unreachable	Wrong number	299	13
1037	2024-09-22 05:17:40.022137	2024-09-22 05:17:40.022137	\N	new	unreachable	wrong number	298	13
1038	2024-09-22 05:21:19.011452	2024-09-22 05:21:19.011452	\N	new	future-interest	Need Fllowup	297	13
1039	2024-09-22 05:21:30.701048	2024-09-22 05:21:30.701048	\N	future-interest	future-interest	Lead updated by Jarin	297	13
1040	2024-09-22 05:24:03.030289	2024-09-22 05:24:03.030289	\N	new	unreachable	No Answer	294	13
1041	2024-09-22 05:24:04.618152	2024-09-22 05:24:04.618152	\N	unreachable	unreachable	Lead updated by Jarin	294	13
1042	2024-09-22 05:25:20.127319	2024-09-22 05:25:20.127319	\N	new	unreachable	Wrong Number 	293	13
1043	2024-09-22 05:26:27.577183	2024-09-22 05:26:27.577183	\N	new	unreachable	No Answer	292	13
1044	2024-09-22 05:29:59.18601	2024-09-22 05:29:59.18601	\N	new	unreachable	No Answer	263	13
1045	2024-09-22 05:34:00.036302	2024-09-22 05:34:00.036302	\N	new	unreachable	No answer	259	13
1046	2024-09-22 05:34:02.166759	2024-09-22 05:34:02.166759	\N	unreachable	unreachable	Lead updated by Jarin	259	13
1047	2024-09-22 05:35:45.452876	2024-09-22 05:35:45.452876	\N	new	not-interested	no	258	13
1048	2024-09-22 05:35:47.296507	2024-09-22 05:35:47.296507	\N	not-interested	not-interested	Lead updated by Jarin	258	13
1049	2024-09-22 05:36:53.977111	2024-09-22 05:36:53.977111	\N	new	unreachable	Busy	257	13
1050	2024-09-22 05:36:54.83392	2024-09-22 05:36:54.83392	\N	unreachable	unreachable	Lead updated by Jarin	257	13
1051	2024-09-22 05:37:50.187162	2024-09-22 05:37:50.187162	\N	new	not-interested	no	256	13
1052	2024-09-22 05:37:50.234256	2024-09-22 05:37:50.234256	\N	not-interested	not-interested	no	256	13
1053	2024-09-22 05:38:52.426872	2024-09-22 05:38:52.426872	\N	new	unreachable	Busy	254	13
1054	2024-09-22 05:40:08.597585	2024-09-22 05:40:08.597585	\N	new	unreachable	Switched Off	253	13
1055	2024-09-22 05:41:00.138183	2024-09-22 05:41:00.138183	\N	new	unreachable	Wrong Number 	252	13
1056	2024-09-22 05:41:58.731798	2024-09-22 05:41:58.731798	\N	new	not-interested	No	251	13
1057	2024-09-22 05:41:58.796945	2024-09-22 05:41:58.796945	\N	not-interested	not-interested	No	251	13
1058	2024-09-22 05:42:51.452756	2024-09-22 05:42:51.452756	\N	new	unreachable	Switched Off	250	13
1059	2024-09-22 05:44:49.338063	2024-09-22 05:44:49.338063	\N	new	unreachable	No answer	217	13
1060	2024-09-22 05:46:53.620141	2024-09-22 05:46:53.620141	\N	new	unreachable	Wrong Number	227	13
1061	2024-09-22 05:47:46.496179	2024-09-22 05:47:46.496179	\N	new	unreachable	Busy	226	13
1062	2024-09-22 05:48:30.13178	2024-09-22 05:48:30.13178	\N	new	unreachable	NO Answer	225	13
1063	2024-09-22 05:49:21.610696	2024-09-22 05:49:21.610696	\N	new	new	Lead updated by Jarin	218	13
1064	2024-09-22 05:49:35.125851	2024-09-22 05:49:35.125851	\N	new	unreachable	Busy	224	13
1065	2024-09-22 05:49:55.281967	2024-09-22 05:49:55.281967	\N	new	unreachable	Number missing	218	13
1066	2024-09-22 05:50:02.962676	2024-09-22 05:50:02.962676	\N	unreachable	unreachable	Lead updated by Jarin	218	13
1067	2024-09-22 05:50:22.172172	2024-09-22 05:50:22.172172	\N	new	unreachable	NO Answer	223	13
1068	2024-09-22 05:51:07.191612	2024-09-22 05:51:07.191612	\N	new	unreachable	Busy	222	13
1069	2024-09-22 05:52:08.525148	2024-09-22 05:52:08.525148	\N	new	not-interested	Not Interested	221	13
1070	2024-09-22 05:53:02.038896	2024-09-22 05:53:02.038896	\N	new	unreachable	Number missing	291	13
1071	2024-09-22 05:53:05.182758	2024-09-22 05:53:05.182758	\N	new	not-interested	Not Interested	220	13
1072	2024-09-22 05:53:08.746813	2024-09-22 05:53:08.746813	\N	not-interested	not-interested	Lead updated by Jarin	220	13
1073	2024-09-22 05:53:49.843907	2024-09-22 05:53:49.843907	\N	new	unreachable	BUSY	219	13
1074	2024-09-22 05:54:08.52507	2024-09-22 05:54:08.52507	\N	new	unreachable	Number missing	265	13
1075	2024-09-22 05:55:29.910338	2024-09-22 05:55:29.910338	\N	new	unreachable	Number missing	255	13
1076	2024-09-22 05:57:26.906397	2024-09-22 05:57:26.906397	\N	new	unreachable	No answer	249	13
1077	2024-09-22 06:06:13.842621	2024-09-22 06:06:13.842621	\N	new	unreachable	No answer	229	13
1078	2024-09-22 06:08:11.580627	2024-09-22 06:08:11.580627	\N	new	unreachable	No answer	228	13
1079	2024-09-22 06:15:09.138043	2024-09-22 06:15:09.138043	\N	new	new	Lead updated by Naf	310	1
1080	2024-09-22 06:15:09.141753	2024-09-22 06:15:09.141753	\N	new	new	Lead updated by Naf	307	1
1081	2024-09-22 06:15:09.17008	2024-09-22 06:15:09.17008	\N	new	new	Lead updated by Naf	312	1
1082	2024-09-22 06:15:09.177316	2024-09-22 06:15:09.177316	\N	new	new	Lead updated by Naf	308	1
1083	2024-09-22 06:15:09.179159	2024-09-22 06:15:09.179159	\N	new	new	Lead updated by Naf	311	1
1084	2024-09-22 06:15:09.180776	2024-09-22 06:15:09.180776	\N	new	new	Lead updated by Naf	309	1
1085	2024-09-22 06:15:09.279314	2024-09-22 06:15:09.279314	\N	new	new	Lead updated by Naf	306	1
1086	2024-09-22 06:15:09.285436	2024-09-22 06:15:09.285436	\N	new	new	Lead updated by Naf	305	1
1087	2024-09-22 06:15:09.320861	2024-09-22 06:15:09.320861	\N	new	new	Lead updated by Naf	304	1
1088	2024-09-22 06:15:26.634859	2024-09-22 06:15:26.634859	\N	-	start	Lead created by Jarin	342	13
1089	2024-09-22 06:16:53.580633	2024-09-22 06:16:53.580633	\N	new	new	Lead updated by Naf	312	1
1090	2024-09-22 06:16:53.582057	2024-09-22 06:16:53.582057	\N	new	new	Lead updated by Naf	311	1
1091	2024-09-22 06:16:53.583768	2024-09-22 06:16:53.583768	\N	new	new	Lead updated by Naf	310	1
1092	2024-09-22 06:16:53.710832	2024-09-22 06:16:53.710832	\N	new	new	Lead updated by Naf	307	1
1093	2024-09-22 06:16:53.711221	2024-09-22 06:16:53.711221	\N	new	new	Lead updated by Naf	308	1
1094	2024-09-22 06:16:53.712078	2024-09-22 06:16:53.712078	\N	new	new	Lead updated by Naf	309	1
1095	2024-09-22 06:16:53.743338	2024-09-22 06:16:53.743338	\N	new	new	Lead updated by Naf	306	1
1096	2024-09-22 06:16:53.744418	2024-09-22 06:16:53.744418	\N	new	new	Lead updated by Naf	305	1
1097	2024-09-22 06:16:53.746732	2024-09-22 06:16:53.746732	\N	new	new	Lead updated by Naf	304	1
1098	2024-09-22 06:17:01.283261	2024-09-22 06:17:01.283261	\N	new	future-interest	He wants to go Malta	342	13
1099	2024-09-22 06:33:47.099087	2024-09-22 06:33:47.099087	\N	-	start	Lead created by Jarin	343	13
1100	2024-09-22 06:33:50.870283	2024-09-22 06:33:50.870283	\N	new	new	Lead updated by Jarin	343	13
1101	2024-09-22 06:34:18.345532	2024-09-22 06:34:18.345532	\N	new	future-interest	Waiting for Hsc result	343	13
1102	2024-09-22 06:35:22.341063	2024-09-22 06:35:22.341063	\N	future-interest	future-interest	Lead updated by Jarin	343	13
1103	2024-09-22 06:43:18.815312	2024-09-22 06:43:18.815312	\N	new	unreachable	Number missing	312	13
1104	2024-09-22 06:46:53.95763	2024-09-22 06:46:53.95763	\N	new	unreachable	Busy	310	13
1105	2024-09-22 06:49:52.074379	2024-09-22 06:49:52.074379	\N	new	future-interest	He wants to go europe ,Japan or south korea	311	13
1106	2024-09-22 07:01:45.002948	2024-09-22 07:01:45.002948	\N	new	unreachable	No answer	309	13
1107	2024-09-22 07:02:05.230958	2024-09-22 07:02:05.230958	\N	new	unreachable	Number Missing	308	13
1108	2024-09-22 07:02:51.419039	2024-09-22 07:02:51.419039	\N	new	not-interested	No answer	307	13
1109	2024-09-22 07:05:14.835891	2024-09-22 07:05:14.835891	\N	new	unreachable	No answer	306	13
1110	2024-09-22 07:09:28.569846	2024-09-22 07:09:28.569846	\N	new	unreachable	No answer	305	13
1111	2024-09-22 07:09:54.300255	2024-09-22 07:09:54.300255	\N	new	unreachable	Busy	304	13
1112	2024-09-24 13:06:38.396871	2024-09-24 13:06:38.396871	\N	not-interested	course-new	Lead updated by Naf	337	1
1113	2024-09-24 13:06:47.829449	2024-09-24 13:06:47.829449	\N	course-new	new	Lead updated by Naf	337	1
1114	2024-09-24 13:13:09.350258	2024-09-24 13:13:09.350258	\N	new	appointment-book	on 24th	337	1
1115	2024-09-24 13:13:24.876874	2024-09-24 13:13:24.876874	\N	appointment-book	waiting-for-document	rec	337	1
1116	2024-09-24 13:13:39.033461	2024-09-24 13:13:39.033461	\N	waiting-for-document	waiting-for-document	Lead updated by Naf	337	1
1117	2024-09-24 13:13:45.995243	2024-09-24 13:13:45.995243	\N	waiting-for-document	waiting-for-document	Lead updated by Naf	337	1
1118	2024-09-24 13:18:04.158353	2024-09-24 13:18:04.158353	\N	unreachable	course-new	Lead updated by Naf	300	1
1119	2024-09-24 13:18:10.28859	2024-09-24 13:18:10.28859	\N	course-new	new	Lead updated by Naf	300	1
1120	2024-09-24 13:18:35.297336	2024-09-24 13:18:35.297336	\N	new	appointment-book	interested	300	1
1121	2024-09-25 06:35:18.928059	2024-09-25 06:35:18.928059	\N	first	course-new	Lead updated by Farzana	322	14
1122	2024-09-25 06:37:05.213529	2024-09-25 06:37:05.213529	\N	course-new	exam	28th September exam. i will call him 13th October	322	14
1123	2024-09-25 06:37:37.693898	2024-09-25 06:37:37.693898	\N	exam	course-new	Lead updated by Farzana	322	14
1124	2024-09-25 06:38:18.650254	2024-09-25 06:38:18.650254	\N	course-new	course-first	28th September exam. i will call him 13th October	322	14
1125	2024-09-25 06:43:46.820766	2024-09-25 06:43:46.820766	\N	first	appointment-book	He will tell me his time for visit	289	14
1126	2024-09-25 06:51:36.258078	2024-09-25 06:51:36.258078	\N	first	appointment-book	he will come 	288	14
1127	2024-09-25 09:11:37.596911	2024-09-25 09:11:37.596911	\N	new	not-interested	mistake	333	14
1128	2024-09-26 11:25:43.748356	2024-09-26 11:25:43.748356	\N	first	unreachable	several time i called her father. no response	205	14
1129	2024-09-26 14:20:05.573473	2024-09-26 14:20:05.573473	\N	-	start	Lead created by Farzana	345	14
1130	2024-09-26 14:20:41.704146	2024-09-26 14:20:41.704146	\N	new	new	Lead updated by Farzana	345	14
1131	2024-09-26 14:23:49.759282	2024-09-26 14:23:49.759282	\N	new	new	Lead updated by Farzana	345	14
1132	2024-09-26 14:24:53.793565	2024-09-26 14:24:53.793565	\N	new	new	Lead updated by Farzana	345	14
1133	2024-09-26 14:25:28.820422	2024-09-26 14:25:28.820422	\N	new	appointment-book	she sends all documents	345	14
1134	2024-09-26 14:26:22.978081	2024-09-26 14:26:22.978081	\N	appointment-book	waiting-for-document	she sends all documents	345	14
1135	2024-09-26 15:29:52.925062	2024-09-26 15:29:52.925062	\N	waiting-for-document	start-application	already all documents have been send to the application team	345	14
1136	2024-09-28 06:35:08.788255	2024-09-28 06:35:08.788255	\N	-	start	Lead created by Jarin	354	13
1137	2024-09-28 06:35:12.121044	2024-09-28 06:35:12.121044	\N	new	new	Lead updated by Jarin	354	13
1138	2024-09-28 06:35:53.697975	2024-09-28 06:35:53.697975	\N	new	appointment-book	He wants to go australia	354	13
1139	2024-09-28 06:35:59.324182	2024-09-28 06:35:59.324182	\N	appointment-book	appointment-book	Lead updated by Jarin	354	13
1140	2024-09-28 06:37:01.470444	2024-09-28 06:37:01.470444	\N	appointment-book	waiting-for-document	He will send documents	354	13
1141	2024-09-30 06:09:54.807075	2024-09-30 06:09:54.807075	\N	-	start	Lead created by Jarin	355	13
1142	2024-09-30 06:10:55.616555	2024-09-30 06:10:55.616555	\N	new	new	Lead updated by Jarin	355	13
1143	2024-09-30 06:11:53.503148	2024-09-30 06:11:53.503148	\N	new	future-interest	interested for australia 2025 september doing ielts or pte	355	13
1144	2024-09-30 06:12:10.405376	2024-09-30 06:12:10.405376	\N	future-interest	future-interest	Lead updated by Jarin	355	13
1145	2024-10-10 10:48:24.833136	2024-10-10 10:48:24.833136	\N	appointment-book	course-new	Lead updated by Farzana	328	14
1146	2024-10-10 10:48:31.531182	2024-10-10 10:48:31.531182	\N	course-new	new	Lead updated by Farzana	328	14
1147	2024-10-10 10:48:51.807701	2024-10-10 10:48:51.807701	\N	new	unreachable	Several times i called him, no response	328	14
1148	2024-10-10 10:48:54.84354	2024-10-10 10:48:54.84354	\N	unreachable	unreachable	Lead updated by Farzana	328	14
1149	2024-10-10 10:48:56.812656	2024-10-10 10:48:56.812656	\N	unreachable	unreachable	Lead updated by Farzana	328	14
1150	2024-10-10 10:52:01.57416	2024-10-10 10:52:01.57416	\N	appointment-book	course-new	Lead updated by Farzana	289	14
1151	2024-10-10 10:52:05.043065	2024-10-10 10:52:05.043065	\N	course-new	new	Lead updated by Farzana	289	14
1152	2024-10-10 10:52:38.374601	2024-10-10 10:52:38.374601	\N	new	future-interest	He will take ielts within December	289	14
1162	2024-11-24 12:45:42.84541	2024-11-24 12:45:42.84541	\N	unreachable	course-new	Lead updated by Farzana	340	14
1172	2024-11-24 13:09:47.905106	2024-11-24 13:09:47.905106	\N	-	start	Lead created by Naf	361	1
1181	2024-11-24 13:09:47.91412	2024-11-24 13:09:47.91412	\N	-	start	Lead created by Naf	376	1
1191	2024-11-24 13:09:47.928215	2024-11-24 13:09:47.928215	\N	-	start	Lead created by Naf	379	1
1202	2024-11-24 13:09:47.940554	2024-11-24 13:09:47.940554	\N	-	start	Lead created by Naf	388	1
1216	2024-11-24 13:09:47.952229	2024-11-24 13:09:47.952229	\N	-	start	Lead created by Naf	417	1
1228	2024-11-24 13:09:47.966102	2024-11-24 13:09:47.966102	\N	-	start	Lead created by Naf	418	1
1244	2024-11-24 13:09:47.978367	2024-11-24 13:09:47.978367	\N	-	start	Lead created by Naf	436	1
1259	2024-11-24 13:09:47.998731	2024-11-24 13:09:47.998731	\N	-	start	Lead created by Naf	446	1
1269	2024-11-24 13:09:48.012001	2024-11-24 13:09:48.012001	\N	-	start	Lead created by Naf	461	1
1283	2024-11-24 13:09:48.021051	2024-11-24 13:09:48.021051	\N	-	start	Lead created by Naf	475	1
1298	2024-11-24 13:09:48.035441	2024-11-24 13:09:48.035441	\N	-	start	Lead created by Naf	494	1
1306	2024-11-24 13:09:48.046189	2024-11-24 13:09:48.046189	\N	-	start	Lead created by Naf	489	1
1316	2024-11-24 13:09:48.055729	2024-11-24 13:09:48.055729	\N	-	start	Lead created by Naf	511	1
1324	2024-11-24 13:09:48.065634	2024-11-24 13:09:48.065634	\N	-	start	Lead created by Naf	517	1
1332	2024-11-24 13:09:48.075977	2024-11-24 13:09:48.075977	\N	-	start	Lead created by Naf	528	1
1341	2024-11-24 13:09:48.083598	2024-11-24 13:09:48.083598	\N	-	start	Lead created by Naf	527	1
1354	2024-11-24 13:09:48.092454	2024-11-24 13:09:48.092454	\N	-	start	Lead created by Naf	533	1
1363	2024-11-24 13:09:48.102432	2024-11-24 13:09:48.102432	\N	-	start	Lead created by Naf	561	1
1372	2024-11-24 13:09:48.113681	2024-11-24 13:09:48.113681	\N	-	start	Lead created by Naf	569	1
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permission (id, name, created_at, updated_at, deleted_at, "roleId", "permissionModuleId") FROM stdin;
\.


--
-- Data for Name: status_change; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status_change (id, created_at, updated_at, deleted_at, "initialStatus", "finalStatus", branch_name, "leadId", "initiatorId") FROM stdin;
546	2024-11-24 06:08:38.776401	2024-11-24 06:08:38.776401	\N	waiting-for-document	course-new	Dhanmondi	337	14
550	2024-11-24 06:21:26.84312	2024-11-24 06:21:26.84312	\N	course-new	new	Dhanmondi	317	14
554	2024-11-24 13:09:48.117605	2024-11-24 13:09:48.117605	\N	-	new	Dhanmondi	359	1
558	2024-11-24 13:09:48.127501	2024-11-24 13:09:48.127501	\N	-	new	Dhanmondi	368	1
560	2024-11-24 13:09:48.129291	2024-11-24 13:09:48.129291	\N	-	new	Dhanmondi	373	1
564	2024-11-24 13:09:48.133965	2024-11-24 13:09:48.133965	\N	-	new	Dhanmondi	362	1
568	2024-11-24 13:09:48.137516	2024-11-24 13:09:48.137516	\N	-	new	Dhanmondi	360	1
570	2024-11-24 13:09:48.138404	2024-11-24 13:09:48.138404	\N	-	new	Dhanmondi	376	1
575	2024-11-24 13:09:48.144436	2024-11-24 13:09:48.144436	\N	-	new	Dhanmondi	377	1
576	2024-11-24 13:09:48.145094	2024-11-24 13:09:48.145094	\N	-	new	Dhanmondi	384	1
578	2024-11-24 13:09:48.149453	2024-11-24 13:09:48.149453	\N	-	new	Dhanmondi	369	1
584	2024-11-24 13:09:48.155846	2024-11-24 13:09:48.155846	\N	-	new	Dhanmondi	386	1
585	2024-11-24 13:09:48.156487	2024-11-24 13:09:48.156487	\N	-	new	Dhanmondi	390	1
587	2024-11-24 13:09:48.158329	2024-11-24 13:09:48.158329	\N	-	new	Dhanmondi	392	1
592	2024-11-24 13:09:48.162311	2024-11-24 13:09:48.162311	\N	-	new	Dhanmondi	395	1
593	2024-11-24 13:09:48.162802	2024-11-24 13:09:48.162802	\N	-	new	Dhanmondi	397	1
596	2024-11-24 13:09:48.164159	2024-11-24 13:09:48.164159	\N	-	new	Dhanmondi	388	1
601	2024-11-24 13:09:48.168532	2024-11-24 13:09:48.168532	\N	-	new	Dhanmondi	405	1
603	2024-11-24 13:09:48.170992	2024-11-24 13:09:48.170992	\N	-	new	Dhanmondi	402	1
608	2024-11-24 13:09:48.172662	2024-11-24 13:09:48.172662	\N	-	new	Dhanmondi	417	1
611	2024-11-24 13:09:48.173731	2024-11-24 13:09:48.173731	\N	-	new	Dhanmondi	413	1
613	2024-11-24 13:09:48.177572	2024-11-24 13:09:48.177572	\N	-	new	Dhanmondi	412	1
619	2024-11-24 13:09:48.181979	2024-11-24 13:09:48.181979	\N	-	new	Dhanmondi	424	1
621	2024-11-24 13:09:48.183388	2024-11-24 13:09:48.183388	\N	-	new	Dhanmondi	426	1
622	2024-11-24 13:09:48.18142	2024-11-24 13:09:48.18142	\N	-	new	Dhanmondi	419	1
629	2024-11-24 13:09:48.198096	2024-11-24 13:09:48.198096	\N	-	new	Dhanmondi	430	1
633	2024-11-24 13:09:48.200333	2024-11-24 13:09:48.200333	\N	-	new	Dhanmondi	435	1
636	2024-11-24 13:09:48.200605	2024-11-24 13:09:48.200605	\N	-	new	Dhanmondi	438	1
637	2024-11-24 13:09:48.203376	2024-11-24 13:09:48.203376	\N	-	new	Dhanmondi	445	1
643	2024-11-24 13:09:48.209641	2024-11-24 13:09:48.209641	\N	-	new	Dhanmondi	451	1
645	2024-11-24 13:09:48.210683	2024-11-24 13:09:48.210683	\N	-	new	Dhanmondi	449	1
646	2024-11-24 13:09:48.212354	2024-11-24 13:09:48.212354	\N	-	new	Dhanmondi	441	1
647	2024-11-24 13:09:48.210082	2024-11-24 13:09:48.210082	\N	-	new	Dhanmondi	448	1
651	2024-11-24 13:09:48.215932	2024-11-24 13:09:48.215932	\N	-	new	Dhanmondi	458	1
653	2024-11-24 13:09:48.217207	2024-11-24 13:09:48.217207	\N	-	new	Dhanmondi	454	1
659	2024-11-24 13:09:48.231403	2024-11-24 13:09:48.231403	\N	-	new	Dhanmondi	452	1
661	2024-11-24 13:09:48.227017	2024-11-24 13:09:48.227017	\N	-	new	Dhanmondi	459	1
662	2024-11-24 13:09:48.234045	2024-11-24 13:09:48.234045	\N	-	new	Dhanmondi	465	1
663	2024-11-24 13:09:48.232944	2024-11-24 13:09:48.232944	\N	-	new	Dhanmondi	463	1
669	2024-11-24 13:09:48.251319	2024-11-24 13:09:48.251319	\N	-	new	Dhanmondi	473	1
671	2024-11-24 13:09:48.253676	2024-11-24 13:09:48.253676	\N	-	new	Dhanmondi	477	1
672	2024-11-24 13:09:48.254765	2024-11-24 13:09:48.254765	\N	-	new	Dhanmondi	471	1
675	2024-11-24 13:09:48.257358	2024-11-24 13:09:48.257358	\N	-	new	Dhanmondi	481	1
677	2024-11-24 13:09:48.259309	2024-11-24 13:09:48.259309	\N	-	new	Dhanmondi	478	1
679	2024-11-24 13:09:48.261102	2024-11-24 13:09:48.261102	\N	-	new	Dhanmondi	479	1
683	2024-11-24 13:09:48.26402	2024-11-24 13:09:48.26402	\N	-	new	Dhanmondi	488	1
686	2024-11-24 13:09:48.266076	2024-11-24 13:09:48.266076	\N	-	new	Dhanmondi	494	1
688	2024-11-24 13:09:48.266537	2024-11-24 13:09:48.266537	\N	-	new	Dhanmondi	490	1
689	2024-11-24 13:09:48.268203	2024-11-24 13:09:48.268203	\N	-	new	Dhanmondi	486	1
692	2024-11-24 13:09:48.274211	2024-11-24 13:09:48.274211	\N	-	new	Dhanmondi	484	1
694	2024-11-24 13:09:48.277005	2024-11-24 13:09:48.277005	\N	-	new	Dhanmondi	499	1
696	2024-11-24 13:09:48.279054	2024-11-24 13:09:48.279054	\N	-	new	Dhanmondi	502	1
697	2024-11-24 13:09:48.280131	2024-11-24 13:09:48.280131	\N	-	new	Dhanmondi	503	1
703	2024-11-24 13:09:48.284663	2024-11-24 13:09:48.284663	\N	-	new	Dhanmondi	509	1
705	2024-11-24 13:09:48.286336	2024-11-24 13:09:48.286336	\N	-	new	Dhanmondi	498	1
706	2024-11-24 13:09:48.287788	2024-11-24 13:09:48.287788	\N	-	new	Dhanmondi	504	1
710	2024-11-24 13:09:48.290556	2024-11-24 13:09:48.290556	\N	-	new	Dhanmondi	507	1
711	2024-11-24 13:09:48.292951	2024-11-24 13:09:48.292951	\N	-	new	Dhanmondi	517	1
714	2024-11-24 13:09:48.295518	2024-11-24 13:09:48.295518	\N	-	new	Dhanmondi	523	1
717	2024-11-24 13:09:48.297522	2024-11-24 13:09:48.297522	\N	-	new	Dhanmondi	506	1
719	2024-11-24 13:09:48.303808	2024-11-24 13:09:48.303808	\N	-	new	Dhanmondi	518	1
720	2024-11-24 13:09:48.306994	2024-11-24 13:09:48.306994	\N	-	new	Dhanmondi	521	1
724	2024-11-24 13:09:48.310541	2024-11-24 13:09:48.310541	\N	-	new	Dhanmondi	520	1
726	2024-11-24 13:09:48.311736	2024-11-24 13:09:48.311736	\N	-	new	Dhanmondi	526	1
728	2024-11-24 13:09:48.313079	2024-11-24 13:09:48.313079	\N	-	new	Dhanmondi	534	1
729	2024-11-24 13:09:48.314733	2024-11-24 13:09:48.314733	\N	-	new	Dhanmondi	532	1
734	2024-11-24 13:09:48.316859	2024-11-24 13:09:48.316859	\N	-	new	Dhanmondi	542	1
736	2024-11-24 13:09:48.319441	2024-11-24 13:09:48.319441	\N	-	new	Dhanmondi	535	1
737	2024-11-24 13:09:48.320439	2024-11-24 13:09:48.320439	\N	-	new	Dhanmondi	543	1
741	2024-11-24 13:09:48.322414	2024-11-24 13:09:48.322414	\N	-	new	Dhanmondi	537	1
743	2024-11-24 13:09:48.321461	2024-11-24 13:09:48.321461	\N	-	new	Dhanmondi	547	1
745	2024-11-24 13:09:48.327284	2024-11-24 13:09:48.327284	\N	-	new	Dhanmondi	553	1
747	2024-11-24 13:09:48.330927	2024-11-24 13:09:48.330927	\N	-	new	Dhanmondi	554	1
751	2024-11-24 13:09:48.33496	2024-11-24 13:09:48.33496	\N	-	new	Dhanmondi	560	1
754	2024-11-24 13:09:48.342955	2024-11-24 13:09:48.342955	\N	-	new	Dhanmondi	555	1
755	2024-11-24 13:09:48.345043	2024-11-24 13:09:48.345043	\N	-	new	Dhanmondi	563	1
758	2024-11-24 13:09:48.346098	2024-11-24 13:09:48.346098	\N	-	new	Dhanmondi	558	1
760	2024-11-24 13:09:48.346939	2024-11-24 13:09:48.346939	\N	-	new	Dhanmondi	567	1
763	2024-11-24 13:09:48.349762	2024-11-24 13:09:48.349762	\N	-	new	Dhanmondi	571	1
764	2024-11-24 13:09:48.351115	2024-11-24 13:09:48.351115	\N	-	new	Dhanmondi	564	1
768	2024-11-24 13:09:48.354534	2024-11-24 13:09:48.354534	\N	-	new	Dhanmondi	568	1
547	2024-11-24 06:08:44.509639	2024-11-24 06:08:44.509639	\N	course-new	new	Dhanmondi	337	14
551	2024-11-24 06:28:35.540344	2024-11-24 06:28:35.540344	\N	new	unreachable	Dhanmondi	317	14
555	2024-11-24 13:09:48.11935	2024-11-24 13:09:48.11935	\N	-	new	Dhanmondi	358	1
559	2024-11-24 13:09:48.125997	2024-11-24 13:09:48.125997	\N	-	new	Dhanmondi	367	1
561	2024-11-24 13:09:48.131541	2024-11-24 13:09:48.131541	\N	-	new	Dhanmondi	366	1
565	2024-11-24 13:09:48.136097	2024-11-24 13:09:48.136097	\N	-	new	Dhanmondi	375	1
569	2024-11-24 13:09:48.137598	2024-11-24 13:09:48.137598	\N	-	new	Dhanmondi	374	1
573	2024-11-24 13:09:48.141739	2024-11-24 13:09:48.141739	\N	-	new	Dhanmondi	381	1
580	2024-11-24 13:09:48.151088	2024-11-24 13:09:48.151088	\N	-	new	Dhanmondi	371	1
581	2024-11-24 13:09:48.151128	2024-11-24 13:09:48.151128	\N	-	new	Dhanmondi	379	1
582	2024-11-24 13:09:48.151374	2024-11-24 13:09:48.151374	\N	-	new	Dhanmondi	389	1
590	2024-11-24 13:09:48.159597	2024-11-24 13:09:48.159597	\N	-	new	Dhanmondi	391	1
594	2024-11-24 13:09:48.163188	2024-11-24 13:09:48.163188	\N	-	new	Dhanmondi	404	1
595	2024-11-24 13:09:48.161659	2024-11-24 13:09:48.161659	\N	-	new	Dhanmondi	401	1
598	2024-11-24 13:09:48.1657	2024-11-24 13:09:48.1657	\N	-	new	Dhanmondi	396	1
604	2024-11-24 13:09:48.171067	2024-11-24 13:09:48.171067	\N	-	new	Dhanmondi	406	1
605	2024-11-24 13:09:48.171246	2024-11-24 13:09:48.171246	\N	-	new	Dhanmondi	407	1
609	2024-11-24 13:09:48.172825	2024-11-24 13:09:48.172825	\N	-	new	Dhanmondi	409	1
614	2024-11-24 13:09:48.178125	2024-11-24 13:09:48.178125	\N	-	new	Dhanmondi	411	1
615	2024-11-24 13:09:48.179273	2024-11-24 13:09:48.179273	\N	-	new	Dhanmondi	421	1
620	2024-11-24 13:09:48.183196	2024-11-24 13:09:48.183196	\N	-	new	Dhanmondi	420	1
623	2024-11-24 13:09:48.183691	2024-11-24 13:09:48.183691	\N	-	new	Dhanmondi	433	1
624	2024-11-24 13:09:48.184357	2024-11-24 13:09:48.184357	\N	-	new	Dhanmondi	434	1
630	2024-11-24 13:09:48.199053	2024-11-24 13:09:48.199053	\N	-	new	Dhanmondi	428	1
631	2024-11-24 13:09:48.199717	2024-11-24 13:09:48.199717	\N	-	new	Dhanmondi	425	1
632	2024-11-24 13:09:48.200081	2024-11-24 13:09:48.200081	\N	-	new	Dhanmondi	437	1
639	2024-11-24 13:09:48.206078	2024-11-24 13:09:48.206078	\N	-	new	Dhanmondi	436	1
640	2024-11-24 13:09:48.207116	2024-11-24 13:09:48.207116	\N	-	new	Dhanmondi	444	1
641	2024-11-24 13:09:48.207454	2024-11-24 13:09:48.207454	\N	-	new	Dhanmondi	443	1
648	2024-11-24 13:09:48.212541	2024-11-24 13:09:48.212541	\N	-	new	Dhanmondi	447	1
649	2024-11-24 13:09:48.213181	2024-11-24 13:09:48.213181	\N	-	new	Dhanmondi	446	1
654	2024-11-24 13:09:48.218825	2024-11-24 13:09:48.218825	\N	-	new	Dhanmondi	460	1
656	2024-11-24 13:09:48.219393	2024-11-24 13:09:48.219393	\N	-	new	Dhanmondi	462	1
657	2024-11-24 13:09:48.221366	2024-11-24 13:09:48.221366	\N	-	new	Dhanmondi	464	1
664	2024-11-24 13:09:48.242639	2024-11-24 13:09:48.242639	\N	-	new	Dhanmondi	468	1
665	2024-11-24 13:09:48.246559	2024-11-24 13:09:48.246559	\N	-	new	Dhanmondi	457	1
666	2024-11-24 13:09:48.248601	2024-11-24 13:09:48.248601	\N	-	new	Dhanmondi	466	1
673	2024-11-24 13:09:48.25514	2024-11-24 13:09:48.25514	\N	-	new	Dhanmondi	482	1
674	2024-11-24 13:09:48.25593	2024-11-24 13:09:48.25593	\N	-	new	Dhanmondi	474	1
680	2024-11-24 13:09:48.260263	2024-11-24 13:09:48.260263	\N	-	new	Dhanmondi	475	1
681	2024-11-24 13:09:48.26243	2024-11-24 13:09:48.26243	\N	-	new	Dhanmondi	483	1
682	2024-11-24 13:09:48.263296	2024-11-24 13:09:48.263296	\N	-	new	Dhanmondi	487	1
690	2024-11-24 13:09:48.271776	2024-11-24 13:09:48.271776	\N	-	new	Dhanmondi	491	1
691	2024-11-24 13:09:48.273013	2024-11-24 13:09:48.273013	\N	-	new	Dhanmondi	496	1
698	2024-11-24 13:09:48.27779	2024-11-24 13:09:48.27779	\N	-	new	Dhanmondi	489	1
699	2024-11-24 13:09:48.280498	2024-11-24 13:09:48.280498	\N	-	new	Dhanmondi	500	1
700	2024-11-24 13:09:48.281405	2024-11-24 13:09:48.281405	\N	-	new	Dhanmondi	497	1
707	2024-11-24 13:09:48.288033	2024-11-24 13:09:48.288033	\N	-	new	Dhanmondi	512	1
708	2024-11-24 13:09:48.288971	2024-11-24 13:09:48.288971	\N	-	new	Dhanmondi	510	1
715	2024-11-24 13:09:48.291977	2024-11-24 13:09:48.291977	\N	-	new	Dhanmondi	513	1
716	2024-11-24 13:09:48.295769	2024-11-24 13:09:48.295769	\N	-	new	Dhanmondi	519	1
722	2024-11-24 13:09:48.30903	2024-11-24 13:09:48.30903	\N	-	new	Dhanmondi	528	1
723	2024-11-24 13:09:48.30927	2024-11-24 13:09:48.30927	\N	-	new	Dhanmondi	524	1
731	2024-11-24 13:09:48.315737	2024-11-24 13:09:48.315737	\N	-	new	Dhanmondi	536	1
732	2024-11-24 13:09:48.314089	2024-11-24 13:09:48.314089	\N	-	new	Dhanmondi	531	1
733	2024-11-24 13:09:48.316216	2024-11-24 13:09:48.316216	\N	-	new	Dhanmondi	538	1
740	2024-11-24 13:09:48.321587	2024-11-24 13:09:48.321587	\N	-	new	Dhanmondi	544	1
742	2024-11-24 13:09:48.324526	2024-11-24 13:09:48.324526	\N	-	new	Dhanmondi	549	1
746	2024-11-24 13:09:48.328404	2024-11-24 13:09:48.328404	\N	-	new	Dhanmondi	550	1
750	2024-11-24 13:09:48.333433	2024-11-24 13:09:48.333433	\N	-	new	Dhanmondi	551	1
752	2024-11-24 13:09:48.340275	2024-11-24 13:09:48.340275	\N	-	new	Dhanmondi	561	1
759	2024-11-24 13:09:48.346254	2024-11-24 13:09:48.346254	\N	-	new	Dhanmondi	559	1
761	2024-11-24 13:09:48.348443	2024-11-24 13:09:48.348443	\N	-	new	Dhanmondi	570	1
767	2024-11-24 13:09:48.352286	2024-11-24 13:09:48.352286	\N	-	new	Dhanmondi	566	1
548	2024-11-24 06:11:40.761479	2024-11-24 06:11:40.761479	\N	new	unreachable	Dhanmondi	337	14
552	2024-11-24 12:45:42.862915	2024-11-24 12:45:42.862915	\N	unreachable	course-new	Dhanmondi	340	14
556	2024-11-24 13:09:48.126655	2024-11-24 13:09:48.126655	\N	-	new	Dhanmondi	356	1
562	2024-11-24 13:09:48.130176	2024-11-24 13:09:48.130176	\N	-	new	Dhanmondi	372	1
566	2024-11-24 13:09:48.135363	2024-11-24 13:09:48.135363	\N	-	new	Dhanmondi	365	1
571	2024-11-24 13:09:48.138234	2024-11-24 13:09:48.138234	\N	-	new	Dhanmondi	363	1
574	2024-11-24 13:09:48.141941	2024-11-24 13:09:48.141941	\N	-	new	Dhanmondi	370	1
579	2024-11-24 13:09:48.149934	2024-11-24 13:09:48.149934	\N	-	new	Dhanmondi	383	1
583	2024-11-24 13:09:48.151526	2024-11-24 13:09:48.151526	\N	-	new	Dhanmondi	385	1
588	2024-11-24 13:09:48.158858	2024-11-24 13:09:48.158858	\N	-	new	Dhanmondi	398	1
591	2024-11-24 13:09:48.159794	2024-11-24 13:09:48.159794	\N	-	new	Dhanmondi	400	1
597	2024-11-24 13:09:48.164321	2024-11-24 13:09:48.164321	\N	-	new	Dhanmondi	393	1
599	2024-11-24 13:09:48.165918	2024-11-24 13:09:48.165918	\N	-	new	Dhanmondi	408	1
606	2024-11-24 13:09:48.171408	2024-11-24 13:09:48.171408	\N	-	new	Dhanmondi	410	1
610	2024-11-24 13:09:48.173039	2024-11-24 13:09:48.173039	\N	-	new	Dhanmondi	403	1
617	2024-11-24 13:09:48.181071	2024-11-24 13:09:48.181071	\N	-	new	Dhanmondi	422	1
625	2024-11-24 13:09:48.183537	2024-11-24 13:09:48.183537	\N	-	new	Dhanmondi	418	1
205	2024-09-14 18:37:46.299698	2024-09-14 18:37:46.299698	\N	-	new	Dhanmondi	189	1
206	2024-09-14 18:37:46.309984	2024-09-14 18:37:46.309984	\N	-	new	Dhanmondi	190	1
207	2024-09-14 18:37:46.3199	2024-09-14 18:37:46.3199	\N	-	new	Dhanmondi	191	1
208	2024-09-14 18:37:46.328326	2024-09-14 18:37:46.328326	\N	-	new	Dhanmondi	192	1
209	2024-09-14 18:37:46.336921	2024-09-14 18:37:46.336921	\N	-	new	Dhanmondi	193	1
210	2024-09-14 18:37:46.344096	2024-09-14 18:37:46.344096	\N	-	new	Dhanmondi	194	1
211	2024-09-14 18:37:46.351625	2024-09-14 18:37:46.351625	\N	-	new	Dhanmondi	195	1
212	2024-09-14 18:37:46.358587	2024-09-14 18:37:46.358587	\N	-	new	Dhanmondi	196	1
213	2024-09-14 18:37:46.366639	2024-09-14 18:37:46.366639	\N	-	new	Dhanmondi	197	1
214	2024-09-14 18:37:46.374074	2024-09-14 18:37:46.374074	\N	-	new	Dhanmondi	198	1
215	2024-09-14 18:37:46.381461	2024-09-14 18:37:46.381461	\N	-	new	Dhanmondi	199	1
216	2024-09-14 18:37:46.389681	2024-09-14 18:37:46.389681	\N	-	new	Dhanmondi	200	1
217	2024-09-14 18:37:46.397458	2024-09-14 18:37:46.397458	\N	-	new	Dhanmondi	201	1
218	2024-09-14 18:37:46.404542	2024-09-14 18:37:46.404542	\N	-	new	Dhanmondi	202	1
219	2024-09-14 18:37:46.412803	2024-09-14 18:37:46.412803	\N	-	new	Dhanmondi	203	1
220	2024-09-14 18:37:46.421915	2024-09-14 18:37:46.421915	\N	-	new	Dhanmondi	204	1
221	2024-09-14 18:37:46.437353	2024-09-14 18:37:46.437353	\N	-	new	Dhanmondi	205	1
222	2024-09-14 18:37:46.449436	2024-09-14 18:37:46.449436	\N	-	new	Dhanmondi	206	1
223	2024-09-14 18:37:46.467625	2024-09-14 18:37:46.467625	\N	-	new	Dhanmondi	207	1
224	2024-09-14 18:37:46.475314	2024-09-14 18:37:46.475314	\N	-	new	Dhanmondi	208	1
225	2024-09-14 18:37:46.4841	2024-09-14 18:37:46.4841	\N	-	new	Dhanmondi	209	1
226	2024-09-14 18:37:46.491562	2024-09-14 18:37:46.491562	\N	-	new	Dhanmondi	210	1
227	2024-09-14 18:37:46.498995	2024-09-14 18:37:46.498995	\N	-	new	Dhanmondi	211	1
228	2024-09-14 18:37:46.507511	2024-09-14 18:37:46.507511	\N	-	new	Dhanmondi	212	1
229	2024-09-14 18:37:46.515228	2024-09-14 18:37:46.515228	\N	-	new	Dhanmondi	213	1
230	2024-09-14 18:37:46.523007	2024-09-14 18:37:46.523007	\N	-	new	Dhanmondi	214	1
231	2024-09-14 18:37:46.530089	2024-09-14 18:37:46.530089	\N	-	new	Dhanmondi	215	1
232	2024-09-14 18:37:46.536836	2024-09-14 18:37:46.536836	\N	-	new	Dhanmondi	216	1
233	2024-09-14 18:37:46.544666	2024-09-14 18:37:46.544666	\N	-	new	Dhanmondi	217	1
234	2024-09-14 18:37:46.552233	2024-09-14 18:37:46.552233	\N	-	new	Dhanmondi	218	1
235	2024-09-14 18:37:46.560014	2024-09-14 18:37:46.560014	\N	-	new	Dhanmondi	219	1
236	2024-09-14 18:37:46.566896	2024-09-14 18:37:46.566896	\N	-	new	Dhanmondi	220	1
237	2024-09-14 18:37:46.575977	2024-09-14 18:37:46.575977	\N	-	new	Dhanmondi	221	1
238	2024-09-14 18:37:46.584258	2024-09-14 18:37:46.584258	\N	-	new	Dhanmondi	222	1
239	2024-09-14 18:37:46.591533	2024-09-14 18:37:46.591533	\N	-	new	Dhanmondi	223	1
240	2024-09-14 18:37:46.601111	2024-09-14 18:37:46.601111	\N	-	new	Dhanmondi	224	1
241	2024-09-14 18:37:46.610449	2024-09-14 18:37:46.610449	\N	-	new	Dhanmondi	225	1
242	2024-09-14 18:37:46.619155	2024-09-14 18:37:46.619155	\N	-	new	Dhanmondi	226	1
243	2024-09-14 18:37:46.629598	2024-09-14 18:37:46.629598	\N	-	new	Dhanmondi	227	1
244	2024-09-14 18:37:46.637689	2024-09-14 18:37:46.637689	\N	-	new	Dhanmondi	228	1
245	2024-09-14 18:37:46.645142	2024-09-14 18:37:46.645142	\N	-	new	Dhanmondi	229	1
246	2024-09-14 18:37:46.654341	2024-09-14 18:37:46.654341	\N	-	new	Dhanmondi	230	1
247	2024-09-14 18:37:46.665363	2024-09-14 18:37:46.665363	\N	-	new	Dhanmondi	231	1
248	2024-09-14 18:37:46.674447	2024-09-14 18:37:46.674447	\N	-	new	Dhanmondi	232	1
249	2024-09-14 18:37:46.68465	2024-09-14 18:37:46.68465	\N	-	new	Dhanmondi	233	1
250	2024-09-14 18:37:46.692157	2024-09-14 18:37:46.692157	\N	-	new	Dhanmondi	234	1
251	2024-09-14 18:37:46.700844	2024-09-14 18:37:46.700844	\N	-	new	Dhanmondi	235	1
252	2024-09-14 18:37:46.709179	2024-09-14 18:37:46.709179	\N	-	new	Dhanmondi	236	1
253	2024-09-14 18:37:46.717019	2024-09-14 18:37:46.717019	\N	-	new	Dhanmondi	237	1
254	2024-09-14 18:37:46.725139	2024-09-14 18:37:46.725139	\N	-	new	Dhanmondi	238	1
255	2024-09-14 18:37:46.734752	2024-09-14 18:37:46.734752	\N	-	new	Dhanmondi	239	1
256	2024-09-14 18:37:46.742611	2024-09-14 18:37:46.742611	\N	-	new	Dhanmondi	240	1
257	2024-09-14 18:37:46.750387	2024-09-14 18:37:46.750387	\N	-	new	Dhanmondi	241	1
258	2024-09-14 18:37:46.757865	2024-09-14 18:37:46.757865	\N	-	new	Dhanmondi	242	1
259	2024-09-14 18:37:46.764864	2024-09-14 18:37:46.764864	\N	-	new	Dhanmondi	243	1
260	2024-09-14 18:37:46.771216	2024-09-14 18:37:46.771216	\N	-	new	Dhanmondi	244	1
261	2024-09-14 18:37:46.778013	2024-09-14 18:37:46.778013	\N	-	new	Dhanmondi	245	1
262	2024-09-14 18:37:46.785064	2024-09-14 18:37:46.785064	\N	-	new	Dhanmondi	246	1
263	2024-09-14 18:37:46.794121	2024-09-14 18:37:46.794121	\N	-	new	Dhanmondi	247	1
264	2024-09-14 18:37:46.802428	2024-09-14 18:37:46.802428	\N	-	new	Dhanmondi	248	1
265	2024-09-14 18:37:46.809032	2024-09-14 18:37:46.809032	\N	-	new	Dhanmondi	249	1
266	2024-09-14 18:37:46.81576	2024-09-14 18:37:46.81576	\N	-	new	Dhanmondi	250	1
267	2024-09-14 18:37:46.822869	2024-09-14 18:37:46.822869	\N	-	new	Dhanmondi	251	1
268	2024-09-14 18:37:46.829433	2024-09-14 18:37:46.829433	\N	-	new	Dhanmondi	252	1
269	2024-09-14 18:37:46.836233	2024-09-14 18:37:46.836233	\N	-	new	Dhanmondi	253	1
270	2024-09-14 18:37:46.844107	2024-09-14 18:37:46.844107	\N	-	new	Dhanmondi	254	1
271	2024-09-14 18:37:46.85084	2024-09-14 18:37:46.85084	\N	-	new	Dhanmondi	255	1
272	2024-09-14 18:37:46.85779	2024-09-14 18:37:46.85779	\N	-	new	Dhanmondi	256	1
273	2024-09-14 18:37:46.865195	2024-09-14 18:37:46.865195	\N	-	new	Dhanmondi	257	1
274	2024-09-14 18:37:46.872559	2024-09-14 18:37:46.872559	\N	-	new	Dhanmondi	258	1
275	2024-09-14 18:37:46.881125	2024-09-14 18:37:46.881125	\N	-	new	Dhanmondi	259	1
276	2024-09-14 18:37:46.890144	2024-09-14 18:37:46.890144	\N	-	new	Dhanmondi	260	1
277	2024-09-14 18:37:46.897996	2024-09-14 18:37:46.897996	\N	-	new	Dhanmondi	261	1
278	2024-09-14 18:37:46.907549	2024-09-14 18:37:46.907549	\N	-	new	Dhanmondi	262	1
279	2024-09-14 18:37:46.915698	2024-09-14 18:37:46.915698	\N	-	new	Dhanmondi	263	1
280	2024-09-14 18:37:46.927823	2024-09-14 18:37:46.927823	\N	-	new	Dhanmondi	264	1
281	2024-09-14 18:37:46.938227	2024-09-14 18:37:46.938227	\N	-	new	Dhanmondi	265	1
627	2024-11-24 13:09:48.196325	2024-11-24 13:09:48.196325	\N	-	new	Dhanmondi	432	1
635	2024-11-24 13:09:48.201732	2024-11-24 13:09:48.201732	\N	-	new	Dhanmondi	440	1
282	2024-09-14 18:37:46.946533	2024-09-14 18:37:46.946533	\N	-	new	Dhanmondi	266	1
283	2024-09-14 18:37:46.955779	2024-09-14 18:37:46.955779	\N	-	new	Dhanmondi	267	1
284	2024-09-14 18:37:46.963406	2024-09-14 18:37:46.963406	\N	-	new	Dhanmondi	268	1
285	2024-09-14 18:37:46.972525	2024-09-14 18:37:46.972525	\N	-	new	Dhanmondi	269	1
286	2024-09-14 18:37:46.982411	2024-09-14 18:37:46.982411	\N	-	new	Dhanmondi	270	1
287	2024-09-14 18:37:46.990743	2024-09-14 18:37:46.990743	\N	-	new	Dhanmondi	271	1
288	2024-09-14 18:37:46.998045	2024-09-14 18:37:46.998045	\N	-	new	Dhanmondi	272	1
289	2024-09-14 18:37:47.008374	2024-09-14 18:37:47.008374	\N	-	new	Dhanmondi	273	1
290	2024-09-14 18:37:47.017402	2024-09-14 18:37:47.017402	\N	-	new	Dhanmondi	274	1
291	2024-09-14 18:37:47.026067	2024-09-14 18:37:47.026067	\N	-	new	Dhanmondi	275	1
292	2024-09-14 18:37:47.034225	2024-09-14 18:37:47.034225	\N	-	new	Dhanmondi	276	1
293	2024-09-14 18:37:47.04341	2024-09-14 18:37:47.04341	\N	-	new	Dhanmondi	277	1
294	2024-09-14 18:37:47.052289	2024-09-14 18:37:47.052289	\N	-	new	Dhanmondi	278	1
295	2024-09-14 18:37:47.06033	2024-09-14 18:37:47.06033	\N	-	new	Dhanmondi	279	1
296	2024-09-14 18:37:47.069391	2024-09-14 18:37:47.069391	\N	-	new	Dhanmondi	280	1
297	2024-09-14 18:37:47.076791	2024-09-14 18:37:47.076791	\N	-	new	Dhanmondi	281	1
298	2024-09-14 18:37:47.085022	2024-09-14 18:37:47.085022	\N	-	new	Dhanmondi	282	1
299	2024-09-14 18:37:47.09313	2024-09-14 18:37:47.09313	\N	-	new	Dhanmondi	283	1
300	2024-09-14 18:37:47.100793	2024-09-14 18:37:47.100793	\N	-	new	Dhanmondi	284	1
301	2024-09-14 18:37:47.10761	2024-09-14 18:37:47.10761	\N	-	new	Dhanmondi	285	1
302	2024-09-14 18:37:47.114624	2024-09-14 18:37:47.114624	\N	-	new	Dhanmondi	286	1
303	2024-09-14 18:37:47.120959	2024-09-14 18:37:47.120959	\N	-	new	Dhanmondi	287	1
304	2024-09-14 18:37:47.128062	2024-09-14 18:37:47.128062	\N	-	new	Dhanmondi	288	1
305	2024-09-14 18:37:47.138768	2024-09-14 18:37:47.138768	\N	-	new	Dhanmondi	289	1
306	2024-09-14 18:37:47.150321	2024-09-14 18:37:47.150321	\N	-	new	Dhanmondi	290	1
307	2024-09-14 18:37:47.15982	2024-09-14 18:37:47.15982	\N	-	new	Dhanmondi	291	1
308	2024-09-14 18:37:47.169062	2024-09-14 18:37:47.169062	\N	-	new	Dhanmondi	292	1
309	2024-09-14 18:37:47.176372	2024-09-14 18:37:47.176372	\N	-	new	Dhanmondi	293	1
310	2024-09-14 18:37:47.185175	2024-09-14 18:37:47.185175	\N	-	new	Dhanmondi	294	1
311	2024-09-14 18:37:47.193166	2024-09-14 18:37:47.193166	\N	-	new	Dhanmondi	295	1
312	2024-09-14 18:37:47.201082	2024-09-14 18:37:47.201082	\N	-	new	Dhanmondi	296	1
313	2024-09-14 18:37:47.20882	2024-09-14 18:37:47.20882	\N	-	new	Dhanmondi	297	1
314	2024-09-14 18:37:47.216005	2024-09-14 18:37:47.216005	\N	-	new	Dhanmondi	298	1
315	2024-09-14 18:37:47.224082	2024-09-14 18:37:47.224082	\N	-	new	Dhanmondi	299	1
316	2024-09-14 18:37:47.232935	2024-09-14 18:37:47.232935	\N	-	new	Dhanmondi	300	1
317	2024-09-14 18:37:47.243249	2024-09-14 18:37:47.243249	\N	-	new	Dhanmondi	301	1
318	2024-09-14 18:37:47.252426	2024-09-14 18:37:47.252426	\N	-	new	Dhanmondi	302	1
319	2024-09-14 18:37:47.259686	2024-09-14 18:37:47.259686	\N	-	new	Dhanmondi	303	1
320	2024-09-14 18:37:47.267093	2024-09-14 18:37:47.267093	\N	-	new	Dhanmondi	304	1
321	2024-09-14 18:37:47.275123	2024-09-14 18:37:47.275123	\N	-	new	Dhanmondi	305	1
322	2024-09-14 18:37:47.282666	2024-09-14 18:37:47.282666	\N	-	new	Dhanmondi	306	1
323	2024-09-14 18:37:47.291517	2024-09-14 18:37:47.291517	\N	-	new	Dhanmondi	307	1
324	2024-09-14 18:37:47.298209	2024-09-14 18:37:47.298209	\N	-	new	Dhanmondi	308	1
325	2024-09-14 18:37:47.304876	2024-09-14 18:37:47.304876	\N	-	new	Dhanmondi	309	1
326	2024-09-14 18:37:47.313524	2024-09-14 18:37:47.313524	\N	-	new	Dhanmondi	310	1
327	2024-09-14 18:37:47.321635	2024-09-14 18:37:47.321635	\N	-	new	Dhanmondi	311	1
328	2024-09-14 18:37:47.332511	2024-09-14 18:37:47.332511	\N	-	new	Dhanmondi	312	1
329	2024-09-14 18:37:47.341074	2024-09-14 18:37:47.341074	\N	-	new	Dhanmondi	313	1
330	2024-09-14 18:37:47.352761	2024-09-14 18:37:47.352761	\N	-	new	Dhanmondi	314	1
331	2024-09-14 18:37:47.360927	2024-09-14 18:37:47.360927	\N	-	new	Dhanmondi	315	1
332	2024-09-14 18:37:47.367859	2024-09-14 18:37:47.367859	\N	-	new	Dhanmondi	316	1
333	2024-09-14 18:37:47.375919	2024-09-14 18:37:47.375919	\N	-	new	Dhanmondi	317	1
334	2024-09-14 18:37:47.384074	2024-09-14 18:37:47.384074	\N	-	new	Dhanmondi	318	1
335	2024-09-14 18:37:47.393828	2024-09-14 18:37:47.393828	\N	-	new	Dhanmondi	319	1
336	2024-09-14 18:37:47.400813	2024-09-14 18:37:47.400813	\N	-	new	Dhanmondi	320	1
337	2024-09-14 18:37:47.408468	2024-09-14 18:37:47.408468	\N	-	new	Dhanmondi	321	1
338	2024-09-14 18:37:47.415113	2024-09-14 18:37:47.415113	\N	-	new	Dhanmondi	322	1
339	2024-09-14 18:37:47.422574	2024-09-14 18:37:47.422574	\N	-	new	Dhanmondi	323	1
340	2024-09-14 18:37:47.429887	2024-09-14 18:37:47.429887	\N	-	new	Dhanmondi	324	1
341	2024-09-14 18:37:47.437822	2024-09-14 18:37:47.437822	\N	-	new	Dhanmondi	325	1
342	2024-09-14 18:37:47.446515	2024-09-14 18:37:47.446515	\N	-	new	Dhanmondi	326	1
343	2024-09-14 18:37:47.453771	2024-09-14 18:37:47.453771	\N	-	new	Dhanmondi	327	1
344	2024-09-14 18:37:47.460474	2024-09-14 18:37:47.460474	\N	-	new	Dhanmondi	328	1
345	2024-09-14 18:37:47.467486	2024-09-14 18:37:47.467486	\N	-	new	Dhanmondi	329	1
346	2024-09-14 18:37:47.475089	2024-09-14 18:37:47.475089	\N	-	new	Dhanmondi	330	1
347	2024-09-14 18:37:47.48228	2024-09-14 18:37:47.48228	\N	-	new	Dhanmondi	331	1
348	2024-09-14 18:37:47.489318	2024-09-14 18:37:47.489318	\N	-	new	Dhanmondi	332	1
349	2024-09-14 18:37:47.496308	2024-09-14 18:37:47.496308	\N	-	new	Dhanmondi	333	1
350	2024-09-14 18:37:47.503462	2024-09-14 18:37:47.503462	\N	-	new	Dhanmondi	334	1
351	2024-09-14 18:37:47.511034	2024-09-14 18:37:47.511034	\N	-	new	Dhanmondi	335	1
352	2024-09-14 18:37:47.517535	2024-09-14 18:37:47.517535	\N	-	new	Dhanmondi	336	1
353	2024-09-14 18:37:47.524516	2024-09-14 18:37:47.524516	\N	-	new	Dhanmondi	337	1
354	2024-09-14 18:37:47.532973	2024-09-14 18:37:47.532973	\N	-	new	Dhanmondi	338	1
355	2024-09-14 18:37:47.542976	2024-09-14 18:37:47.542976	\N	-	new	Dhanmondi	339	1
356	2024-09-14 18:37:47.552283	2024-09-14 18:37:47.552283	\N	-	new	Dhanmondi	340	1
357	2024-09-16 15:24:09.039382	2024-09-16 15:24:09.039382	\N	-	new	Dhanmondi	341	1
358	2024-09-16 15:31:24.683652	2024-09-16 15:31:24.683652	\N	new	appointment-book	Dhanmondi	341	1
359	2024-09-16 15:31:40.071173	2024-09-16 15:31:40.071173	\N	appointment-book	waiting-for-document	Dhanmondi	341	1
360	2024-09-18 06:38:50.048839	2024-09-18 06:38:50.048839	\N	new	appointment-book	Dhanmondi	339	1
361	2024-09-18 06:39:30.498295	2024-09-18 06:39:30.498295	\N	appointment-book	postponed	Dhanmondi	339	1
362	2024-09-18 07:51:04.168233	2024-09-18 07:51:04.168233	\N	new	unreachable	Dhanmondi	340	14
363	2024-09-21 06:38:15.596523	2024-09-21 06:38:15.596523	\N	new	unreachable	Dhanmondi	338	14
364	2024-09-21 06:42:09.455635	2024-09-21 06:42:09.455635	\N	new	not-interested	Dhanmondi	337	14
365	2024-09-21 06:52:13.057004	2024-09-21 06:52:13.057004	\N	new	appointment-book	Dhanmondi	317	14
366	2024-09-21 06:55:22.884987	2024-09-21 06:55:22.884987	\N	new	not-interested	Dhanmondi	314	14
367	2024-09-21 07:04:02.453513	2024-09-21 07:04:02.453513	\N	new	unreachable	Dhanmondi	336	14
368	2024-09-21 07:07:31.581137	2024-09-21 07:07:31.581137	\N	new	unreachable	Dhanmondi	335	14
369	2024-09-21 07:08:51.807615	2024-09-21 07:08:51.807615	\N	new	not-interested	Dhanmondi	334	14
370	2024-09-21 07:09:21.727377	2024-09-21 07:09:21.727377	\N	new	not-interested	Dhanmondi	332	14
371	2024-09-21 07:11:37.165673	2024-09-21 07:11:37.165673	\N	new	unreachable	Dhanmondi	331	14
372	2024-09-21 07:13:05.29873	2024-09-21 07:13:05.29873	\N	new	unreachable	Dhanmondi	330	14
373	2024-09-21 07:14:17.489551	2024-09-21 07:14:17.489551	\N	new	not-interested	Dhanmondi	329	14
374	2024-09-21 07:15:17.150583	2024-09-21 07:15:17.150583	\N	new	appointment-book	Dhanmondi	328	14
375	2024-09-21 08:12:17.899832	2024-09-21 08:12:17.899832	\N	new	not-interested	Dhanmondi	327	14
376	2024-09-21 08:19:06.890673	2024-09-21 08:19:06.890673	\N	new	unreachable	Dhanmondi	326	14
377	2024-09-21 08:28:47.082876	2024-09-21 08:28:47.082876	\N	new	not-interested	Dhanmondi	325	14
378	2024-09-21 08:31:36.045409	2024-09-21 08:31:36.045409	\N	new	future-interest	Dhanmondi	324	14
379	2024-09-21 08:33:46.611352	2024-09-21 08:33:46.611352	\N	new	future-interest	Dhanmondi	323	14
380	2024-09-21 08:41:32.006579	2024-09-21 08:41:32.006579	\N	new	first	Dhanmondi	322	14
381	2024-09-21 08:43:42.474749	2024-09-21 08:43:42.474749	\N	new	not-interested	Dhanmondi	320	14
382	2024-09-21 08:46:22.530679	2024-09-21 08:46:22.530679	\N	new	not-interested	Dhanmondi	321	14
383	2024-09-21 08:47:17.433645	2024-09-21 08:47:17.433645	\N	new	unreachable	Dhanmondi	318	14
384	2024-09-21 09:07:41.78405	2024-09-21 09:07:41.78405	\N	new	not-interested	Dhanmondi	319	14
385	2024-09-21 09:09:58.689531	2024-09-21 09:09:58.689531	\N	new	future-interest	Dhanmondi	316	14
386	2024-09-21 09:10:44.748588	2024-09-21 09:10:44.748588	\N	new	not-interested	Dhanmondi	315	14
387	2024-09-21 09:11:40.819122	2024-09-21 09:11:40.819122	\N	new	unreachable	Dhanmondi	313	14
388	2024-09-21 10:43:04.719257	2024-09-21 10:43:04.719257	\N	new	not-interested	Dhanmondi	290	14
389	2024-09-21 11:22:27.541415	2024-09-21 11:22:27.541415	\N	new	first	Dhanmondi	289	14
390	2024-09-21 13:33:14.004593	2024-09-21 13:33:14.004593	\N	new	first	Dhanmondi	288	14
391	2024-09-21 13:34:14.165431	2024-09-21 13:34:14.165431	\N	new	not-interested	Dhanmondi	287	14
392	2024-09-21 13:36:30.471778	2024-09-21 13:36:30.471778	\N	new	unreachable	Dhanmondi	286	14
393	2024-09-21 13:39:11.629826	2024-09-21 13:39:11.629826	\N	new	first	Dhanmondi	285	14
394	2024-09-21 13:42:12.341325	2024-09-21 13:42:12.341325	\N	new	unreachable	Dhanmondi	283	14
395	2024-09-21 13:45:27.986301	2024-09-21 13:45:27.986301	\N	new	not-interested	Dhanmondi	284	14
396	2024-09-21 13:47:59.797661	2024-09-21 13:47:59.797661	\N	new	future-interest	Dhanmondi	282	14
397	2024-09-21 13:50:09.632552	2024-09-21 13:50:09.632552	\N	new	unreachable	Dhanmondi	281	14
398	2024-09-21 13:51:12.52229	2024-09-21 13:51:12.52229	\N	new	unreachable	Dhanmondi	280	14
399	2024-09-21 15:48:28.979113	2024-09-21 15:48:28.979113	\N	new	future-interest	Dhanmondi	279	14
400	2024-09-21 15:49:47.578572	2024-09-21 15:49:47.578572	\N	new	unreachable	Dhanmondi	278	14
401	2024-09-21 15:51:04.716007	2024-09-21 15:51:04.716007	\N	new	first	Dhanmondi	277	14
402	2024-09-21 15:55:10.077976	2024-09-21 15:55:10.077976	\N	new	not-interested	Dhanmondi	276	14
403	2024-09-21 15:55:59.188047	2024-09-21 15:55:59.188047	\N	new	first	Dhanmondi	275	14
404	2024-09-21 15:56:58.097207	2024-09-21 15:56:58.097207	\N	new	not-interested	Dhanmondi	274	14
405	2024-09-21 15:57:13.092721	2024-09-21 15:57:13.092721	\N	new	not-interested	Dhanmondi	273	14
406	2024-09-21 15:57:51.834354	2024-09-21 15:57:51.834354	\N	new	unreachable	Dhanmondi	272	14
407	2024-09-21 15:58:10.894172	2024-09-21 15:58:10.894172	\N	new	unreachable	Dhanmondi	271	14
408	2024-09-21 15:58:42.725582	2024-09-21 15:58:42.725582	\N	new	not-interested	Dhanmondi	270	14
409	2024-09-21 15:59:33.69089	2024-09-21 15:59:33.69089	\N	new	not-interested	Dhanmondi	248	14
410	2024-09-21 15:59:43.368875	2024-09-21 15:59:43.368875	\N	new	not-interested	Dhanmondi	247	14
411	2024-09-21 15:59:52.6178	2024-09-21 15:59:52.6178	\N	new	not-interested	Dhanmondi	246	14
412	2024-09-21 16:00:02.573527	2024-09-21 16:00:02.573527	\N	new	not-interested	Dhanmondi	245	14
413	2024-09-21 16:00:20.982587	2024-09-21 16:00:20.982587	\N	new	first	Dhanmondi	244	14
414	2024-09-21 16:00:58.4318	2024-09-21 16:00:58.4318	\N	new	unreachable	Dhanmondi	243	14
415	2024-09-21 16:01:05.768386	2024-09-21 16:01:05.768386	\N	new	not-interested	Dhanmondi	242	14
416	2024-09-21 16:03:14.498431	2024-09-21 16:03:14.498431	\N	new	unreachable	Dhanmondi	241	14
417	2024-09-21 16:03:29.558983	2024-09-21 16:03:29.558983	\N	new	unreachable	Dhanmondi	240	14
418	2024-09-21 16:04:21.306633	2024-09-21 16:04:21.306633	\N	new	not-interested	Dhanmondi	239	14
419	2024-09-21 16:04:51.810527	2024-09-21 16:04:51.810527	\N	new	unreachable	Dhanmondi	238	14
420	2024-09-21 16:05:05.55626	2024-09-21 16:05:05.55626	\N	new	unreachable	Dhanmondi	237	14
421	2024-09-21 16:05:55.733762	2024-09-21 16:05:55.733762	\N	new	future-interest	Dhanmondi	236	14
422	2024-09-21 16:06:11.500698	2024-09-21 16:06:11.500698	\N	new	future-interest	Dhanmondi	235	14
423	2024-09-21 16:06:41.649685	2024-09-21 16:06:41.649685	\N	new	not-interested	Dhanmondi	234	14
424	2024-09-21 16:06:52.84541	2024-09-21 16:06:52.84541	\N	new	unreachable	Dhanmondi	233	14
425	2024-09-21 16:07:49.53328	2024-09-21 16:07:49.53328	\N	new	first	Dhanmondi	232	14
426	2024-09-21 16:08:01.124809	2024-09-21 16:08:01.124809	\N	new	unreachable	Dhanmondi	231	14
427	2024-09-21 16:08:23.031148	2024-09-21 16:08:23.031148	\N	new	unreachable	Dhanmondi	230	14
428	2024-09-21 16:13:09.234066	2024-09-21 16:13:09.234066	\N	new	first	Dhanmondi	208	14
429	2024-09-21 16:13:19.875464	2024-09-21 16:13:19.875464	\N	new	first	Dhanmondi	207	14
430	2024-09-21 16:13:58.352248	2024-09-21 16:13:58.352248	\N	new	unreachable	Dhanmondi	206	14
431	2024-09-21 16:14:13.344933	2024-09-21 16:14:13.344933	\N	new	first	Dhanmondi	205	14
432	2024-09-21 16:15:52.514057	2024-09-21 16:15:52.514057	\N	new	first	Dhanmondi	204	14
433	2024-09-21 16:16:49.589308	2024-09-21 16:16:49.589308	\N	new	unreachable	Dhanmondi	203	14
434	2024-09-21 16:17:00.096155	2024-09-21 16:17:00.096155	\N	new	not-interested	Dhanmondi	202	14
435	2024-09-21 16:17:11.963223	2024-09-21 16:17:11.963223	\N	new	not-interested	Dhanmondi	201	14
436	2024-09-21 16:17:28.56322	2024-09-21 16:17:28.56322	\N	new	unreachable	Dhanmondi	200	14
437	2024-09-21 16:17:42.579489	2024-09-21 16:17:42.579489	\N	new	not-interested	Dhanmondi	199	14
438	2024-09-21 16:17:50.004972	2024-09-21 16:17:50.004972	\N	new	not-interested	Dhanmondi	198	14
439	2024-09-21 16:17:57.123144	2024-09-21 16:17:57.123144	\N	new	not-interested	Dhanmondi	197	14
440	2024-09-21 16:18:14.690391	2024-09-21 16:18:14.690391	\N	new	unreachable	Dhanmondi	196	14
441	2024-09-21 16:18:27.271146	2024-09-21 16:18:27.271146	\N	new	unreachable	Dhanmondi	195	14
442	2024-09-21 16:18:57.078885	2024-09-21 16:18:57.078885	\N	new	not-interested	Dhanmondi	194	14
443	2024-09-21 16:19:03.926034	2024-09-21 16:19:03.926034	\N	new	not-interested	Dhanmondi	193	14
444	2024-09-21 16:19:13.725604	2024-09-21 16:19:13.725604	\N	new	unreachable	Dhanmondi	192	14
445	2024-09-21 16:19:20.765824	2024-09-21 16:19:20.765824	\N	new	not-interested	Dhanmondi	191	14
446	2024-09-21 16:19:32.274975	2024-09-21 16:19:32.274975	\N	new	not-interested	Dhanmondi	190	14
447	2024-09-21 16:19:42.046757	2024-09-21 16:19:42.046757	\N	new	not-interested	Dhanmondi	189	14
448	2024-09-21 17:24:31.492747	2024-09-21 17:24:31.492747	\N	new	unreachable	Dhanmondi	209	13
449	2024-09-21 17:42:59.649841	2024-09-21 17:42:59.649841	\N	new	future-interest	Dhanmondi	261	13
450	2024-09-21 17:51:42.80672	2024-09-21 17:51:42.80672	\N	new	unreachable	Dhanmondi	303	13
451	2024-09-21 18:18:07.15125	2024-09-21 18:18:07.15125	\N	new	unreachable	Dhanmondi	262	13
452	2024-09-21 18:20:09.730345	2024-09-21 18:20:09.730345	\N	new	not-interested	Dhanmondi	260	13
453	2024-09-21 18:24:53.361795	2024-09-21 18:24:53.361795	\N	new	unreachable	Dhanmondi	264	13
454	2024-09-21 18:26:18.159937	2024-09-21 18:26:18.159937	\N	new	unreachable	Dhanmondi	267	13
455	2024-09-21 18:27:02.048635	2024-09-21 18:27:02.048635	\N	new	unreachable	Dhanmondi	266	13
456	2024-09-21 18:29:00.611116	2024-09-21 18:29:00.611116	\N	new	not-interested	Dhanmondi	268	13
457	2024-09-21 18:31:02.419547	2024-09-21 18:31:02.419547	\N	new	unreachable	Dhanmondi	269	13
458	2024-09-21 18:41:42.659526	2024-09-21 18:41:42.659526	\N	new	unreachable	Dhanmondi	210	13
459	2024-09-21 18:43:53.715625	2024-09-21 18:43:53.715625	\N	new	unreachable	Dhanmondi	211	13
460	2024-09-21 18:45:18.011624	2024-09-21 18:45:18.011624	\N	new	first	Dhanmondi	212	13
461	2024-09-21 18:47:05.887309	2024-09-21 18:47:05.887309	\N	new	not-interested	Dhanmondi	213	13
462	2024-09-21 18:48:23.182	2024-09-21 18:48:23.182	\N	new	first	Dhanmondi	214	13
463	2024-09-21 18:49:17.884309	2024-09-21 18:49:17.884309	\N	new	not-interested	Dhanmondi	215	13
464	2024-09-21 18:51:00.560059	2024-09-21 18:51:00.560059	\N	new	not-interested	Dhanmondi	216	13
465	2024-09-21 18:53:33.381357	2024-09-21 18:53:33.381357	\N	new	appointment-book	Dhanmondi	296	13
466	2024-09-21 18:55:48.688977	2024-09-21 18:55:48.688977	\N	new	appointment-book	Dhanmondi	295	13
467	2024-09-22 05:09:56.996402	2024-09-22 05:09:56.996402	\N	new	unreachable	Dhanmondi	302	13
468	2024-09-22 05:11:42.729559	2024-09-22 05:11:42.729559	\N	new	unreachable	Dhanmondi	301	13
469	2024-09-22 05:12:58.215309	2024-09-22 05:12:58.215309	\N	new	unreachable	Dhanmondi	300	13
470	2024-09-22 05:13:37.62896	2024-09-22 05:13:37.62896	\N	new	unreachable	Dhanmondi	299	13
471	2024-09-22 05:17:40.035867	2024-09-22 05:17:40.035867	\N	new	unreachable	Dhanmondi	298	13
472	2024-09-22 05:21:19.027811	2024-09-22 05:21:19.027811	\N	new	future-interest	Dhanmondi	297	13
473	2024-09-22 05:24:03.045798	2024-09-22 05:24:03.045798	\N	new	unreachable	Dhanmondi	294	13
474	2024-09-22 05:25:20.138314	2024-09-22 05:25:20.138314	\N	new	unreachable	Dhanmondi	293	13
475	2024-09-22 05:26:27.608036	2024-09-22 05:26:27.608036	\N	new	unreachable	Dhanmondi	292	13
476	2024-09-22 05:29:59.198682	2024-09-22 05:29:59.198682	\N	new	unreachable	Dhanmondi	263	13
477	2024-09-22 05:34:00.051311	2024-09-22 05:34:00.051311	\N	new	unreachable	Dhanmondi	259	13
478	2024-09-22 05:35:45.469026	2024-09-22 05:35:45.469026	\N	new	not-interested	Dhanmondi	258	13
479	2024-09-22 05:36:53.989965	2024-09-22 05:36:53.989965	\N	new	unreachable	Dhanmondi	257	13
480	2024-09-22 05:37:50.201508	2024-09-22 05:37:50.201508	\N	new	not-interested	Dhanmondi	256	13
481	2024-09-22 05:38:52.436892	2024-09-22 05:38:52.436892	\N	new	unreachable	Dhanmondi	254	13
482	2024-09-22 05:40:08.609321	2024-09-22 05:40:08.609321	\N	new	unreachable	Dhanmondi	253	13
483	2024-09-22 05:41:00.148823	2024-09-22 05:41:00.148823	\N	new	unreachable	Dhanmondi	252	13
484	2024-09-22 05:41:58.741842	2024-09-22 05:41:58.741842	\N	new	not-interested	Dhanmondi	251	13
485	2024-09-22 05:42:51.465723	2024-09-22 05:42:51.465723	\N	new	unreachable	Dhanmondi	250	13
486	2024-09-22 05:44:49.350569	2024-09-22 05:44:49.350569	\N	new	unreachable	Dhanmondi	217	13
487	2024-09-22 05:46:53.631326	2024-09-22 05:46:53.631326	\N	new	unreachable	Dhanmondi	227	13
488	2024-09-22 05:47:46.508439	2024-09-22 05:47:46.508439	\N	new	unreachable	Dhanmondi	226	13
489	2024-09-22 05:48:30.144298	2024-09-22 05:48:30.144298	\N	new	unreachable	Dhanmondi	225	13
490	2024-09-22 05:49:35.140751	2024-09-22 05:49:35.140751	\N	new	unreachable	Dhanmondi	224	13
491	2024-09-22 05:49:55.292253	2024-09-22 05:49:55.292253	\N	new	unreachable	Dhanmondi	218	13
492	2024-09-22 05:50:22.184025	2024-09-22 05:50:22.184025	\N	new	unreachable	Dhanmondi	223	13
493	2024-09-22 05:51:07.204921	2024-09-22 05:51:07.204921	\N	new	unreachable	Dhanmondi	222	13
494	2024-09-22 05:52:08.538667	2024-09-22 05:52:08.538667	\N	new	not-interested	Dhanmondi	221	13
495	2024-09-22 05:53:02.053545	2024-09-22 05:53:02.053545	\N	new	unreachable	Dhanmondi	291	13
496	2024-09-22 05:53:05.186265	2024-09-22 05:53:05.186265	\N	new	not-interested	Dhanmondi	220	13
497	2024-09-22 05:53:49.857008	2024-09-22 05:53:49.857008	\N	new	unreachable	Dhanmondi	219	13
498	2024-09-22 05:54:08.528304	2024-09-22 05:54:08.528304	\N	new	unreachable	Dhanmondi	265	13
499	2024-09-22 05:55:29.9139	2024-09-22 05:55:29.9139	\N	new	unreachable	Dhanmondi	255	13
500	2024-09-22 05:57:26.917731	2024-09-22 05:57:26.917731	\N	new	unreachable	Dhanmondi	249	13
501	2024-09-22 06:06:13.853792	2024-09-22 06:06:13.853792	\N	new	unreachable	Dhanmondi	229	13
502	2024-09-22 06:08:11.594617	2024-09-22 06:08:11.594617	\N	new	unreachable	Dhanmondi	228	13
503	2024-09-22 06:15:26.637131	2024-09-22 06:15:26.637131	\N	-	new	Dhanmondi	342	13
504	2024-09-22 06:17:01.286706	2024-09-22 06:17:01.286706	\N	new	future-interest	Dhanmondi	342	13
505	2024-09-22 06:33:47.102238	2024-09-22 06:33:47.102238	\N	-	new	Dhanmondi	343	13
506	2024-09-22 06:34:18.355745	2024-09-22 06:34:18.355745	\N	new	future-interest	Dhanmondi	343	13
507	2024-09-22 06:43:18.828543	2024-09-22 06:43:18.828543	\N	new	unreachable	Dhanmondi	312	13
508	2024-09-22 06:46:53.97019	2024-09-22 06:46:53.97019	\N	new	unreachable	Dhanmondi	310	13
509	2024-09-22 06:49:52.088832	2024-09-22 06:49:52.088832	\N	new	future-interest	Dhanmondi	311	13
510	2024-09-22 07:01:45.015809	2024-09-22 07:01:45.015809	\N	new	unreachable	Dhanmondi	309	13
511	2024-09-22 07:02:05.242037	2024-09-22 07:02:05.242037	\N	new	unreachable	Dhanmondi	308	13
512	2024-09-22 07:02:51.430919	2024-09-22 07:02:51.430919	\N	new	not-interested	Dhanmondi	307	13
513	2024-09-22 07:05:14.847896	2024-09-22 07:05:14.847896	\N	new	unreachable	Dhanmondi	306	13
514	2024-09-22 07:09:28.584906	2024-09-22 07:09:28.584906	\N	new	unreachable	Dhanmondi	305	13
515	2024-09-22 07:09:54.312195	2024-09-22 07:09:54.312195	\N	new	unreachable	Dhanmondi	304	13
516	2024-09-24 13:06:38.411962	2024-09-24 13:06:38.411962	\N	not-interested	course-new	Dhanmondi	337	1
517	2024-09-24 13:06:47.83362	2024-09-24 13:06:47.83362	\N	course-new	new	Dhanmondi	337	1
518	2024-09-24 13:13:09.364651	2024-09-24 13:13:09.364651	\N	new	appointment-book	Dhanmondi	337	1
519	2024-09-24 13:13:24.891046	2024-09-24 13:13:24.891046	\N	appointment-book	waiting-for-document	Dhanmondi	337	1
520	2024-09-24 13:18:04.162142	2024-09-24 13:18:04.162142	\N	unreachable	course-new	Dhanmondi	300	1
521	2024-09-24 13:18:10.292237	2024-09-24 13:18:10.292237	\N	course-new	new	Dhanmondi	300	1
522	2024-09-24 13:18:35.311699	2024-09-24 13:18:35.311699	\N	new	appointment-book	Dhanmondi	300	1
523	2024-09-25 06:35:18.951816	2024-09-25 06:35:18.951816	\N	first	course-new	Dhanmondi	322	14
524	2024-09-25 06:37:05.224742	2024-09-25 06:37:05.224742	\N	course-new	exam	Dhanmondi	322	14
525	2024-09-25 06:37:37.708039	2024-09-25 06:37:37.708039	\N	exam	course-new	Dhanmondi	322	14
526	2024-09-25 06:38:18.666432	2024-09-25 06:38:18.666432	\N	course-new	course-first	Dhanmondi	322	14
527	2024-09-25 06:43:46.837415	2024-09-25 06:43:46.837415	\N	first	appointment-book	Dhanmondi	289	14
528	2024-09-25 06:51:36.269405	2024-09-25 06:51:36.269405	\N	first	appointment-book	Dhanmondi	288	14
529	2024-09-25 09:11:37.608842	2024-09-25 09:11:37.608842	\N	new	not-interested	Dhanmondi	333	14
530	2024-09-26 11:25:43.76317	2024-09-26 11:25:43.76317	\N	first	unreachable	Dhanmondi	205	14
531	2024-09-26 14:20:05.577464	2024-09-26 14:20:05.577464	\N	-	new	Dhanmondi	345	14
532	2024-09-26 14:25:28.834409	2024-09-26 14:25:28.834409	\N	new	appointment-book	Dhanmondi	345	14
533	2024-09-26 14:26:22.992386	2024-09-26 14:26:22.992386	\N	appointment-book	waiting-for-document	Dhanmondi	345	14
534	2024-09-26 15:29:52.986139	2024-09-26 15:29:52.986139	\N	waiting-for-document	start-application	Dhanmondi	345	14
535	2024-09-28 06:35:08.79673	2024-09-28 06:35:08.79673	\N	-	new	Dhanmondi	354	13
536	2024-09-28 06:35:53.709656	2024-09-28 06:35:53.709656	\N	new	appointment-book	Dhanmondi	354	13
537	2024-09-28 06:37:01.493815	2024-09-28 06:37:01.493815	\N	appointment-book	waiting-for-document	Dhanmondi	354	13
538	2024-09-30 06:09:54.813988	2024-09-30 06:09:54.813988	\N	-	new	Dhanmondi	355	13
539	2024-09-30 06:11:53.513839	2024-09-30 06:11:53.513839	\N	new	future-interest	Dhanmondi	355	13
540	2024-10-10 10:48:24.863985	2024-10-10 10:48:24.863985	\N	appointment-book	course-new	Dhanmondi	328	14
541	2024-10-10 10:48:31.541382	2024-10-10 10:48:31.541382	\N	course-new	new	Dhanmondi	328	14
542	2024-10-10 10:48:51.822746	2024-10-10 10:48:51.822746	\N	new	unreachable	Dhanmondi	328	14
543	2024-10-10 10:52:01.596339	2024-10-10 10:52:01.596339	\N	appointment-book	course-new	Dhanmondi	289	14
544	2024-10-10 10:52:05.047587	2024-10-10 10:52:05.047587	\N	course-new	new	Dhanmondi	289	14
545	2024-10-10 10:52:38.391528	2024-10-10 10:52:38.391528	\N	new	future-interest	Dhanmondi	289	14
549	2024-11-24 06:21:22.183732	2024-11-24 06:21:22.183732	\N	appointment-book	course-new	Dhanmondi	317	14
553	2024-11-24 12:45:49.911578	2024-11-24 12:45:49.911578	\N	course-new	new	Dhanmondi	340	14
557	2024-11-24 13:09:48.12728	2024-11-24 13:09:48.12728	\N	-	new	Dhanmondi	357	1
563	2024-11-24 13:09:48.132693	2024-11-24 13:09:48.132693	\N	-	new	Dhanmondi	361	1
567	2024-11-24 13:09:48.135513	2024-11-24 13:09:48.135513	\N	-	new	Dhanmondi	364	1
572	2024-11-24 13:09:48.141528	2024-11-24 13:09:48.141528	\N	-	new	Dhanmondi	380	1
577	2024-11-24 13:09:48.145763	2024-11-24 13:09:48.145763	\N	-	new	Dhanmondi	382	1
586	2024-11-24 13:09:48.156776	2024-11-24 13:09:48.156776	\N	-	new	Dhanmondi	378	1
589	2024-11-24 13:09:48.157207	2024-11-24 13:09:48.157207	\N	-	new	Dhanmondi	387	1
600	2024-11-24 13:09:48.1674	2024-11-24 13:09:48.1674	\N	-	new	Dhanmondi	394	1
602	2024-11-24 13:09:48.169206	2024-11-24 13:09:48.169206	\N	-	new	Dhanmondi	399	1
607	2024-11-24 13:09:48.171716	2024-11-24 13:09:48.171716	\N	-	new	Dhanmondi	416	1
612	2024-11-24 13:09:48.174478	2024-11-24 13:09:48.174478	\N	-	new	Dhanmondi	415	1
616	2024-11-24 13:09:48.180063	2024-11-24 13:09:48.180063	\N	-	new	Dhanmondi	414	1
618	2024-11-24 13:09:48.181262	2024-11-24 13:09:48.181262	\N	-	new	Dhanmondi	423	1
626	2024-11-24 13:09:48.195144	2024-11-24 13:09:48.195144	\N	-	new	Dhanmondi	429	1
628	2024-11-24 13:09:48.196593	2024-11-24 13:09:48.196593	\N	-	new	Dhanmondi	431	1
634	2024-11-24 13:09:48.201082	2024-11-24 13:09:48.201082	\N	-	new	Dhanmondi	427	1
638	2024-11-24 13:09:48.205715	2024-11-24 13:09:48.205715	\N	-	new	Dhanmondi	439	1
642	2024-11-24 13:09:48.208956	2024-11-24 13:09:48.208956	\N	-	new	Dhanmondi	450	1
644	2024-11-24 13:09:48.208461	2024-11-24 13:09:48.208461	\N	-	new	Dhanmondi	442	1
650	2024-11-24 13:09:48.216051	2024-11-24 13:09:48.216051	\N	-	new	Dhanmondi	453	1
652	2024-11-24 13:09:48.21608	2024-11-24 13:09:48.21608	\N	-	new	Dhanmondi	455	1
655	2024-11-24 13:09:48.21644	2024-11-24 13:09:48.21644	\N	-	new	Dhanmondi	456	1
658	2024-11-24 13:09:48.229736	2024-11-24 13:09:48.229736	\N	-	new	Dhanmondi	467	1
660	2024-11-24 13:09:48.232075	2024-11-24 13:09:48.232075	\N	-	new	Dhanmondi	461	1
667	2024-11-24 13:09:48.248963	2024-11-24 13:09:48.248963	\N	-	new	Dhanmondi	469	1
668	2024-11-24 13:09:48.250115	2024-11-24 13:09:48.250115	\N	-	new	Dhanmondi	472	1
670	2024-11-24 13:09:48.251514	2024-11-24 13:09:48.251514	\N	-	new	Dhanmondi	476	1
676	2024-11-24 13:09:48.258111	2024-11-24 13:09:48.258111	\N	-	new	Dhanmondi	480	1
678	2024-11-24 13:09:48.259241	2024-11-24 13:09:48.259241	\N	-	new	Dhanmondi	470	1
684	2024-11-24 13:09:48.262249	2024-11-24 13:09:48.262249	\N	-	new	Dhanmondi	485	1
685	2024-11-24 13:09:48.265164	2024-11-24 13:09:48.265164	\N	-	new	Dhanmondi	495	1
687	2024-11-24 13:09:48.266313	2024-11-24 13:09:48.266313	\N	-	new	Dhanmondi	492	1
693	2024-11-24 13:09:48.27592	2024-11-24 13:09:48.27592	\N	-	new	Dhanmondi	493	1
695	2024-11-24 13:09:48.277368	2024-11-24 13:09:48.277368	\N	-	new	Dhanmondi	501	1
701	2024-11-24 13:09:48.280359	2024-11-24 13:09:48.280359	\N	-	new	Dhanmondi	508	1
702	2024-11-24 13:09:48.283704	2024-11-24 13:09:48.283704	\N	-	new	Dhanmondi	505	1
704	2024-11-24 13:09:48.28476	2024-11-24 13:09:48.28476	\N	-	new	Dhanmondi	511	1
709	2024-11-24 13:09:48.290797	2024-11-24 13:09:48.290797	\N	-	new	Dhanmondi	516	1
712	2024-11-24 13:09:48.294061	2024-11-24 13:09:48.294061	\N	-	new	Dhanmondi	514	1
713	2024-11-24 13:09:48.29509	2024-11-24 13:09:48.29509	\N	-	new	Dhanmondi	515	1
718	2024-11-24 13:09:48.301795	2024-11-24 13:09:48.301795	\N	-	new	Dhanmondi	525	1
721	2024-11-24 13:09:48.307468	2024-11-24 13:09:48.307468	\N	-	new	Dhanmondi	529	1
725	2024-11-24 13:09:48.311582	2024-11-24 13:09:48.311582	\N	-	new	Dhanmondi	522	1
727	2024-11-24 13:09:48.312251	2024-11-24 13:09:48.312251	\N	-	new	Dhanmondi	539	1
730	2024-11-24 13:09:48.315157	2024-11-24 13:09:48.315157	\N	-	new	Dhanmondi	527	1
735	2024-11-24 13:09:48.318638	2024-11-24 13:09:48.318638	\N	-	new	Dhanmondi	530	1
738	2024-11-24 13:09:48.321125	2024-11-24 13:09:48.321125	\N	-	new	Dhanmondi	548	1
739	2024-11-24 13:09:48.3198	2024-11-24 13:09:48.3198	\N	-	new	Dhanmondi	546	1
744	2024-11-24 13:09:48.32552	2024-11-24 13:09:48.32552	\N	-	new	Dhanmondi	533	1
748	2024-11-24 13:09:48.331747	2024-11-24 13:09:48.331747	\N	-	new	Dhanmondi	540	1
749	2024-11-24 13:09:48.332669	2024-11-24 13:09:48.332669	\N	-	new	Dhanmondi	545	1
753	2024-11-24 13:09:48.341521	2024-11-24 13:09:48.341521	\N	-	new	Dhanmondi	556	1
756	2024-11-24 13:09:48.34539	2024-11-24 13:09:48.34539	\N	-	new	Dhanmondi	552	1
757	2024-11-24 13:09:48.345935	2024-11-24 13:09:48.345935	\N	-	new	Dhanmondi	557	1
762	2024-11-24 13:09:48.34895	2024-11-24 13:09:48.34895	\N	-	new	Dhanmondi	562	1
765	2024-11-24 13:09:48.351469	2024-11-24 13:09:48.351469	\N	-	new	Dhanmondi	569	1
766	2024-11-24 13:09:48.351962	2024-11-24 13:09:48.351962	\N	-	new	Dhanmondi	572	1
769	2024-11-24 13:09:48.360476	2024-11-24 13:09:48.360476	\N	-	new	Dhanmondi	573	1
770	2024-11-24 13:09:48.365801	2024-11-24 13:09:48.365801	\N	-	new	Dhanmondi	565	1
771	2024-11-24 13:09:48.381364	2024-11-24 13:09:48.381364	\N	-	new	Dhanmondi	574	1
\.


--
-- Data for Name: substagelabel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.substagelabel (id, created_at, updated_at, deleted_at, stage, substage, substagelabel) FROM stdin;
1	2024-09-06 09:46:07.088601	2024-09-06 09:46:07.088601	\N	lead	all	all
2	2024-09-06 09:46:07.093735	2024-09-06 09:46:07.093735	\N	lead	new	new
3	2024-09-06 09:46:07.096041	2024-09-06 09:46:07.096041	\N	lead	first	first
4	2024-09-06 09:46:07.09809	2024-09-06 09:46:07.09809	\N	lead	second	second
5	2024-09-06 09:46:07.100506	2024-09-06 09:46:07.100506	\N	lead	third	third
6	2024-09-06 09:46:07.104078	2024-09-06 09:46:07.104078	\N	lead	final-call	final-call
7	2024-09-06 09:46:07.107102	2024-09-06 09:46:07.107102	\N	lead	unreachable	unreachable
8	2024-09-06 09:46:07.110249	2024-09-06 09:46:07.110249	\N	lead	future-interest	future-interest
9	2024-09-06 09:46:07.112843	2024-09-06 09:46:07.112843	\N	lead	not-interested	not-interested
10	2024-09-06 09:46:07.116206	2024-09-06 09:46:07.116206	\N	potential	all	all
11	2024-09-06 09:46:07.119051	2024-09-06 09:46:07.119051	\N	potential	appointment-book	appointment-book
12	2024-09-06 09:46:07.121521	2024-09-06 09:46:07.121521	\N	potential	postponed	postponed
13	2024-09-06 09:46:07.125286	2024-09-06 09:46:07.125286	\N	potential	cancel	cancel
14	2024-09-06 09:46:07.127738	2024-09-06 09:46:07.127738	\N	potential	waiting-for-document	waiting-for-document
15	2024-09-06 09:46:07.130349	2024-09-06 09:46:07.130349	\N	admission	all	all
16	2024-09-06 09:46:07.133244	2024-09-06 09:46:07.133244	\N	admission	start-application	start-application
17	2024-09-06 09:46:07.136208	2024-09-06 09:46:07.136208	\N	admission	applied	applied
18	2024-09-06 09:46:07.138428	2024-09-06 09:46:07.138428	\N	admission	offer-received	offer-received
19	2024-09-06 09:46:07.141117	2024-09-06 09:46:07.141117	\N	admission	offer	offer
20	2024-09-06 09:46:07.143204	2024-09-06 09:46:07.143204	\N	admission	first-interview	first-interview
21	2024-09-06 09:46:07.145085	2024-09-06 09:46:07.145085	\N	admission	unconditional-offer	unconditional-offer
22	2024-09-06 09:46:07.14722	2024-09-06 09:46:07.14722	\N	admission	first-payment	first-payment
23	2024-09-06 09:46:07.149365	2024-09-06 09:46:07.149365	\N	admission	end-application	end-application
24	2024-09-06 09:46:07.151192	2024-09-06 09:46:07.151192	\N	compliance	all	all
25	2024-09-06 09:46:07.153207	2024-09-06 09:46:07.153207	\N	compliance	final-choice	final-choice
26	2024-09-06 09:46:07.155565	2024-09-06 09:46:07.155565	\N	compliance	visa-application	visa-application
27	2024-09-06 09:46:07.157703	2024-09-06 09:46:07.157703	\N	compliance	visa-interview	visa-interview
28	2024-09-06 09:46:07.159619	2024-09-06 09:46:07.159619	\N	compliance	visa	visa
29	2024-09-06 09:46:07.161412	2024-09-06 09:46:07.161412	\N	compliance	refused	refused
30	2024-09-06 09:46:07.163334	2024-09-06 09:46:07.163334	\N	compliance	final-payment	final-payment
31	2024-09-06 09:46:07.165224	2024-09-06 09:46:07.165224	\N	compliance	enrolled	enrolled
32	2024-09-06 09:46:07.167529	2024-09-06 09:46:07.167529	\N	compliance	not-enrolled	not-enrolled
\.


--
-- Data for Name: system_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_module (id, name, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (id, created_at, updated_at, deleted_at, task, description, status, start_date, end_date, "assignedId") FROM stdin;
\.


--
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university (id, created_at, updated_at, deleted_at, university_name, country) FROM stdin;
1	2024-09-06 09:38:39.762777	2024-09-06 09:38:39.762777	\N	University of Birmingham	UK
2	2024-09-06 09:38:49.524934	2024-09-06 09:38:49.524934	\N	MIT	USA
3	2024-09-06 09:39:07.164649	2024-09-06 09:39:07.164649	\N	Sydney University	Australia
4	2024-09-07 19:45:04.900347	2024-09-07 19:45:04.900347	\N	OXFORD	USA
5	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Cambridge	UK
6	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Oxford	UK
7	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	London School of Economics and Political Science, University of London	UK
8	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of St Andrews	UK
9	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Imperial College London	UK
10	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Loughborough University	UK
11	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Durham University	UK
12	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Bath	UK
13	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	UCL (University College London)	UK
14	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Warwick	UK
15	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Lancaster University	UK
16	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Surrey	UK
17	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Birmingham	UK
18	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Exeter	UK
19	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	The University of Edinburgh	UK
20	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Bristol	UK
21	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of York	UK
22	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Sheffield	UK
23	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Liverpool	UK
24	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Southampton	UK
25	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of East Anglia UEA	UK
26	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Manchester	UK
27	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Leeds	UK
28	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	King's College London, University of London	UK
29	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Queen's University Belfast	UK
30	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Newcastle University	UK
31	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Cardiff University	UK
32	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Glasgow	UK
33	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of the Arts London	UK
34	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Nottingham	UK
35	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Essex	UK
36	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Strathclyde	UK
37	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Harper Adams University	UK
38	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Northumbria University Newcastle	UK
39	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Reading	UK
40	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Leicester	UK
41	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Swansea University	UK
42	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Royal Holloway, University of London	UK
43	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Aston University Birmingham	UK
44	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	City University of London	UK
45	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Aberdeen	UK
46	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Ulster University	UK
47	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Aberystwyth University	UK
48	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Heriot-Watt University	UK
49	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Nottingham Trent University	UK
50	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Oxford Brookes University	UK
51	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Sussex	UK
52	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Lincoln	UK
53	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Portsmouth	UK
54	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Queen Mary University of London	UK
55	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Dundee	UK
56	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Kent	UK
57	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Stirling	UK
58	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Edge Hill University	UK
59	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Bournemouth University	UK
60	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Chester	UK
61	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Manchester Metropolitan University	UK
62	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Suffolk	UK
63	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of West London	UK
64	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Goldsmiths University of London	UK
65	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Keele University	UK
66	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Cardiff Metropolitan University	UK
67	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Sheffield Hallam University	UK
68	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Falmouth University	UK
69	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Plymouth	UK
70	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Huddersfield	UK
71	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Coventry University	UK
72	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Bangor University	UK
73	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	St George's University of London	UK
74	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Brighton	UK
75	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	SOAS University of London	UK
76	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	St Mary's University Twickenham	UK
77	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Hull	UK
78	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Salford	UK
79	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Bristol, University of the West of England	UK
80	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Glasgow Caledonian University	UK
81	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Leeds Beckett University	UK
82	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Sunderland	UK
83	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Chichester	UK
84	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Brunel University London	UK
85	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Liverpool John Moores University	UK
86	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Norwich University of the Arts	UK
87	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Liverpool Hope University	UK
88	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Hertfordshire	UK
89	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University for the Creative Arts	UK
90	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Edinburgh Napier University	UK
91	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Central Lancashire	UK
92	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Worcester	UK
93	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Gloucestershire	UK
94	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Kingston University	UK
95	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Robert Gordon University	UK
96	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Birmingham City University	UK
97	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Roehampton	UK
98	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Arts University Bournemouth	UK
99	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Derby	UK
100	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of South Wales	UK
101	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Queen Margaret University, Edinburgh	UK
102	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Staffordshire University	UK
103	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Abertay University	UK
104	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Teesside University Middlesbrough	UK
105	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	York St John University	UK
106	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Solent University (Southampton)	UK
107	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Winchester	UK
108	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Bath Spa University	UK
109	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	De Montfort University	UK
110	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Buckinghamshire New University	UK
111	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Bradford	UK
112	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Bolton	UK
113	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Canterbury Christ Church University	UK
114	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Greenwich	UK
115	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Wolverhampton	UK
116	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Leeds Arts University	UK
117	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Middlesex University	UK
118	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	London South Bank University	UK
119	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Plymouth Marjon University	UK
120	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Leeds Trinity University	UK
121	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Wales Trinity Saint David	UK
122	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Westminster London	UK
123	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Royal Agricultural University	UK
124	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Northampton	UK
125	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Anglia Ruskin University	UK
126	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Bishop Grosseteste University	UK
127	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Cumbria	UK
128	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Birmingham Newman University	UK
129	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of East London	UK
130	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Buckingham	UK
131	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	London Metropolitan University	UK
132	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of the West of Scotland	UK
133	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	University of Bedfordshire	UK
134	2024-09-12 20:20:38.148719	2024-09-12 20:20:38.148719	\N	Wrexham University	UK
135	2024-09-26 15:20:34.956931	2024-09-26 15:20:34.956931	\N	University of South Wales	UK
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, created_at, updated_at, deleted_at, full_name, email, password, status, is_verified, phone_number, otp, provider, branch_name, role) FROM stdin;
6	2024-09-06 09:57:36.907729	2024-09-06 09:57:36.907729	\N	Rafiq	binaryphysics123@gmail.com	$2b$10$LlyCILJHF6kgdHpY3FJzp.PcRdkyilm0.1az8JTOun4v4tBgfIDoa	active	t	\N	\N	local	Mirpur	student
7	2024-09-07 19:55:32.187077	2024-09-07 20:04:51.821591	\N	Latoya Reed	jfisher@example.net	$2b$10$qBzk0HLraiPWYmLJPG3cAe84JHu61W5WHohs96iN6iOYrQf0NlNgC	active	t	\N	\N	local	Mirpur	student
8	2024-09-07 20:05:35.978268	2024-09-07 20:05:49.397813	\N	Latoya Reed	factoryze.official@gmail.com	$2b$10$NDx.jDebGaS284IZYrAVxODGEO0hxWRDLWWDIadIM94R1FXTmCxIW	active	t	\N	\N	local	Mirpur	student
9	2024-09-08 21:09:32.862775	2024-09-08 21:09:32.862775	\N	Education 	educationdoorways@gmail.com	$2b$10$aPrudBUyperv8PjnZRCHd.g9/86fCAxldB9bKkrhnEMOFhmPhzmbu	active	t	07977755658	\N	local	London	manager
1	2024-09-05 10:43:12.738607	2024-09-05 10:43:12.738607	\N	Naf	dhaka@educationdoorway.io	$2b$10$OwlPQvdLanQCorhGMb8F3.kRZzrjnA96iOVtq3irAKT5O/Qy8LHp.	active	t	\N	\N	local	Dhanmondi	admin
2	2024-09-06 09:39:46.33243	2024-09-13 19:51:01.224351	2024-09-13 19:51:01.224351	M. Fahad	fali87026@gmail.com	$2b$10$ubbpqh0kVMPqXDyJYVNfJOvd.wWIQRHBZ0f/fU1wmmlvQ4ZIWDnDS	active	t	01538425875	\N	local	Mirpur	manager
3	2024-09-06 09:42:38.109594	2024-09-13 19:51:54.049418	2024-09-13 19:51:54.049418	M. Fayzal	bsse1105@iit.du.ac.bd	$2b$10$zKjkLX0GBMTFR52MeETZ/OWjMnCwDIqAodZwI/6ISFMsDDN3s5VaW	active	t	01538425875	\N	local	Mirpur	counsellor
4	2024-09-06 09:44:00.596818	2024-09-13 19:52:00.470509	2024-09-13 19:52:00.470509	ফাহাদ হসসাইন	itiqad123@gmail.com	$2b$10$E9bh8k46VvAuATcXRtOk3.PwwaNv9ALRGYVSH7kzo3pX.ND.UmJz2	active	t	01538425875	\N	local	Mirpur	application
5	2024-09-06 09:44:19.21096	2024-09-13 19:52:20.959125	2024-09-13 19:52:20.959125	Rahat	fahadhossain5269@gmail.com	$2b$10$2oiHE4AgrWmHcT.D0yZMcuziCqET2KooFaCOJoqnyxX4Oycb/dO0y	active	t	01538425875	\N	local	Mirpur	compliance
10	2024-09-14 10:16:47.144661	2024-09-14 10:16:47.144661	\N	MD	MD@gmail.com	$2b$10$8kKe1y1xWSArlxmU7svoieITHZpfUo2SmkA0wI5ks23HCov0M38L2	active	t	\N	\N	local	Dhanmondi	student
11	2024-09-15 19:16:56.110944	2024-09-15 19:16:56.110944	\N	Naf	application1@educationdoorway.io	$2b$10$0Rvpk7azJCCF7G0JNBf5R.Fxe25PjH2v2QXW2jVavR.Da5DGzCRXK	active	t	01717532473	\N	local	Dhanmondi	application
12	2024-09-15 19:19:45.795103	2024-09-15 19:19:45.795103	\N	Naf	compliance@educationdoorway.io	$2b$10$2ztTQwYe0YHMsGfL.oR4te0sHc4xs9H6AedcsJaH2QbhuW5mR/uOi	active	t	01717532473	\N	local	Dhanmondi	compliance
13	2024-09-16 14:02:47.505639	2024-09-16 14:02:47.505639	\N	Jarin	consultant@educationdoorway.io	$2b$10$pZ84PqNvhc5YWwpvfth32eXHbSNg5sNGXGKOk7gNzMI9I0F65oRg2	active	t	+880 1327417717	\N	local	Dhanmondi	counsellor
14	2024-09-16 14:03:38.356834	2024-09-16 14:03:38.356834	\N	Farzana	Consultant17@educationdoorway.io	$2b$10$mUvNiLAU3xhKWpvlDJo4hOk2VZGcF.H56n8Ba.mY6ThEZgh1cXL2C	active	t	+880 1709021487	\N	local	Dhanmondi	counsellor
15	2024-09-16 14:04:21.36593	2024-09-16 14:04:30.245103	\N	Nusrat	Consultant21@educationdoorway.io	$2b$10$rcDkvmB/RANZIpmh3/rX0OY7bkTIhmhRTHATq5Ctc.zlnikdrxtu2	active	t	+880 1607035396	\N	local	Dhanmondi	counsellor
16	2024-09-26 15:29:52.914964	2024-09-26 15:29:52.914964	\N	Shuvarthy Barua	drshuvarthybarua@gmail.com	$2b$10$XQvcpvlX.yo41Rl2wfLit.9iWL7ZuJgV1CjAzoH79EjxIDpM0NLQa	active	t	\N	\N	local	Dhanmondi	student
\.


--
-- Name: activity_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_event_id_seq', 2033, true);


--
-- Name: application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_id_seq', 4, true);


--
-- Name: branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branch_id_seq', 9, true);


--
-- Name: cats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cats_id_seq', 1, false);


--
-- Name: coachingclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coachingclass_id_seq', 1, false);


--
-- Name: kpi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kpi_id_seq', 1, false);


--
-- Name: lead_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lead_document_id_seq', 11, true);


--
-- Name: lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lead_id_seq', 574, true);


--
-- Name: mail_cred_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mail_cred_id_seq', 1, false);


--
-- Name: metacridential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metacridential_id_seq', 1, false);


--
-- Name: module_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.module_permission_id_seq', 1, false);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 290, true);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permission_id_seq', 1, false);


--
-- Name: remark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.remark_id_seq', 1381, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permission_id_seq', 1, false);


--
-- Name: status_change_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_change_id_seq', 771, true);


--
-- Name: substagelabel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.substagelabel_id_seq', 32, true);


--
-- Name: system_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.system_module_id_seq', 1, false);


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_seq', 2, true);


--
-- Name: university_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_id_seq', 135, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: module_permission PK_1caf25b35b30900d1f1bc075c7e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_permission
    ADD CONSTRAINT "PK_1caf25b35b30900d1f1bc075c7e" PRIMARY KEY (id);


--
-- Name: branch PK_2e39f426e2faefdaa93c5961976; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT "PK_2e39f426e2faefdaa93c5961976" PRIMARY KEY (id);


--
-- Name: permission PK_3b8b97af9d9d8807e41e6f48362; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT "PK_3b8b97af9d9d8807e41e6f48362" PRIMARY KEY (id);


--
-- Name: substagelabel PK_40b87acaea6f636a4cb367a55e1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.substagelabel
    ADD CONSTRAINT "PK_40b87acaea6f636a4cb367a55e1" PRIMARY KEY (id);


--
-- Name: kpi PK_56589835e31cc0331684d2d28a7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi
    ADD CONSTRAINT "PK_56589835e31cc0331684d2d28a7" PRIMARY KEY (id);


--
-- Name: application PK_569e0c3e863ebdf5f2408ee1670; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT "PK_569e0c3e863ebdf5f2408ee1670" PRIMARY KEY (id);


--
-- Name: remark PK_58427c64a5e9ff68e1ff44d01f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.remark
    ADD CONSTRAINT "PK_58427c64a5e9ff68e1ff44d01f9" PRIMARY KEY (id);


--
-- Name: cats PK_611e3c0a930b4ddc1541422864c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cats
    ADD CONSTRAINT "PK_611e3c0a930b4ddc1541422864c" PRIMARY KEY (id);


--
-- Name: lead_document PK_69b2a65dbe16cdee29f2026fd5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_document
    ADD CONSTRAINT "PK_69b2a65dbe16cdee29f2026fd5c" PRIMARY KEY (id);


--
-- Name: notification PK_705b6c7cdf9b2c2ff7ac7872cb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "PK_705b6c7cdf9b2c2ff7ac7872cb7" PRIMARY KEY (id);


--
-- Name: role_permission PK_96c8f1fd25538d3692024115b47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT "PK_96c8f1fd25538d3692024115b47" PRIMARY KEY (id);


--
-- Name: metacridential PK_a01c7a6d0558409b78ca8bb0354; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metacridential
    ADD CONSTRAINT "PK_a01c7a6d0558409b78ca8bb0354" PRIMARY KEY (id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: system_module PK_a5b501ae42f4a62fbc6ea9127ec; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_module
    ADD CONSTRAINT "PK_a5b501ae42f4a62fbc6ea9127ec" PRIMARY KEY (id);


--
-- Name: role PK_b36bcfe02fc8de3c57a8b2391c2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "PK_b36bcfe02fc8de3c57a8b2391c2" PRIMARY KEY (id);


--
-- Name: status_change PK_c24e2142db7320c7da70a806f45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_change
    ADD CONSTRAINT "PK_c24e2142db7320c7da70a806f45" PRIMARY KEY (id);


--
-- Name: coachingclass PK_c299887cfe4805da6c95fec2257; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachingclass
    ADD CONSTRAINT "PK_c299887cfe4805da6c95fec2257" PRIMARY KEY (id);


--
-- Name: activity_event PK_c2c1e9fdda754a6bf7f664d7e04; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_event
    ADD CONSTRAINT "PK_c2c1e9fdda754a6bf7f664d7e04" PRIMARY KEY (id);


--
-- Name: lead PK_ca96c1888f7dcfccab72b72fffa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT "PK_ca96c1888f7dcfccab72b72fffa" PRIMARY KEY (id);


--
-- Name: university PK_d14e5687dbd51fd7a915c22ac13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT "PK_d14e5687dbd51fd7a915c22ac13" PRIMARY KEY (id);


--
-- Name: mail_cred PK_ed67e70f6d0442a4bb7440dde18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mail_cred
    ADD CONSTRAINT "PK_ed67e70f6d0442a4bb7440dde18" PRIMARY KEY (id);


--
-- Name: task PK_fb213f79ee45060ba925ecd576e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT "PK_fb213f79ee45060ba925ecd576e" PRIMARY KEY (id);


--
-- Name: lead UQ_82927bc307d97fe09c616cd3f58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT "UQ_82927bc307d97fe09c616cd3f58" UNIQUE (email);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: remark FK_0872f1d7199829936cc0ba40cbf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.remark
    ADD CONSTRAINT "FK_0872f1d7199829936cc0ba40cbf" FOREIGN KEY ("leadId") REFERENCES public.lead(id);


--
-- Name: status_change FK_0a08cd6afd02cef865f551608c9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_change
    ADD CONSTRAINT "FK_0a08cd6afd02cef865f551608c9" FOREIGN KEY ("initiatorId") REFERENCES public.users(id);


--
-- Name: lead FK_1ab391a93290519d62d52671a13; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT "FK_1ab391a93290519d62d52671a13" FOREIGN KEY ("assignedId") REFERENCES public.users(id);


--
-- Name: status_change FK_24e3b70304539485859184ecdb6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_change
    ADD CONSTRAINT "FK_24e3b70304539485859184ecdb6" FOREIGN KEY ("leadId") REFERENCES public.lead(id);


--
-- Name: activity_event FK_29654477f37189453b353d3f46a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_event
    ADD CONSTRAINT "FK_29654477f37189453b353d3f46a" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: application FK_476bb702502c0d14bf82b71ffe9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT "FK_476bb702502c0d14bf82b71ffe9" FOREIGN KEY ("universityId") REFERENCES public.university(id);


--
-- Name: module_permission FK_5449391befab2a593dce38f4ab6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_permission
    ADD CONSTRAINT "FK_5449391befab2a593dce38f4ab6" FOREIGN KEY ("moduleId") REFERENCES public.system_module(id);


--
-- Name: coachingclass FK_5a529f6a037cc1b5ffd08125013; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachingclass
    ADD CONSTRAINT "FK_5a529f6a037cc1b5ffd08125013" FOREIGN KEY ("leadId") REFERENCES public.lead(id);


--
-- Name: application FK_5c9ce672e2fa547b53a1fea12d5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT "FK_5c9ce672e2fa547b53a1fea12d5" FOREIGN KEY ("leadId") REFERENCES public.lead(id);


--
-- Name: lead_document FK_7debdf61a6f7d97a882fa15f684; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_document
    ADD CONSTRAINT "FK_7debdf61a6f7d97a882fa15f684" FOREIGN KEY ("leadId") REFERENCES public.lead(id);


--
-- Name: role_permission FK_7eadd8634ba61c6957b89d545ed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT "FK_7eadd8634ba61c6957b89d545ed" FOREIGN KEY ("permissionModuleId") REFERENCES public.module_permission(id);


--
-- Name: task FK_861fc64a5d366b3cfe90a0f4a35; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT "FK_861fc64a5d366b3cfe90a0f4a35" FOREIGN KEY ("assignedId") REFERENCES public.users(id);


--
-- Name: module_permission FK_abc2829cceb66d53779ac57e595; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_permission
    ADD CONSTRAINT "FK_abc2829cceb66d53779ac57e595" FOREIGN KEY ("permissionId") REFERENCES public.permission(id);


--
-- Name: remark FK_ceea12e073d2f65af4a2128bd3c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.remark
    ADD CONSTRAINT "FK_ceea12e073d2f65af4a2128bd3c" FOREIGN KEY ("assignedId") REFERENCES public.users(id);


--
-- Name: role_permission FK_e3130a39c1e4a740d044e685730; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT "FK_e3130a39c1e4a740d044e685730" FOREIGN KEY ("roleId") REFERENCES public.role(id);


--
-- PostgreSQL database dump complete
--

