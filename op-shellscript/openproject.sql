--
-- PostgreSQL database dump
--

-- Dumped from database version 13.18 (Debian 13.18-1.pgdg120+1)
-- Dumped by pg_dump version 13.18 (Debian 13.18-1.pgdg120+1)

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
-- Name: versions_name; Type: COLLATION; Schema: public; Owner: -
--

CREATE COLLATION public.versions_name (provider = icu, locale = 'und-u-kn-true');


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id bigint NOT NULL,
    text text,
    show_until date,
    active boolean DEFAULT false,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: attachable_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attachable_journals (
    id bigint NOT NULL,
    journal_id bigint NOT NULL,
    attachment_id bigint NOT NULL,
    filename character varying NOT NULL
);


--
-- Name: attachable_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attachable_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachable_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attachable_journals_id_seq OWNED BY public.attachable_journals.id;


--
-- Name: attachment_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attachment_journals (
    id bigint NOT NULL,
    container_id bigint,
    container_type character varying(30),
    filename character varying NOT NULL,
    disk_filename character varying NOT NULL,
    filesize bigint NOT NULL,
    content_type character varying,
    digest character varying(40) NOT NULL,
    downloads integer NOT NULL,
    author_id bigint NOT NULL,
    description text
);


--
-- Name: attachment_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attachment_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachment_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attachment_journals_id_seq OWNED BY public.attachment_journals.id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attachments (
    id bigint NOT NULL,
    container_id bigint,
    container_type character varying(30),
    filename character varying DEFAULT ''::character varying NOT NULL,
    disk_filename character varying DEFAULT ''::character varying NOT NULL,
    filesize bigint DEFAULT 0 NOT NULL,
    content_type character varying DEFAULT ''::character varying,
    digest character varying(40) DEFAULT ''::character varying NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    author_id bigint NOT NULL,
    created_at timestamp with time zone,
    description character varying,
    file character varying,
    fulltext text,
    fulltext_tsv tsvector,
    file_tsv tsvector,
    updated_at timestamp with time zone,
    status integer DEFAULT 0 NOT NULL
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attachments_id_seq OWNED BY public.attachments.id;


--
-- Name: attribute_help_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attribute_help_texts (
    id bigint NOT NULL,
    help_text text NOT NULL,
    type character varying NOT NULL,
    attribute_name character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: attribute_help_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attribute_help_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attribute_help_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attribute_help_texts_id_seq OWNED BY public.attribute_help_texts.id;


--
-- Name: auth_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_providers (
    id bigint NOT NULL,
    type character varying NOT NULL,
    display_name character varying NOT NULL,
    slug character varying NOT NULL,
    available boolean DEFAULT true NOT NULL,
    limit_self_registration boolean DEFAULT false NOT NULL,
    options jsonb DEFAULT '{}'::jsonb NOT NULL,
    creator_id bigint NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: auth_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_providers_id_seq OWNED BY public.auth_providers.id;


--
-- Name: bcf_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bcf_comments (
    id bigint NOT NULL,
    uuid text,
    journal_id bigint,
    issue_id bigint,
    viewpoint_id bigint,
    reply_to bigint
);


--
-- Name: bcf_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bcf_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bcf_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bcf_comments_id_seq OWNED BY public.bcf_comments.id;


--
-- Name: bcf_issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bcf_issues (
    id bigint NOT NULL,
    uuid text,
    markup xml,
    work_package_id bigint,
    stage character varying,
    index integer,
    labels text[] DEFAULT '{}'::text[],
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: bcf_issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bcf_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bcf_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bcf_issues_id_seq OWNED BY public.bcf_issues.id;


--
-- Name: bcf_viewpoints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bcf_viewpoints (
    id bigint NOT NULL,
    uuid text,
    viewpoint_name text,
    issue_id bigint,
    json_viewpoint jsonb,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: bcf_viewpoints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bcf_viewpoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bcf_viewpoints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bcf_viewpoints_id_seq OWNED BY public.bcf_viewpoints.id;


--
-- Name: budget_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budget_journals (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    author_id bigint NOT NULL,
    subject character varying NOT NULL,
    description text,
    fixed_date date NOT NULL
);


--
-- Name: budget_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.budget_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budget_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.budget_journals_id_seq OWNED BY public.budget_journals.id;


--
-- Name: budgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budgets (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    author_id bigint NOT NULL,
    subject character varying NOT NULL,
    description text NOT NULL,
    fixed_date date NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: budgets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.budgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.budgets_id_seq OWNED BY public.budgets.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    assigned_to_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.changes (
    id bigint NOT NULL,
    changeset_id bigint NOT NULL,
    action character varying(1) DEFAULT ''::character varying NOT NULL,
    path text NOT NULL,
    from_path text,
    from_revision character varying,
    revision character varying,
    branch character varying
);


--
-- Name: changes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.changes_id_seq OWNED BY public.changes.id;


--
-- Name: changeset_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.changeset_journals (
    id bigint NOT NULL,
    repository_id bigint NOT NULL,
    revision character varying NOT NULL,
    committer character varying,
    committed_on timestamp with time zone NOT NULL,
    comments text,
    commit_date date,
    scmid character varying,
    user_id bigint
);


--
-- Name: changeset_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.changeset_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: changeset_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.changeset_journals_id_seq OWNED BY public.changeset_journals.id;


--
-- Name: changesets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.changesets (
    id bigint NOT NULL,
    repository_id bigint NOT NULL,
    revision character varying NOT NULL,
    committer character varying,
    committed_on timestamp with time zone NOT NULL,
    comments text,
    commit_date date,
    scmid character varying,
    user_id bigint
);


--
-- Name: changesets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.changesets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: changesets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.changesets_id_seq OWNED BY public.changesets.id;


--
-- Name: changesets_work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.changesets_work_packages (
    changeset_id bigint NOT NULL,
    work_package_id bigint NOT NULL
);


--
-- Name: colors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colors (
    id bigint NOT NULL,
    name character varying NOT NULL,
    hexcode character varying NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.colors_id_seq OWNED BY public.colors.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    commented_type character varying(30) DEFAULT ''::character varying NOT NULL,
    commented_id bigint NOT NULL,
    author_id bigint NOT NULL,
    comments text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: cost_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cost_entries (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    work_package_id bigint NOT NULL,
    cost_type_id bigint NOT NULL,
    units double precision NOT NULL,
    spent_on date NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    comments character varying NOT NULL,
    blocked boolean DEFAULT false NOT NULL,
    overridden_costs numeric(15,4),
    costs numeric(15,4),
    rate_id bigint,
    tyear integer NOT NULL,
    tmonth integer NOT NULL,
    tweek integer NOT NULL,
    logged_by_id bigint
);


--
-- Name: cost_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cost_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cost_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cost_entries_id_seq OWNED BY public.cost_entries.id;


--
-- Name: cost_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cost_queries (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint,
    name character varying NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    serialized character varying(2000) NOT NULL
);


--
-- Name: cost_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cost_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cost_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cost_queries_id_seq OWNED BY public.cost_queries.id;


--
-- Name: cost_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cost_types (
    id bigint NOT NULL,
    name character varying NOT NULL,
    unit character varying NOT NULL,
    unit_plural character varying NOT NULL,
    "default" boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: cost_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cost_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cost_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cost_types_id_seq OWNED BY public.cost_types.id;


--
-- Name: custom_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_actions (
    id bigint NOT NULL,
    name character varying,
    actions text,
    description text,
    "position" integer
);


--
-- Name: custom_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_actions_id_seq OWNED BY public.custom_actions.id;


--
-- Name: custom_actions_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_actions_projects (
    id bigint NOT NULL,
    project_id bigint,
    custom_action_id bigint
);


--
-- Name: custom_actions_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_actions_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_actions_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_actions_projects_id_seq OWNED BY public.custom_actions_projects.id;


--
-- Name: custom_actions_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_actions_roles (
    id bigint NOT NULL,
    role_id bigint,
    custom_action_id bigint
);


--
-- Name: custom_actions_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_actions_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_actions_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_actions_roles_id_seq OWNED BY public.custom_actions_roles.id;


--
-- Name: custom_actions_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_actions_statuses (
    id bigint NOT NULL,
    status_id bigint,
    custom_action_id bigint
);


--
-- Name: custom_actions_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_actions_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_actions_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_actions_statuses_id_seq OWNED BY public.custom_actions_statuses.id;


--
-- Name: custom_actions_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_actions_types (
    id bigint NOT NULL,
    type_id bigint,
    custom_action_id bigint
);


--
-- Name: custom_actions_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_actions_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_actions_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_actions_types_id_seq OWNED BY public.custom_actions_types.id;


--
-- Name: custom_field_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_field_sections (
    id bigint NOT NULL,
    "position" integer,
    name character varying,
    type character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: custom_field_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_field_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_field_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_field_sections_id_seq OWNED BY public.custom_field_sections.id;


--
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_fields (
    id bigint NOT NULL,
    type character varying(30) DEFAULT ''::character varying NOT NULL,
    field_format character varying(30) DEFAULT ''::character varying NOT NULL,
    regexp character varying DEFAULT ''::character varying,
    min_length integer DEFAULT 0 NOT NULL,
    max_length integer DEFAULT 0 NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    is_for_all boolean DEFAULT false NOT NULL,
    is_filter boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 1,
    searchable boolean DEFAULT false,
    editable boolean DEFAULT true,
    admin_only boolean DEFAULT false NOT NULL,
    multi_value boolean DEFAULT false,
    default_value text,
    name character varying DEFAULT NULL::character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    content_right_to_left boolean DEFAULT false,
    allow_non_open_versions boolean DEFAULT false,
    custom_field_section_id bigint,
    position_in_custom_field_section integer
);


--
-- Name: custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_fields_id_seq OWNED BY public.custom_fields.id;


--
-- Name: custom_fields_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_fields_projects (
    custom_field_id bigint NOT NULL,
    project_id bigint NOT NULL,
    id bigint NOT NULL
);


--
-- Name: custom_fields_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_fields_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_fields_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_fields_projects_id_seq OWNED BY public.custom_fields_projects.id;


--
-- Name: custom_fields_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_fields_types (
    custom_field_id bigint NOT NULL,
    type_id bigint NOT NULL
);


--
-- Name: custom_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_options (
    id bigint NOT NULL,
    custom_field_id bigint,
    "position" integer,
    default_value boolean,
    value text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: custom_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_options_id_seq OWNED BY public.custom_options.id;


--
-- Name: custom_styles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_styles (
    id bigint NOT NULL,
    logo character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    favicon character varying,
    touch_icon character varying,
    theme character varying DEFAULT 'OpenProject (default)'::character varying,
    theme_logo character varying,
    export_logo character varying,
    export_cover character varying,
    export_cover_text_color character varying
);


--
-- Name: custom_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_styles_id_seq OWNED BY public.custom_styles.id;


--
-- Name: custom_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_values (
    id bigint NOT NULL,
    customized_type character varying(30) DEFAULT ''::character varying NOT NULL,
    customized_id bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    value text
);


--
-- Name: custom_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_values_id_seq OWNED BY public.custom_values.id;


--
-- Name: customizable_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customizable_journals (
    id bigint NOT NULL,
    journal_id bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    value text
);


--
-- Name: customizable_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customizable_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customizable_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customizable_journals_id_seq OWNED BY public.customizable_journals.id;


--
-- Name: deploy_status_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deploy_status_checks (
    id bigint NOT NULL,
    deploy_target_id bigint,
    github_pull_request_id bigint,
    core_sha text NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: deploy_status_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deploy_status_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deploy_status_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deploy_status_checks_id_seq OWNED BY public.deploy_status_checks.id;


--
-- Name: deploy_targets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deploy_targets (
    id bigint NOT NULL,
    type text NOT NULL,
    host text NOT NULL,
    options jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: deploy_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deploy_targets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deploy_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deploy_targets_id_seq OWNED BY public.deploy_targets.id;


--
-- Name: design_colors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.design_colors (
    id bigint NOT NULL,
    variable character varying,
    hexcode character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: design_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.design_colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: design_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.design_colors_id_seq OWNED BY public.design_colors.id;


--
-- Name: document_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_journals (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    category_id bigint NOT NULL,
    title character varying(60) NOT NULL,
    description text
);


--
-- Name: document_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_journals_id_seq OWNED BY public.document_journals.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    category_id bigint NOT NULL,
    title character varying(60) DEFAULT ''::character varying NOT NULL,
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: done_statuses_for_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.done_statuses_for_project (
    project_id bigint,
    status_id bigint
);


--
-- Name: emoji_reactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.emoji_reactions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    reactable_type character varying NOT NULL,
    reactable_id bigint NOT NULL,
    reaction character varying NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: emoji_reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emoji_reactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emoji_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emoji_reactions_id_seq OWNED BY public.emoji_reactions.id;


--
-- Name: enabled_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enabled_modules (
    id bigint NOT NULL,
    project_id bigint,
    name character varying NOT NULL
);


--
-- Name: enabled_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enabled_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enabled_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enabled_modules_id_seq OWNED BY public.enabled_modules.id;


--
-- Name: enterprise_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprise_tokens (
    id bigint NOT NULL,
    encoded_token text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprise_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprise_tokens_id_seq OWNED BY public.enterprise_tokens.id;


--
-- Name: enumerations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enumerations (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    "position" integer DEFAULT 1,
    is_default boolean DEFAULT false NOT NULL,
    type character varying,
    active boolean DEFAULT true NOT NULL,
    project_id bigint,
    parent_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    color_id bigint
);


--
-- Name: enumerations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enumerations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enumerations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enumerations_id_seq OWNED BY public.enumerations.id;


--
-- Name: exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exports (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    type character varying
);


--
-- Name: exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exports_id_seq OWNED BY public.exports.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    favored_type character varying NOT NULL,
    favored_id bigint NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: file_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_links (
    id bigint NOT NULL,
    storage_id bigint,
    creator_id bigint NOT NULL,
    container_id bigint,
    container_type character varying,
    origin_id character varying,
    origin_name character varying,
    origin_created_by_name character varying,
    origin_last_modified_by_name character varying,
    origin_mime_type character varying,
    origin_created_at timestamp with time zone,
    origin_updated_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: file_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_links_id_seq OWNED BY public.file_links.id;


--
-- Name: forums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forums (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description character varying,
    "position" integer DEFAULT 1,
    topics_count integer DEFAULT 0 NOT NULL,
    messages_count integer DEFAULT 0 NOT NULL,
    last_message_id bigint
);


--
-- Name: forums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forums_id_seq OWNED BY public.forums.id;


--
-- Name: github_check_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.github_check_runs (
    id bigint NOT NULL,
    github_pull_request_id bigint NOT NULL,
    github_id bigint NOT NULL,
    github_html_url character varying NOT NULL,
    app_id bigint NOT NULL,
    github_app_owner_avatar_url character varying NOT NULL,
    status character varying NOT NULL,
    name character varying NOT NULL,
    conclusion character varying,
    output_title character varying,
    output_summary character varying,
    details_url character varying,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: github_check_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.github_check_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: github_check_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.github_check_runs_id_seq OWNED BY public.github_check_runs.id;


--
-- Name: github_pull_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.github_pull_requests (
    id bigint NOT NULL,
    github_user_id bigint,
    merged_by_id bigint,
    github_id bigint,
    number integer NOT NULL,
    github_html_url character varying NOT NULL,
    state character varying NOT NULL,
    repository character varying NOT NULL,
    github_updated_at timestamp with time zone,
    title character varying,
    body text,
    draft boolean,
    merged boolean,
    merged_at timestamp with time zone,
    comments_count integer,
    review_comments_count integer,
    additions_count integer,
    deletions_count integer,
    changed_files_count integer,
    labels json,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    repository_html_url character varying,
    merge_commit_sha text
);


--
-- Name: github_pull_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.github_pull_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: github_pull_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.github_pull_requests_id_seq OWNED BY public.github_pull_requests.id;


--
-- Name: github_pull_requests_work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.github_pull_requests_work_packages (
    github_pull_request_id bigint NOT NULL,
    work_package_id bigint NOT NULL
);


--
-- Name: github_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.github_users (
    id bigint NOT NULL,
    github_id bigint NOT NULL,
    github_login character varying NOT NULL,
    github_html_url character varying NOT NULL,
    github_avatar_url character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: github_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.github_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: github_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.github_users_id_seq OWNED BY public.github_users.id;


--
-- Name: gitlab_issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_issues (
    id bigint NOT NULL,
    gitlab_user_id bigint,
    gitlab_id bigint,
    number integer NOT NULL,
    gitlab_html_url character varying NOT NULL,
    state character varying NOT NULL,
    repository character varying NOT NULL,
    gitlab_updated_at timestamp(6) with time zone,
    title character varying,
    body text,
    labels json,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: gitlab_issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gitlab_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gitlab_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gitlab_issues_id_seq OWNED BY public.gitlab_issues.id;


--
-- Name: gitlab_issues_work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_issues_work_packages (
    gitlab_issue_id bigint NOT NULL,
    work_package_id bigint NOT NULL
);


--
-- Name: gitlab_merge_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_merge_requests (
    id bigint NOT NULL,
    gitlab_user_id bigint,
    merged_by_id bigint,
    gitlab_id bigint,
    number integer NOT NULL,
    gitlab_html_url character varying NOT NULL,
    state character varying NOT NULL,
    repository character varying NOT NULL,
    gitlab_updated_at timestamp with time zone,
    title character varying,
    body text,
    draft boolean,
    merged boolean,
    merged_at timestamp with time zone,
    labels json,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: gitlab_merge_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gitlab_merge_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gitlab_merge_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gitlab_merge_requests_id_seq OWNED BY public.gitlab_merge_requests.id;


--
-- Name: gitlab_merge_requests_work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_merge_requests_work_packages (
    gitlab_merge_request_id bigint NOT NULL,
    work_package_id bigint NOT NULL
);


--
-- Name: gitlab_pipelines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_pipelines (
    id bigint NOT NULL,
    gitlab_merge_request_id bigint NOT NULL,
    gitlab_id bigint NOT NULL,
    gitlab_html_url character varying NOT NULL,
    project_id bigint NOT NULL,
    gitlab_user_avatar_url character varying NOT NULL,
    status character varying NOT NULL,
    name character varying NOT NULL,
    details_url character varying,
    ci_details json,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    username text,
    commit_id text
);


--
-- Name: gitlab_pipelines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gitlab_pipelines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gitlab_pipelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gitlab_pipelines_id_seq OWNED BY public.gitlab_pipelines.id;


--
-- Name: gitlab_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gitlab_users (
    id bigint NOT NULL,
    gitlab_id bigint NOT NULL,
    gitlab_name character varying NOT NULL,
    gitlab_username character varying NOT NULL,
    gitlab_email character varying NOT NULL,
    gitlab_avatar_url character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: gitlab_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gitlab_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gitlab_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gitlab_users_id_seq OWNED BY public.gitlab_users.id;


--
-- Name: good_job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_batches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    description text,
    serialized_properties jsonb,
    on_finish text,
    on_success text,
    on_discard text,
    callback_queue_name text,
    callback_priority integer,
    enqueued_at timestamp(6) with time zone,
    discarded_at timestamp(6) with time zone,
    finished_at timestamp(6) with time zone
);


--
-- Name: good_job_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_executions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    active_job_id uuid NOT NULL,
    job_class text,
    queue_name text,
    serialized_params jsonb,
    scheduled_at timestamp(6) with time zone,
    finished_at timestamp(6) with time zone,
    error text,
    error_event smallint
);


--
-- Name: good_job_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_processes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    state jsonb
);


--
-- Name: good_job_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    key text,
    value jsonb
);


--
-- Name: good_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    queue_name text,
    priority integer,
    serialized_params jsonb,
    scheduled_at timestamp(6) with time zone,
    performed_at timestamp(6) with time zone,
    finished_at timestamp(6) with time zone,
    error text,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    active_job_id uuid,
    concurrency_key text,
    cron_key text,
    retried_good_job_id uuid,
    cron_at timestamp(6) with time zone,
    batch_id uuid,
    batch_callback_id uuid,
    is_discrete boolean,
    executions_count integer,
    job_class text,
    error_event smallint,
    labels text[]
);


--
-- Name: grid_widgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grid_widgets (
    id bigint NOT NULL,
    start_row integer NOT NULL,
    end_row integer NOT NULL,
    start_column integer NOT NULL,
    end_column integer NOT NULL,
    identifier character varying,
    options text,
    grid_id bigint
);


--
-- Name: grid_widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grid_widgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grid_widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grid_widgets_id_seq OWNED BY public.grid_widgets.id;


--
-- Name: grids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grids (
    id bigint NOT NULL,
    row_count integer NOT NULL,
    column_count integer NOT NULL,
    type character varying,
    user_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_id bigint,
    name text,
    options text
);


--
-- Name: grids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grids_id_seq OWNED BY public.grids.id;


--
-- Name: group_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_users (
    group_id bigint NOT NULL,
    user_id bigint NOT NULL,
    id bigint NOT NULL
);


--
-- Name: group_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_users_id_seq OWNED BY public.group_users.id;


--
-- Name: hierarchical_item_hierarchies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hierarchical_item_hierarchies (
    ancestor_id integer NOT NULL,
    descendant_id integer NOT NULL,
    generations integer NOT NULL
);


--
-- Name: hierarchical_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hierarchical_items (
    id bigint NOT NULL,
    parent_id integer,
    sort_order integer,
    label character varying,
    short character varying,
    is_deleted boolean DEFAULT false NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    custom_field_id bigint
);


--
-- Name: hierarchical_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hierarchical_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hierarchical_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hierarchical_items_id_seq OWNED BY public.hierarchical_items.id;


--
-- Name: ical_token_query_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ical_token_query_assignments (
    id bigint NOT NULL,
    ical_token_id bigint,
    query_id bigint,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    name character varying NOT NULL
);


--
-- Name: ical_token_query_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ical_token_query_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ical_token_query_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ical_token_query_assignments_id_seq OWNED BY public.ical_token_query_assignments.id;


--
-- Name: ifc_models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ifc_models (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_id bigint,
    uploader_id bigint,
    is_default boolean DEFAULT false NOT NULL,
    conversion_status integer DEFAULT 0,
    conversion_error_message text
);


--
-- Name: ifc_models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ifc_models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ifc_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ifc_models_id_seq OWNED BY public.ifc_models.id;


--
-- Name: job_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_statuses (
    id bigint NOT NULL,
    reference_type character varying,
    reference_id bigint,
    message character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying DEFAULT 'in_queue'::character varying,
    user_id bigint,
    job_id character varying,
    payload jsonb,
    CONSTRAINT delayed_job_statuses_status_check CHECK (((status IS NULL) OR ((status)::text = ANY ((ARRAY['in_queue'::character varying, 'error'::character varying, 'in_process'::character varying, 'success'::character varying, 'failure'::character varying, 'cancelled'::character varying])::text[]))))
);


--
-- Name: job_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_statuses_id_seq OWNED BY public.job_statuses.id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journals (
    id bigint NOT NULL,
    journable_type character varying,
    journable_id bigint,
    user_id bigint NOT NULL,
    notes text,
    created_at timestamp with time zone NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_type character varying NOT NULL,
    data_id bigint NOT NULL,
    cause jsonb DEFAULT '{}'::jsonb,
    validity_period tstzrange,
    CONSTRAINT journals_validity_period_not_empty CHECK (((NOT isempty(validity_period)) AND (validity_period IS NOT NULL)))
);


--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journals_id_seq OWNED BY public.journals.id;


--
-- Name: labor_budget_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.labor_budget_items (
    id bigint NOT NULL,
    budget_id bigint NOT NULL,
    hours double precision NOT NULL,
    user_id bigint,
    comments character varying DEFAULT ''::character varying NOT NULL,
    amount numeric(15,4)
);


--
-- Name: labor_budget_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.labor_budget_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labor_budget_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.labor_budget_items_id_seq OWNED BY public.labor_budget_items.id;


--
-- Name: last_project_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.last_project_folders (
    id bigint NOT NULL,
    project_storage_id bigint NOT NULL,
    origin_folder_id character varying,
    mode character varying DEFAULT 'inactive'::character varying NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    CONSTRAINT last_project_folders_mode_check CHECK (((mode)::text = ANY ((ARRAY['inactive'::character varying, 'manual'::character varying, 'automatic'::character varying])::text[])))
);


--
-- Name: TABLE last_project_folders; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.last_project_folders IS 'This table contains the last used project folder IDs for a project storage per mode.';


--
-- Name: last_project_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.last_project_folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: last_project_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.last_project_folders_id_seq OWNED BY public.last_project_folders.id;


--
-- Name: ldap_auth_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ldap_auth_sources (
    id bigint NOT NULL,
    name character varying(60) DEFAULT ''::character varying NOT NULL,
    host character varying(60),
    port integer,
    account character varying,
    account_password character varying DEFAULT ''::character varying,
    base_dn character varying,
    attr_login character varying(30),
    attr_firstname character varying(30),
    attr_lastname character varying(30),
    attr_mail character varying(30),
    onthefly_register boolean DEFAULT false NOT NULL,
    attr_admin character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    tls_mode integer DEFAULT 0 NOT NULL,
    filter_string text,
    verify_peer boolean DEFAULT true NOT NULL,
    tls_certificate_string text
);


--
-- Name: ldap_auth_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ldap_auth_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ldap_auth_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ldap_auth_sources_id_seq OWNED BY public.ldap_auth_sources.id;


--
-- Name: ldap_groups_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ldap_groups_memberships (
    id bigint NOT NULL,
    user_id bigint,
    group_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ldap_groups_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ldap_groups_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ldap_groups_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ldap_groups_memberships_id_seq OWNED BY public.ldap_groups_memberships.id;


--
-- Name: ldap_groups_synchronized_filters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ldap_groups_synchronized_filters (
    id bigint NOT NULL,
    name character varying,
    group_name_attribute character varying,
    filter_string character varying,
    ldap_auth_source_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    base_dn text,
    sync_users boolean DEFAULT false NOT NULL
);


--
-- Name: ldap_groups_synchronized_filters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ldap_groups_synchronized_filters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ldap_groups_synchronized_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ldap_groups_synchronized_filters_id_seq OWNED BY public.ldap_groups_synchronized_filters.id;


--
-- Name: ldap_groups_synchronized_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ldap_groups_synchronized_groups (
    id bigint NOT NULL,
    group_id bigint,
    ldap_auth_source_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dn text,
    users_count integer DEFAULT 0 NOT NULL,
    filter_id bigint,
    sync_users boolean DEFAULT false NOT NULL
);


--
-- Name: ldap_groups_synchronized_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ldap_groups_synchronized_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ldap_groups_synchronized_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ldap_groups_synchronized_groups_id_seq OWNED BY public.ldap_groups_synchronized_groups.id;


--
-- Name: material_budget_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.material_budget_items (
    id bigint NOT NULL,
    budget_id bigint NOT NULL,
    units double precision NOT NULL,
    cost_type_id bigint,
    comments character varying DEFAULT ''::character varying NOT NULL,
    amount numeric(15,4)
);


--
-- Name: material_budget_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.material_budget_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: material_budget_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.material_budget_items_id_seq OWNED BY public.material_budget_items.id;


--
-- Name: meeting_agenda_item_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_agenda_item_journals (
    id bigint NOT NULL,
    journal_id integer,
    agenda_item_id integer,
    author_id integer,
    title character varying,
    notes text,
    "position" integer,
    duration_in_minutes integer,
    start_time timestamp(6) with time zone,
    end_time timestamp(6) with time zone,
    work_package_id integer,
    item_type smallint,
    presenter_id bigint
);


--
-- Name: meeting_agenda_item_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_agenda_item_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_agenda_item_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_agenda_item_journals_id_seq OWNED BY public.meeting_agenda_item_journals.id;


--
-- Name: meeting_agenda_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_agenda_items (
    id bigint NOT NULL,
    meeting_id bigint,
    author_id bigint,
    title character varying,
    notes text,
    "position" integer,
    duration_in_minutes integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    work_package_id bigint,
    item_type smallint DEFAULT 0,
    lock_version integer DEFAULT 0 NOT NULL,
    presenter_id bigint,
    meeting_section_id bigint
);


--
-- Name: meeting_agenda_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_agenda_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_agenda_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_agenda_items_id_seq OWNED BY public.meeting_agenda_items.id;


--
-- Name: meeting_content_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_content_journals (
    id bigint NOT NULL,
    meeting_id bigint,
    author_id bigint,
    text text,
    locked boolean
);


--
-- Name: meeting_content_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_content_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_content_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_content_journals_id_seq OWNED BY public.meeting_content_journals.id;


--
-- Name: meeting_contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_contents (
    id bigint NOT NULL,
    type character varying,
    meeting_id bigint,
    author_id bigint,
    text text,
    lock_version integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    locked boolean DEFAULT false
);


--
-- Name: meeting_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_contents_id_seq OWNED BY public.meeting_contents.id;


--
-- Name: meeting_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_journals (
    id bigint NOT NULL,
    title character varying,
    author_id bigint,
    project_id bigint,
    location character varying,
    start_time timestamp with time zone,
    duration double precision,
    state integer DEFAULT 0 NOT NULL
);


--
-- Name: meeting_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_journals_id_seq OWNED BY public.meeting_journals.id;


--
-- Name: meeting_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_participants (
    id bigint NOT NULL,
    user_id bigint,
    meeting_id bigint,
    email character varying,
    name character varying,
    invited boolean,
    attended boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: meeting_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_participants_id_seq OWNED BY public.meeting_participants.id;


--
-- Name: meeting_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_sections (
    id bigint NOT NULL,
    "position" integer,
    title character varying,
    meeting_id bigint NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: meeting_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_sections_id_seq OWNED BY public.meeting_sections.id;


--
-- Name: meetings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meetings (
    id bigint NOT NULL,
    title character varying,
    author_id bigint,
    project_id bigint,
    location character varying,
    start_time timestamp with time zone,
    duration double precision,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    state integer DEFAULT 0 NOT NULL,
    type character varying DEFAULT 'Meeting'::character varying NOT NULL,
    lock_version integer DEFAULT 0 NOT NULL
);


--
-- Name: meetings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meetings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meetings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meetings_id_seq OWNED BY public.meetings.id;


--
-- Name: member_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member_roles (
    id bigint NOT NULL,
    member_id bigint NOT NULL,
    role_id bigint NOT NULL,
    inherited_from bigint
);


--
-- Name: member_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.member_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: member_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.member_roles_id_seq OWNED BY public.member_roles.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.members (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    entity_type character varying,
    entity_id bigint
);


--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.members_id_seq OWNED BY public.members.id;


--
-- Name: menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu_items (
    id bigint NOT NULL,
    name character varying,
    title character varying,
    parent_id bigint,
    options text,
    navigatable_id bigint,
    type character varying
);


--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menu_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


--
-- Name: message_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_journals (
    id bigint NOT NULL,
    forum_id bigint NOT NULL,
    parent_id bigint,
    subject character varying NOT NULL,
    content text,
    author_id bigint,
    locked boolean,
    sticky integer
);


--
-- Name: message_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_journals_id_seq OWNED BY public.message_journals.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    forum_id bigint NOT NULL,
    parent_id bigint,
    subject character varying DEFAULT ''::character varying NOT NULL,
    content text,
    author_id bigint,
    replies_count integer DEFAULT 0 NOT NULL,
    last_reply_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    locked boolean DEFAULT false,
    sticky integer DEFAULT 0,
    sticked_on timestamp with time zone
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news (
    id bigint NOT NULL,
    project_id bigint,
    title character varying DEFAULT ''::character varying NOT NULL,
    summary character varying DEFAULT ''::character varying,
    description text,
    author_id bigint NOT NULL,
    created_at timestamp with time zone,
    comments_count integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone
);


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: news_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news_journals (
    id bigint NOT NULL,
    project_id bigint,
    title character varying NOT NULL,
    summary character varying,
    description text,
    author_id bigint NOT NULL,
    comments_count integer NOT NULL
);


--
-- Name: news_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.news_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.news_journals_id_seq OWNED BY public.news_journals.id;


--
-- Name: non_working_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.non_working_days (
    id bigint NOT NULL,
    name character varying NOT NULL,
    date date NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: non_working_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.non_working_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: non_working_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.non_working_days_id_seq OWNED BY public.non_working_days.id;


--
-- Name: notification_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_settings (
    id bigint NOT NULL,
    project_id bigint,
    user_id bigint NOT NULL,
    watched boolean DEFAULT true,
    mentioned boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    work_package_commented boolean DEFAULT false,
    work_package_created boolean DEFAULT false,
    work_package_processed boolean DEFAULT false,
    work_package_prioritized boolean DEFAULT false,
    work_package_scheduled boolean DEFAULT false,
    news_added boolean DEFAULT false,
    news_commented boolean DEFAULT false,
    document_added boolean DEFAULT false,
    forum_messages boolean DEFAULT false,
    wiki_page_added boolean DEFAULT false,
    wiki_page_updated boolean DEFAULT false,
    membership_added boolean DEFAULT false,
    membership_updated boolean DEFAULT false,
    start_date integer DEFAULT 1,
    due_date integer DEFAULT 1,
    overdue integer,
    assignee boolean DEFAULT true NOT NULL,
    responsible boolean DEFAULT true NOT NULL,
    shared boolean DEFAULT true NOT NULL
);


--
-- Name: notification_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_settings_id_seq OWNED BY public.notification_settings.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    subject text,
    read_ian boolean DEFAULT false,
    reason smallint,
    recipient_id bigint NOT NULL,
    actor_id bigint,
    resource_type character varying NOT NULL,
    resource_id bigint NOT NULL,
    journal_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    mail_reminder_sent boolean DEFAULT false,
    mail_alert_sent boolean
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_grants (
    id bigint NOT NULL,
    resource_owner_id bigint NOT NULL,
    application_id bigint NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    revoked_at timestamp with time zone,
    scopes character varying,
    code_challenge character varying,
    code_challenge_method character varying
);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_grants_id_seq OWNED BY public.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_tokens (
    id bigint NOT NULL,
    resource_owner_id bigint,
    application_id bigint,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    scopes character varying,
    previous_refresh_token character varying DEFAULT ''::character varying NOT NULL
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_applications (
    id bigint NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    owner_type character varying,
    owner_id bigint,
    client_credentials_user_id bigint,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    confidential boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    integration_type character varying,
    integration_id bigint,
    enabled boolean DEFAULT true NOT NULL,
    builtin boolean DEFAULT false NOT NULL
);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_applications_id_seq OWNED BY public.oauth_applications.id;


--
-- Name: oauth_client_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_client_tokens (
    id bigint NOT NULL,
    oauth_client_id bigint NOT NULL,
    user_id bigint NOT NULL,
    access_token character varying,
    refresh_token character varying,
    token_type character varying,
    expires_in integer,
    scope character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    lock_version integer DEFAULT 0 NOT NULL
);


--
-- Name: oauth_client_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_client_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_client_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_client_tokens_id_seq OWNED BY public.oauth_client_tokens.id;


--
-- Name: oauth_clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_clients (
    id bigint NOT NULL,
    client_id character varying NOT NULL,
    client_secret character varying,
    integration_type character varying NOT NULL,
    integration_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;


--
-- Name: oidc_user_session_links; Type: TABLE; Schema: public; Owner: -
--

CREATE UNLOGGED TABLE public.oidc_user_session_links (
    id bigint NOT NULL,
    oidc_session character varying NOT NULL,
    session_id bigint,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: oidc_user_session_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oidc_user_session_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oidc_user_session_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oidc_user_session_links_id_seq OWNED BY public.oidc_user_session_links.id;


--
-- Name: ordered_work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ordered_work_packages (
    id bigint NOT NULL,
    "position" integer NOT NULL,
    query_id bigint,
    work_package_id bigint
);


--
-- Name: ordered_work_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ordered_work_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ordered_work_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ordered_work_packages_id_seq OWNED BY public.ordered_work_packages.id;


--
-- Name: paper_trail_audits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.paper_trail_audits (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    stack text,
    object jsonb,
    object_changes jsonb,
    created_at timestamp(6) with time zone
);


--
-- Name: paper_trail_audits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.paper_trail_audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: paper_trail_audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.paper_trail_audits_id_seq OWNED BY public.paper_trail_audits.id;


--
-- Name: project_custom_field_project_mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_custom_field_project_mappings (
    id bigint NOT NULL,
    custom_field_id bigint,
    project_id bigint,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: project_custom_field_project_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_custom_field_project_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_custom_field_project_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_custom_field_project_mappings_id_seq OWNED BY public.project_custom_field_project_mappings.id;


--
-- Name: project_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_journals (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    public boolean NOT NULL,
    parent_id bigint,
    identifier character varying NOT NULL,
    active boolean NOT NULL,
    templated boolean NOT NULL,
    status_code integer,
    status_explanation text
);


--
-- Name: project_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_journals_id_seq OWNED BY public.project_journals.id;


--
-- Name: project_life_cycle_step_definitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_life_cycle_step_definitions (
    id bigint NOT NULL,
    type character varying,
    name character varying,
    "position" integer,
    color_id bigint,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: project_life_cycle_step_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_life_cycle_step_definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_life_cycle_step_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_life_cycle_step_definitions_id_seq OWNED BY public.project_life_cycle_step_definitions.id;


--
-- Name: project_life_cycle_steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_life_cycle_steps (
    id bigint NOT NULL,
    type character varying,
    start_date date,
    end_date date,
    active boolean DEFAULT false NOT NULL,
    project_id bigint,
    definition_id bigint,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: project_life_cycle_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_life_cycle_steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_life_cycle_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_life_cycle_steps_id_seq OWNED BY public.project_life_cycle_steps.id;


--
-- Name: project_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_queries (
    id bigint NOT NULL,
    name character varying NOT NULL,
    user_id bigint NOT NULL,
    filters json DEFAULT '[]'::json,
    selects json DEFAULT '[]'::json,
    orders json DEFAULT '[]'::json,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    public boolean DEFAULT false NOT NULL
);


--
-- Name: project_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_queries_id_seq OWNED BY public.project_queries.id;


--
-- Name: project_storages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_storages (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    storage_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_folder_id character varying,
    project_folder_mode character varying NOT NULL,
    CONSTRAINT project_storages_project_folder_mode_check CHECK (((project_folder_mode)::text = ANY ((ARRAY['inactive'::character varying, 'manual'::character varying, 'automatic'::character varying])::text[])))
);


--
-- Name: project_storages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_storages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_storages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_storages_id_seq OWNED BY public.project_storages.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description text,
    public boolean DEFAULT true NOT NULL,
    parent_id bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    identifier character varying NOT NULL,
    lft integer,
    rgt integer,
    active boolean DEFAULT true NOT NULL,
    templated boolean DEFAULT false NOT NULL,
    status_code integer,
    status_explanation text,
    settings jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: projects_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects_types (
    project_id bigint NOT NULL,
    type_id bigint NOT NULL
);


--
-- Name: queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queries (
    id bigint NOT NULL,
    project_id bigint,
    name character varying NOT NULL,
    filters text,
    user_id bigint NOT NULL,
    public boolean DEFAULT false NOT NULL,
    column_names text,
    sort_criteria text,
    group_by character varying,
    display_sums boolean DEFAULT false NOT NULL,
    timeline_visible boolean DEFAULT false,
    show_hierarchies boolean DEFAULT false,
    timeline_zoom_level integer DEFAULT 5,
    timeline_labels text,
    highlighting_mode text,
    highlighted_attributes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    display_representation text,
    starred boolean DEFAULT false,
    include_subprojects boolean NOT NULL,
    timestamps character varying
);


--
-- Name: queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.queries_id_seq OWNED BY public.queries.id;


--
-- Name: rates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rates (
    id bigint NOT NULL,
    valid_from date NOT NULL,
    rate numeric(15,4) NOT NULL,
    type character varying NOT NULL,
    project_id bigint,
    user_id bigint,
    cost_type_id bigint
);


--
-- Name: rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rates_id_seq OWNED BY public.rates.id;


--
-- Name: recaptcha_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recaptcha_entries (
    id integer NOT NULL,
    user_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    version integer NOT NULL
);


--
-- Name: recaptcha_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recaptcha_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recaptcha_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recaptcha_entries_id_seq OWNED BY public.recaptcha_entries.id;


--
-- Name: relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relations (
    id bigint NOT NULL,
    from_id integer NOT NULL,
    to_id integer NOT NULL,
    lag integer,
    description text,
    relation_type character varying
);


--
-- Name: relations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.relations_id_seq OWNED BY public.relations.id;


--
-- Name: remote_identities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.remote_identities (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    oauth_client_id bigint NOT NULL,
    origin_user_id character varying NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: remote_identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.remote_identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: remote_identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.remote_identities_id_seq OWNED BY public.remote_identities.id;


--
-- Name: repositories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.repositories (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    url character varying DEFAULT ''::character varying NOT NULL,
    login character varying(60) DEFAULT ''::character varying,
    password character varying DEFAULT ''::character varying,
    root_url character varying DEFAULT ''::character varying,
    type character varying,
    path_encoding character varying(64),
    log_encoding character varying(64),
    scm_type character varying NOT NULL,
    required_storage_bytes bigint DEFAULT 0 NOT NULL,
    storage_updated_at timestamp with time zone
);


--
-- Name: repositories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.repositories_id_seq OWNED BY public.repositories.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    permission character varying,
    role_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    "position" integer DEFAULT 1,
    builtin integer DEFAULT 0 NOT NULL,
    type character varying(30) DEFAULT 'Role'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE UNLOGGED TABLE public.sessions (
    id bigint NOT NULL,
    session_id character varying NOT NULL,
    data text,
    updated_at timestamp with time zone,
    user_id bigint
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    value text,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statuses (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    is_closed boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 1,
    default_done_ratio integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    color_id bigint,
    is_readonly boolean DEFAULT false,
    excluded_from_totals boolean DEFAULT false NOT NULL
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: storages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.storages (
    id bigint NOT NULL,
    provider_type character varying NOT NULL,
    name character varying NOT NULL,
    host character varying,
    creator_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    provider_fields jsonb DEFAULT '{}'::jsonb NOT NULL,
    health_status character varying DEFAULT 'pending'::character varying NOT NULL,
    health_changed_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    health_reason character varying,
    health_checked_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT storages_health_status_check CHECK (((health_status)::text = ANY ((ARRAY['pending'::character varying, 'healthy'::character varying, 'unhealthy'::character varying])::text[])))
);


--
-- Name: storages_file_links_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.storages_file_links_journals (
    id bigint NOT NULL,
    journal_id bigint NOT NULL,
    file_link_id bigint NOT NULL,
    link_name character varying NOT NULL,
    storage_name character varying
);


--
-- Name: storages_file_links_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.storages_file_links_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storages_file_links_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.storages_file_links_journals_id_seq OWNED BY public.storages_file_links_journals.id;


--
-- Name: storages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.storages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.storages_id_seq OWNED BY public.storages.id;


--
-- Name: time_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_entries (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    user_id bigint NOT NULL,
    work_package_id bigint,
    hours double precision,
    comments character varying,
    activity_id bigint,
    spent_on date NOT NULL,
    tyear integer NOT NULL,
    tmonth integer NOT NULL,
    tweek integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    overridden_costs numeric(15,4),
    costs numeric(15,4),
    rate_id bigint,
    logged_by_id bigint NOT NULL,
    ongoing boolean DEFAULT false NOT NULL,
    start_time integer,
    time_zone character varying
);


--
-- Name: time_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.time_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.time_entries_id_seq OWNED BY public.time_entries.id;


--
-- Name: time_entry_activities_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_entry_activities_projects (
    id bigint NOT NULL,
    activity_id bigint NOT NULL,
    project_id bigint NOT NULL,
    active boolean DEFAULT true
);


--
-- Name: time_entry_activities_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.time_entry_activities_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_entry_activities_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.time_entry_activities_projects_id_seq OWNED BY public.time_entry_activities_projects.id;


--
-- Name: time_entry_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_entry_journals (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    user_id bigint NOT NULL,
    work_package_id bigint,
    hours double precision,
    comments character varying,
    activity_id bigint,
    spent_on date NOT NULL,
    tyear integer NOT NULL,
    tmonth integer NOT NULL,
    tweek integer NOT NULL,
    overridden_costs numeric(15,2),
    costs numeric(15,2),
    rate_id bigint,
    logged_by_id bigint NOT NULL,
    start_time integer,
    time_zone character varying
);


--
-- Name: time_entry_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.time_entry_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_entry_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.time_entry_journals_id_seq OWNED BY public.time_entry_journals.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tokens (
    id bigint NOT NULL,
    user_id bigint,
    type character varying,
    value character varying(128) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_on timestamp with time zone,
    data json
);


--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: two_factor_authentication_devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.two_factor_authentication_devices (
    id bigint NOT NULL,
    type character varying,
    "default" boolean DEFAULT false NOT NULL,
    active boolean DEFAULT false NOT NULL,
    channel character varying NOT NULL,
    phone_number character varying,
    identifier character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_used_at integer,
    otp_secret text,
    user_id bigint,
    webauthn_external_id character varying,
    webauthn_public_key character varying,
    webauthn_sign_count bigint DEFAULT 0 NOT NULL
);


--
-- Name: two_factor_authentication_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.two_factor_authentication_devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: two_factor_authentication_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.two_factor_authentication_devices_id_seq OWNED BY public.two_factor_authentication_devices.id;


--
-- Name: types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    "position" integer DEFAULT 1,
    is_in_roadmap boolean DEFAULT true NOT NULL,
    is_milestone boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    color_id bigint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_standard boolean DEFAULT false NOT NULL,
    attribute_groups text,
    description text
);


--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;


--
-- Name: user_passwords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_passwords (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    hashed_password character varying(128) NOT NULL,
    salt character varying(64),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    type character varying NOT NULL
);


--
-- Name: user_passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_passwords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_passwords_id_seq OWNED BY public.user_passwords.id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_preferences (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    settings jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) with time zone DEFAULT '2024-12-12 05:11:13.657993+00'::timestamp with time zone NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT '2024-12-12 05:11:13.657993+00'::timestamp with time zone NOT NULL
);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_preferences_id_seq OWNED BY public.user_preferences.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    login character varying(256) DEFAULT ''::character varying NOT NULL,
    firstname character varying DEFAULT ''::character varying NOT NULL,
    lastname character varying DEFAULT ''::character varying NOT NULL,
    mail character varying DEFAULT ''::character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    last_login_on timestamp with time zone,
    language character varying(5) DEFAULT ''::character varying,
    ldap_auth_source_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    type character varying,
    identity_url character varying,
    first_login boolean DEFAULT true NOT NULL,
    force_password_change boolean DEFAULT false,
    failed_login_count integer DEFAULT 0,
    last_failed_login_on timestamp with time zone,
    consented_at timestamp with time zone,
    webauthn_id character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: version_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.version_settings (
    id bigint NOT NULL,
    project_id bigint,
    version_id bigint,
    display integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: version_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.version_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: version_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.version_settings_id_seq OWNED BY public.version_settings.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL COLLATE public.versions_name,
    description character varying DEFAULT ''::character varying,
    effective_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    wiki_page_title character varying,
    status character varying DEFAULT 'open'::character varying,
    sharing character varying DEFAULT 'none'::character varying NOT NULL,
    start_date date
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.views (
    id bigint NOT NULL,
    query_id bigint NOT NULL,
    options jsonb DEFAULT '{}'::jsonb NOT NULL,
    type character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.views_id_seq OWNED BY public.views.id;


--
-- Name: watchers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.watchers (
    id bigint NOT NULL,
    watchable_type character varying DEFAULT ''::character varying NOT NULL,
    watchable_id bigint NOT NULL,
    user_id bigint
);


--
-- Name: watchers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.watchers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: watchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.watchers_id_seq OWNED BY public.watchers.id;


--
-- Name: webhooks_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks_events (
    id bigint NOT NULL,
    name character varying,
    webhooks_webhook_id bigint
);


--
-- Name: webhooks_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhooks_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhooks_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhooks_events_id_seq OWNED BY public.webhooks_events.id;


--
-- Name: webhooks_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks_logs (
    id bigint NOT NULL,
    webhooks_webhook_id bigint,
    event_name character varying,
    url character varying,
    request_headers text,
    request_body text,
    response_code integer,
    response_headers text,
    response_body text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: webhooks_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhooks_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhooks_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhooks_logs_id_seq OWNED BY public.webhooks_logs.id;


--
-- Name: webhooks_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks_projects (
    id bigint NOT NULL,
    project_id bigint,
    webhooks_webhook_id bigint
);


--
-- Name: webhooks_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhooks_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhooks_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhooks_projects_id_seq OWNED BY public.webhooks_projects.id;


--
-- Name: webhooks_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks_webhooks (
    id bigint NOT NULL,
    name character varying,
    url text,
    description text NOT NULL,
    secret character varying,
    enabled boolean NOT NULL,
    all_projects boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhooks_webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhooks_webhooks_id_seq OWNED BY public.webhooks_webhooks.id;


--
-- Name: wiki_page_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_page_journals (
    id bigint NOT NULL,
    author_id bigint,
    text text
);


--
-- Name: wiki_page_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_page_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_page_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_page_journals_id_seq OWNED BY public.wiki_page_journals.id;


--
-- Name: wiki_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_pages (
    id bigint NOT NULL,
    wiki_id bigint NOT NULL,
    title character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    protected boolean DEFAULT false NOT NULL,
    parent_id bigint,
    slug character varying NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    author_id bigint NOT NULL,
    text text,
    lock_version integer NOT NULL
);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_pages_id_seq OWNED BY public.wiki_pages.id;


--
-- Name: wiki_redirects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_redirects (
    id bigint NOT NULL,
    wiki_id bigint NOT NULL,
    title character varying,
    redirects_to character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_redirects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_redirects_id_seq OWNED BY public.wiki_redirects.id;


--
-- Name: wikis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wikis (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    start_page character varying NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: wikis_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wikis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wikis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wikis_id_seq OWNED BY public.wikis.id;


--
-- Name: work_package_hierarchies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.work_package_hierarchies (
    ancestor_id integer NOT NULL,
    descendant_id integer NOT NULL,
    generations integer NOT NULL
);


--
-- Name: work_package_journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.work_package_journals (
    id bigint NOT NULL,
    type_id bigint NOT NULL,
    project_id bigint NOT NULL,
    subject character varying NOT NULL,
    description text,
    due_date date,
    category_id bigint,
    status_id bigint NOT NULL,
    assigned_to_id bigint,
    priority_id bigint NOT NULL,
    version_id bigint,
    author_id bigint NOT NULL,
    done_ratio integer,
    estimated_hours double precision,
    start_date date,
    parent_id bigint,
    responsible_id bigint,
    budget_id bigint,
    story_points integer,
    remaining_hours double precision,
    derived_estimated_hours double precision,
    schedule_manually boolean,
    duration integer,
    ignore_non_working_days boolean NOT NULL,
    derived_remaining_hours double precision,
    derived_done_ratio integer
);


--
-- Name: work_package_journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.work_package_journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_package_journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.work_package_journals_id_seq OWNED BY public.work_package_journals.id;


--
-- Name: work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.work_packages (
    id bigint NOT NULL,
    type_id bigint NOT NULL,
    project_id bigint NOT NULL,
    subject character varying DEFAULT ''::character varying NOT NULL,
    description text,
    due_date date,
    category_id bigint,
    status_id bigint NOT NULL,
    assigned_to_id bigint,
    priority_id bigint,
    version_id bigint,
    author_id bigint NOT NULL,
    lock_version integer DEFAULT 0 NOT NULL,
    done_ratio integer,
    estimated_hours double precision,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    start_date date,
    responsible_id bigint,
    budget_id bigint,
    "position" integer,
    story_points integer,
    remaining_hours double precision,
    derived_estimated_hours double precision,
    schedule_manually boolean DEFAULT false,
    parent_id bigint,
    duration integer,
    ignore_non_working_days boolean DEFAULT false NOT NULL,
    derived_remaining_hours double precision,
    derived_done_ratio integer,
    project_life_cycle_step_id bigint,
    CONSTRAINT work_packages_due_larger_start_date CHECK ((due_date >= start_date))
);


--
-- Name: work_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.work_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.work_packages_id_seq OWNED BY public.work_packages.id;


--
-- Name: workflows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflows (
    id bigint NOT NULL,
    type_id bigint NOT NULL,
    old_status_id bigint NOT NULL,
    new_status_id bigint NOT NULL,
    role_id bigint NOT NULL,
    assignee boolean DEFAULT false NOT NULL,
    author boolean DEFAULT false NOT NULL
);


--
-- Name: workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workflows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workflows_id_seq OWNED BY public.workflows.id;


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: attachable_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachable_journals ALTER COLUMN id SET DEFAULT nextval('public.attachable_journals_id_seq'::regclass);


--
-- Name: attachment_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachment_journals ALTER COLUMN id SET DEFAULT nextval('public.attachment_journals_id_seq'::regclass);


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachments ALTER COLUMN id SET DEFAULT nextval('public.attachments_id_seq'::regclass);


--
-- Name: attribute_help_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attribute_help_texts ALTER COLUMN id SET DEFAULT nextval('public.attribute_help_texts_id_seq'::regclass);


--
-- Name: auth_providers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_providers ALTER COLUMN id SET DEFAULT nextval('public.auth_providers_id_seq'::regclass);


--
-- Name: bcf_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_comments ALTER COLUMN id SET DEFAULT nextval('public.bcf_comments_id_seq'::regclass);


--
-- Name: bcf_issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_issues ALTER COLUMN id SET DEFAULT nextval('public.bcf_issues_id_seq'::regclass);


--
-- Name: bcf_viewpoints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_viewpoints ALTER COLUMN id SET DEFAULT nextval('public.bcf_viewpoints_id_seq'::regclass);


--
-- Name: budget_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budget_journals ALTER COLUMN id SET DEFAULT nextval('public.budget_journals_id_seq'::regclass);


--
-- Name: budgets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgets ALTER COLUMN id SET DEFAULT nextval('public.budgets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: changes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changes ALTER COLUMN id SET DEFAULT nextval('public.changes_id_seq'::regclass);


--
-- Name: changeset_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changeset_journals ALTER COLUMN id SET DEFAULT nextval('public.changeset_journals_id_seq'::regclass);


--
-- Name: changesets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changesets ALTER COLUMN id SET DEFAULT nextval('public.changesets_id_seq'::regclass);


--
-- Name: colors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colors ALTER COLUMN id SET DEFAULT nextval('public.colors_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: cost_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_entries ALTER COLUMN id SET DEFAULT nextval('public.cost_entries_id_seq'::regclass);


--
-- Name: cost_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_queries ALTER COLUMN id SET DEFAULT nextval('public.cost_queries_id_seq'::regclass);


--
-- Name: cost_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_types ALTER COLUMN id SET DEFAULT nextval('public.cost_types_id_seq'::regclass);


--
-- Name: custom_actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions ALTER COLUMN id SET DEFAULT nextval('public.custom_actions_id_seq'::regclass);


--
-- Name: custom_actions_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_projects ALTER COLUMN id SET DEFAULT nextval('public.custom_actions_projects_id_seq'::regclass);


--
-- Name: custom_actions_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_roles ALTER COLUMN id SET DEFAULT nextval('public.custom_actions_roles_id_seq'::regclass);


--
-- Name: custom_actions_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_statuses ALTER COLUMN id SET DEFAULT nextval('public.custom_actions_statuses_id_seq'::regclass);


--
-- Name: custom_actions_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_types ALTER COLUMN id SET DEFAULT nextval('public.custom_actions_types_id_seq'::regclass);


--
-- Name: custom_field_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_sections ALTER COLUMN id SET DEFAULT nextval('public.custom_field_sections_id_seq'::regclass);


--
-- Name: custom_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields ALTER COLUMN id SET DEFAULT nextval('public.custom_fields_id_seq'::regclass);


--
-- Name: custom_fields_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields_projects ALTER COLUMN id SET DEFAULT nextval('public.custom_fields_projects_id_seq'::regclass);


--
-- Name: custom_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_options ALTER COLUMN id SET DEFAULT nextval('public.custom_options_id_seq'::regclass);


--
-- Name: custom_styles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_styles ALTER COLUMN id SET DEFAULT nextval('public.custom_styles_id_seq'::regclass);


--
-- Name: custom_values id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_values ALTER COLUMN id SET DEFAULT nextval('public.custom_values_id_seq'::regclass);


--
-- Name: customizable_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customizable_journals ALTER COLUMN id SET DEFAULT nextval('public.customizable_journals_id_seq'::regclass);


--
-- Name: deploy_status_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploy_status_checks ALTER COLUMN id SET DEFAULT nextval('public.deploy_status_checks_id_seq'::regclass);


--
-- Name: deploy_targets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploy_targets ALTER COLUMN id SET DEFAULT nextval('public.deploy_targets_id_seq'::regclass);


--
-- Name: design_colors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.design_colors ALTER COLUMN id SET DEFAULT nextval('public.design_colors_id_seq'::regclass);


--
-- Name: document_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_journals ALTER COLUMN id SET DEFAULT nextval('public.document_journals_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: emoji_reactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emoji_reactions ALTER COLUMN id SET DEFAULT nextval('public.emoji_reactions_id_seq'::regclass);


--
-- Name: enabled_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enabled_modules ALTER COLUMN id SET DEFAULT nextval('public.enabled_modules_id_seq'::regclass);


--
-- Name: enterprise_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_tokens ALTER COLUMN id SET DEFAULT nextval('public.enterprise_tokens_id_seq'::regclass);


--
-- Name: enumerations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enumerations ALTER COLUMN id SET DEFAULT nextval('public.enumerations_id_seq'::regclass);


--
-- Name: exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exports ALTER COLUMN id SET DEFAULT nextval('public.exports_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: file_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_links ALTER COLUMN id SET DEFAULT nextval('public.file_links_id_seq'::regclass);


--
-- Name: forums id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forums ALTER COLUMN id SET DEFAULT nextval('public.forums_id_seq'::regclass);


--
-- Name: github_check_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_check_runs ALTER COLUMN id SET DEFAULT nextval('public.github_check_runs_id_seq'::regclass);


--
-- Name: github_pull_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_pull_requests ALTER COLUMN id SET DEFAULT nextval('public.github_pull_requests_id_seq'::regclass);


--
-- Name: github_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_users ALTER COLUMN id SET DEFAULT nextval('public.github_users_id_seq'::regclass);


--
-- Name: gitlab_issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_issues ALTER COLUMN id SET DEFAULT nextval('public.gitlab_issues_id_seq'::regclass);


--
-- Name: gitlab_merge_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_merge_requests ALTER COLUMN id SET DEFAULT nextval('public.gitlab_merge_requests_id_seq'::regclass);


--
-- Name: gitlab_pipelines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_pipelines ALTER COLUMN id SET DEFAULT nextval('public.gitlab_pipelines_id_seq'::regclass);


--
-- Name: gitlab_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_users ALTER COLUMN id SET DEFAULT nextval('public.gitlab_users_id_seq'::regclass);


--
-- Name: grid_widgets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grid_widgets ALTER COLUMN id SET DEFAULT nextval('public.grid_widgets_id_seq'::regclass);


--
-- Name: grids id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grids ALTER COLUMN id SET DEFAULT nextval('public.grids_id_seq'::regclass);


--
-- Name: group_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_users ALTER COLUMN id SET DEFAULT nextval('public.group_users_id_seq'::regclass);


--
-- Name: hierarchical_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hierarchical_items ALTER COLUMN id SET DEFAULT nextval('public.hierarchical_items_id_seq'::regclass);


--
-- Name: ical_token_query_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ical_token_query_assignments ALTER COLUMN id SET DEFAULT nextval('public.ical_token_query_assignments_id_seq'::regclass);


--
-- Name: ifc_models id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ifc_models ALTER COLUMN id SET DEFAULT nextval('public.ifc_models_id_seq'::regclass);


--
-- Name: job_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_statuses ALTER COLUMN id SET DEFAULT nextval('public.job_statuses_id_seq'::regclass);


--
-- Name: journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journals ALTER COLUMN id SET DEFAULT nextval('public.journals_id_seq'::regclass);


--
-- Name: labor_budget_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_budget_items ALTER COLUMN id SET DEFAULT nextval('public.labor_budget_items_id_seq'::regclass);


--
-- Name: last_project_folders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.last_project_folders ALTER COLUMN id SET DEFAULT nextval('public.last_project_folders_id_seq'::regclass);


--
-- Name: ldap_auth_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_auth_sources ALTER COLUMN id SET DEFAULT nextval('public.ldap_auth_sources_id_seq'::regclass);


--
-- Name: ldap_groups_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_memberships ALTER COLUMN id SET DEFAULT nextval('public.ldap_groups_memberships_id_seq'::regclass);


--
-- Name: ldap_groups_synchronized_filters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_synchronized_filters ALTER COLUMN id SET DEFAULT nextval('public.ldap_groups_synchronized_filters_id_seq'::regclass);


--
-- Name: ldap_groups_synchronized_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_synchronized_groups ALTER COLUMN id SET DEFAULT nextval('public.ldap_groups_synchronized_groups_id_seq'::regclass);


--
-- Name: material_budget_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.material_budget_items ALTER COLUMN id SET DEFAULT nextval('public.material_budget_items_id_seq'::regclass);


--
-- Name: meeting_agenda_item_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_item_journals ALTER COLUMN id SET DEFAULT nextval('public.meeting_agenda_item_journals_id_seq'::regclass);


--
-- Name: meeting_agenda_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_items ALTER COLUMN id SET DEFAULT nextval('public.meeting_agenda_items_id_seq'::regclass);


--
-- Name: meeting_content_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_content_journals ALTER COLUMN id SET DEFAULT nextval('public.meeting_content_journals_id_seq'::regclass);


--
-- Name: meeting_contents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_contents ALTER COLUMN id SET DEFAULT nextval('public.meeting_contents_id_seq'::regclass);


--
-- Name: meeting_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_journals ALTER COLUMN id SET DEFAULT nextval('public.meeting_journals_id_seq'::regclass);


--
-- Name: meeting_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_participants ALTER COLUMN id SET DEFAULT nextval('public.meeting_participants_id_seq'::regclass);


--
-- Name: meeting_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_sections ALTER COLUMN id SET DEFAULT nextval('public.meeting_sections_id_seq'::regclass);


--
-- Name: meetings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meetings ALTER COLUMN id SET DEFAULT nextval('public.meetings_id_seq'::regclass);


--
-- Name: member_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_roles ALTER COLUMN id SET DEFAULT nextval('public.member_roles_id_seq'::regclass);


--
-- Name: members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members ALTER COLUMN id SET DEFAULT nextval('public.members_id_seq'::regclass);


--
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


--
-- Name: message_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_journals ALTER COLUMN id SET DEFAULT nextval('public.message_journals_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: news_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_journals ALTER COLUMN id SET DEFAULT nextval('public.news_journals_id_seq'::regclass);


--
-- Name: non_working_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.non_working_days ALTER COLUMN id SET DEFAULT nextval('public.non_working_days_id_seq'::regclass);


--
-- Name: notification_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings ALTER COLUMN id SET DEFAULT nextval('public.notification_settings_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications ALTER COLUMN id SET DEFAULT nextval('public.oauth_applications_id_seq'::regclass);


--
-- Name: oauth_client_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_client_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_client_tokens_id_seq'::regclass);


--
-- Name: oauth_clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);


--
-- Name: oidc_user_session_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oidc_user_session_links ALTER COLUMN id SET DEFAULT nextval('public.oidc_user_session_links_id_seq'::regclass);


--
-- Name: ordered_work_packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ordered_work_packages ALTER COLUMN id SET DEFAULT nextval('public.ordered_work_packages_id_seq'::regclass);


--
-- Name: paper_trail_audits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paper_trail_audits ALTER COLUMN id SET DEFAULT nextval('public.paper_trail_audits_id_seq'::regclass);


--
-- Name: project_custom_field_project_mappings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_custom_field_project_mappings ALTER COLUMN id SET DEFAULT nextval('public.project_custom_field_project_mappings_id_seq'::regclass);


--
-- Name: project_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_journals ALTER COLUMN id SET DEFAULT nextval('public.project_journals_id_seq'::regclass);


--
-- Name: project_life_cycle_step_definitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_step_definitions ALTER COLUMN id SET DEFAULT nextval('public.project_life_cycle_step_definitions_id_seq'::regclass);


--
-- Name: project_life_cycle_steps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_steps ALTER COLUMN id SET DEFAULT nextval('public.project_life_cycle_steps_id_seq'::regclass);


--
-- Name: project_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_queries ALTER COLUMN id SET DEFAULT nextval('public.project_queries_id_seq'::regclass);


--
-- Name: project_storages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storages ALTER COLUMN id SET DEFAULT nextval('public.project_storages_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries ALTER COLUMN id SET DEFAULT nextval('public.queries_id_seq'::regclass);


--
-- Name: rates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates ALTER COLUMN id SET DEFAULT nextval('public.rates_id_seq'::regclass);


--
-- Name: recaptcha_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recaptcha_entries ALTER COLUMN id SET DEFAULT nextval('public.recaptcha_entries_id_seq'::regclass);


--
-- Name: relations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relations ALTER COLUMN id SET DEFAULT nextval('public.relations_id_seq'::regclass);


--
-- Name: remote_identities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_identities ALTER COLUMN id SET DEFAULT nextval('public.remote_identities_id_seq'::regclass);


--
-- Name: repositories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.repositories ALTER COLUMN id SET DEFAULT nextval('public.repositories_id_seq'::regclass);


--
-- Name: role_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: storages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages ALTER COLUMN id SET DEFAULT nextval('public.storages_id_seq'::regclass);


--
-- Name: storages_file_links_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages_file_links_journals ALTER COLUMN id SET DEFAULT nextval('public.storages_file_links_journals_id_seq'::regclass);


--
-- Name: time_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entries ALTER COLUMN id SET DEFAULT nextval('public.time_entries_id_seq'::regclass);


--
-- Name: time_entry_activities_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_activities_projects ALTER COLUMN id SET DEFAULT nextval('public.time_entry_activities_projects_id_seq'::regclass);


--
-- Name: time_entry_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_journals ALTER COLUMN id SET DEFAULT nextval('public.time_entry_journals_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: two_factor_authentication_devices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.two_factor_authentication_devices ALTER COLUMN id SET DEFAULT nextval('public.two_factor_authentication_devices_id_seq'::regclass);


--
-- Name: types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: user_passwords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_passwords ALTER COLUMN id SET DEFAULT nextval('public.user_passwords_id_seq'::regclass);


--
-- Name: user_preferences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN id SET DEFAULT nextval('public.user_preferences_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: version_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_settings ALTER COLUMN id SET DEFAULT nextval('public.version_settings_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views ALTER COLUMN id SET DEFAULT nextval('public.views_id_seq'::regclass);


--
-- Name: watchers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.watchers ALTER COLUMN id SET DEFAULT nextval('public.watchers_id_seq'::regclass);


--
-- Name: webhooks_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_events ALTER COLUMN id SET DEFAULT nextval('public.webhooks_events_id_seq'::regclass);


--
-- Name: webhooks_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_logs ALTER COLUMN id SET DEFAULT nextval('public.webhooks_logs_id_seq'::regclass);


--
-- Name: webhooks_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_projects ALTER COLUMN id SET DEFAULT nextval('public.webhooks_projects_id_seq'::regclass);


--
-- Name: webhooks_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_webhooks ALTER COLUMN id SET DEFAULT nextval('public.webhooks_webhooks_id_seq'::regclass);


--
-- Name: wiki_page_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_page_journals ALTER COLUMN id SET DEFAULT nextval('public.wiki_page_journals_id_seq'::regclass);


--
-- Name: wiki_pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_pages ALTER COLUMN id SET DEFAULT nextval('public.wiki_pages_id_seq'::regclass);


--
-- Name: wiki_redirects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_redirects ALTER COLUMN id SET DEFAULT nextval('public.wiki_redirects_id_seq'::regclass);


--
-- Name: wikis id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wikis ALTER COLUMN id SET DEFAULT nextval('public.wikis_id_seq'::regclass);


--
-- Name: work_package_journals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_package_journals ALTER COLUMN id SET DEFAULT nextval('public.work_package_journals_id_seq'::regclass);


--
-- Name: work_packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages ALTER COLUMN id SET DEFAULT nextval('public.work_packages_id_seq'::regclass);


--
-- Name: workflows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows ALTER COLUMN id SET DEFAULT nextval('public.workflows_id_seq'::regclass);


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.announcements (id, text, show_until, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2024-12-12 05:11:01.129351+00	2024-12-12 05:11:01.129354+00
\.


--
-- Data for Name: attachable_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attachable_journals (id, journal_id, attachment_id, filename) FROM stdin;
\.


--
-- Data for Name: attachment_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attachment_journals (id, container_id, container_type, filename, disk_filename, filesize, content_type, digest, downloads, author_id, description) FROM stdin;
1	6	Grids::Grid			455768	image/png	2a53ddc815206499a480d08e38272b8a	0	4	\N
2	7	Grids::Grid			442579	image/png	7b7d591a8dfdaf2900ceecdb9755f39f	0	4	\N
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attachments (id, container_id, container_type, filename, disk_filename, filesize, content_type, digest, downloads, author_id, created_at, description, file, fulltext, fulltext_tsv, file_tsv, updated_at, status) FROM stdin;
1	6	Grids::Grid			455768	image/png	2a53ddc815206499a480d08e38272b8a	0	4	2024-12-12 05:11:43.196223+00	\N	demo_project_teaser.png	\N	\N	\N	2024-12-12 05:11:43.196223+00	0
2	7	Grids::Grid			442579	image/png	7b7d591a8dfdaf2900ceecdb9755f39f	0	4	2024-12-12 05:11:43.276447+00	\N	scrum_project_teaser.png	\N	\N	\N	2024-12-12 05:11:43.276447+00	0
\.


--
-- Data for Name: attribute_help_texts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attribute_help_texts (id, help_text, type, attribute_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: auth_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_providers (id, type, display_name, slug, available, limit_self_registration, options, creator_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bcf_comments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bcf_comments (id, uuid, journal_id, issue_id, viewpoint_id, reply_to) FROM stdin;
\.


--
-- Data for Name: bcf_issues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bcf_issues (id, uuid, markup, work_package_id, stage, index, labels, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bcf_viewpoints; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bcf_viewpoints (id, uuid, viewpoint_name, issue_id, json_viewpoint, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: budget_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.budget_journals (id, project_id, author_id, subject, description, fixed_date) FROM stdin;
\.


--
-- Data for Name: budgets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.budgets (id, project_id, author_id, subject, description, fixed_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, project_id, name, assigned_to_id, created_at, updated_at) FROM stdin;
1	1	Category 1 (to be changed in Project settings)	\N	2024-12-12 05:11:39.257726+00	2024-12-12 05:11:39.257726+00
2	2	Category 1 (to be changed in Project settings)	\N	2024-12-12 05:11:41.017132+00	2024-12-12 05:11:41.017132+00
\.


--
-- Data for Name: changes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.changes (id, changeset_id, action, path, from_path, from_revision, revision, branch) FROM stdin;
\.


--
-- Data for Name: changeset_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.changeset_journals (id, repository_id, revision, committer, committed_on, comments, commit_date, scmid, user_id) FROM stdin;
\.


--
-- Data for Name: changesets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.changesets (id, repository_id, revision, committer, committed_on, comments, commit_date, scmid, user_id) FROM stdin;
\.


--
-- Data for Name: changesets_work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.changesets_work_packages (changeset_id, work_package_id) FROM stdin;
\.


--
-- Data for Name: colors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.colors (id, name, hexcode, created_at, updated_at) FROM stdin;
1	Blue (dark)	#175A8E	2024-12-12 05:11:36.659766+00	2024-12-12 05:11:36.659766+00
2	Blue	#1A67A3	2024-12-12 05:11:36.664056+00	2024-12-12 05:11:36.664056+00
3	Blue (light)	#00B0F0	2024-12-12 05:11:36.665114+00	2024-12-12 05:11:36.665114+00
4	Green (light)	#35C53F	2024-12-12 05:11:36.665591+00	2024-12-12 05:11:36.665591+00
5	Green (dark)	#339933	2024-12-12 05:11:36.666079+00	2024-12-12 05:11:36.666079+00
6	Yellow	#FFFF00	2024-12-12 05:11:36.666531+00	2024-12-12 05:11:36.666531+00
7	Orange	#FFCC00	2024-12-12 05:11:36.666983+00	2024-12-12 05:11:36.666983+00
8	Red	#FF3300	2024-12-12 05:11:36.667392+00	2024-12-12 05:11:36.667392+00
9	Magenta	#E20074	2024-12-12 05:11:36.66789+00	2024-12-12 05:11:36.66789+00
10	White	#FFFFFF	2024-12-12 05:11:36.668343+00	2024-12-12 05:11:36.668343+00
11	Grey (light)	#F8F8F8	2024-12-12 05:11:36.668709+00	2024-12-12 05:11:36.668709+00
12	Grey	#EAEAEA	2024-12-12 05:11:36.669122+00	2024-12-12 05:11:36.669122+00
13	Grey (dark)	#878787	2024-12-12 05:11:36.669517+00	2024-12-12 05:11:36.669517+00
14	Black	#000000	2024-12-12 05:11:36.669897+00	2024-12-12 05:11:36.669897+00
15	gray-0	#F8F9FA	2024-12-12 05:11:36.671976+00	2024-12-12 05:11:36.671976+00
16	gray-1	#F1F3F5	2024-12-12 05:11:36.672464+00	2024-12-12 05:11:36.672464+00
17	gray-2	#E9ECEF	2024-12-12 05:11:36.67284+00	2024-12-12 05:11:36.67284+00
18	gray-3	#DEE2E6	2024-12-12 05:11:36.673363+00	2024-12-12 05:11:36.673363+00
19	gray-4	#CED4DA	2024-12-12 05:11:36.67376+00	2024-12-12 05:11:36.67376+00
20	gray-5	#ADB5BD	2024-12-12 05:11:36.674189+00	2024-12-12 05:11:36.674189+00
21	gray-6	#868E96	2024-12-12 05:11:36.674547+00	2024-12-12 05:11:36.674547+00
22	gray-7	#495057	2024-12-12 05:11:36.674894+00	2024-12-12 05:11:36.674894+00
23	gray-8	#343A40	2024-12-12 05:11:36.675252+00	2024-12-12 05:11:36.675252+00
24	gray-9	#212529	2024-12-12 05:11:36.675734+00	2024-12-12 05:11:36.675734+00
25	red-0	#FFF5F5	2024-12-12 05:11:36.676315+00	2024-12-12 05:11:36.676315+00
26	red-1	#FFE3E3	2024-12-12 05:11:36.67731+00	2024-12-12 05:11:36.67731+00
27	red-2	#FFC9C9	2024-12-12 05:11:36.677877+00	2024-12-12 05:11:36.677877+00
28	red-3	#FFA8A8	2024-12-12 05:11:36.678287+00	2024-12-12 05:11:36.678287+00
29	red-4	#FF8787	2024-12-12 05:11:36.678777+00	2024-12-12 05:11:36.678777+00
30	red-5	#FF6B6B	2024-12-12 05:11:36.679384+00	2024-12-12 05:11:36.679384+00
31	red-6	#FA5252	2024-12-12 05:11:36.679801+00	2024-12-12 05:11:36.679801+00
32	red-7	#F03E3E	2024-12-12 05:11:36.68016+00	2024-12-12 05:11:36.68016+00
33	red-8	#E03131	2024-12-12 05:11:36.68051+00	2024-12-12 05:11:36.68051+00
34	red-9	#C92A2A	2024-12-12 05:11:36.680861+00	2024-12-12 05:11:36.680861+00
35	pink-0	#FFF0F6	2024-12-12 05:11:36.681263+00	2024-12-12 05:11:36.681263+00
36	pink-1	#FFDEEB	2024-12-12 05:11:36.681621+00	2024-12-12 05:11:36.681621+00
37	pink-2	#FCC2D7	2024-12-12 05:11:36.682586+00	2024-12-12 05:11:36.682586+00
38	pink-3	#FAA2C1	2024-12-12 05:11:36.682989+00	2024-12-12 05:11:36.682989+00
39	pink-4	#F783AC	2024-12-12 05:11:36.683343+00	2024-12-12 05:11:36.683343+00
40	pink-5	#F06595	2024-12-12 05:11:36.683688+00	2024-12-12 05:11:36.683688+00
41	pink-6	#E64980	2024-12-12 05:11:36.6841+00	2024-12-12 05:11:36.6841+00
42	pink-7	#D6336C	2024-12-12 05:11:36.684473+00	2024-12-12 05:11:36.684473+00
43	pink-8	#C2255C	2024-12-12 05:11:36.684825+00	2024-12-12 05:11:36.684825+00
44	pink-9	#A61E4D	2024-12-12 05:11:36.685269+00	2024-12-12 05:11:36.685269+00
45	grape-0	#F8F0FC	2024-12-12 05:11:36.685651+00	2024-12-12 05:11:36.685651+00
46	grape-1	#F3D9FA	2024-12-12 05:11:36.686006+00	2024-12-12 05:11:36.686006+00
47	grape-2	#EEBEFA	2024-12-12 05:11:36.686704+00	2024-12-12 05:11:36.686704+00
48	grape-3	#E599F7	2024-12-12 05:11:36.687937+00	2024-12-12 05:11:36.687937+00
49	grape-4	#DA77F2	2024-12-12 05:11:36.688365+00	2024-12-12 05:11:36.688365+00
50	grape-5	#CC5DE8	2024-12-12 05:11:36.68873+00	2024-12-12 05:11:36.68873+00
51	grape-6	#BE4BDB	2024-12-12 05:11:36.68911+00	2024-12-12 05:11:36.68911+00
52	grape-7	#AE3EC9	2024-12-12 05:11:36.689521+00	2024-12-12 05:11:36.689521+00
53	grape-8	#9C36B5	2024-12-12 05:11:36.689881+00	2024-12-12 05:11:36.689881+00
54	grape-9	#862E9C	2024-12-12 05:11:36.690229+00	2024-12-12 05:11:36.690229+00
55	violet-0	#F3F0FF	2024-12-12 05:11:36.691046+00	2024-12-12 05:11:36.691046+00
56	violet-1	#E5DBFF	2024-12-12 05:11:36.691444+00	2024-12-12 05:11:36.691444+00
57	violet-2	#D0BFFF	2024-12-12 05:11:36.6918+00	2024-12-12 05:11:36.6918+00
58	violet-3	#B197FC	2024-12-12 05:11:36.692238+00	2024-12-12 05:11:36.692238+00
59	violet-4	#9775FA	2024-12-12 05:11:36.692984+00	2024-12-12 05:11:36.692984+00
60	violet-5	#845EF7	2024-12-12 05:11:36.693798+00	2024-12-12 05:11:36.693798+00
61	violet-6	#7950F2	2024-12-12 05:11:36.694311+00	2024-12-12 05:11:36.694311+00
62	violet-7	#7048E8	2024-12-12 05:11:36.694706+00	2024-12-12 05:11:36.694706+00
63	violet-8	#6741D9	2024-12-12 05:11:36.69514+00	2024-12-12 05:11:36.69514+00
64	violet-9	#5F3DC4	2024-12-12 05:11:36.695589+00	2024-12-12 05:11:36.695589+00
65	indigo-0	#EDF2FF	2024-12-12 05:11:36.696104+00	2024-12-12 05:11:36.696104+00
66	indigo-1	#DBE4FF	2024-12-12 05:11:36.696501+00	2024-12-12 05:11:36.696501+00
67	indigo-2	#BAC8FF	2024-12-12 05:11:36.696853+00	2024-12-12 05:11:36.696853+00
68	indigo-3	#91A7FF	2024-12-12 05:11:36.697279+00	2024-12-12 05:11:36.697279+00
69	indigo-4	#748FFC	2024-12-12 05:11:36.697654+00	2024-12-12 05:11:36.697654+00
70	indigo-5	#5C7CFA	2024-12-12 05:11:36.69802+00	2024-12-12 05:11:36.69802+00
71	indigo-6	#4C6EF5	2024-12-12 05:11:36.698384+00	2024-12-12 05:11:36.698384+00
72	indigo-7	#4263EB	2024-12-12 05:11:36.698746+00	2024-12-12 05:11:36.698746+00
73	indigo-8	#3B5BDB	2024-12-12 05:11:36.699102+00	2024-12-12 05:11:36.699102+00
74	indigo-9	#364FC7	2024-12-12 05:11:36.69952+00	2024-12-12 05:11:36.69952+00
75	blue-0	#E7F5FF	2024-12-12 05:11:36.699908+00	2024-12-12 05:11:36.699908+00
76	blue-1	#D0EBFF	2024-12-12 05:11:36.700273+00	2024-12-12 05:11:36.700273+00
77	blue-2	#A5D8FF	2024-12-12 05:11:36.700618+00	2024-12-12 05:11:36.700618+00
78	blue-3	#74C0FC	2024-12-12 05:11:36.700971+00	2024-12-12 05:11:36.700971+00
79	blue-4	#4DABF7	2024-12-12 05:11:36.701349+00	2024-12-12 05:11:36.701349+00
80	blue-5	#339AF0	2024-12-12 05:11:36.701729+00	2024-12-12 05:11:36.701729+00
81	blue-6	#228BE6	2024-12-12 05:11:36.702102+00	2024-12-12 05:11:36.702102+00
82	blue-7	#1C7ED6	2024-12-12 05:11:36.70246+00	2024-12-12 05:11:36.70246+00
83	blue-8	#1971C2	2024-12-12 05:11:36.702821+00	2024-12-12 05:11:36.702821+00
84	blue-9	#1864AB	2024-12-12 05:11:36.70318+00	2024-12-12 05:11:36.70318+00
85	cyan-0	#E3FAFC	2024-12-12 05:11:36.70361+00	2024-12-12 05:11:36.70361+00
86	cyan-1	#C5F6FA	2024-12-12 05:11:36.703964+00	2024-12-12 05:11:36.703964+00
87	cyan-2	#99E9F2	2024-12-12 05:11:36.704311+00	2024-12-12 05:11:36.704311+00
88	cyan-3	#66D9E8	2024-12-12 05:11:36.704657+00	2024-12-12 05:11:36.704657+00
89	cyan-4	#3BC9DB	2024-12-12 05:11:36.705021+00	2024-12-12 05:11:36.705021+00
90	cyan-5	#22B8CF	2024-12-12 05:11:36.705436+00	2024-12-12 05:11:36.705436+00
91	cyan-6	#15AABF	2024-12-12 05:11:36.705812+00	2024-12-12 05:11:36.705812+00
92	cyan-7	#1098AD	2024-12-12 05:11:36.706173+00	2024-12-12 05:11:36.706173+00
93	cyan-8	#0C8599	2024-12-12 05:11:36.706528+00	2024-12-12 05:11:36.706528+00
94	cyan-9	#0B7285	2024-12-12 05:11:36.706879+00	2024-12-12 05:11:36.706879+00
95	teal-0	#E6FCF5	2024-12-12 05:11:36.707327+00	2024-12-12 05:11:36.707327+00
96	teal-1	#C3FAE8	2024-12-12 05:11:36.707767+00	2024-12-12 05:11:36.707767+00
97	teal-2	#96F2D7	2024-12-12 05:11:36.708122+00	2024-12-12 05:11:36.708122+00
98	teal-3	#63E6BE	2024-12-12 05:11:36.708466+00	2024-12-12 05:11:36.708466+00
99	teal-4	#38D9A9	2024-12-12 05:11:36.708851+00	2024-12-12 05:11:36.708851+00
100	teal-5	#20C997	2024-12-12 05:11:36.709695+00	2024-12-12 05:11:36.709695+00
101	teal-6	#12B886	2024-12-12 05:11:36.710384+00	2024-12-12 05:11:36.710384+00
102	teal-7	#0CA678	2024-12-12 05:11:36.71084+00	2024-12-12 05:11:36.71084+00
103	teal-8	#099268	2024-12-12 05:11:36.711214+00	2024-12-12 05:11:36.711214+00
104	teal-9	#087F5B	2024-12-12 05:11:36.711587+00	2024-12-12 05:11:36.711587+00
105	green-0	#EBFBEE	2024-12-12 05:11:36.712114+00	2024-12-12 05:11:36.712114+00
106	green-1	#D3F9D8	2024-12-12 05:11:36.712656+00	2024-12-12 05:11:36.712656+00
107	green-2	#B2F2BB	2024-12-12 05:11:36.713166+00	2024-12-12 05:11:36.713166+00
108	green-3	#8CE99A	2024-12-12 05:11:36.714181+00	2024-12-12 05:11:36.714181+00
109	green-4	#69DB7C	2024-12-12 05:11:36.715247+00	2024-12-12 05:11:36.715247+00
110	green-5	#51CF66	2024-12-12 05:11:36.71575+00	2024-12-12 05:11:36.71575+00
111	green-6	#40C057	2024-12-12 05:11:36.716159+00	2024-12-12 05:11:36.716159+00
112	green-7	#37B24D	2024-12-12 05:11:36.716518+00	2024-12-12 05:11:36.716518+00
113	green-8	#2F9E44	2024-12-12 05:11:36.716856+00	2024-12-12 05:11:36.716856+00
114	green-9	#2B8A3E	2024-12-12 05:11:36.717244+00	2024-12-12 05:11:36.717244+00
115	lime-0	#F4FCE3	2024-12-12 05:11:36.717631+00	2024-12-12 05:11:36.717631+00
116	lime-1	#E9FAC8	2024-12-12 05:11:36.717993+00	2024-12-12 05:11:36.717993+00
117	lime-2	#D8F5A2	2024-12-12 05:11:36.718353+00	2024-12-12 05:11:36.718353+00
118	lime-3	#C0EB75	2024-12-12 05:11:36.718778+00	2024-12-12 05:11:36.718778+00
119	lime-4	#A9E34B	2024-12-12 05:11:36.71959+00	2024-12-12 05:11:36.71959+00
120	lime-5	#94D82D	2024-12-12 05:11:36.720882+00	2024-12-12 05:11:36.720882+00
121	lime-6	#82C91E	2024-12-12 05:11:36.721326+00	2024-12-12 05:11:36.721326+00
122	lime-7	#74B816	2024-12-12 05:11:36.721684+00	2024-12-12 05:11:36.721684+00
123	lime-8	#66A80F	2024-12-12 05:11:36.722024+00	2024-12-12 05:11:36.722024+00
124	lime-9	#5C940D	2024-12-12 05:11:36.722358+00	2024-12-12 05:11:36.722358+00
125	yellow-0	#FFF9DB	2024-12-12 05:11:36.722877+00	2024-12-12 05:11:36.722877+00
126	yellow-1	#FFF3BF	2024-12-12 05:11:36.72327+00	2024-12-12 05:11:36.72327+00
127	yellow-2	#FFEC99	2024-12-12 05:11:36.723651+00	2024-12-12 05:11:36.723651+00
128	yellow-3	#FFE066	2024-12-12 05:11:36.723994+00	2024-12-12 05:11:36.723994+00
129	yellow-4	#FFD43B	2024-12-12 05:11:36.724406+00	2024-12-12 05:11:36.724406+00
130	yellow-5	#FCC419	2024-12-12 05:11:36.724745+00	2024-12-12 05:11:36.724745+00
131	yellow-6	#FAB005	2024-12-12 05:11:36.725109+00	2024-12-12 05:11:36.725109+00
132	yellow-7	#F59F00	2024-12-12 05:11:36.725504+00	2024-12-12 05:11:36.725504+00
133	yellow-8	#F08C00	2024-12-12 05:11:36.726021+00	2024-12-12 05:11:36.726021+00
134	yellow-9	#E67700	2024-12-12 05:11:36.7267+00	2024-12-12 05:11:36.7267+00
135	orange-0	#FFF4E6	2024-12-12 05:11:36.727383+00	2024-12-12 05:11:36.727383+00
136	orange-1	#FFE8CC	2024-12-12 05:11:36.727839+00	2024-12-12 05:11:36.727839+00
137	orange-2	#FFD8A8	2024-12-12 05:11:36.728206+00	2024-12-12 05:11:36.728206+00
138	orange-3	#FFC078	2024-12-12 05:11:36.728547+00	2024-12-12 05:11:36.728547+00
139	orange-4	#FFA94D	2024-12-12 05:11:36.729082+00	2024-12-12 05:11:36.729082+00
140	orange-5	#FF922B	2024-12-12 05:11:36.729594+00	2024-12-12 05:11:36.729594+00
141	orange-6	#FD7E14	2024-12-12 05:11:36.729988+00	2024-12-12 05:11:36.729988+00
142	orange-7	#F76707	2024-12-12 05:11:36.730346+00	2024-12-12 05:11:36.730346+00
143	orange-8	#E8590C	2024-12-12 05:11:36.730704+00	2024-12-12 05:11:36.730704+00
144	orange-9	#D9480F	2024-12-12 05:11:36.731062+00	2024-12-12 05:11:36.731062+00
145	PM2 Orange	#F7983A	2024-12-12 05:11:36.732377+00	2024-12-12 05:11:36.732377+00
146	PM2 Purple	#682D91	2024-12-12 05:11:36.732825+00	2024-12-12 05:11:36.732825+00
147	PM2 Red	#F05823	2024-12-12 05:11:36.733222+00	2024-12-12 05:11:36.733222+00
148	PM2 Magenta	#EC038A	2024-12-12 05:11:36.733576+00	2024-12-12 05:11:36.733576+00
149	PM2 Green Yellow	#B1D13A	2024-12-12 05:11:36.733976+00	2024-12-12 05:11:36.733976+00
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.comments (id, commented_type, commented_id, author_id, comments, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cost_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cost_entries (id, user_id, project_id, work_package_id, cost_type_id, units, spent_on, created_at, updated_at, comments, blocked, overridden_costs, costs, rate_id, tyear, tmonth, tweek, logged_by_id) FROM stdin;
\.


--
-- Data for Name: cost_queries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cost_queries (id, user_id, project_id, name, is_public, created_at, updated_at, serialized) FROM stdin;
\.


--
-- Data for Name: cost_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cost_types (id, name, unit, unit_plural, "default", deleted_at) FROM stdin;
\.


--
-- Data for Name: custom_actions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_actions (id, name, actions, description, "position") FROM stdin;
\.


--
-- Data for Name: custom_actions_projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_actions_projects (id, project_id, custom_action_id) FROM stdin;
\.


--
-- Data for Name: custom_actions_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_actions_roles (id, role_id, custom_action_id) FROM stdin;
\.


--
-- Data for Name: custom_actions_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_actions_statuses (id, status_id, custom_action_id) FROM stdin;
\.


--
-- Data for Name: custom_actions_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_actions_types (id, type_id, custom_action_id) FROM stdin;
\.


--
-- Data for Name: custom_field_sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_field_sections (id, "position", name, type, created_at, updated_at) FROM stdin;
1	1	Project attributes	ProjectCustomFieldSection	2024-12-12 05:11:07.6151+00	2024-12-12 05:11:07.6151+00
\.


--
-- Data for Name: custom_fields; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_fields (id, type, field_format, regexp, min_length, max_length, is_required, is_for_all, is_filter, "position", searchable, editable, admin_only, multi_value, default_value, name, created_at, updated_at, content_right_to_left, allow_non_open_versions, custom_field_section_id, position_in_custom_field_section) FROM stdin;
\.


--
-- Data for Name: custom_fields_projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_fields_projects (custom_field_id, project_id, id) FROM stdin;
\.


--
-- Data for Name: custom_fields_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_fields_types (custom_field_id, type_id) FROM stdin;
\.


--
-- Data for Name: custom_options; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_options (id, custom_field_id, "position", default_value, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: custom_styles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_styles (id, logo, created_at, updated_at, favicon, touch_icon, theme, theme_logo, export_logo, export_cover, export_cover_text_color) FROM stdin;
\.


--
-- Data for Name: custom_values; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_values (id, customized_type, customized_id, custom_field_id, value) FROM stdin;
\.


--
-- Data for Name: customizable_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customizable_journals (id, journal_id, custom_field_id, value) FROM stdin;
\.


--
-- Data for Name: deploy_status_checks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.deploy_status_checks (id, deploy_target_id, github_pull_request_id, core_sha, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: deploy_targets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.deploy_targets (id, type, host, options, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: design_colors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.design_colors (id, variable, hexcode, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.document_journals (id, project_id, category_id, title, description) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.documents (id, project_id, category_id, title, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: done_statuses_for_project; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.done_statuses_for_project (project_id, status_id) FROM stdin;
\.


--
-- Data for Name: emoji_reactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.emoji_reactions (id, user_id, reactable_type, reactable_id, reaction, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: enabled_modules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enabled_modules (id, project_id, name) FROM stdin;
1	1	work_package_tracking
2	1	news
3	1	gantt
4	1	wiki
5	1	board_view
6	1	team_planner_view
7	1	meetings
8	2	backlogs
9	2	news
10	2	wiki
11	2	work_package_tracking
12	2	gantt
13	2	board_view
\.


--
-- Data for Name: enterprise_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprise_tokens (id, encoded_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: enumerations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enumerations (id, name, "position", is_default, type, active, project_id, parent_id, created_at, updated_at, color_id) FROM stdin;
1	Management	1	t	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.613447+00	2024-12-12 05:11:36.613447+00	\N
2	Specification	2	f	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.622079+00	2024-12-12 05:11:36.622079+00	\N
3	Development	3	f	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.630773+00	2024-12-12 05:11:36.630773+00	\N
4	Testing	4	f	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.635981+00	2024-12-12 05:11:36.635981+00	\N
5	Support	5	f	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.640786+00	2024-12-12 05:11:36.640786+00	\N
6	Other	6	f	TimeEntryActivity	t	\N	\N	2024-12-12 05:11:36.646767+00	2024-12-12 05:11:36.646767+00	\N
7	Low	1	f	IssuePriority	t	\N	\N	2024-12-12 05:11:37.839529+00	2024-12-12 05:11:37.839529+00	86
8	Normal	2	t	IssuePriority	t	\N	\N	2024-12-12 05:11:37.845545+00	2024-12-12 05:11:37.845545+00	78
9	High	3	f	IssuePriority	t	\N	\N	2024-12-12 05:11:37.851132+00	2024-12-12 05:11:37.851132+00	132
10	Immediate	4	f	IssuePriority	t	\N	\N	2024-12-12 05:11:37.857356+00	2024-12-12 05:11:37.857356+00	50
11	Documentation	1	f	DocumentCategory	t	\N	\N	2024-12-12 05:11:38.511571+00	2024-12-12 05:11:38.511571+00	\N
12	Specification	2	f	DocumentCategory	t	\N	\N	2024-12-12 05:11:38.516264+00	2024-12-12 05:11:38.516264+00	\N
13	Other	3	f	DocumentCategory	t	\N	\N	2024-12-12 05:11:38.518606+00	2024-12-12 05:11:38.518606+00	\N
\.


--
-- Data for Name: exports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exports (id, created_at, updated_at, type) FROM stdin;
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.favorites (id, user_id, favored_type, favored_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: file_links; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.file_links (id, storage_id, creator_id, container_id, container_type, origin_id, origin_name, origin_created_by_name, origin_last_modified_by_name, origin_mime_type, origin_created_at, origin_updated_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: forums; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.forums (id, project_id, name, description, "position", topics_count, messages_count, last_message_id) FROM stdin;
\.


--
-- Data for Name: github_check_runs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.github_check_runs (id, github_pull_request_id, github_id, github_html_url, app_id, github_app_owner_avatar_url, status, name, conclusion, output_title, output_summary, details_url, started_at, completed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: github_pull_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.github_pull_requests (id, github_user_id, merged_by_id, github_id, number, github_html_url, state, repository, github_updated_at, title, body, draft, merged, merged_at, comments_count, review_comments_count, additions_count, deletions_count, changed_files_count, labels, created_at, updated_at, repository_html_url, merge_commit_sha) FROM stdin;
\.


--
-- Data for Name: github_pull_requests_work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.github_pull_requests_work_packages (github_pull_request_id, work_package_id) FROM stdin;
\.


--
-- Data for Name: github_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.github_users (id, github_id, github_login, github_html_url, github_avatar_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gitlab_issues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_issues (id, gitlab_user_id, gitlab_id, number, gitlab_html_url, state, repository, gitlab_updated_at, title, body, labels, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gitlab_issues_work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_issues_work_packages (gitlab_issue_id, work_package_id) FROM stdin;
\.


--
-- Data for Name: gitlab_merge_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_merge_requests (id, gitlab_user_id, merged_by_id, gitlab_id, number, gitlab_html_url, state, repository, gitlab_updated_at, title, body, draft, merged, merged_at, labels, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gitlab_merge_requests_work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_merge_requests_work_packages (gitlab_merge_request_id, work_package_id) FROM stdin;
\.


--
-- Data for Name: gitlab_pipelines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_pipelines (id, gitlab_merge_request_id, gitlab_id, gitlab_html_url, project_id, gitlab_user_avatar_url, status, name, details_url, ci_details, started_at, completed_at, created_at, updated_at, username, commit_id) FROM stdin;
\.


--
-- Data for Name: gitlab_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gitlab_users (id, gitlab_id, gitlab_name, gitlab_username, gitlab_email, gitlab_avatar_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: good_job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_job_batches (id, created_at, updated_at, description, serialized_properties, on_finish, on_success, on_discard, callback_queue_name, callback_priority, enqueued_at, discarded_at, finished_at) FROM stdin;
\.


--
-- Data for Name: good_job_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_job_executions (id, created_at, updated_at, active_job_id, job_class, queue_name, serialized_params, scheduled_at, finished_at, error, error_event) FROM stdin;
494914a8-f9f3-4644-868b-c2597a981cad	2024-12-12 05:11:39.117729+00	2024-12-12 05:11:39.161583+00	8fdacb5c-85b7-4bfd-813b-46b278778ed0	Notifications::WorkflowJob	default	{"job_id": "8fdacb5c-85b7-4bfd-813b-46b278778ed0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/1"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.084780340Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.112371+00	2024-12-12 05:11:39.160913+00	\N	\N
0a6a551e-41f3-47ae-a551-a21d5dab17e2	2024-12-12 05:11:39.216711+00	2024-12-12 05:11:39.238336+00	e7e93f49-774b-4c11-a67b-7a53714788c6	Notifications::WorkflowJob	default	{"job_id": "e7e93f49-774b-4c11-a67b-7a53714788c6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/2"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.213919402Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.214795+00	2024-12-12 05:11:39.238161+00	\N	\N
cf1b9f08-4313-483d-bc7c-731b528f7fa7	2024-12-12 05:11:39.460855+00	2024-12-12 05:11:39.471938+00	4d747ab4-d6dc-40cc-b570-be76af04342f	Notifications::WorkflowJob	default	{"job_id": "4d747ab4-d6dc-40cc-b570-be76af04342f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/3"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.458837279Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.45911+00	2024-12-12 05:11:39.471773+00	\N	\N
52688aeb-9192-4042-b9c2-f5989cb21d12	2024-12-12 05:11:39.543789+00	2024-12-12 05:11:39.554824+00	d613a89f-279d-4956-9aaf-7062e09dba42	Notifications::WorkflowJob	default	{"job_id": "d613a89f-279d-4956-9aaf-7062e09dba42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.542097333Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.542331+00	2024-12-12 05:11:39.554665+00	\N	\N
4ae67ae1-33e6-4e4f-9ed9-a11a210b858e	2024-12-12 05:11:39.570388+00	2024-12-12 05:11:39.578565+00	6e3925d3-4c5f-47e1-b7f9-437e395e8ce0	Notifications::WorkflowJob	default	{"job_id": "6e3925d3-4c5f-47e1-b7f9-437e395e8ce0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.568893103Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.569252+00	2024-12-12 05:11:39.578404+00	\N	\N
38315d02-d870-4947-bdd9-9bb05931ec90	2024-12-12 05:11:39.599782+00	2024-12-12 05:11:39.607949+00	355f2ffc-ffab-4ed0-a804-d894c206edb7	Notifications::WorkflowJob	default	{"job_id": "355f2ffc-ffab-4ed0-a804-d894c206edb7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.598320208Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.598516+00	2024-12-12 05:11:39.607771+00	\N	\N
3e956163-280f-45c3-bc99-378a7134e505	2024-12-12 05:12:22.983369+00	2024-12-12 05:12:23.117297+00	d84ec7a0-b2fd-4eda-bf7f-895cb1ba6ae9	WorkPackages::Progress::MigrateValuesJob	default	{"job_id": "d84ec7a0-b2fd-4eda-bf7f-895cb1ba6ae9", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [{"current_mode": "field", "previous_mode": null, "_aj_ruby2_keywords": ["current_mode", "previous_mode"]}], "job_class": "WorkPackages::Progress::MigrateValuesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:13.388283600Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:13.422922+00	2024-12-12 05:12:23.116433+00	\N	\N
f98a97b3-35da-4658-96ed-61fdccb3e2ee	2024-12-12 05:15:00.106072+00	2024-12-12 05:15:00.227223+00	0d44cf95-4b60-4779-a86a-a9d794aa5ade	Notifications::ScheduleReminderMailsJob	default	{"job_id": "0d44cf95-4b60-4779-a86a-a9d794aa5ade", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:15:00.060213328Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:15:00.065371+00	2024-12-12 05:15:00.226793+00	\N	\N
232d0090-0e16-4365-b762-a6921d601c79	2024-12-12 05:16:39.247827+00	2024-12-12 05:16:39.295631+00	c3b435e4-90dc-4914-966f-0abc6c883e90	Journals::CompletedJob	default	{"job_id": "c3b435e4-90dc-4914-966f-0abc6c883e90", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [2, {"value": "2024-12-12T05:11:39.194667000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.243156738Z", "scheduled_at": "2024-12-12T05:16:39.241993764Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.241993+00	2024-12-12 05:16:39.294957+00	\N	\N
11c61640-4aba-4f3f-a8c7-41070ab02318	2024-12-12 05:17:23.105185+00	2024-12-12 05:17:23.140421+00	44d9c410-9509-4d4c-b976-c64cde3cf3a4	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	default	{"job_id": "44d9c410-9509-4d4c-b976-c64cde3cf3a4", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 1, "queue_name": "default", "enqueued_at": "2024-12-12T05:12:23.100651401Z", "scheduled_at": "2024-12-12T05:17:23.099299430Z", "provider_job_id": "44d9c410-9509-4d4c-b976-c64cde3cf3a4", "exception_executions": {"[GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError]": 1}}	2024-12-12 05:17:23.099299+00	2024-12-12 05:17:23.140176+00	\N	\N
2d742d39-a482-47c9-a34a-aa5dd71727c4	2024-12-12 05:30:00.073209+00	2024-12-12 05:30:00.08746+00	b7c7b7bf-c114-4c04-9f10-a7a685e6c538	LdapGroups::SynchronizationJob	default	{"job_id": "b7c7b7bf-c114-4c04-9f10-a7a685e6c538", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.013147603Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.017337+00	2024-12-12 05:30:00.087324+00	\N	\N
01ba27dc-be6b-46ac-85a4-80b69e290b44	2024-12-12 05:11:39.625842+00	2024-12-12 05:11:39.638134+00	7d548bbe-9349-402b-9f72-d45c7f3a8eab	Notifications::WorkflowJob	default	{"job_id": "7d548bbe-9349-402b-9f72-d45c7f3a8eab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.624264765Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.624459+00	2024-12-12 05:11:39.637965+00	\N	\N
372b11e1-13e0-4e6d-8f9f-be7373e243d6	2024-12-12 05:11:39.653981+00	2024-12-12 05:11:39.661487+00	ba10f053-5591-4d77-ab57-c7503710b78d	Notifications::WorkflowJob	default	{"job_id": "ba10f053-5591-4d77-ab57-c7503710b78d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.652602578Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.652796+00	2024-12-12 05:11:39.661319+00	\N	\N
7c38b489-132e-4b6b-8025-e762f7cb0b32	2024-12-12 05:11:39.672891+00	2024-12-12 05:11:39.681548+00	cb2088cd-a018-4cd8-967c-ca174f27724f	Notifications::WorkflowJob	default	{"job_id": "cb2088cd-a018-4cd8-967c-ca174f27724f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.671533305Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.671724+00	2024-12-12 05:11:39.681388+00	\N	\N
467e27dd-0982-4891-9e4f-b78497113f0b	2024-12-12 05:11:39.708182+00	2024-12-12 05:11:39.715996+00	4501076c-06c5-4906-acee-2d373e68c093	Notifications::WorkflowJob	default	{"job_id": "4501076c-06c5-4906-acee-2d373e68c093", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.706996619Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.707192+00	2024-12-12 05:11:39.715838+00	\N	\N
3a739110-3a19-4ea4-a459-3ddefb0e7b31	2024-12-12 05:11:39.733121+00	2024-12-12 05:11:39.739712+00	454e316a-27fc-40d5-9fd8-eaa74628734f	Notifications::WorkflowJob	default	{"job_id": "454e316a-27fc-40d5-9fd8-eaa74628734f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.731513080Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.73171+00	2024-12-12 05:11:39.739564+00	\N	\N
5a6b4f11-b9bf-4b76-9baf-66eed17ebc28	2024-12-12 05:11:39.751204+00	2024-12-12 05:11:39.758232+00	883c0f20-a5c0-46fa-ae44-fe5678822fef	Notifications::WorkflowJob	default	{"job_id": "883c0f20-a5c0-46fa-ae44-fe5678822fef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.750032890Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.750219+00	2024-12-12 05:11:39.75809+00	\N	\N
3f4731ac-1a5d-4130-8935-1bffc3d5456e	2024-12-12 05:12:23.051229+00	2024-12-12 05:12:23.130773+00	44d9c410-9509-4d4c-b976-c64cde3cf3a4	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	default	{"job_id": "44d9c410-9509-4d4c-b976-c64cde3cf3a4", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:13.564146654Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:13.564379+00	2024-12-12 05:12:23.130126+00	GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError: GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError	3
a9190056-8677-45af-853d-89826e19e12c	2024-12-12 05:15:00.137881+00	2024-12-12 05:15:00.232817+00	72db92c2-55ad-437b-b0ac-530c5497d4be	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "72db92c2-55ad-437b-b0ac-530c5497d4be", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:15:00.114937146Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:15:00.115744+00	2024-12-12 05:15:00.232627+00	\N	\N
5802498d-9e2d-4c27-8d98-ac6ee25050cf	2024-12-12 05:16:39.162543+00	2024-12-12 05:16:39.193373+00	e8689e9f-ae25-4e8c-9f2c-ed1778fcc1ea	Notifications::WorkflowJob	default	{"job_id": "e8689e9f-ae25-4e8c-9f2c-ed1778fcc1ea", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.156772224Z", "scheduled_at": "2024-12-12T05:16:39.155371550Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.155371+00	2024-12-12 05:16:39.192985+00	\N	\N
f4997375-898b-4b78-87a4-56f77117f4ee	2024-12-12 05:30:00.091543+00	2024-12-12 05:30:00.143273+00	b528a40f-f6c5-437b-beab-d8a7dd7573f7	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "b528a40f-f6c5-437b-beab-d8a7dd7573f7", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.050323783Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.050913+00	2024-12-12 05:30:00.143001+00	\N	\N
149877fa-81be-4047-9415-5ed1aa27ce1e	2024-12-12 05:31:22.895037+00	2024-12-12 05:31:22.904169+00	e9c8c92b-3eb5-4ede-a31a-52aa64c44704	Notifications::WorkflowJob	default	{"job_id": "e9c8c92b-3eb5-4ede-a31a-52aa64c44704", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:31.258084648Z", "scheduled_at": "2024-12-12T03:22:31.257795258Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:22:31.257795+00	2024-12-12 05:31:22.903985+00	\N	\N
21a3b462-e949-4ab8-a256-a2f3b843ab46	2024-12-12 05:11:39.774104+00	2024-12-12 05:11:39.781402+00	44fa0c75-5d7f-4a12-940f-0eaf1a16ed53	Notifications::WorkflowJob	default	{"job_id": "44fa0c75-5d7f-4a12-940f-0eaf1a16ed53", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.772922349Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.773114+00	2024-12-12 05:11:39.781246+00	\N	\N
7f189d24-db78-4f08-b584-e2d94c8d08ca	2024-12-12 05:11:39.800102+00	2024-12-12 05:11:39.808482+00	3d8d65b4-e5f8-4bcd-9223-fd7318646c37	Notifications::WorkflowJob	default	{"job_id": "3d8d65b4-e5f8-4bcd-9223-fd7318646c37", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.798672588Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.798898+00	2024-12-12 05:11:39.808339+00	\N	\N
2ae88409-c8a7-4d56-8ba6-72158f2abf18	2024-12-12 05:11:39.818088+00	2024-12-12 05:11:39.825466+00	cc5aba9b-3b27-450d-99ae-7bd06e2ad9c4	Notifications::WorkflowJob	default	{"job_id": "cc5aba9b-3b27-450d-99ae-7bd06e2ad9c4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.816769256Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.817079+00	2024-12-12 05:11:39.825309+00	\N	\N
46075019-c2e7-4de2-910d-59f8015ae3d6	2024-12-12 05:11:39.848552+00	2024-12-12 05:11:39.856316+00	5ea957c7-a2de-4ea8-a758-43f69ffec957	Notifications::WorkflowJob	default	{"job_id": "5ea957c7-a2de-4ea8-a758-43f69ffec957", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.847268463Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.847457+00	2024-12-12 05:11:39.856166+00	\N	\N
f570dbcc-257f-4faa-99c0-ffa105a65915	2024-12-12 05:11:39.867027+00	2024-12-12 05:11:39.874668+00	6730de29-0179-4b3b-a245-0be4845edbce	Notifications::WorkflowJob	default	{"job_id": "6730de29-0179-4b3b-a245-0be4845edbce", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.865752796Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.86594+00	2024-12-12 05:11:39.874522+00	\N	\N
06df18d3-10a7-4df2-9633-da51bda2594a	2024-12-12 05:11:39.903131+00	2024-12-12 05:11:39.914023+00	7131e9b5-541e-4bee-b5dc-337e6ff393dc	Notifications::WorkflowJob	default	{"job_id": "7131e9b5-541e-4bee-b5dc-337e6ff393dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.901858364Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.902045+00	2024-12-12 05:11:39.913855+00	\N	\N
b776f88d-ce95-475c-b45e-81216b44074b	2024-12-12 05:16:39.240271+00	2024-12-12 05:16:39.253994+00	bcf13854-4cd3-4458-8886-0a14b103e8e9	Notifications::WorkflowJob	default	{"job_id": "bcf13854-4cd3-4458-8886-0a14b103e8e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.235807032Z", "scheduled_at": "2024-12-12T05:16:39.235626340Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.235626+00	2024-12-12 05:16:39.253711+00	\N	\N
94bf4242-2ff4-4ca4-bf22-e315a003f6ad	2024-12-12 05:16:39.493407+00	2024-12-12 05:16:39.520096+00	09fe791e-f28d-4ec0-a63c-6f813b90d79a	Journals::CompletedJob	default	{"job_id": "09fe791e-f28d-4ec0-a63c-6f813b90d79a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [3, {"value": "2024-12-12T05:11:39.450982000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.475621040Z", "scheduled_at": "2024-12-12T05:16:39.474989503Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.474989+00	2024-12-12 05:16:39.519653+00	\N	\N
3f346261-3e19-4c10-a0ee-16e3e020daf0	2024-12-12 05:16:39.560826+00	2024-12-12 05:16:39.580653+00	9ee19c6c-b7ce-4ebc-b593-4482f75c9f8e	Notifications::WorkflowJob	default	{"job_id": "9ee19c6c-b7ce-4ebc-b593-4482f75c9f8e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.553265292Z", "scheduled_at": "2024-12-12T05:16:39.553088647Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.553088+00	2024-12-12 05:16:39.580307+00	\N	\N
5fc967f7-6910-4dcc-9909-93708869e17e	2024-12-12 05:30:00.131587+00	2024-12-12 05:30:00.196727+00	57cdaf17-1cec-44f1-a80d-2edfef4e4c3f	Notifications::ScheduleReminderMailsJob	default	{"job_id": "57cdaf17-1cec-44f1-a80d-2edfef4e4c3f", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.066178061Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.066545+00	2024-12-12 05:30:00.196525+00	\N	\N
9415f1c3-3c14-45f4-a96f-32ea663c5383	2024-12-12 05:31:22.88964+00	2024-12-12 05:31:22.902843+00	33141995-4d04-441c-be71-9543df2f2293	Notifications::WorkflowJob	default	{"job_id": "33141995-4d04-441c-be71-9543df2f2293", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:07.692067625Z", "scheduled_at": "2024-12-12T03:22:07.690253835Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:22:07.690253+00	2024-12-12 05:31:22.902654+00	\N	\N
69dd9b53-e220-4c2b-8d90-5387c4ad8ad2	2024-12-12 05:11:39.931952+00	2024-12-12 05:11:39.939238+00	393d774c-da05-4297-bbde-41d91624df49	Notifications::WorkflowJob	default	{"job_id": "393d774c-da05-4297-bbde-41d91624df49", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.930460127Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.930652+00	2024-12-12 05:11:39.939083+00	\N	\N
85e08994-cac8-486b-afe2-2f0dcd811dab	2024-12-12 05:11:39.949188+00	2024-12-12 05:11:39.956531+00	a00bc308-e1a5-40c3-9ed4-ad0c344b2dac	Notifications::WorkflowJob	default	{"job_id": "a00bc308-e1a5-40c3-9ed4-ad0c344b2dac", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.947828234Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.948012+00	2024-12-12 05:11:39.956241+00	\N	\N
1df4f008-b349-4b5d-9244-cd419c53b27c	2024-12-12 05:11:39.975506+00	2024-12-12 05:11:39.9869+00	c0d16f39-7385-4be6-ae12-ba54ae4b9d4e	Notifications::WorkflowJob	default	{"job_id": "c0d16f39-7385-4be6-ae12-ba54ae4b9d4e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.974191685Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.974386+00	2024-12-12 05:11:39.986726+00	\N	\N
3244553e-f263-49ad-a5eb-e236567c1107	2024-12-12 05:11:40.003011+00	2024-12-12 05:11:40.010023+00	96527050-aeec-4e61-963e-57966864cd23	Notifications::WorkflowJob	default	{"job_id": "96527050-aeec-4e61-963e-57966864cd23", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.001720746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.001914+00	2024-12-12 05:11:40.009846+00	\N	\N
1528db58-3b8a-49db-9b41-45035c393b6c	2024-12-12 05:11:40.019565+00	2024-12-12 05:11:40.027428+00	e95db8c6-9131-434f-a08c-550914aa86b4	Notifications::WorkflowJob	default	{"job_id": "e95db8c6-9131-434f-a08c-550914aa86b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.018295098Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.018486+00	2024-12-12 05:11:40.027271+00	\N	\N
bcb726fd-1ce8-4db8-ba0b-d4854ab7bf23	2024-12-12 05:11:40.044916+00	2024-12-12 05:11:40.052543+00	7ba5b681-f1a0-48f3-b6b4-98cff8e87645	Notifications::WorkflowJob	default	{"job_id": "7ba5b681-f1a0-48f3-b6b4-98cff8e87645", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.043608820Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.043798+00	2024-12-12 05:11:40.052392+00	\N	\N
0c663438-4d6b-48d5-a0b8-eb288a96b827	2024-12-12 05:16:39.475074+00	2024-12-12 05:16:39.504742+00	8d386dbf-3946-41d5-8d45-d02c4f249a88	Notifications::WorkflowJob	default	{"job_id": "8d386dbf-3946-41d5-8d45-d02c4f249a88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.470209316Z", "scheduled_at": "2024-12-12T05:16:39.470032391Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.470032+00	2024-12-12 05:16:39.504283+00	\N	\N
e4c9d595-0aea-4f6c-b278-aa90000dd8a8	2024-12-12 05:16:39.566311+00	2024-12-12 05:16:39.592802+00	2c62ebfb-717f-414e-8f2b-30bf89bfd440	Journals::CompletedJob	default	{"job_id": "2c62ebfb-717f-414e-8f2b-30bf89bfd440", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-12-12T05:11:39.507931000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.556843231Z", "scheduled_at": "2024-12-12T05:16:39.556631700Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.556631+00	2024-12-12 05:16:39.592384+00	\N	\N
2c94afd4-b5d0-422e-94c8-a89c96f4552c	2024-12-12 05:16:39.615046+00	2024-12-12 05:16:39.678744+00	d42cf4dd-d3a3-4ed2-9966-a2df389757b0	Notifications::WorkflowJob	default	{"job_id": "d42cf4dd-d3a3-4ed2-9966-a2df389757b0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.606051316Z", "scheduled_at": "2024-12-12T05:16:39.605875794Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.605875+00	2024-12-12 05:16:39.678375+00	\N	\N
26fcdfa1-f61f-4f1f-85e2-9942c503acac	2024-12-11 10:15:00.03816+00	2024-12-11 10:15:00.06357+00	dab273d4-b283-4476-9483-3be2d8c8c267	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "dab273d4-b283-4476-9483-3be2d8c8c267", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:15:00.009283719Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:15:00.010087+00	2024-12-11 10:15:00.062808+00	\N	\N
671bb3f4-2298-406f-a822-9ecc0b915207	2024-12-12 03:15:00.137807+00	2024-12-12 03:15:00.367674+00	13dadf80-2237-4336-891f-2095675482bb	Notifications::ScheduleReminderMailsJob	default	{"job_id": "13dadf80-2237-4336-891f-2095675482bb", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:15:00.058268248Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:15:00.08677+00	2024-12-12 03:15:00.367374+00	\N	\N
2929df55-052e-43d9-942a-dd50264f7b3e	2024-12-12 03:17:07.605238+00	2024-12-12 03:17:07.698003+00	0f57c48c-257e-4078-b3ae-f1a8d228c069	Notifications::WorkflowJob	default	{"job_id": "0f57c48c-257e-4078-b3ae-f1a8d228c069", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/81"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:07.562474026Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:17:07.576158+00	2024-12-12 03:17:07.697787+00	\N	\N
6213fc93-3b92-46a5-9581-044d5bd1461e	2024-12-12 05:11:40.06366+00	2024-12-12 05:11:40.072868+00	35fb11af-0abf-46dc-9d9b-675475e9eb2d	Notifications::WorkflowJob	default	{"job_id": "35fb11af-0abf-46dc-9d9b-675475e9eb2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.062363846Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.062554+00	2024-12-12 05:11:40.072695+00	\N	\N
9348a289-1926-4715-ae49-30754c1dd581	2024-12-12 05:11:40.089663+00	2024-12-12 05:11:40.09866+00	ae186a59-e036-4725-a410-814c10cd3d4f	Notifications::WorkflowJob	default	{"job_id": "ae186a59-e036-4725-a410-814c10cd3d4f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.088345182Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.088539+00	2024-12-12 05:11:40.098503+00	\N	\N
12fb89d7-ab7f-4ed1-bcbe-c61d1e798011	2024-12-12 05:11:40.107666+00	2024-12-12 05:11:40.115067+00	5c6eec33-856c-4826-b7dc-ab2d63bee43a	Notifications::WorkflowJob	default	{"job_id": "5c6eec33-856c-4826-b7dc-ab2d63bee43a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.106409550Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.106599+00	2024-12-12 05:11:40.114918+00	\N	\N
951f5191-9cdd-4658-92c3-add35b67116a	2024-12-12 05:11:40.129963+00	2024-12-12 05:11:40.1372+00	6015f296-da11-4c99-acd7-cd2c78d41267	Notifications::WorkflowJob	default	{"job_id": "6015f296-da11-4c99-acd7-cd2c78d41267", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.128613880Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.128815+00	2024-12-12 05:11:40.137049+00	\N	\N
5f7edb06-529b-4e41-aff5-1a76aa86fcc3	2024-12-12 05:11:40.151896+00	2024-12-12 05:11:40.158906+00	37f3cc91-19c7-4454-b81c-d0adbb71db4d	Notifications::WorkflowJob	default	{"job_id": "37f3cc91-19c7-4454-b81c-d0adbb71db4d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.150616679Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.15081+00	2024-12-12 05:11:40.158746+00	\N	\N
9f0a3ab5-816e-4ada-86ae-b2ab0b25bb49	2024-12-12 05:11:40.169695+00	2024-12-12 05:11:40.176727+00	9e4eaea0-af8d-42f4-a1aa-6e7e4e709f98	Notifications::WorkflowJob	default	{"job_id": "9e4eaea0-af8d-42f4-a1aa-6e7e4e709f98", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.168387400Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.168574+00	2024-12-12 05:11:40.176545+00	\N	\N
2de74138-8061-4add-960e-095e41ec3097	2024-12-12 05:16:39.594717+00	2024-12-12 05:16:39.612478+00	6b1333e9-bb0a-41ed-9745-9dc39db9181e	Notifications::WorkflowJob	default	{"job_id": "6b1333e9-bb0a-41ed-9745-9dc39db9181e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.576956340Z", "scheduled_at": "2024-12-12T05:16:39.576660960Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.576661+00	2024-12-12 05:16:39.61131+00	\N	\N
b3ab80e0-763b-49fe-8a80-9c8148eea85d	2024-12-12 05:16:39.68256+00	2024-12-12 05:16:39.73249+00	c36ac149-fe78-4d44-a165-1d2fd7440c80	Journals::CompletedJob	default	{"job_id": "c36ac149-fe78-4d44-a165-1d2fd7440c80", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-12-12T05:11:39.588643000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.610061766Z", "scheduled_at": "2024-12-12T05:16:39.609833914Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.609833+00	2024-12-12 05:16:39.732201+00	\N	\N
b3119785-1245-4309-af8e-bd962c057b42	2024-12-12 05:16:39.788307+00	2024-12-12 05:16:40.036878+00	7796ff26-8747-4f86-8d2e-8bf96f264adc	Journals::CompletedJob	default	{"job_id": "7796ff26-8747-4f86-8d2e-8bf96f264adc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.690221000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.718270529Z", "scheduled_at": "2024-12-12T05:16:39.718061292Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.718061+00	2024-12-12 05:16:40.036614+00	\N	\N
d18ea86e-a116-4069-86e3-d52d7ca43e8e	2024-12-12 05:16:39.956131+00	2024-12-12 05:16:40.209689+00	1e23f241-a41c-472b-82ac-a62db4aec576	Journals::CompletedJob	default	{"job_id": "1e23f241-a41c-472b-82ac-a62db4aec576", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.787075000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.810797891Z", "scheduled_at": "2024-12-12T05:16:39.810594967Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.810595+00	2024-12-12 05:16:40.209447+00	\N	\N
c79b9585-6dcf-4158-9d36-68eb71f57f88	2024-12-12 03:17:31.241947+00	2024-12-12 03:17:31.265647+00	70b58a97-85cd-4648-8a3b-63ee73a6be89	Notifications::WorkflowJob	default	{"job_id": "70b58a97-85cd-4648-8a3b-63ee73a6be89", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/81"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:31.196586319Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:17:31.209216+00	2024-12-12 03:17:31.265234+00	\N	\N
2cfc731f-027d-414e-a52d-1a05b07e3de6	2024-12-11 10:15:00.083665+00	2024-12-11 10:15:00.118651+00	90751669-e99a-4a8a-a27b-9661baccb8a0	Notifications::ScheduleReminderMailsJob	default	{"job_id": "90751669-e99a-4a8a-a27b-9661baccb8a0", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:15:00.022511171Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:15:00.022921+00	2024-12-11 10:15:00.118426+00	\N	\N
cc4dff49-34aa-49c8-9426-4614d4a52052	2024-12-12 05:11:40.198969+00	2024-12-12 05:11:40.207639+00	123e0b96-93d7-47c9-a304-9ea76e92c3f2	Notifications::WorkflowJob	default	{"job_id": "123e0b96-93d7-47c9-a304-9ea76e92c3f2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.196870266Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.197558+00	2024-12-12 05:11:40.207479+00	\N	\N
0a628263-f54b-491d-a9c4-9cd28c54c032	2024-12-12 05:11:40.227783+00	2024-12-12 05:11:40.234975+00	c45588ee-fce5-4456-8d93-6f9e2a37913a	Notifications::WorkflowJob	default	{"job_id": "c45588ee-fce5-4456-8d93-6f9e2a37913a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.226176342Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.226368+00	2024-12-12 05:11:40.234819+00	\N	\N
0bc3aecb-7151-406c-b513-55a471cefc92	2024-12-12 05:11:40.244757+00	2024-12-12 05:11:40.251612+00	e76529c9-672f-47da-8750-6996270eafff	Notifications::WorkflowJob	default	{"job_id": "e76529c9-672f-47da-8750-6996270eafff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.243473746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.243665+00	2024-12-12 05:11:40.251466+00	\N	\N
bc5ae2b5-e12f-4097-a415-e63a28293735	2024-12-12 05:11:40.269372+00	2024-12-12 05:11:40.276344+00	21f600c6-e401-4d8b-adb3-f30f233ed491	Notifications::WorkflowJob	default	{"job_id": "21f600c6-e401-4d8b-adb3-f30f233ed491", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.268084376Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.268271+00	2024-12-12 05:11:40.276174+00	\N	\N
a5621e10-df19-4ba6-8167-0f15e8496da0	2024-12-12 05:11:40.285783+00	2024-12-12 05:11:40.292434+00	65d8c496-1e4d-4303-87d5-3310e4a806c2	Notifications::WorkflowJob	default	{"job_id": "65d8c496-1e4d-4303-87d5-3310e4a806c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.284520226Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.284703+00	2024-12-12 05:11:40.292271+00	\N	\N
dad25bce-3629-4bea-93dc-26dc926fb0ad	2024-12-12 05:11:40.308124+00	2024-12-12 05:11:40.315222+00	3a8fb5e2-228e-4fb6-be8c-b92960486d28	Notifications::WorkflowJob	default	{"job_id": "3a8fb5e2-228e-4fb6-be8c-b92960486d28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.306851898Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.307043+00	2024-12-12 05:11:40.315076+00	\N	\N
1f4ed550-9fdc-4f71-bf61-b89b06915c43	2024-12-12 05:16:39.602267+00	2024-12-12 05:16:39.692264+00	3b719e0b-ad68-4daa-932b-6633e9aeebb1	Journals::CompletedJob	default	{"job_id": "3b719e0b-ad68-4daa-932b-6633e9aeebb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-12-12T05:11:39.567864000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.580619470Z", "scheduled_at": "2024-12-12T05:16:39.580402559Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.580402+00	2024-12-12 05:16:39.692071+00	\N	\N
751bb247-01f5-43a3-a4d7-59ff7c39f590	2024-12-12 05:16:39.736671+00	2024-12-12 05:16:39.779459+00	b5b426b5-6ef6-44c8-8c77-7293a53e819c	Notifications::WorkflowJob	default	{"job_id": "b5b426b5-6ef6-44c8-8c77-7293a53e819c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.659846032Z", "scheduled_at": "2024-12-12T05:16:39.659653488Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.659653+00	2024-12-12 05:16:39.779294+00	\N	\N
49c4e534-e6a3-4fd3-8ba3-407d8ac47584	2024-12-12 05:16:39.852538+00	2024-12-12 05:16:40.129015+00	df191477-cf92-4125-a435-64e9b3f9c23e	Journals::CompletedJob	default	{"job_id": "df191477-cf92-4125-a435-64e9b3f9c23e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.762828000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.783172780Z", "scheduled_at": "2024-12-12T05:16:39.782974935Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.782974+00	2024-12-12 05:16:40.128724+00	\N	\N
54e13a27-b9b9-4e36-839a-0ea2b9293816	2024-12-12 05:16:40.022901+00	2024-12-12 05:16:40.200688+00	dd189965-029a-488d-b5b9-e91a3167716d	Notifications::WorkflowJob	default	{"job_id": "dd189965-029a-488d-b5b9-e91a3167716d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.824040012Z", "scheduled_at": "2024-12-12T05:16:39.823878005Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.823877+00	2024-12-12 05:16:40.200407+00	\N	\N
4b97c5cc-344a-40d2-828d-a775a23748e0	2024-12-12 03:15:00.179093+00	2024-12-12 03:15:00.342424+00	41360ba7-bd8f-46e1-a9d6-e891e67107db	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "41360ba7-bd8f-46e1-a9d6-e891e67107db", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:15:00.121716539Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:15:00.122706+00	2024-12-12 03:15:00.342005+00	\N	\N
692a8727-e9a8-46e3-a60e-0a5f6e2ba70a	2024-12-11 10:30:00.050327+00	2024-12-11 10:30:00.081742+00	bee5d49f-63b8-4872-858a-6c2cb3553c4d	Notifications::ScheduleReminderMailsJob	default	{"job_id": "bee5d49f-63b8-4872-858a-6c2cb3553c4d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.009356246Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.009851+00	2024-12-11 10:30:00.081422+00	\N	\N
294df23d-ddcc-4648-9f3a-e549b0aaf985	2024-12-11 10:30:00.069741+00	2024-12-11 10:30:00.0897+00	99f3eb89-3249-43a2-8aca-8b5587343262	LdapGroups::SynchronizationJob	default	{"job_id": "99f3eb89-3249-43a2-8aca-8b5587343262", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.028158610Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.02864+00	2024-12-11 10:30:00.088667+00	\N	\N
e92e73e3-1945-4a60-87f2-9584f191d18f	2024-12-12 05:11:40.324343+00	2024-12-12 05:11:40.331531+00	9f6435b0-2f97-4648-b4cf-aefa521aaecf	Notifications::WorkflowJob	default	{"job_id": "9f6435b0-2f97-4648-b4cf-aefa521aaecf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.323108470Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.32329+00	2024-12-12 05:11:40.331384+00	\N	\N
1de2bc99-d5cc-4d91-b05c-eb4e9ffb7e72	2024-12-12 05:11:40.763519+00	2024-12-12 05:11:40.775322+00	96d619ba-0553-45d4-99ae-4b45e4ae50c2	Notifications::WorkflowJob	default	{"job_id": "96d619ba-0553-45d4-99ae-4b45e4ae50c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/17"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.762100310Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.762328+00	2024-12-12 05:11:40.775164+00	\N	\N
8278f284-decb-487d-8e29-84df5daf8d35	2024-12-12 05:11:40.970468+00	2024-12-12 05:11:40.979765+00	9b64196f-d115-4989-a0ec-93726de05e41	Notifications::WorkflowJob	default	{"job_id": "9b64196f-d115-4989-a0ec-93726de05e41", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/18"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.969106006Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.96931+00	2024-12-12 05:11:40.979612+00	\N	\N
5b50f610-2a4c-430d-927d-9db8540f77b9	2024-12-12 05:11:40.999308+00	2024-12-12 05:11:41.007273+00	2d0500d6-a7ee-4cba-823b-b554ed15e4a2	Notifications::WorkflowJob	default	{"job_id": "2d0500d6-a7ee-4cba-823b-b554ed15e4a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/19"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.998031300Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.998221+00	2024-12-12 05:11:41.007123+00	\N	\N
b006a712-a0a5-40bb-90b0-60b114f9fe0a	2024-12-12 05:11:41.095829+00	2024-12-12 05:11:41.106607+00	d3d2fb23-fba7-4ba6-882b-0d3648e848a8	Notifications::WorkflowJob	default	{"job_id": "d3d2fb23-fba7-4ba6-882b-0d3648e848a8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/20"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.094451729Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.094646+00	2024-12-12 05:11:41.10646+00	\N	\N
b4dba2a0-e4a1-4cf9-8ce5-9d8b7074a547	2024-12-12 05:11:41.264329+00	2024-12-12 05:11:41.274252+00	94a8ef01-20fa-420f-87fc-cd6874ea317a	Notifications::WorkflowJob	default	{"job_id": "94a8ef01-20fa-420f-87fc-cd6874ea317a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/21"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.262336339Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.262523+00	2024-12-12 05:11:41.274092+00	\N	\N
ff1a4e74-3284-4ae1-972b-3d0c83d5fcf7	2024-12-12 05:16:39.718356+00	2024-12-12 05:16:39.763082+00	c08034e0-4001-4f3f-ab46-026a678463b7	Notifications::WorkflowJob	default	{"job_id": "c08034e0-4001-4f3f-ab46-026a678463b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.635439429Z", "scheduled_at": "2024-12-12T05:16:39.635268495Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.635268+00	2024-12-12 05:16:39.762847+00	\N	\N
883c2681-2bee-453a-8b56-5aac1208311d	2024-12-12 05:16:39.819929+00	2024-12-12 05:16:40.044417+00	793b77cd-044a-4a13-85e0-b73ecfa9f2eb	Journals::CompletedJob	default	{"job_id": "793b77cd-044a-4a13-85e0-b73ecfa9f2eb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.749243000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.760021615Z", "scheduled_at": "2024-12-12T05:16:39.759797631Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.759797+00	2024-12-12 05:16:40.044159+00	\N	\N
e46043cd-ac05-4ebc-8594-761cdfbdf65f	2024-12-12 05:16:40.045834+00	2024-12-12 05:16:40.316876+00	15f59e44-7569-4187-9f86-7c58d7903415	Journals::CompletedJob	default	{"job_id": "15f59e44-7569-4187-9f86-7c58d7903415", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.815975000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.827868455Z", "scheduled_at": "2024-12-12T05:16:39.827548770Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.827548+00	2024-12-12 05:16:40.316591+00	\N	\N
7bb1dfca-a3b6-41a7-90e0-bc98935d7563	2024-12-12 05:16:40.29973+00	2024-12-12 05:16:40.480764+00	a96cae93-61ff-4162-843f-ae2ffabab199	Notifications::WorkflowJob	default	{"job_id": "a96cae93-61ff-4162-843f-ae2ffabab199", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.983948783Z", "scheduled_at": "2024-12-12T05:16:39.983792677Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.983792+00	2024-12-12 05:16:40.480495+00	\N	\N
4fe4a339-75cc-408a-8b19-88dae0a61818	2024-12-11 10:30:00.077261+00	2024-12-11 10:30:00.101213+00	5a213f90-ea86-44ac-b69a-a39f3d5af2f9	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "5a213f90-ea86-44ac-b69a-a39f3d5af2f9", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.037498548Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.037651+00	2024-12-11 10:30:00.101042+00	\N	\N
3223f23b-bb5e-4cd6-920f-f9c8152f3094	2024-12-11 10:11:51.319682+00	2024-12-11 10:11:51.343261+00	175a69dc-8d18-48b7-9090-89c6caacd2ce	Journals::CompletedJob	default	{"job_id": "175a69dc-8d18-48b7-9090-89c6caacd2ce", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [80, {"value": "2024-12-11T10:06:51.258816000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, true], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.326107766Z", "scheduled_at": "2024-12-11T10:11:51.316779096Z", "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:11:51.316778+00	2024-12-11 10:11:51.3427+00	\N	\N
b6c2696c-ae36-44db-899b-438151eae6af	2024-12-12 05:11:41.311688+00	2024-12-12 05:11:41.319424+00	03caeeec-83ef-4654-a827-70753effb389	Notifications::WorkflowJob	default	{"job_id": "03caeeec-83ef-4654-a827-70753effb389", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.309377899Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.309574+00	2024-12-12 05:11:41.319276+00	\N	\N
da307b16-5505-4c1d-b248-dc36665284a5	2024-12-12 05:11:41.331707+00	2024-12-12 05:11:41.339278+00	46002419-9b91-468c-a788-64a68603067e	Notifications::WorkflowJob	default	{"job_id": "46002419-9b91-468c-a788-64a68603067e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.330304879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.330493+00	2024-12-12 05:11:41.339125+00	\N	\N
583f8c71-80a0-481b-8e96-b8652cfaa38f	2024-12-12 05:11:41.369868+00	2024-12-12 05:11:41.37785+00	0a4a5441-3a13-4fcd-b4ba-8865dd12ab73	Notifications::WorkflowJob	default	{"job_id": "0a4a5441-3a13-4fcd-b4ba-8865dd12ab73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.368175272Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.368365+00	2024-12-12 05:11:41.377693+00	\N	\N
7323e768-1d70-4919-8978-b918ce01d567	2024-12-12 05:11:41.38998+00	2024-12-12 05:11:41.398189+00	c300834c-5e27-47b9-94c0-8a8d10715146	Notifications::WorkflowJob	default	{"job_id": "c300834c-5e27-47b9-94c0-8a8d10715146", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.388535799Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.388725+00	2024-12-12 05:11:41.398039+00	\N	\N
a47b29d9-c3a5-48c5-bc42-4437c157b93f	2024-12-12 05:11:41.422501+00	2024-12-12 05:11:41.430395+00	217c112e-1839-42c6-83c0-6d9f361e842c	Notifications::WorkflowJob	default	{"job_id": "217c112e-1839-42c6-83c0-6d9f361e842c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.420803697Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.421007+00	2024-12-12 05:11:41.430243+00	\N	\N
6455b51d-4c53-4d39-90a7-ec2692caac6c	2024-12-12 05:11:41.4596+00	2024-12-12 05:11:41.467145+00	a01eb811-44b6-44ef-98d4-b1bd744d311b	Notifications::WorkflowJob	default	{"job_id": "a01eb811-44b6-44ef-98d4-b1bd744d311b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.457710415Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.457898+00	2024-12-12 05:11:41.467003+00	\N	\N
9be48ce2-895d-4225-867c-762c6df09364	2024-12-12 05:16:39.728592+00	2024-12-12 05:16:39.777206+00	6b9e366d-bf22-4553-affd-1d07d55d8300	Journals::CompletedJob	default	{"job_id": "6b9e366d-bf22-4553-affd-1d07d55d8300", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.615712000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.640018815Z", "scheduled_at": "2024-12-12T05:16:39.639810440Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.63981+00	2024-12-12 05:16:39.777046+00	\N	\N
be57a161-7e1b-48c6-b655-935ae5c247e2	2024-12-12 05:16:39.842459+00	2024-12-12 05:16:40.020228+00	c556477a-2565-463d-abdc-64def4036d20	Notifications::WorkflowJob	default	{"job_id": "c556477a-2565-463d-abdc-64def4036d20", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.779682076Z", "scheduled_at": "2024-12-12T05:16:39.779520079Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.77952+00	2024-12-12 05:16:40.01995+00	\N	\N
613a0e55-1a87-4b33-8442-97f5c0d587f5	2024-12-12 05:16:40.103452+00	2024-12-12 05:16:40.284627+00	bfff0189-055d-4878-89d6-6b60be06525e	Notifications::WorkflowJob	default	{"job_id": "bfff0189-055d-4878-89d6-6b60be06525e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.854803148Z", "scheduled_at": "2024-12-12T05:16:39.854376991Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.854377+00	2024-12-12 05:16:40.284485+00	\N	\N
c16f5060-983a-41ad-a735-eaa504d10d25	2024-12-12 05:16:40.265748+00	2024-12-12 05:16:40.45901+00	c347c7e8-358c-4ee8-a770-0753c1b9c4e6	Notifications::WorkflowJob	default	{"job_id": "c347c7e8-358c-4ee8-a770-0753c1b9c4e6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.954767864Z", "scheduled_at": "2024-12-12T05:16:39.954619893Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.954619+00	2024-12-12 05:16:40.458756+00	\N	\N
4448ce3c-4779-49bd-8b98-849854b0aadc	2024-12-11 10:11:51.464002+00	2024-12-11 10:11:51.486708+00	5f4a7f00-f237-48f3-90c5-e19354f534a9	Notifications::WorkflowJob	default	{"job_id": "5f4a7f00-f237-48f3-90c5-e19354f534a9", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.460841609Z", "scheduled_at": "2024-12-11T10:11:51.459093765Z", "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:11:51.459093+00	2024-12-11 10:11:51.483845+00	\N	\N
e0a98ede-2998-4d02-9144-28237c44b63f	2024-12-11 10:00:00.151622+00	2024-12-11 10:00:00.420252+00	b0688e97-6e69-49fe-82fb-97da60e92b8d	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "b0688e97-6e69-49fe-82fb-97da60e92b8d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.087238984Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.088277+00	2024-12-11 10:00:00.420017+00	\N	\N
f5c06d88-e948-4228-9390-49ac5edf4abd	2024-12-12 05:11:41.478952+00	2024-12-12 05:11:41.486267+00	ac55ea5a-aea9-4491-b112-0e7b3d4a15dc	Notifications::WorkflowJob	default	{"job_id": "ac55ea5a-aea9-4491-b112-0e7b3d4a15dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.477346750Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.477535+00	2024-12-12 05:11:41.486121+00	\N	\N
9687ebf5-c3be-4dd8-babf-f9b717846abd	2024-12-12 05:11:41.508384+00	2024-12-12 05:11:41.516295+00	387f9cac-a42f-48d5-a602-b8bc42b59f88	Notifications::WorkflowJob	default	{"job_id": "387f9cac-a42f-48d5-a602-b8bc42b59f88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.506856943Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.50705+00	2024-12-12 05:11:41.51614+00	\N	\N
be13a61e-7d88-4e4e-9639-a29d7549652e	2024-12-12 05:11:41.541017+00	2024-12-12 05:11:41.549036+00	d4d49186-49e2-45db-a5e1-61e4b26b7891	Notifications::WorkflowJob	default	{"job_id": "d4d49186-49e2-45db-a5e1-61e4b26b7891", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.539321113Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.539518+00	2024-12-12 05:11:41.548864+00	\N	\N
87b974db-f7e9-4755-9054-61096ae97225	2024-12-12 05:11:41.560842+00	2024-12-12 05:11:41.568006+00	730e909f-fcab-4a58-b52b-cd94c91870b9	Notifications::WorkflowJob	default	{"job_id": "730e909f-fcab-4a58-b52b-cd94c91870b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.559207361Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.559401+00	2024-12-12 05:11:41.567862+00	\N	\N
c38ed30a-206c-4dd4-acc6-6ce3e1819a3a	2024-12-12 05:11:41.586358+00	2024-12-12 05:11:41.593795+00	3712c2cb-20b8-4891-b17c-29d07c3619d9	Notifications::WorkflowJob	default	{"job_id": "3712c2cb-20b8-4891-b17c-29d07c3619d9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.584994290Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.585186+00	2024-12-12 05:11:41.593618+00	\N	\N
03542ee2-a83a-47f6-bdca-59a8319fba59	2024-12-12 05:11:41.619538+00	2024-12-12 05:11:41.626965+00	2daea336-81d8-447c-9ab2-d0692a0678e8	Notifications::WorkflowJob	default	{"job_id": "2daea336-81d8-447c-9ab2-d0692a0678e8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.617768256Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.617961+00	2024-12-12 05:11:41.626782+00	\N	\N
9eb06698-a26b-4f9d-bfec-034887b4a164	2024-12-12 05:16:39.773268+00	2024-12-12 05:16:39.831994+00	0fb96a69-92be-4c65-8498-41845b81b28b	Journals::CompletedJob	default	{"job_id": "0fb96a69-92be-4c65-8498-41845b81b28b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.643963000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.663679295Z", "scheduled_at": "2024-12-12T05:16:39.663452906Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.663452+00	2024-12-12 05:16:39.83187+00	\N	\N
71eb613b-79c1-4afb-a482-6bf770704208	2024-12-12 05:16:40.07577+00	2024-12-12 05:16:40.448995+00	00a6e9ed-2fa4-4a48-98de-bddb19a674aa	Journals::CompletedJob	default	{"job_id": "00a6e9ed-2fa4-4a48-98de-bddb19a674aa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.830992000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.858539458Z", "scheduled_at": "2024-12-12T05:16:39.858235442Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.858235+00	2024-12-12 05:16:40.448684+00	\N	\N
46d4b84e-c731-421c-9a92-c335cee8b90f	2024-12-12 05:16:40.286051+00	2024-12-12 05:16:40.494911+00	edc9b1f0-d37f-4d05-8812-859c4709dbde	Journals::CompletedJob	default	{"job_id": "edc9b1f0-d37f-4d05-8812-859c4709dbde", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.947018000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.958854226Z", "scheduled_at": "2024-12-12T05:16:39.958668514Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.958668+00	2024-12-12 05:16:40.494731+00	\N	\N
4175c714-35c5-4b6d-876c-ce8ed1b2dfb8	2024-12-12 05:16:40.686119+00	2024-12-12 05:16:40.850773+00	e819fd7e-9bc7-4daa-9ab5-9ad15ea38394	Journals::CompletedJob	default	{"job_id": "e819fd7e-9bc7-4daa-9ab5-9ad15ea38394", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-12-12T05:11:40.079898000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.100553755Z", "scheduled_at": "2024-12-12T05:16:40.100381138Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.100381+00	2024-12-12 05:16:40.850512+00	\N	\N
af38cccb-02c2-4381-b0b1-65cf2506fe16	2024-12-12 05:16:40.993798+00	2024-12-12 05:16:41.077847+00	f3aecf6f-cbe3-4236-a5e0-ff97f96ee360	Notifications::WorkflowJob	default	{"job_id": "f3aecf6f-cbe3-4236-a5e0-ff97f96ee360", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.274731149Z", "scheduled_at": "2024-12-12T05:16:40.274600302Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.2746+00	2024-12-12 05:16:41.077636+00	\N	\N
0fdd01ec-f48b-4e81-9226-7fe0c4f6a7c2	2024-12-11 10:00:00.415681+00	2024-12-11 10:00:00.439858+00	c76379a3-8375-451c-9e91-32cff2cfeeed	LdapGroups::SynchronizationJob	default	{"job_id": "c76379a3-8375-451c-9e91-32cff2cfeeed", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.099758627Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.100142+00	2024-12-11 10:00:00.439496+00	\N	\N
f6072f44-0bd3-4e82-9915-0f6a705669ce	2024-12-12 05:11:41.647521+00	2024-12-12 05:11:41.654841+00	6f92d2ff-6f67-4629-b894-fc5c7f8efcff	Notifications::WorkflowJob	default	{"job_id": "6f92d2ff-6f67-4629-b894-fc5c7f8efcff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.645791271Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.645984+00	2024-12-12 05:11:41.654693+00	\N	\N
8dfbffc1-9102-42d5-9373-679811149d85	2024-12-12 05:11:41.667083+00	2024-12-12 05:11:41.674256+00	8bef7c8b-e509-436b-b010-670b4caaab53	Notifications::WorkflowJob	default	{"job_id": "8bef7c8b-e509-436b-b010-670b4caaab53", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.665666489Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.665852+00	2024-12-12 05:11:41.674105+00	\N	\N
a9c10269-a97a-41df-9064-99a6881bef7a	2024-12-12 05:11:41.696204+00	2024-12-12 05:11:41.703953+00	711574e4-53cf-443a-99a2-075bc1615a8b	Notifications::WorkflowJob	default	{"job_id": "711574e4-53cf-443a-99a2-075bc1615a8b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.694495071Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.694691+00	2024-12-12 05:11:41.703746+00	\N	\N
1ad43730-69a6-45a7-8573-cff9221b9c3b	2024-12-12 05:11:41.717007+00	2024-12-12 05:11:41.726988+00	e2aa8d90-3427-4e55-a4c5-69d62261e16b	Notifications::WorkflowJob	default	{"job_id": "e2aa8d90-3427-4e55-a4c5-69d62261e16b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.715419507Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.715619+00	2024-12-12 05:11:41.726776+00	\N	\N
ac2ef5bf-0909-45e2-ae76-ae7c965c311b	2024-12-12 05:11:41.745644+00	2024-12-12 05:11:41.756748+00	cf0b2824-8864-436c-ad31-fb03cb660db3	Notifications::WorkflowJob	default	{"job_id": "cf0b2824-8864-436c-ad31-fb03cb660db3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.744346164Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.744538+00	2024-12-12 05:11:41.75659+00	\N	\N
84a1adee-61dd-4574-9b44-56ec03910465	2024-12-12 05:11:41.766065+00	2024-12-12 05:11:41.776269+00	99d5ba99-9195-4c6f-85d3-fe357e25e186	Notifications::WorkflowJob	default	{"job_id": "99d5ba99-9195-4c6f-85d3-fe357e25e186", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.764761455Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.764974+00	2024-12-12 05:11:41.776037+00	\N	\N
7f2eb34f-2081-4583-aff8-49e7c63a0ba8	2024-12-12 05:16:39.797142+00	2024-12-12 05:16:39.895686+00	27f293ea-996d-420a-bb0e-291ccf15a996	Notifications::WorkflowJob	default	{"job_id": "27f293ea-996d-420a-bb0e-291ccf15a996", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.679687096Z", "scheduled_at": "2024-12-12T05:16:39.679498428Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.679498+00	2024-12-12 05:16:39.894356+00	\N	\N
4413449c-eb03-4ea5-b785-2f472e6a5999	2024-12-12 05:16:40.145521+00	2024-12-12 05:16:40.348851+00	59235f6f-f167-4277-8dae-dd8a4e77c0a4	Notifications::WorkflowJob	default	{"job_id": "59235f6f-f167-4277-8dae-dd8a4e77c0a4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.873164779Z", "scheduled_at": "2024-12-12T05:16:39.872995117Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.872995+00	2024-12-12 05:16:40.348602+00	\N	\N
56292a42-9c96-40c4-8a96-c02783af37e0	2024-12-12 05:16:40.381586+00	2024-12-12 05:16:40.552161+00	4358ab45-6909-4238-9c59-dfe18ec7e870	Notifications::WorkflowJob	default	{"job_id": "4358ab45-6909-4238-9c59-dfe18ec7e870", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.008330829Z", "scheduled_at": "2024-12-12T05:16:40.008184011Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.008183+00	2024-12-12 05:16:40.551946+00	\N	\N
60c1b2a0-bfd5-4af2-9214-d0294a8e5a4a	2024-12-11 10:00:00.125531+00	2024-12-11 10:00:00.469033+00	96c84240-0c36-457d-9e2c-bf494f42ee51	Notifications::ScheduleReminderMailsJob	default	{"job_id": "96c84240-0c36-457d-9e2c-bf494f42ee51", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.034581711Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.059757+00	2024-12-11 10:00:00.468614+00	\N	\N
d3a7c135-cb7c-4718-9436-f1a543964a9e	2024-12-11 10:01:00.029172+00	2024-12-11 10:01:00.048963+00	106e6c38-457e-4a66-b1bb-bc4263b58eaf	Storages::ManageStorageIntegrationsJob	default	{"job_id": "106e6c38-457e-4a66-b1bb-bc4263b58eaf", "locale": "en", "priority": 7, "timezone": "UTC", "arguments": [], "job_class": "Storages::ManageStorageIntegrationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:01:00.018425847Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:01:00.019023+00	2024-12-11 10:01:00.048741+00	\N	\N
30e1e6a9-1707-4074-9bcf-396021635525	2024-12-11 10:06:51.337741+00	2024-12-11 10:06:51.466695+00	6ef3dd58-4742-4683-8a72-de28d2a0855e	Notifications::WorkflowJob	default	{"job_id": "6ef3dd58-4742-4683-8a72-de28d2a0855e", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/80"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.298760920Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:06:51.311583+00	2024-12-11 10:06:51.466493+00	\N	\N
ec3046cd-fed7-4053-8685-819145f326c3	2024-12-12 05:11:41.801519+00	2024-12-12 05:11:41.809185+00	0bd7b9db-b80a-47be-bc23-52450342420a	Notifications::WorkflowJob	default	{"job_id": "0bd7b9db-b80a-47be-bc23-52450342420a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.799756189Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.799967+00	2024-12-12 05:11:41.808877+00	\N	\N
29739f31-d171-49af-99d3-811eec486033	2024-12-12 05:11:41.820918+00	2024-12-12 05:11:41.829952+00	d852cb95-5643-4e5e-b60d-281c83c8985e	Notifications::WorkflowJob	default	{"job_id": "d852cb95-5643-4e5e-b60d-281c83c8985e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.819419185Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.819602+00	2024-12-12 05:11:41.829778+00	\N	\N
62e5a866-9d99-4dc8-8473-3d002baf869b	2024-12-12 05:11:41.855196+00	2024-12-12 05:11:41.862979+00	03b23537-164b-42b0-8724-cfa9e985192c	Notifications::WorkflowJob	default	{"job_id": "03b23537-164b-42b0-8724-cfa9e985192c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.853464772Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.853658+00	2024-12-12 05:11:41.86282+00	\N	\N
9cc7cf66-8c07-469b-8154-bf0cfca99245	2024-12-12 05:11:41.881566+00	2024-12-12 05:11:41.888653+00	57b33fc8-e3e6-4492-9630-50797996d91c	Notifications::WorkflowJob	default	{"job_id": "57b33fc8-e3e6-4492-9630-50797996d91c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.879798967Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.879986+00	2024-12-12 05:11:41.888497+00	\N	\N
6d7773b9-bfe6-42b1-85e3-0a26317912d7	2024-12-12 05:11:41.900336+00	2024-12-12 05:11:41.907302+00	d56e8ef2-c400-4907-8ef3-000aeb001443	Notifications::WorkflowJob	default	{"job_id": "d56e8ef2-c400-4907-8ef3-000aeb001443", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.898899887Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.899088+00	2024-12-12 05:11:41.907161+00	\N	\N
13c22c50-9328-4729-bb30-527c48b8530b	2024-12-12 05:11:41.926605+00	2024-12-12 05:11:41.934053+00	8a851b62-3f3b-432f-983d-e8683734433a	Notifications::WorkflowJob	default	{"job_id": "8a851b62-3f3b-432f-983d-e8683734433a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.924812844Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.925017+00	2024-12-12 05:11:41.933903+00	\N	\N
4db9ffe6-90fd-4228-bfb2-9ab98b6dd5d6	2024-12-12 05:16:39.798211+00	2024-12-12 05:16:39.981981+00	0220cb3a-647c-49fd-b8ab-4fb7e899559b	Journals::CompletedJob	default	{"job_id": "0220cb3a-647c-49fd-b8ab-4fb7e899559b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.670563000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.683439695Z", "scheduled_at": "2024-12-12T05:16:39.683218256Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.683218+00	2024-12-12 05:16:39.98061+00	\N	\N
fad661cd-6961-4fcb-a7fa-e310785bebb6	2024-12-12 05:16:40.226453+00	2024-12-12 05:16:40.569476+00	f25ce4d2-89d0-4517-a66f-e7a4efdf53cd	Journals::CompletedJob	default	{"job_id": "f25ce4d2-89d0-4517-a66f-e7a4efdf53cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.881035000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.917221844Z", "scheduled_at": "2024-12-12T05:16:39.915757440Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.915757+00	2024-12-12 05:16:40.569209+00	\N	\N
982e451b-b9e5-4fb9-a980-3352a8de96c7	2024-12-12 05:16:40.452548+00	2024-12-12 05:16:40.696648+00	aad3e900-a1a5-4583-82fb-db39dbf256e2	Journals::CompletedJob	default	{"job_id": "aad3e900-a1a5-4583-82fb-db39dbf256e2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:39.993512000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.011857832Z", "scheduled_at": "2024-12-12T05:16:40.011681417Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.011681+00	2024-12-12 05:16:40.696376+00	\N	\N
8c044a60-4199-418d-8e57-9c76f5e20b0c	2024-12-12 05:16:40.700472+00	2024-12-12 05:16:40.837494+00	7dd09a0e-eaec-4c9c-b3c1-66c4a4206e70	Notifications::WorkflowJob	default	{"job_id": "7dd09a0e-eaec-4c9c-b3c1-66c4a4206e70", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.113606926Z", "scheduled_at": "2024-12-12T05:16:40.113466320Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.113466+00	2024-12-12 05:16:40.837285+00	\N	\N
6dc50e07-0da2-4cd6-8748-1501fb7c4586	2024-12-12 05:16:40.784303+00	2024-12-12 05:16:40.932089+00	fe958cbf-402c-4530-8d06-148763ab5a77	Notifications::WorkflowJob	default	{"job_id": "fe958cbf-402c-4530-8d06-148763ab5a77", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.157438644Z", "scheduled_at": "2024-12-12T05:16:40.157297557Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.157297+00	2024-12-12 05:16:40.931884+00	\N	\N
62091010-782c-4819-b725-b0b4d28260dd	2024-12-12 05:11:41.945246+00	2024-12-12 05:11:41.952456+00	4ff24af5-bdf8-494e-8c46-946311ccca63	Notifications::WorkflowJob	default	{"job_id": "4ff24af5-bdf8-494e-8c46-946311ccca63", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.943817292Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.944002+00	2024-12-12 05:11:41.952312+00	\N	\N
699cff53-23fc-4e79-a0c8-d5162d6427c7	2024-12-12 05:11:41.978336+00	2024-12-12 05:11:41.985795+00	10f7b38c-4229-48d8-a022-5ceaa0429aca	Notifications::WorkflowJob	default	{"job_id": "10f7b38c-4229-48d8-a022-5ceaa0429aca", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.976588624Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.976784+00	2024-12-12 05:11:41.985644+00	\N	\N
9b8e8bac-cfe5-4e5a-94de-e375f304d7c2	2024-12-12 05:11:41.997502+00	2024-12-12 05:11:42.00452+00	2c34cd19-5232-4991-84a3-94c1cb1b4fb1	Notifications::WorkflowJob	default	{"job_id": "2c34cd19-5232-4991-84a3-94c1cb1b4fb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.996058143Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.996247+00	2024-12-12 05:11:42.004373+00	\N	\N
35f49984-5779-4579-b977-714df1c6d960	2024-12-12 05:11:42.029655+00	2024-12-12 05:11:42.03675+00	3e7596fa-a3a7-4b2b-b7ea-1863aa705eb1	Notifications::WorkflowJob	default	{"job_id": "3e7596fa-a3a7-4b2b-b7ea-1863aa705eb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.027797529Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.027986+00	2024-12-12 05:11:42.036611+00	\N	\N
ce09d292-1a94-4d2e-a8b1-1f60a682651a	2024-12-12 05:11:42.04828+00	2024-12-12 05:11:42.055241+00	239747a1-0641-4d11-b448-acbbd04d8412	Notifications::WorkflowJob	default	{"job_id": "239747a1-0641-4d11-b448-acbbd04d8412", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.046755540Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.04694+00	2024-12-12 05:11:42.055101+00	\N	\N
03028d58-4b03-4df8-ae02-988a6ae32c2f	2024-12-12 05:11:42.079573+00	2024-12-12 05:11:42.086723+00	9bb48d66-689b-45f5-a49f-3b47ac1e17e0	Notifications::WorkflowJob	default	{"job_id": "9bb48d66-689b-45f5-a49f-3b47ac1e17e0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.077732271Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.077922+00	2024-12-12 05:11:42.086582+00	\N	\N
6e4bbafa-326d-402f-a320-a8dc0f0306eb	2024-12-12 05:16:39.799434+00	2024-12-12 05:16:39.90863+00	b0667920-1841-4687-9a9a-20d3bed5fc51	Notifications::WorkflowJob	default	{"job_id": "b0667920-1841-4687-9a9a-20d3bed5fc51", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.738305710Z", "scheduled_at": "2024-12-12T05:16:39.738139445Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.738139+00	2024-12-12 05:16:39.908312+00	\N	\N
e053e631-58e2-4fca-801a-ba0a385073e5	2024-12-12 05:16:40.152564+00	2024-12-12 05:16:40.404506+00	242cc540-cb9b-4782-8ad7-601f7164345b	Journals::CompletedJob	default	{"job_id": "242cc540-cb9b-4782-8ad7-601f7164345b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.864781000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.877646760Z", "scheduled_at": "2024-12-12T05:16:39.876851804Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.876851+00	2024-12-12 05:16:40.404232+00	\N	\N
a7b85448-0368-4e38-b33d-04184aef9169	2024-12-12 05:16:40.465623+00	2024-12-12 05:16:40.638575+00	b21df8b3-b513-44a7-86ba-2e4a30b46ae4	Notifications::WorkflowJob	default	{"job_id": "b21df8b3-b513-44a7-86ba-2e4a30b46ae4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.025671846Z", "scheduled_at": "2024-12-12T05:16:40.024773103Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.024773+00	2024-12-12 05:16:40.636999+00	\N	\N
36f41ca0-976a-424a-ba64-6bafb4914812	2024-12-12 05:11:42.098401+00	2024-12-12 05:11:42.105614+00	00d092a9-b0bd-414c-971b-977a1df0783c	Notifications::WorkflowJob	default	{"job_id": "00d092a9-b0bd-414c-971b-977a1df0783c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.096877746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.097073+00	2024-12-12 05:11:42.10547+00	\N	\N
3dbb585c-d015-4c35-a4b6-708dab22afb4	2024-12-12 05:11:42.130086+00	2024-12-12 05:11:42.13703+00	34702ddb-1877-4409-bb1e-384adfdd62c3	Notifications::WorkflowJob	default	{"job_id": "34702ddb-1877-4409-bb1e-384adfdd62c3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.128294321Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.128483+00	2024-12-12 05:11:42.136875+00	\N	\N
bef7b41e-1d2d-4875-905e-687a39528a18	2024-12-12 05:11:42.148379+00	2024-12-12 05:11:42.155472+00	004b298f-075c-4666-9f30-93a75c011abf	Notifications::WorkflowJob	default	{"job_id": "004b298f-075c-4666-9f30-93a75c011abf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.146958244Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.14715+00	2024-12-12 05:11:42.155327+00	\N	\N
88ae1b82-0e04-41cc-9a38-3c2cdfa4488f	2024-12-12 05:11:42.180702+00	2024-12-12 05:11:42.188962+00	3a6b6c72-cfcc-49c5-9103-ef9ad8a71130	Notifications::WorkflowJob	default	{"job_id": "3a6b6c72-cfcc-49c5-9103-ef9ad8a71130", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.178967051Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.179163+00	2024-12-12 05:11:42.188807+00	\N	\N
8eac3715-3a77-47d4-a15d-124f61546d49	2024-12-12 05:11:42.208171+00	2024-12-12 05:11:42.215687+00	97fed273-19ad-4d6e-9798-79007dd0a194	Notifications::WorkflowJob	default	{"job_id": "97fed273-19ad-4d6e-9798-79007dd0a194", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.206478336Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.206676+00	2024-12-12 05:11:42.21553+00	\N	\N
98b5814f-0e85-4dc6-806e-e2fd774d37aa	2024-12-12 05:11:42.227539+00	2024-12-12 05:11:42.234709+00	2f6c05df-7d9d-4bb7-96ec-93bcc540d7ff	Notifications::WorkflowJob	default	{"job_id": "2f6c05df-7d9d-4bb7-96ec-93bcc540d7ff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.225842396Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.226075+00	2024-12-12 05:11:42.234564+00	\N	\N
30dc703b-9993-476f-9135-15cbb9177ae3	2024-12-12 05:16:39.801134+00	2024-12-12 05:16:39.933021+00	f2f93f58-072d-40e4-bb55-d73915f30b73	Notifications::WorkflowJob	default	{"job_id": "f2f93f58-072d-40e4-bb55-d73915f30b73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.713918353Z", "scheduled_at": "2024-12-12T05:16:39.713748551Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.713748+00	2024-12-12 05:16:39.932585+00	\N	\N
95fc6f1c-c704-4b04-8bbb-35b0c559c8c0	2024-12-12 05:16:40.173786+00	2024-12-12 05:16:40.375015+00	0c18000f-ff98-4a0a-9269-46d3960c7717	Notifications::WorkflowJob	default	{"job_id": "0c18000f-ff98-4a0a-9269-46d3960c7717", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.911443216Z", "scheduled_at": "2024-12-12T05:16:39.910107776Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.910107+00	2024-12-12 05:16:40.374753+00	\N	\N
0492f7c4-b97e-4cf7-8390-326f160e7580	2024-12-12 05:16:40.524347+00	2024-12-12 05:16:40.767954+00	61d5324e-76e7-4515-ba6b-9e802b2fa1f5	Journals::CompletedJob	default	{"job_id": "61d5324e-76e7-4515-ba6b-9e802b2fa1f5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:40.017469000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.029524395Z", "scheduled_at": "2024-12-12T05:16:40.029061398Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.029061+00	2024-12-12 05:16:40.767727+00	\N	\N
115eb241-af88-44ef-be5e-f78dce04bc01	2024-12-12 05:16:40.603676+00	2024-12-12 05:16:40.779642+00	20cc6fde-9c69-4d36-a610-7b865c471cd4	Notifications::WorkflowJob	default	{"job_id": "20cc6fde-9c69-4d36-a610-7b865c471cd4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.070538364Z", "scheduled_at": "2024-12-12T05:16:40.070395253Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.070395+00	2024-12-12 05:16:40.779402+00	\N	\N
04ed0f9c-d06d-4d6d-92bf-e63240f4a982	2024-12-12 05:11:42.254105+00	2024-12-12 05:11:42.261648+00	a2914155-a44b-4ab1-9956-90e54735de1b	Notifications::WorkflowJob	default	{"job_id": "a2914155-a44b-4ab1-9956-90e54735de1b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.252672881Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.252867+00	2024-12-12 05:11:42.261498+00	\N	\N
3eea6102-ccbf-474d-b480-a29614cb213f	2024-12-12 05:11:42.272506+00	2024-12-12 05:11:42.280384+00	33e6c480-4f22-4a66-ad6a-f673f63f0a1d	Notifications::WorkflowJob	default	{"job_id": "33e6c480-4f22-4a66-ad6a-f673f63f0a1d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.271104904Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.271291+00	2024-12-12 05:11:42.28023+00	\N	\N
5cf0d0de-5ddf-4976-abf3-5728d71a03bb	2024-12-12 05:11:42.311827+00	2024-12-12 05:11:42.322959+00	800c48ff-5fb9-46c1-8c8b-8df67e9045e1	Notifications::WorkflowJob	default	{"job_id": "800c48ff-5fb9-46c1-8c8b-8df67e9045e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.309298720Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.309541+00	2024-12-12 05:11:42.322809+00	\N	\N
7a96798d-3493-488f-a5cb-fa17f8deee27	2024-12-12 05:11:42.343237+00	2024-12-12 05:11:42.357021+00	0fe98cbf-293b-46cb-853a-ad64bb94a90e	Notifications::WorkflowJob	default	{"job_id": "0fe98cbf-293b-46cb-853a-ad64bb94a90e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.340636555Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.340826+00	2024-12-12 05:11:42.356852+00	\N	\N
6978a808-3418-4273-a5b0-03200fb127b2	2024-12-12 05:11:42.390405+00	2024-12-12 05:11:42.404052+00	2af64997-d854-4a09-87a7-63026929b180	Notifications::WorkflowJob	default	{"job_id": "2af64997-d854-4a09-87a7-63026929b180", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.386027468Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.386217+00	2024-12-12 05:11:42.403866+00	\N	\N
6f4e2b66-0a63-4a2f-938a-a95b3e773ff0	2024-12-12 05:11:42.424113+00	2024-12-12 05:11:42.437855+00	afbd9f05-9e18-43c3-abc5-34567c5cff3b	Notifications::WorkflowJob	default	{"job_id": "afbd9f05-9e18-43c3-abc5-34567c5cff3b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.422184915Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.42285+00	2024-12-12 05:11:42.437382+00	\N	\N
56db44be-cef6-459d-a23f-27e8142187ab	2024-12-12 05:16:39.809049+00	2024-12-12 05:16:40.011444+00	18950377-0230-4572-a224-b4dc6a23846e	Journals::CompletedJob	default	{"job_id": "18950377-0230-4572-a224-b4dc6a23846e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.722974000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.741962268Z", "scheduled_at": "2024-12-12T05:16:39.741752230Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.741752+00	2024-12-12 05:16:40.003114+00	\N	\N
36995ff1-abde-48b7-842e-9b65ea33d9f9	2024-12-12 05:16:40.249964+00	2024-12-12 05:16:40.471472+00	1e529fd6-eeb7-4c0b-8d9e-aeeea8ab5722	Journals::CompletedJob	default	{"job_id": "1e529fd6-eeb7-4c0b-8d9e-aeeea8ab5722", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.921022000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.941389976Z", "scheduled_at": "2024-12-12T05:16:39.940828833Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.940829+00	2024-12-12 05:16:40.471224+00	\N	\N
122581ec-bfb6-4b1c-8f07-dbd0901c24fe	2024-12-12 05:16:40.545933+00	2024-12-12 05:16:40.736587+00	08b8466b-b762-408b-9cd9-f9f4946e443f	Notifications::WorkflowJob	default	{"job_id": "08b8466b-b762-408b-9cd9-f9f4946e443f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.051037186Z", "scheduled_at": "2024-12-12T05:16:40.050639643Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.050639+00	2024-12-12 05:16:40.736338+00	\N	\N
7a481a72-35bd-4e2b-91bb-0af93d528e40	2024-12-12 05:16:40.738722+00	2024-12-12 05:16:40.85951+00	2c957247-54e2-4c5d-a451-d44c35b5219f	Notifications::WorkflowJob	default	{"job_id": "2c957247-54e2-4c5d-a451-d44c35b5219f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.135718481Z", "scheduled_at": "2024-12-12T05:16:40.135577334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.135577+00	2024-12-12 05:16:40.859253+00	\N	\N
bf1fa737-0025-47c5-a277-7c11f59a985b	2024-12-12 05:16:40.712818+00	2024-12-12 05:16:40.960474+00	79cf40ab-f98b-4ce5-b0fa-40c6c5fd2c0d	Journals::CompletedJob	default	{"job_id": "79cf40ab-f98b-4ce5-b0fa-40c6c5fd2c0d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-12-12T05:11:40.105614000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.116751774Z", "scheduled_at": "2024-12-12T05:16:40.116582984Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.116582+00	2024-12-12 05:16:40.960188+00	\N	\N
eee62fd5-212e-4427-964a-b5efd66e91a0	2024-12-12 05:11:42.470916+00	2024-12-12 05:11:42.482082+00	4c1609cd-e989-42d6-afef-49fef0103988	Notifications::WorkflowJob	default	{"job_id": "4c1609cd-e989-42d6-afef-49fef0103988", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.468821047Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.469025+00	2024-12-12 05:11:42.481933+00	\N	\N
b8fa69e1-0a16-432e-b308-83926c7c1823	2024-12-12 05:11:42.500875+00	2024-12-12 05:11:42.51503+00	64af2838-aa3c-4db2-a8d4-2afaebfbb8ab	Notifications::WorkflowJob	default	{"job_id": "64af2838-aa3c-4db2-a8d4-2afaebfbb8ab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.499145252Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.499333+00	2024-12-12 05:11:42.514878+00	\N	\N
ee2bb713-656b-4694-ae52-cc8c6a1a61fd	2024-12-12 05:11:42.541083+00	2024-12-12 05:11:42.552254+00	3b0976c9-aea3-4040-9746-cef17e90a5f5	Notifications::WorkflowJob	default	{"job_id": "3b0976c9-aea3-4040-9746-cef17e90a5f5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.539004774Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.539197+00	2024-12-12 05:11:42.552081+00	\N	\N
6f824316-fd71-48b8-884b-22b719e9c760	2024-12-12 05:11:42.568069+00	2024-12-12 05:11:42.580432+00	0e3fecc5-a7fa-4e73-9540-b002abc79b45	Notifications::WorkflowJob	default	{"job_id": "0e3fecc5-a7fa-4e73-9540-b002abc79b45", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.566076546Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.566268+00	2024-12-12 05:11:42.579921+00	\N	\N
e2f85f0f-303d-44a6-99a0-000d04030584	2024-12-12 05:11:42.605909+00	2024-12-12 05:11:42.617155+00	123f8421-edb0-4335-9f87-1ad1f543baae	Notifications::WorkflowJob	default	{"job_id": "123f8421-edb0-4335-9f87-1ad1f543baae", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.603545158Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.604025+00	2024-12-12 05:11:42.616987+00	\N	\N
db420209-7947-49de-b470-c3d0051621bb	2024-12-12 05:11:42.633425+00	2024-12-12 05:11:42.643592+00	3784ce7b-8768-448b-856b-8942bd4f975c	Notifications::WorkflowJob	default	{"job_id": "3784ce7b-8768-448b-856b-8942bd4f975c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.631148107Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.631332+00	2024-12-12 05:11:42.643398+00	\N	\N
45b4db4e-4b8a-4bca-8bca-e20c89e10dc3	2024-12-12 05:16:39.825264+00	2024-12-12 05:16:39.994971+00	c29244ec-3b73-43b8-8343-bedead59d6d2	Notifications::WorkflowJob	default	{"job_id": "c29244ec-3b73-43b8-8343-bedead59d6d2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.756819969Z", "scheduled_at": "2024-12-12T05:16:39.756582469Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.756582+00	2024-12-12 05:16:39.994498+00	\N	\N
59b77d2b-72a1-42e9-b4a2-91b459d5bd8f	2024-12-12 05:16:40.238551+00	2024-12-12 05:16:40.422487+00	3f682f21-fb16-4dba-a0c3-73ed655a85ea	Notifications::WorkflowJob	default	{"job_id": "3f682f21-fb16-4dba-a0c3-73ed655a85ea", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.937718720Z", "scheduled_at": "2024-12-12T05:16:39.937568265Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.937568+00	2024-12-12 05:16:40.422233+00	\N	\N
e4e15c41-b618-476d-a2e6-57b59e8bb89b	2024-12-12 05:16:40.673863+00	2024-12-12 05:16:40.813707+00	257c694a-d8ee-48e7-9858-42f5623e75cf	Notifications::WorkflowJob	default	{"job_id": "257c694a-d8ee-48e7-9858-42f5623e75cf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.096936832Z", "scheduled_at": "2024-12-12T05:16:40.096720622Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.09672+00	2024-12-12 05:16:40.813462+00	\N	\N
6ace30e8-f058-48ee-a64a-dcd90439eaee	2024-12-12 05:16:40.579959+00	2024-12-12 05:16:40.925912+00	bc159cc0-cca4-4838-af39-27e4278d60b8	Journals::CompletedJob	default	{"job_id": "bc159cc0-cca4-4838-af39-27e4278d60b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:40.032201000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.054285660Z", "scheduled_at": "2024-12-12T05:16:40.054114075Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.054114+00	2024-12-12 05:16:40.925712+00	\N	\N
69a51872-f7c9-43c3-a065-7182265be9aa	2024-12-12 05:11:42.674288+00	2024-12-12 05:11:42.68759+00	8fc4e55c-b86e-4b05-b8b3-8fd897162e7a	Notifications::WorkflowJob	default	{"job_id": "8fc4e55c-b86e-4b05-b8b3-8fd897162e7a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.671863762Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.672057+00	2024-12-12 05:11:42.68744+00	\N	\N
988e31e7-e19e-4d61-bd61-611c033b8766	2024-12-12 05:11:42.707415+00	2024-12-12 05:11:42.719118+00	b9e23133-ae87-47aa-ade0-d9ff4352425b	Notifications::WorkflowJob	default	{"job_id": "b9e23133-ae87-47aa-ade0-d9ff4352425b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.704053622Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.704243+00	2024-12-12 05:11:42.718637+00	\N	\N
27459589-7f1d-4076-8a97-8f3541034b2b	2024-12-12 05:11:42.748186+00	2024-12-12 05:11:42.76085+00	d3ae65ac-4700-4035-8cce-ed142e37bc2d	Notifications::WorkflowJob	default	{"job_id": "d3ae65ac-4700-4035-8cce-ed142e37bc2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.745230849Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.745421+00	2024-12-12 05:11:42.760617+00	\N	\N
49924d82-3f92-45d9-a80b-fd60db4f29a4	2024-12-12 05:11:42.785089+00	2024-12-12 05:11:42.801326+00	3ec9396e-c6e0-4f23-bb11-cdf426ddf1b7	Notifications::WorkflowJob	default	{"job_id": "3ec9396e-c6e0-4f23-bb11-cdf426ddf1b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.781856235Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.782202+00	2024-12-12 05:11:42.801082+00	\N	\N
7e95b657-393a-488f-8a4f-3080f330246a	2024-12-12 05:11:43.205126+00	2024-12-12 05:11:43.213749+00	af59599b-eafa-46b7-8043-2139e3d643ad	Notifications::WorkflowJob	default	{"job_id": "af59599b-eafa-46b7-8043-2139e3d643ad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/45"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.203842450Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:43.204038+00	2024-12-12 05:11:43.213597+00	\N	\N
d56ed45b-aab4-41ea-9a1d-c671fe40d93a	2024-12-12 05:11:43.282599+00	2024-12-12 05:11:43.289283+00	a428a492-8728-4b1a-810c-a368439ea1ed	Notifications::WorkflowJob	default	{"job_id": "a428a492-8728-4b1a-810c-a368439ea1ed", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/46"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.281392354Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:43.281584+00	2024-12-12 05:11:43.289141+00	\N	\N
d568fecf-07f9-4ee8-bfcf-100107c936cb	2024-12-12 05:16:39.938404+00	2024-12-12 05:16:40.117322+00	4e8f7703-8fa5-4371-9247-1b121da61313	Notifications::WorkflowJob	default	{"job_id": "4e8f7703-8fa5-4371-9247-1b121da61313", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.806933790Z", "scheduled_at": "2024-12-12T05:16:39.806621529Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.806621+00	2024-12-12 05:16:40.116042+00	\N	\N
a09978ab-6dba-4b5b-a1f5-3c33e7ec699b	2024-12-12 05:16:40.370907+00	2024-12-12 05:16:40.76097+00	aeecb719-ec0c-4b75-9aad-f67386f7e3d3	Journals::CompletedJob	default	{"job_id": "aeecb719-ec0c-4b75-9aad-f67386f7e3d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.961736000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.989339787Z", "scheduled_at": "2024-12-12T05:16:39.989152592Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.989152+00	2024-12-12 05:16:40.760601+00	\N	\N
1151d9bd-bdc5-4ed7-8d7f-f514c8131129	2024-12-12 05:16:40.748565+00	2024-12-12 05:16:40.903525+00	75f87ccf-7881-4848-b7b0-f0427a8a2ed4	Journals::CompletedJob	default	{"job_id": "75f87ccf-7881-4848-b7b0-f0427a8a2ed4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-12-12T05:11:40.120523000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.138894007Z", "scheduled_at": "2024-12-12T05:16:40.138726089Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.138726+00	2024-12-12 05:16:40.903254+00	\N	\N
ffe444e5-e834-49f4-900c-df15fda81563	2024-12-12 05:16:40.936184+00	2024-12-12 05:16:41.031945+00	e37bf894-5245-44d1-9ec1-0ee590d75bdc	Journals::CompletedJob	default	{"job_id": "e37bf894-5245-44d1-9ec1-0ee590d75bdc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.184770000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.213626654Z", "scheduled_at": "2024-12-12T05:16:40.213097321Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.213097+00	2024-12-12 05:16:41.031746+00	\N	\N
44b2d9c7-cd88-486b-b071-47a60d708851	2024-12-12 05:16:41.190572+00	2024-12-12 05:16:41.286406+00	f09ab1d8-6ae2-4999-bd9e-8ff4f3dbb4af	Notifications::WorkflowJob	default	{"job_id": "f09ab1d8-6ae2-4999-bd9e-8ff4f3dbb4af", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.105115973Z", "scheduled_at": "2024-12-12T05:16:41.104973954Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.104974+00	2024-12-12 05:16:41.286157+00	\N	\N
24c9768e-41d7-43ad-aa66-b0e360dda47b	2024-12-12 05:16:40.795273+00	2024-12-12 05:16:40.951639+00	d6247004-8fde-4364-a96f-64391b6fd3ee	Journals::CompletedJob	default	{"job_id": "d6247004-8fde-4364-a96f-64391b6fd3ee", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.142513000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.161382286Z", "scheduled_at": "2024-12-12T05:16:40.161205942Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.161206+00	2024-12-12 05:16:40.951423+00	\N	\N
c64423f3-7969-41d8-b509-73fb9732913b	2024-12-12 05:16:41.034946+00	2024-12-12 05:16:41.14278+00	c4ea7dd5-b37d-49ff-bd75-e11647a974b9	Notifications::WorkflowJob	default	{"job_id": "c4ea7dd5-b37d-49ff-bd75-e11647a974b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.330115786Z", "scheduled_at": "2024-12-12T05:16:40.329981512Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.329981+00	2024-12-12 05:16:41.142527+00	\N	\N
26192678-fc8f-41c9-945e-d4edd95e740e	2024-12-12 05:16:41.328661+00	2024-12-12 05:16:41.396767+00	d8d33613-ccbc-41ad-a676-a760913af035	Journals::CompletedJob	default	{"job_id": "d8d33613-ccbc-41ad-a676-a760913af035", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [21, {"value": "2024-12-12T05:11:41.254043000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.277438313Z", "scheduled_at": "2024-12-12T05:16:41.277153764Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.277153+00	2024-12-12 05:16:41.396501+00	\N	\N
6fe88f16-a3b4-4f48-a927-384d04f78b1a	2024-12-12 05:16:41.49441+00	2024-12-12 05:16:41.537662+00	02dc4eca-cf10-4afd-a675-dae20eb493a7	Notifications::WorkflowJob	default	{"job_id": "02dc4eca-cf10-4afd-a675-dae20eb493a7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.465637334Z", "scheduled_at": "2024-12-12T05:16:41.465519170Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.465519+00	2024-12-12 05:16:41.53751+00	\N	\N
dcdf70ad-26b2-4fb3-a11b-812f4c793912	2024-12-12 05:16:41.620521+00	2024-12-12 05:16:41.696314+00	8ffa6d8e-1cc3-460f-9a81-c30c0d001cc1	Journals::CompletedJob	default	{"job_id": "8ffa6d8e-1cc3-460f-9a81-c30c0d001cc1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.572765000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.595701436Z", "scheduled_at": "2024-12-12T05:16:41.595546072Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.595546+00	2024-12-12 05:16:41.696049+00	\N	\N
f9f8ca01-479d-48c5-ad31-55db2cd15c49	2024-12-12 05:16:41.813934+00	2024-12-12 05:16:42.053934+00	cf3d8952-4e06-41e0-a70e-2f4a70402e31	Journals::CompletedJob	default	{"job_id": "cf3d8952-4e06-41e0-a70e-2f4a70402e31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.732652000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.758298360Z", "scheduled_at": "2024-12-12T05:16:41.758161561Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.758161+00	2024-12-12 05:16:42.053726+00	\N	\N
15ca8a7b-8c95-4aa1-9fd3-73554a5befcd	2024-12-12 05:16:40.840626+00	2024-12-12 05:16:40.965889+00	e371569c-fa5c-489f-8763-713b7dd8ba0f	Notifications::WorkflowJob	default	{"job_id": "e371569c-fa5c-489f-8763-713b7dd8ba0f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.175106450Z", "scheduled_at": "2024-12-12T05:16:40.174967106Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.174967+00	2024-12-12 05:16:40.965765+00	\N	\N
2089a9dc-3a11-4473-905e-bf4c88aeba0f	2024-12-12 05:16:41.060798+00	2024-12-12 05:16:41.175158+00	7c9c5059-6301-4a02-a84d-505bf8d9d7a3	Notifications::WorkflowJob	default	{"job_id": "7c9c5059-6301-4a02-a84d-505bf8d9d7a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.773757618Z", "scheduled_at": "2024-12-12T05:16:40.773628964Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.773628+00	2024-12-12 05:16:41.174902+00	\N	\N
4a54681c-9a69-4a85-86e7-8cba5fda3aa7	2024-12-12 05:16:41.375285+00	2024-12-12 05:16:41.480298+00	a4f4e6c0-4436-4238-ac5d-55e5773883fa	Journals::CompletedJob	default	{"job_id": "a4f4e6c0-4436-4238-ac5d-55e5773883fa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-12-12T05:11:41.329266000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.341081397Z", "scheduled_at": "2024-12-12T05:16:41.340937975Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.340938+00	2024-12-12 05:16:41.480168+00	\N	\N
5e26369d-5516-453a-83f8-2ec7d9c721ea	2024-12-12 05:16:41.600249+00	2024-12-12 05:16:41.638368+00	ad868684-e514-4328-aa54-278df3e3c199	Notifications::WorkflowJob	default	{"job_id": "ad868684-e514-4328-aa54-278df3e3c199", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.566526038Z", "scheduled_at": "2024-12-12T05:16:41.566409567Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.566409+00	2024-12-12 05:16:41.638076+00	\N	\N
061c25ca-aceb-4066-a892-a19b6d33b47a	2024-12-12 05:16:41.760994+00	2024-12-12 05:16:41.885594+00	8cf66b9e-1fbc-4616-a23a-3f800db9ccba	Notifications::WorkflowJob	default	{"job_id": "8cf66b9e-1fbc-4616-a23a-3f800db9ccba", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.724521522Z", "scheduled_at": "2024-12-12T05:16:41.724355617Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.724355+00	2024-12-12 05:16:41.885363+00	\N	\N
3c4752a9-f52f-47d2-9aae-529d54dbea56	2024-12-12 05:16:42.059099+00	2024-12-12 05:16:42.145344+00	c15da142-4fb3-4772-ac89-d443e9d09af2	Journals::CompletedJob	default	{"job_id": "c15da142-4fb3-4772-ac89-d443e9d09af2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.897905000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.909398139Z", "scheduled_at": "2024-12-12T05:16:41.909211155Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.909211+00	2024-12-12 05:16:42.145103+00	\N	\N
de3d798c-9b9f-4d0b-a4a1-16b0cfd4ddd5	2024-12-12 05:45:00.026927+00	2024-12-12 05:45:00.034337+00	b6c54e10-04c0-4402-8e5e-5c7f8471e36a	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "b6c54e10-04c0-4402-8e5e-5c7f8471e36a", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:45:00.006350401Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:45:00.006637+00	2024-12-12 05:45:00.034187+00	\N	\N
c18168b1-e48d-448c-b877-3e3019617867	2024-12-12 05:45:00.04638+00	2024-12-12 05:45:00.057445+00	7f4c0149-d6bf-40eb-a836-9a59f6da9f58	Notifications::ScheduleReminderMailsJob	default	{"job_id": "7f4c0149-d6bf-40eb-a836-9a59f6da9f58", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:45:00.019520272Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:45:00.019807+00	2024-12-12 05:45:00.057286+00	\N	\N
3194ecac-941c-461f-ae83-ae1dc2e6c17f	2024-12-12 05:16:40.898549+00	2024-12-12 05:16:41.000327+00	d9f7c587-66ff-4a72-8590-3bc09fac255b	Journals::CompletedJob	default	{"job_id": "d9f7c587-66ff-4a72-8590-3bc09fac255b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.167304000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.179530232Z", "scheduled_at": "2024-12-12T05:16:40.178735105Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.178735+00	2024-12-12 05:16:41.000198+00	\N	\N
ef185a64-eb75-46a0-91c5-15730dda8675	2024-12-12 05:16:41.108623+00	2024-12-12 05:16:41.233775+00	e9797f50-702a-4ad2-a30f-4028350deb5a	Notifications::WorkflowJob	default	{"job_id": "e9797f50-702a-4ad2-a30f-4028350deb5a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.005787616Z", "scheduled_at": "2024-12-12T05:16:41.005648171Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.005648+00	2024-12-12 05:16:41.233514+00	\N	\N
31eb7f6a-37a2-4361-89d5-c73d4496c3b7	2024-12-12 05:16:41.891403+00	2024-12-12 05:16:42.047236+00	9830447d-5ca4-492e-99dd-83eea1ae1d38	Journals::CompletedJob	default	{"job_id": "9830447d-5ca4-492e-99dd-83eea1ae1d38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-12-12T05:11:41.782618000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.811296866Z", "scheduled_at": "2024-12-12T05:16:41.811164525Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.811164+00	2024-12-12 05:16:42.04704+00	\N	\N
551d7913-c94b-4e10-ba4e-02a1717d59fa	2024-12-12 05:16:42.152128+00	2024-12-12 05:16:42.311861+00	0ae37e36-1b13-4cc5-b8b9-594330a9af20	Journals::CompletedJob	default	{"job_id": "0ae37e36-1b13-4cc5-b8b9-594330a9af20", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-12-12T05:11:41.994991000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.006347729Z", "scheduled_at": "2024-12-12T05:16:42.006212422Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.006212+00	2024-12-12 05:16:42.311652+00	\N	\N
3e637ac1-116a-44b0-9aa1-736e8dfa30fc	2024-12-12 05:16:42.422728+00	2024-12-12 05:16:42.546966+00	a6954c98-5aa5-4361-8f32-073f3e52668c	Journals::CompletedJob	default	{"job_id": "a6954c98-5aa5-4361-8f32-073f3e52668c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-12-12T05:11:42.270144000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.282202220Z", "scheduled_at": "2024-12-12T05:16:42.282070381Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.28207+00	2024-12-12 05:16:42.546771+00	\N	\N
3fc2f408-5789-4f63-9e2b-d67bf568458f	2024-12-12 05:16:42.661801+00	2024-12-12 05:16:42.769215+00	390af1e7-697d-4bf4-ad58-7d33ebfcb26e	Journals::CompletedJob	default	{"job_id": "390af1e7-697d-4bf4-ad58-7d33ebfcb26e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-12-12T05:11:42.588933000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.619506580Z", "scheduled_at": "2024-12-12T05:16:42.619367767Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.619367+00	2024-12-12 05:16:42.768997+00	\N	\N
02856170-3cd0-4145-801a-b113dfae828d	2024-12-12 06:00:00.036569+00	2024-12-12 06:00:00.045094+00	96878028-c7b0-482f-afad-3b97c9cb331e	LdapGroups::SynchronizationJob	default	{"job_id": "96878028-c7b0-482f-afad-3b97c9cb331e", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.003733193Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.004193+00	2024-12-12 06:00:00.04486+00	\N	\N
3c12216f-4ddd-422b-a1a1-301b2b0d4d70	2024-12-12 05:16:40.92302+00	2024-12-12 05:16:40.995978+00	55dcd337-c41d-4a0d-831f-023ce4d14120	Notifications::WorkflowJob	default	{"job_id": "55dcd337-c41d-4a0d-831f-023ce4d14120", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.205905435Z", "scheduled_at": "2024-12-12T05:16:40.205772433Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.205772+00	2024-12-12 05:16:40.995861+00	\N	\N
4ae02b2c-bf65-4526-a0f3-f2a2dfe17b60	2024-12-12 05:16:41.101392+00	2024-12-12 05:16:41.238469+00	6d608530-f489-479e-8cb0-9e22044e4cc9	Notifications::WorkflowJob	default	{"job_id": "6d608530-f489-479e-8cb0-9e22044e4cc9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.978116788Z", "scheduled_at": "2024-12-12T05:16:40.977884097Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.977884+00	2024-12-12 05:16:41.238218+00	\N	\N
69cb9117-d6b9-404d-af4f-3ec2e1ec4c74	2024-12-12 05:16:41.366311+00	2024-12-12 05:16:41.412117+00	f004feca-eee6-489f-a668-6e44e66c9f9a	Notifications::WorkflowJob	default	{"job_id": "f004feca-eee6-489f-a668-6e44e66c9f9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.317883414Z", "scheduled_at": "2024-12-12T05:16:41.317759038Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.317759+00	2024-12-12 05:16:41.411995+00	\N	\N
204ffeac-2920-44ac-998f-e5c40a035b85	2024-12-12 05:16:41.50937+00	2024-12-12 05:16:41.554534+00	38020831-55b0-493c-851a-b904b33ffc58	Notifications::WorkflowJob	default	{"job_id": "38020831-55b0-493c-851a-b904b33ffc58", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.484712015Z", "scheduled_at": "2024-12-12T05:16:41.484597338Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.484597+00	2024-12-12 05:16:41.554403+00	\N	\N
5d339dc5-93c6-40df-b639-9ac30364a28f	2024-12-12 05:16:41.619132+00	2024-12-12 05:16:41.668136+00	21e8d1dd-82e5-49f4-a3e9-561bebafb0ec	Notifications::WorkflowJob	default	{"job_id": "21e8d1dd-82e5-49f4-a3e9-561bebafb0ec", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.591759968Z", "scheduled_at": "2024-12-12T05:16:41.591643848Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.591643+00	2024-12-12 05:16:41.667907+00	\N	\N
8bec3e2e-f4a6-44df-9a57-4680cc17f444	2024-12-12 05:16:41.76518+00	2024-12-12 05:16:41.931075+00	863c4065-c7bb-4943-9eed-6e89435c28a1	Journals::CompletedJob	default	{"job_id": "863c4065-c7bb-4943-9eed-6e89435c28a1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.714337000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.729704954Z", "scheduled_at": "2024-12-12T05:16:41.729541254Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.729541+00	2024-12-12 05:16:41.930819+00	\N	\N
3588c8de-fe5b-4ceb-a188-1a430ccec0c6	2024-12-12 05:16:42.155361+00	2024-12-12 05:16:42.246842+00	b1d7dd42-cbf4-46d4-9b5c-6cb5bc2f4adf	Notifications::WorkflowJob	default	{"job_id": "b1d7dd42-cbf4-46d4-9b5c-6cb5bc2f4adf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.035242727Z", "scheduled_at": "2024-12-12T05:16:42.035124253Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.035124+00	2024-12-12 05:16:42.246607+00	\N	\N
4adc82fa-0171-4804-958f-a42533dff475	2024-12-12 05:16:42.351792+00	2024-12-12 05:16:42.432602+00	7d399117-b351-46b7-8311-783feef5b62c	Notifications::WorkflowJob	default	{"job_id": "7d399117-b351-46b7-8311-783feef5b62c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.214158237Z", "scheduled_at": "2024-12-12T05:16:42.214041225Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.214041+00	2024-12-12 05:16:42.432355+00	\N	\N
f73c04ba-c018-4f15-827a-5502a18292b5	2024-12-12 05:16:42.545394+00	2024-12-12 05:16:42.637016+00	8bb29984-aa43-4e13-a0e3-61dd7efbe758	Notifications::WorkflowJob	default	{"job_id": "8bb29984-aa43-4e13-a0e3-61dd7efbe758", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.434036601Z", "scheduled_at": "2024-12-12T05:16:42.433917536Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.433917+00	2024-12-12 05:16:42.636745+00	\N	\N
93cf0bf1-db34-4b51-a0a2-7ace4db26c03	2024-12-12 06:00:00.04725+00	2024-12-12 06:00:00.076148+00	520ebc91-b056-470a-819c-4ce87dfada23	Notifications::ScheduleReminderMailsJob	default	{"job_id": "520ebc91-b056-470a-819c-4ce87dfada23", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.015498159Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.015646+00	2024-12-12 06:00:00.075951+00	\N	\N
8d027392-1459-445b-b493-b71968f2718d	2024-12-12 05:16:40.657332+00	2024-12-12 05:16:40.937275+00	674b786d-6173-4e70-bca6-6f99864f481d	Journals::CompletedJob	default	{"job_id": "674b786d-6173-4e70-bca6-6f99864f481d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-12-12T05:11:40.060131000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.075164820Z", "scheduled_at": "2024-12-12T05:16:40.074910949Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.07491+00	2024-12-12 05:16:40.937172+00	\N	\N
baa72c30-5070-41c4-a867-837fc2086301	2024-12-12 05:16:41.02568+00	2024-12-12 05:16:41.162828+00	5e5383bb-3980-486d-aa97-7541bec5a410	Journals::CompletedJob	default	{"job_id": "5e5383bb-3980-486d-aa97-7541bec5a410", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-12-12T05:11:40.298688000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.316909656Z", "scheduled_at": "2024-12-12T05:16:40.316741187Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.316741+00	2024-12-12 05:16:41.16257+00	\N	\N
e2044587-3229-4120-9cd6-4e4ae095e721	2024-12-12 05:16:41.397532+00	2024-12-12 05:16:41.450295+00	a6518bdf-c4f1-4324-8431-bec00dd73b7e	Notifications::WorkflowJob	default	{"job_id": "a6518bdf-c4f1-4324-8431-bec00dd73b7e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.376054752Z", "scheduled_at": "2024-12-12T05:16:41.375923053Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.375922+00	2024-12-12 05:16:41.450045+00	\N	\N
17ef05bb-0435-4751-a7c5-faff9a3919c7	2024-12-12 05:16:41.540594+00	2024-12-12 05:16:41.61371+00	788d48ec-8182-4ade-81a7-83cf90a257dd	Journals::CompletedJob	default	{"job_id": "788d48ec-8182-4ade-81a7-83cf90a257dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.493085000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.518109172Z", "scheduled_at": "2024-12-12T05:16:41.517973104Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.517972+00	2024-12-12 05:16:41.613449+00	\N	\N
babf4863-4479-4c23-8dd6-d988deab0cc6	2024-12-12 05:16:41.716221+00	2024-12-12 05:16:41.812082+00	2ee50b3e-7ad5-452e-aec9-57385cd3ddb3	Journals::CompletedJob	default	{"job_id": "2ee50b3e-7ad5-452e-aec9-57385cd3ddb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.664189000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.676221869Z", "scheduled_at": "2024-12-12T05:16:41.675990802Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.67599+00	2024-12-12 05:16:41.811826+00	\N	\N
8323f7a2-1a54-4501-b144-6d2ce131e9ed	2024-12-12 05:16:42.015997+00	2024-12-12 05:16:42.119868+00	f7f9e998-bf58-4159-bf3d-2fc80ceed3c6	Journals::CompletedJob	default	{"job_id": "f7f9e998-bf58-4159-bf3d-2fc80ceed3c6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.868153000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.890514079Z", "scheduled_at": "2024-12-12T05:16:41.890377871Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.890377+00	2024-12-12 05:16:42.119614+00	\N	\N
5c6c1393-fc20-49f6-878d-8518028524b7	2024-12-12 05:16:42.225127+00	2024-12-12 05:16:42.302826+00	de2232fc-b4e4-4f9a-84d2-52e27d18703f	Notifications::WorkflowJob	default	{"job_id": "de2232fc-b4e4-4f9a-84d2-52e27d18703f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.104105560Z", "scheduled_at": "2024-12-12T05:16:42.103989050Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.103988+00	2024-12-12 05:16:42.302648+00	\N	\N
60ea8fd4-457d-4ad5-93fa-471056f59618	2024-12-12 05:16:42.411819+00	2024-12-12 05:16:42.530422+00	353a33df-ec4c-4749-bd91-1d11251c33a5	Journals::CompletedJob	default	{"job_id": "353a33df-ec4c-4749-bd91-1d11251c33a5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.239797000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.263671239Z", "scheduled_at": "2024-12-12T05:16:42.263535282Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.263535+00	2024-12-12 05:16:42.530223+00	\N	\N
2b46710f-bf01-43a7-9b7e-90d58a2f6a01	2024-12-12 05:16:42.645972+00	2024-12-12 05:16:42.775982+00	762bcb6e-0c63-4ea8-959e-2c921a93c801	Journals::CompletedJob	default	{"job_id": "762bcb6e-0c63-4ea8-959e-2c921a93c801", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-12-12T05:11:42.564398000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.582683311Z", "scheduled_at": "2024-12-12T05:16:42.582550549Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.58255+00	2024-12-12 05:16:42.77581+00	\N	\N
8154b463-c470-4a56-b12d-dbb51036ddc3	2024-12-12 06:00:00.05935+00	2024-12-12 06:00:00.080367+00	424099b7-1539-4aa6-9296-d285a0030f6e	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "424099b7-1539-4aa6-9296-d285a0030f6e", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.022068026Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.022367+00	2024-12-12 06:00:00.080198+00	\N	\N
051cfb0a-3cc3-4f3c-819e-6423736e0263	2024-12-12 06:01:00.023181+00	2024-12-12 06:01:00.057107+00	2781ac8b-d2d5-4616-a18b-51ea828cff67	Storages::ManageStorageIntegrationsJob	default	{"job_id": "2781ac8b-d2d5-4616-a18b-51ea828cff67", "locale": "en", "priority": 7, "timezone": "UTC", "arguments": [], "job_class": "Storages::ManageStorageIntegrationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:01:00.010693028Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:01:00.01203+00	2024-12-12 06:01:00.056778+00	\N	\N
f5ac3fe8-d0a0-4c22-a79d-e5910d519dfd	2024-12-12 05:16:40.948755+00	2024-12-12 05:16:41.007276+00	d396fc89-4071-4576-b3c9-bbc36dde223a	Notifications::WorkflowJob	default	{"job_id": "d396fc89-4071-4576-b3c9-bbc36dde223a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.233499166Z", "scheduled_at": "2024-12-12T05:16:40.233364912Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.233365+00	2024-12-12 05:16:41.00715+00	\N	\N
42beb187-1ce4-417a-9eb2-2ca0f18cbeb8	2024-12-12 05:16:41.138444+00	2024-12-12 05:16:41.266585+00	16764864-5540-4153-93cf-c23937f417dd	Journals::CompletedJob	default	{"job_id": "16764864-5540-4153-93cf-c23937f417dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [19, {"value": "2024-12-12T05:11:40.988961000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.010007280Z", "scheduled_at": "2024-12-12T05:16:41.009731287Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.009731+00	2024-12-12 05:16:41.266279+00	\N	\N
a030edbb-1c5d-4e0e-99fd-52a91a12845d	2024-12-12 05:16:41.403073+00	2024-12-12 05:16:41.472731+00	4c04150f-db07-46b0-a2a7-4bd79c6e608c	Journals::CompletedJob	default	{"job_id": "4c04150f-db07-46b0-a2a7-4bd79c6e608c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-12-12T05:11:41.348647000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.379866424Z", "scheduled_at": "2024-12-12T05:16:41.379725036Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.379724+00	2024-12-12 05:16:41.472477+00	\N	\N
28868c4d-2e27-47ee-87d2-50cf24ae99e6	2024-12-12 05:16:41.603349+00	2024-12-12 05:16:41.646272+00	eef22eec-13db-4f3f-802c-a4470a9c8848	Journals::CompletedJob	default	{"job_id": "eef22eec-13db-4f3f-802c-a4470a9c8848", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.557949000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.569765225Z", "scheduled_at": "2024-12-12T05:16:41.569629658Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.569629+00	2024-12-12 05:16:41.646021+00	\N	\N
edf6c3f0-8152-45c0-9d19-f64b1e046f46	2024-12-12 05:16:41.74152+00	2024-12-12 05:16:41.843281+00	b1199811-8054-47f8-ac11-efa3cc59c4c5	Notifications::WorkflowJob	default	{"job_id": "b1199811-8054-47f8-ac11-efa3cc59c4c5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.702170485Z", "scheduled_at": "2024-12-12T05:16:41.702052992Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.702052+00	2024-12-12 05:16:41.843001+00	\N	\N
6c29e735-8f52-487e-a9d7-1923fc22f3c9	2024-12-12 05:16:42.032472+00	2024-12-12 05:16:42.113047+00	1e417181-2382-4579-90b8-723820c3d8d1	Notifications::WorkflowJob	default	{"job_id": "1e417181-2382-4579-90b8-723820c3d8d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.905812155Z", "scheduled_at": "2024-12-12T05:16:41.905692298Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.905692+00	2024-12-12 05:16:42.112789+00	\N	\N
5ef6a0b1-09c0-415c-9d47-9e8c7b8135e3	2024-12-12 05:16:40.955223+00	2024-12-12 05:16:41.045739+00	e6df5b6d-40ca-4f46-870b-a366e1f01af1	Journals::CompletedJob	default	{"job_id": "e6df5b6d-40ca-4f46-870b-a366e1f01af1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.217201000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.236660596Z", "scheduled_at": "2024-12-12T05:16:40.236501194Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.236501+00	2024-12-12 05:16:41.045603+00	\N	\N
27a1956c-1ddb-4d8a-a550-69d4ba3064ea	2024-12-12 05:16:41.372762+00	2024-12-12 05:16:41.417859+00	75395ba8-39a7-438d-a328-1b8e1acb7a8e	Notifications::WorkflowJob	default	{"job_id": "75395ba8-39a7-438d-a328-1b8e1acb7a8e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.337627663Z", "scheduled_at": "2024-12-12T05:16:41.337508047Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.337508+00	2024-12-12 05:16:41.417718+00	\N	\N
e9c3578e-a3ec-4906-93a7-5beb320d330e	2024-12-12 05:16:41.514546+00	2024-12-12 05:16:41.564071+00	2b218527-ba61-4a67-a6c4-72712a594b1b	Journals::CompletedJob	default	{"job_id": "2b218527-ba61-4a67-a6c4-72712a594b1b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.476151000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.488227706Z", "scheduled_at": "2024-12-12T05:16:41.488089384Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.488089+00	2024-12-12 05:16:41.563925+00	\N	\N
58812d4f-4543-4513-9a28-545e46b7fb5b	2024-12-12 05:16:41.648853+00	2024-12-12 05:16:41.721704+00	42c2061e-6662-48e9-8877-337f66b41b33	Notifications::WorkflowJob	default	{"job_id": "42c2061e-6662-48e9-8877-337f66b41b33", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.625103426Z", "scheduled_at": "2024-12-12T05:16:41.624985532Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.624985+00	2024-12-12 05:16:41.721439+00	\N	\N
0e665210-795d-44ce-8838-b3a213727216	2024-12-12 05:16:41.896771+00	2024-12-12 05:16:42.043699+00	62e70fee-4ea9-4956-8aa1-510269b1646f	Notifications::WorkflowJob	default	{"job_id": "62e70fee-4ea9-4956-8aa1-510269b1646f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.827507741Z", "scheduled_at": "2024-12-12T05:16:41.827350994Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.827351+00	2024-12-12 05:16:42.043466+00	\N	\N
49105a12-fbb0-4999-a6e0-c6be1d508e62	2024-12-12 05:16:42.14779+00	2024-12-12 05:16:42.229587+00	4ffefb53-cbfc-486a-996c-69ac895f6451	Notifications::WorkflowJob	default	{"job_id": "4ffefb53-cbfc-486a-996c-69ac895f6451", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.002997841Z", "scheduled_at": "2024-12-12T05:16:42.002879036Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.002878+00	2024-12-12 05:16:42.229329+00	\N	\N
92ac912e-d150-4f9a-9f3b-85c4e76ae3ad	2024-12-12 05:16:40.972018+00	2024-12-12 05:16:41.036317+00	27b342bf-8fab-460a-b942-bcfe58a3da85	Notifications::WorkflowJob	default	{"job_id": "27b342bf-8fab-460a-b942-bcfe58a3da85", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.250189210Z", "scheduled_at": "2024-12-12T05:16:40.250054334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.250054+00	2024-12-12 05:16:41.036083+00	\N	\N
bf647a18-0cd1-4c7f-8cef-516e82b52d86	2024-12-12 05:16:41.19928+00	2024-12-12 05:16:41.337264+00	6544e3d1-b597-4212-a7de-9794b2582da7	Journals::CompletedJob	default	{"job_id": "6544e3d1-b597-4212-a7de-9794b2582da7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [20, {"value": "2024-12-12T05:11:41.088301000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.110874965Z", "scheduled_at": "2024-12-12T05:16:41.108671720Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.108671+00	2024-12-12 05:16:41.337017+00	\N	\N
50ee193a-1d43-4675-8cd4-4c6bc261311a	2024-12-12 05:16:41.463757+00	2024-12-12 05:16:41.516127+00	1a202862-0d6f-46e5-91e3-a0358b1df2ec	Notifications::WorkflowJob	default	{"job_id": "1a202862-0d6f-46e5-91e3-a0358b1df2ec", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.428713354Z", "scheduled_at": "2024-12-12T05:16:41.428596403Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.428596+00	2024-12-12 05:16:41.515894+00	\N	\N
083990ed-1305-4f29-a145-219bd35d5019	2024-12-12 05:16:41.575103+00	2024-12-12 05:16:41.632815+00	c1d1e538-51a5-4d8a-af4e-692b39db8fdd	Journals::CompletedJob	default	{"job_id": "c1d1e538-51a5-4d8a-af4e-692b39db8fdd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.522121000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.551091304Z", "scheduled_at": "2024-12-12T05:16:41.550951169Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.550951+00	2024-12-12 05:16:41.632725+00	\N	\N
fff670e8-34a9-424a-9304-2a10bd4a8e97	2024-12-12 05:16:41.714204+00	2024-12-12 05:16:41.795184+00	a7aeba4a-8dcb-4af4-85ff-7993bb6d1c12	Notifications::WorkflowJob	default	{"job_id": "a7aeba4a-8dcb-4af4-85ff-7993bb6d1c12", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.672608181Z", "scheduled_at": "2024-12-12T05:16:41.672488475Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.672488+00	2024-12-12 05:16:41.794862+00	\N	\N
a54ba75b-0155-4247-86ba-7ec443950984	2024-12-12 05:16:42.001437+00	2024-12-12 05:16:42.090779+00	fcf405a3-3a21-415a-b89f-b81d1b5296d1	Notifications::WorkflowJob	default	{"job_id": "fcf405a3-3a21-415a-b89f-b81d1b5296d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.887139215Z", "scheduled_at": "2024-12-12T05:16:41.887022624Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.887022+00	2024-12-12 05:16:42.090515+00	\N	\N
5fbd17a5-e046-4955-b5f2-cb3f75c7d7f0	2024-12-12 05:16:40.98599+00	2024-12-12 05:16:41.081174+00	be30b1cf-957f-4e26-9c4e-adc44ffaff8a	Journals::CompletedJob	default	{"job_id": "be30b1cf-957f-4e26-9c4e-adc44ffaff8a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.242629000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.253282641Z", "scheduled_at": "2024-12-12T05:16:40.253125303Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.253125+00	2024-12-12 05:16:41.080945+00	\N	\N
9010729f-b843-4693-b732-d33beb5c873a	2024-12-12 05:16:41.832669+00	2024-12-12 05:16:41.998534+00	219beae2-7ac4-4489-b242-d84f6b118aaf	Notifications::WorkflowJob	default	{"job_id": "219beae2-7ac4-4489-b242-d84f6b118aaf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.773675935Z", "scheduled_at": "2024-12-12T05:16:41.773555507Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.773555+00	2024-12-12 05:16:41.996289+00	\N	\N
774cac16-6024-4dcb-aee0-2c95d2980c88	2024-12-12 05:16:42.11165+00	2024-12-12 05:16:42.258227+00	91e2003b-4778-4191-ae43-8ebb3bd40b97	Journals::CompletedJob	default	{"job_id": "91e2003b-4778-4191-ae43-8ebb3bd40b97", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-12-12T05:11:41.942761000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.954350990Z", "scheduled_at": "2024-12-12T05:16:41.954106187Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.954106+00	2024-12-12 05:16:42.258048+00	\N	\N
388df612-3726-4ce8-80b8-da56d5ae6300	2024-12-12 05:16:42.364793+00	2024-12-12 05:16:42.460982+00	d7ff8860-7a4d-4200-b286-7b9292649c6d	Journals::CompletedJob	default	{"job_id": "d7ff8860-7a4d-4200-b286-7b9292649c6d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.194243000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.217487946Z", "scheduled_at": "2024-12-12T05:16:42.217353200Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.217353+00	2024-12-12 05:16:42.460725+00	\N	\N
f471323d-acbf-4b6b-8570-489395a01892	2024-12-12 05:16:42.568957+00	2024-12-12 05:16:42.653147+00	1cc809b1-27aa-4827-8da2-e8059514eae0	Notifications::WorkflowJob	default	{"job_id": "1cc809b1-27aa-4827-8da2-e8059514eae0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.480251213Z", "scheduled_at": "2024-12-12T05:16:42.480121747Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.480121+00	2024-12-12 05:16:42.652863+00	\N	\N
9e21c0a7-043f-4709-9c45-4d6411773d22	2024-12-12 05:16:42.773411+00	2024-12-12 05:16:42.852728+00	3954f6db-9e72-4194-839d-52ddab70a3e8	Notifications::WorkflowJob	default	{"job_id": "3954f6db-9e72-4194-839d-52ddab70a3e8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.716796355Z", "scheduled_at": "2024-12-12T05:16:42.716661088Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.71666+00	2024-12-12 05:16:42.852535+00	\N	\N
7387ddda-c72b-448c-bdcb-b998cde94850	2024-12-12 06:15:00.030301+00	2024-12-12 06:15:00.042983+00	50fa8501-919c-4f33-a88a-d90736206e1d	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "50fa8501-919c-4f33-a88a-d90736206e1d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:15:00.007742278Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:15:00.007964+00	2024-12-12 06:15:00.042707+00	\N	\N
bc4908db-3f35-43e6-9b67-4d35dc701842	2024-12-12 05:16:40.99783+00	2024-12-12 05:16:41.189808+00	fc5bebdc-ea55-4cd6-ba14-44a518634c41	Journals::CompletedJob	default	{"job_id": "fc5bebdc-ea55-4cd6-ba14-44a518634c41", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.256049000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.278274413Z", "scheduled_at": "2024-12-12T05:16:40.278117365Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.278117+00	2024-12-12 05:16:41.189552+00	\N	\N
79b30c89-c5e8-4002-82cd-a1338105cb72	2024-12-12 05:16:41.422055+00	2024-12-12 05:16:41.489393+00	19ba3f49-8ae5-49c1-b95e-7a7a3438b084	Notifications::WorkflowJob	default	{"job_id": "19ba3f49-8ae5-49c1-b95e-7a7a3438b084", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.396608015Z", "scheduled_at": "2024-12-12T05:16:41.396487186Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.396487+00	2024-12-12 05:16:41.489213+00	\N	\N
37089904-0e89-4b3e-bf37-ea878b95d7e9	2024-12-12 05:16:41.889024+00	2024-12-12 05:16:42.03061+00	3e1b6fc2-ea6a-4aca-9ae5-9a3701f3fe66	Notifications::WorkflowJob	default	{"job_id": "3e1b6fc2-ea6a-4aca-9ae5-9a3701f3fe66", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.807427004Z", "scheduled_at": "2024-12-12T05:16:41.807183312Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.807183+00	2024-12-12 05:16:42.03033+00	\N	\N
d75ad67e-a87a-436b-a1df-0e081a2b01a4	2024-12-12 05:16:42.134703+00	2024-12-12 05:16:42.209478+00	7e10fce1-46de-49f5-ad14-df36b16bab09	Notifications::WorkflowJob	default	{"job_id": "7e10fce1-46de-49f5-ad14-df36b16bab09", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.984147647Z", "scheduled_at": "2024-12-12T05:16:41.984027600Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.984027+00	2024-12-12 05:16:42.209215+00	\N	\N
956cb994-6360-40cd-9961-8e405afb8dc6	2024-12-12 05:16:42.316857+00	2024-12-12 05:16:42.4072+00	d1c1f1de-d557-45d9-be69-bad2262b2614	Notifications::WorkflowJob	default	{"job_id": "d1c1f1de-d557-45d9-be69-bad2262b2614", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.153936154Z", "scheduled_at": "2024-12-12T05:16:42.153816778Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.153816+00	2024-12-12 05:16:42.406943+00	\N	\N
323f0e07-a712-439f-b07b-7fd91c6a74ff	2024-12-12 05:16:42.520627+00	2024-12-12 05:16:42.601013+00	53893000-32b6-4873-bec8-d453f63a6af8	Notifications::WorkflowJob	default	{"job_id": "53893000-32b6-4873-bec8-d453f63a6af8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.399529960Z", "scheduled_at": "2024-12-12T05:16:42.399411536Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.399411+00	2024-12-12 05:16:42.60074+00	\N	\N
5c71bd9e-fc6f-4f63-9ea2-074b23d7e2ad	2024-12-12 06:15:00.055203+00	2024-12-12 06:15:00.083952+00	41a380d4-975a-4d39-81fa-44af42f88916	Notifications::ScheduleReminderMailsJob	default	{"job_id": "41a380d4-975a-4d39-81fa-44af42f88916", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:15:00.021437499Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:15:00.021737+00	2024-12-12 06:15:00.083678+00	\N	\N
3fec1cc1-ecba-41db-9238-dec9b2e0f49c	2024-12-12 05:16:41.008628+00	2024-12-12 05:16:41.096234+00	2b507715-486d-4705-98b4-ff49eabb79e3	Notifications::WorkflowJob	default	{"job_id": "2b507715-486d-4705-98b4-ff49eabb79e3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.290996087Z", "scheduled_at": "2024-12-12T05:16:40.290863867Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.290863+00	2024-12-12 05:16:41.095954+00	\N	\N
24e389dd-f80c-4c0a-b462-02f3d61eb4f6	2024-12-12 05:16:41.807998+00	2024-12-12 05:16:41.966794+00	d9c3a443-a665-436e-9f19-1da2c9135721	Notifications::WorkflowJob	default	{"job_id": "d9c3a443-a665-436e-9f19-1da2c9135721", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.755089711Z", "scheduled_at": "2024-12-12T05:16:41.754969433Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.754969+00	2024-12-12 05:16:41.966534+00	\N	\N
b37e9400-0613-4622-878c-40bed3791b4a	2024-12-12 05:16:42.096848+00	2024-12-12 05:16:42.174334+00	84660288-f772-4716-bc09-0b20822b1e38	Notifications::WorkflowJob	default	{"job_id": "84660288-f772-4716-bc09-0b20822b1e38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.950958011Z", "scheduled_at": "2024-12-12T05:16:41.950841250Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.950841+00	2024-12-12 05:16:42.174065+00	\N	\N
183553b3-ae74-43cb-9933-ba6d4f889316	2024-12-12 05:16:42.288824+00	2024-12-12 05:16:42.376573+00	63261828-fc17-4a82-b186-d1d621efae87	Journals::CompletedJob	default	{"job_id": "63261828-fc17-4a82-b186-d1d621efae87", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-12-12T05:11:42.111325000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.138802050Z", "scheduled_at": "2024-12-12T05:16:42.138668387Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.138668+00	2024-12-12 05:16:42.376301+00	\N	\N
4763635f-51f5-4830-8ae1-4d513dc1d247	2024-12-12 05:16:42.489192+00	2024-12-12 05:16:42.573447+00	2ef5c0ed-6114-49ce-ad0d-60ca9d989afe	Notifications::WorkflowJob	default	{"job_id": "2ef5c0ed-6114-49ce-ad0d-60ca9d989afe", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.354742693Z", "scheduled_at": "2024-12-12T05:16:42.354611004Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.35461+00	2024-12-12 05:16:42.573206+00	\N	\N
1456a782-a7fa-43ee-a0c1-2d09546e0d6d	2024-12-12 05:16:42.689302+00	2024-12-12 05:16:42.781162+00	6d08cf20-1ed7-4d76-95ae-250369e6626a	Notifications::WorkflowJob	default	{"job_id": "6d08cf20-1ed7-4d76-95ae-250369e6626a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.641101125Z", "scheduled_at": "2024-12-12T05:16:42.640982981Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.640983+00	2024-12-12 05:16:42.780885+00	\N	\N
6857c1c2-5205-452c-a24d-f15e7100e844	2024-12-12 05:16:41.019048+00	2024-12-12 05:16:41.182626+00	fa628f48-18d3-4915-abe5-d3dd3caa5ae2	Journals::CompletedJob	default	{"job_id": "fa628f48-18d3-4915-abe5-d3dd3caa5ae2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-12-12T05:11:40.283728000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.294376191Z", "scheduled_at": "2024-12-12T05:16:40.294222731Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.294222+00	2024-12-12 05:16:41.182367+00	\N	\N
7ccfc90d-79c3-4f87-ba67-eea2d69cc011	2024-12-12 05:16:41.319586+00	2024-12-12 05:16:41.387696+00	853b12bb-d074-4d74-97af-fbd679ebf8ef	Notifications::WorkflowJob	default	{"job_id": "853b12bb-d074-4d74-97af-fbd679ebf8ef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.272075823Z", "scheduled_at": "2024-12-12T05:16:41.271756358Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.271756+00	2024-12-12 05:16:41.38744+00	\N	\N
45ff41b6-ad31-4912-bcae-fab36cd012ed	2024-12-12 05:16:41.454693+00	2024-12-12 05:16:41.523115+00	652ccdbf-dbd7-4225-a663-1d169bef8446	Journals::CompletedJob	default	{"job_id": "652ccdbf-dbd7-4225-a663-1d169bef8446", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-12-12T05:11:41.407032000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.432185934Z", "scheduled_at": "2024-12-12T05:16:41.432047031Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.432047+00	2024-12-12 05:16:41.522914+00	\N	\N
e8d1dfa3-4411-49bb-b700-abbb4687e423	2024-12-12 05:16:41.653358+00	2024-12-12 05:16:41.731427+00	30c4a113-23df-407f-b140-adca54cf3012	Journals::CompletedJob	default	{"job_id": "30c4a113-23df-407f-b140-adca54cf3012", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.600012000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.629019385Z", "scheduled_at": "2024-12-12T05:16:41.628729666Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.628729+00	2024-12-12 05:16:41.731193+00	\N	\N
6dfa5ded-8cdc-4f56-89ae-76eceab29dd1	2024-12-12 05:16:41.931719+00	2024-12-12 05:16:42.098565+00	30f7f5c5-75a9-49e0-9715-efa158f32f61	Journals::CompletedJob	default	{"job_id": "30f7f5c5-75a9-49e0-9715-efa158f32f61", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-12-12T05:11:41.818173000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.831994242Z", "scheduled_at": "2024-12-12T05:16:41.831725322Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.831725+00	2024-12-12 05:16:42.098373+00	\N	\N
7d0c4a60-7cb4-4d7e-b48b-50827643836b	2024-12-12 05:16:42.197201+00	2024-12-12 05:16:42.320677+00	7823103e-c249-4054-be64-e53035da898a	Journals::CompletedJob	default	{"job_id": "7823103e-c249-4054-be64-e53035da898a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-12-12T05:11:42.045751000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.057024596Z", "scheduled_at": "2024-12-12T05:16:42.056877838Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.056877+00	2024-12-12 05:16:42.320483+00	\N	\N
d4ca3ba7-f7a1-4621-98f1-1b42f6972fc1	2024-12-12 05:16:42.435224+00	2024-12-12 05:16:42.516164+00	d94a0356-d5d2-4a63-b76c-3d80facfe242	Notifications::WorkflowJob	default	{"job_id": "d94a0356-d5d2-4a63-b76c-3d80facfe242", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.320667409Z", "scheduled_at": "2024-12-12T05:16:42.319604566Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.319604+00	2024-12-12 05:16:42.515979+00	\N	\N
d9bb9108-4dc1-451e-bf41-f4ed792690aa	2024-12-12 05:16:42.63096+00	2024-12-12 05:16:42.715655+00	7a9160f3-34b2-4811-bbea-b90a7a0e8ca3	Notifications::WorkflowJob	default	{"job_id": "7a9160f3-34b2-4811-bbea-b90a7a0e8ca3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.577416452Z", "scheduled_at": "2024-12-12T05:16:42.577295042Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.577295+00	2024-12-12 05:16:42.715407+00	\N	\N
5a77660f-4828-4410-8193-04df4094e1b0	2024-12-12 05:16:41.022904+00	2024-12-12 05:16:41.11466+00	98ae185a-3805-4bd6-b2d4-8c21653da9a5	Notifications::WorkflowJob	default	{"job_id": "98ae185a-3805-4bd6-b2d4-8c21653da9a5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.313793742Z", "scheduled_at": "2024-12-12T05:16:40.313662153Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.313662+00	2024-12-12 05:16:41.114428+00	\N	\N
6211594a-2160-4a87-b9c4-c63b3c5c32d3	2024-12-12 05:16:41.82016+00	2024-12-12 05:16:42.039324+00	6cd7e33f-982c-4efe-a1b8-9397071f6da4	Journals::CompletedJob	default	{"job_id": "6cd7e33f-982c-4efe-a1b8-9397071f6da4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-12-12T05:11:41.763922000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.778869116Z", "scheduled_at": "2024-12-12T05:16:41.778703382Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.778703+00	2024-12-12 05:16:42.039087+00	\N	\N
9eb53da4-68db-4f35-b118-488ad411d959	2024-12-12 05:16:42.14204+00	2024-12-12 05:16:42.239004+00	67ddc475-bd3c-4c18-bf17-37318c717768	Journals::CompletedJob	default	{"job_id": "67ddc475-bd3c-4c18-bf17-37318c717768", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-12-12T05:11:41.958908000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.987777615Z", "scheduled_at": "2024-12-12T05:16:41.987636868Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.987637+00	2024-12-12 05:16:42.238743+00	\N	\N
91c133fb-a21f-4822-919c-8afe27f2297d	2024-12-12 05:16:42.34317+00	2024-12-12 05:16:42.442724+00	2a193219-6be6-4fa2-b51f-3dd536bfbad2	Journals::CompletedJob	default	{"job_id": "2a193219-6be6-4fa2-b51f-3dd536bfbad2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-12-12T05:11:42.162091000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.190744636Z", "scheduled_at": "2024-12-12T05:16:42.190611563Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.190611+00	2024-12-12 05:16:42.442458+00	\N	\N
c6dd36d1-dc62-4f8f-8e69-6438d88c4acb	2024-12-12 05:16:42.553898+00	2024-12-12 05:16:42.684199+00	20d2482b-eca3-4683-b796-49065238612c	Journals::CompletedJob	default	{"job_id": "20d2482b-eca3-4683-b796-49065238612c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-12-12T05:11:42.420692000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.442919591Z", "scheduled_at": "2024-12-12T05:16:42.442751012Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.44275+00	2024-12-12 05:16:42.683943+00	\N	\N
1a9c71bd-d7e7-4d83-be80-7d380fca9f22	2024-12-12 05:16:42.799526+00	2024-12-12 05:16:42.873703+00	9690f241-9db0-495f-8a79-acb01ec22037	Notifications::WorkflowJob	default	{"job_id": "9690f241-9db0-495f-8a79-acb01ec22037", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.758259095Z", "scheduled_at": "2024-12-12T05:16:42.757628831Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.757628+00	2024-12-12 05:16:42.87348+00	\N	\N
fd8382ed-bf72-4ca7-9b9c-c82b6b61d8c3	2024-12-12 06:30:00.127695+00	2024-12-12 06:30:00.234056+00	3cbaeb98-cf10-4f75-a056-97a9d5653b5c	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "3cbaeb98-cf10-4f75-a056-97a9d5653b5c", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.037395333Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.07085+00	2024-12-12 06:30:00.229629+00	\N	\N
a607cc88-41ef-444a-b674-dec1d16ba0a6	2024-12-12 05:16:41.052478+00	2024-12-12 05:16:41.228744+00	da7794f8-6f33-45a4-83dc-265b4b265fc9	Journals::CompletedJob	default	{"job_id": "da7794f8-6f33-45a4-83dc-265b4b265fc9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-12-12T05:11:40.322317000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.333203877Z", "scheduled_at": "2024-12-12T05:16:40.333044966Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.333045+00	2024-12-12 05:16:41.228513+00	\N	\N
5b57ec81-8dd4-4ad2-8d55-b5bd9a037fba	2024-12-12 05:16:41.496389+00	2024-12-12 05:16:41.547444+00	65b98263-e360-40d0-9edc-1f55dd3bb2b7	Journals::CompletedJob	default	{"job_id": "65b98263-e360-40d0-9edc-1f55dd3bb2b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.436597000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.468853086Z", "scheduled_at": "2024-12-12T05:16:41.468716798Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.468716+00	2024-12-12 05:16:41.547196+00	\N	\N
0da7dde7-fb3c-4104-89e9-882d056141e8	2024-12-12 05:16:41.688974+00	2024-12-12 05:16:41.787913+00	fe8dff05-5a69-49da-9b7d-4adb591f1dbf	Journals::CompletedJob	default	{"job_id": "fe8dff05-5a69-49da-9b7d-4adb591f1dbf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.633679000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.656622054Z", "scheduled_at": "2024-12-12T05:16:41.656483160Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.656483+00	2024-12-12 05:16:41.787691+00	\N	\N
51d6c6aa-073f-42ad-aacf-18a8b536a679	2024-12-12 05:16:41.969364+00	2024-12-12 05:16:42.080771+00	796e6e5b-395b-4b9a-8e1d-d1c8f4cdce2e	Notifications::WorkflowJob	default	{"job_id": "796e6e5b-395b-4b9a-8e1d-d1c8f4cdce2e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.861272465Z", "scheduled_at": "2024-12-12T05:16:41.861151185Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.861151+00	2024-12-12 05:16:42.080544+00	\N	\N
395be3d7-1d34-46d4-93c4-9d289bcb6602	2024-12-12 05:16:42.181665+00	2024-12-12 05:16:42.276709+00	66101ee3-aa29-4601-859e-744f1c9a75a3	Journals::CompletedJob	default	{"job_id": "66101ee3-aa29-4601-859e-744f1c9a75a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-12-12T05:11:42.010370000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.038593035Z", "scheduled_at": "2024-12-12T05:16:42.038461986Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.038461+00	2024-12-12 05:16:42.276452+00	\N	\N
88b492da-0c91-4482-92b7-6b3892e9e2a7	2024-12-12 05:16:42.385631+00	2024-12-12 05:16:42.483013+00	d91e8c12-8e41-4fa4-9b0e-181c994c0fa4	Journals::CompletedJob	default	{"job_id": "d91e8c12-8e41-4fa4-9b0e-181c994c0fa4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.224768000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.236503074Z", "scheduled_at": "2024-12-12T05:16:42.236368539Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.236368+00	2024-12-12 05:16:42.482777+00	\N	\N
ccad4414-5896-4de7-9062-a14ba26e2011	2024-12-12 05:16:42.592717+00	2024-12-12 05:16:42.72445+00	8cf442ff-f16a-433e-a77d-fde8feb122cd	Journals::CompletedJob	default	{"job_id": "8cf442ff-f16a-433e-a77d-fde8feb122cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-12-12T05:11:42.498160000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.518178855Z", "scheduled_at": "2024-12-12T05:16:42.518046244Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.518046+00	2024-12-12 05:16:42.724203+00	\N	\N
cb2cb0cd-f25d-4717-8a5b-6ef02a028789	2024-12-12 05:16:42.834006+00	2024-12-12 05:16:42.901202+00	eb60d7e7-35a3-4fa9-b003-ad78a52aa47a	Notifications::WorkflowJob	default	{"job_id": "eb60d7e7-35a3-4fa9-b003-ad78a52aa47a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.797734368Z", "scheduled_at": "2024-12-12T05:16:42.797562332Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.797562+00	2024-12-12 05:16:42.900982+00	\N	\N
b338627f-04a0-4889-aacd-df37ce407061	2024-12-12 06:30:00.248198+00	2024-12-12 06:30:00.457645+00	90ea7e1d-00ff-4cbf-9995-5cf816867318	Notifications::ScheduleReminderMailsJob	default	{"job_id": "90ea7e1d-00ff-4cbf-9995-5cf816867318", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.099955531Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.102608+00	2024-12-12 06:30:00.457427+00	\N	\N
c795b427-cd4f-4793-bdd4-a95abfb0aad4	2024-12-12 05:16:41.368203+00	2024-12-12 05:16:41.421223+00	a29e16ba-85fd-4029-ab08-21ead8ccfe48	Journals::CompletedJob	default	{"job_id": "a29e16ba-85fd-4029-ab08-21ead8ccfe48", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-12-12T05:11:41.289724000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.321232421Z", "scheduled_at": "2024-12-12T05:16:41.321096032Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.321095+00	2024-12-12 05:16:41.42102+00	\N	\N
2acdd7f6-4320-41fe-8ab7-fbd77c587ead	2024-12-12 05:16:41.538276+00	2024-12-12 05:16:41.583129+00	f2480275-23d5-40d4-a2a0-94cd8ebbedb3	Notifications::WorkflowJob	default	{"job_id": "f2480275-23d5-40d4-a2a0-94cd8ebbedb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.514617056Z", "scheduled_at": "2024-12-12T05:16:41.514495596Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.514495+00	2024-12-12 05:16:41.582874+00	\N	\N
726259d8-2f47-4cd7-b40d-7621ea96cdba	2024-12-12 05:16:41.685997+00	2024-12-12 05:16:41.756445+00	5190745c-c619-440d-bc91-26315ad352c7	Notifications::WorkflowJob	default	{"job_id": "5190745c-c619-440d-bc91-26315ad352c7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.653310129Z", "scheduled_at": "2024-12-12T05:16:41.653190712Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.65319+00	2024-12-12 05:16:41.756187+00	\N	\N
192e7940-b06f-4735-bd92-9a31ca616a66	2024-12-12 05:16:41.999434+00	2024-12-12 05:16:42.104412+00	e504b9e1-fa04-4033-a5df-ff769990603f	Journals::CompletedJob	default	{"job_id": "e504b9e1-fa04-4033-a5df-ff769990603f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-12-12T05:11:41.835833000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.864844763Z", "scheduled_at": "2024-12-12T05:16:41.864712082Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.864712+00	2024-12-12 05:16:42.104263+00	\N	\N
c203e4e4-fbb0-40e5-8d00-34959801de60	2024-12-12 05:16:42.201948+00	2024-12-12 05:16:42.28468+00	77890532-7b6f-41a0-991a-74aa3c7f7435	Notifications::WorkflowJob	default	{"job_id": "77890532-7b6f-41a0-991a-74aa3c7f7435", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.085032724Z", "scheduled_at": "2024-12-12T05:16:42.084915412Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.084915+00	2024-12-12 05:16:42.284452+00	\N	\N
b29618dd-5738-4df1-8e06-f9514c90bfb1	2024-12-12 05:16:42.390894+00	2024-12-12 05:16:42.473324+00	513c2b83-8ae8-4469-8e9e-66600ce8dbad	Notifications::WorkflowJob	default	{"job_id": "513c2b83-8ae8-4469-8e9e-66600ce8dbad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.260028978Z", "scheduled_at": "2024-12-12T05:16:42.259889123Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.259889+00	2024-12-12 05:16:42.473076+00	\N	\N
fd6c5885-064a-4aea-836f-1ad86bddc331	2024-12-12 06:30:00.306144+00	2024-12-12 06:30:00.38591+00	480bc58c-caa6-4c4b-8956-10227afb1b42	LdapGroups::SynchronizationJob	default	{"job_id": "480bc58c-caa6-4c4b-8956-10227afb1b42", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.113889910Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.114564+00	2024-12-12 06:30:00.385486+00	\N	\N
a01a58f5-0dae-48e0-8362-8f87b4d2d1af	2024-12-12 05:16:41.42317+00	2024-12-12 05:16:41.50725+00	9b3ca3bc-1797-408a-9cb3-baa6ac115575	Journals::CompletedJob	default	{"job_id": "9b3ca3bc-1797-408a-9cb3-baa6ac115575", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-12-12T05:11:41.387566000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.399987919Z", "scheduled_at": "2024-12-12T05:16:41.399850488Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.39985+00	2024-12-12 05:16:41.507058+00	\N	\N
d499c304-564c-4fed-bf2f-aa70b9006b3f	2024-12-12 05:16:41.568568+00	2024-12-12 05:16:41.618309+00	a4185266-fb2e-483c-ae3a-2e686da65a28	Notifications::WorkflowJob	default	{"job_id": "a4185266-fb2e-483c-ae3a-2e686da65a28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.547485803Z", "scheduled_at": "2024-12-12T05:16:41.547365334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.547365+00	2024-12-12 05:16:41.618168+00	\N	\N
3a39cb7d-478f-49ab-801d-80875eb1312d	2024-12-12 05:16:41.744205+00	2024-12-12 05:16:41.910243+00	f88c715d-87b1-4e5a-b5fa-4484afda6c25	Journals::CompletedJob	default	{"job_id": "f88c715d-87b1-4e5a-b5fa-4484afda6c25", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.679831000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.706174050Z", "scheduled_at": "2024-12-12T05:16:41.706009418Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.706009+00	2024-12-12 05:16:41.909993+00	\N	\N
263267f9-3446-422d-95a7-a294b62f58f7	2024-12-12 05:16:42.077369+00	2024-12-12 05:16:42.151087+00	f4b8350e-3fc9-4231-9ec7-b9c392f3767b	Notifications::WorkflowJob	default	{"job_id": "f4b8350e-3fc9-4231-9ec7-b9c392f3767b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.932484321Z", "scheduled_at": "2024-12-12T05:16:41.932364544Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.932364+00	2024-12-12 05:16:42.150875+00	\N	\N
f165e910-7eb4-4ff5-9bcd-66441d4a76c7	2024-12-12 05:16:42.26185+00	2024-12-12 05:16:42.332362+00	b5313fc8-17c5-4be2-9985-e0b9dc7c8f9a	Notifications::WorkflowJob	default	{"job_id": "b5313fc8-17c5-4be2-9985-e0b9dc7c8f9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.135539929Z", "scheduled_at": "2024-12-12T05:16:42.135419771Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.135419+00	2024-12-12 05:16:42.332138+00	\N	\N
87ae1366-1f9c-468e-b682-1fd4b2f16077	2024-12-12 05:16:42.448838+00	2024-12-12 05:16:42.539785+00	62dc0511-3627-441b-be8b-499061e2ef60	Journals::CompletedJob	default	{"job_id": "62dc0511-3627-441b-be8b-499061e2ef60", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-12-12T05:11:42.286053000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.327269509Z", "scheduled_at": "2024-12-12T05:16:42.327127560Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.327127+00	2024-12-12 05:16:42.539552+00	\N	\N
85677ae9-2112-4b63-9933-d6afda03b519	2024-12-12 05:16:42.08451+00	2024-12-12 05:16:42.234665+00	3f75ad1f-98f4-4501-b37b-e940ff0c1a90	Journals::CompletedJob	default	{"job_id": "3f75ad1f-98f4-4501-b37b-e940ff0c1a90", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.912893000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.936093949Z", "scheduled_at": "2024-12-12T05:16:41.935954866Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.935955+00	2024-12-12 05:16:42.234417+00	\N	\N
31808389-c5b9-46ff-a0e2-904f82ecfd32	2024-12-12 05:16:42.337999+00	2024-12-12 05:16:42.420796+00	2df54fa4-7f06-4aaa-9df3-8ba213e3d5e9	Notifications::WorkflowJob	default	{"job_id": "2df54fa4-7f06-4aaa-9df3-8ba213e3d5e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.187446847Z", "scheduled_at": "2024-12-12T05:16:42.187324345Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.187324+00	2024-12-12 05:16:42.420542+00	\N	\N
6acd3059-094f-454b-9eb8-c9abd14bb609	2024-12-12 05:16:42.531155+00	2024-12-12 05:16:42.626512+00	7d400cf8-19b0-4d39-ba29-f2869940f4bc	Journals::CompletedJob	default	{"job_id": "7d400cf8-19b0-4d39-ba29-f2869940f4bc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-12-12T05:11:42.370082000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.408475711Z", "scheduled_at": "2024-12-12T05:16:42.408339673Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.408339+00	2024-12-12 05:16:42.626275+00	\N	\N
da9fdbf2-f214-4107-a89a-c663b2c7006b	2024-12-12 05:16:42.746943+00	2024-12-12 05:16:42.835859+00	0b25f365-f9d7-40fa-9cca-7cd767d62c66	Journals::CompletedJob	default	{"job_id": "0b25f365-f9d7-40fa-9cca-7cd767d62c66", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-12-12T05:11:42.651970000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.691182314Z", "scheduled_at": "2024-12-12T05:16:42.690640016Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.69064+00	2024-12-12 05:16:42.835587+00	\N	\N
8cfa734a-d817-4eca-bf8c-6fc1431639cd	2024-12-12 05:16:42.1881+00	2024-12-12 05:16:42.269232+00	318e57f1-25f7-4ebb-9f3d-d024d7155527	Notifications::WorkflowJob	default	{"job_id": "318e57f1-25f7-4ebb-9f3d-d024d7155527", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.053762776Z", "scheduled_at": "2024-12-12T05:16:42.053646065Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.053646+00	2024-12-12 05:16:42.268981+00	\N	\N
dfbd036f-bd0c-4a6b-872b-1ec380d2c923	2024-12-12 05:16:42.377474+00	2024-12-12 05:16:42.466605+00	19ec265c-5d0a-4ac3-8436-f6e0cef67128	Notifications::WorkflowJob	default	{"job_id": "19ec265c-5d0a-4ac3-8436-f6e0cef67128", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.233081982Z", "scheduled_at": "2024-12-12T05:16:42.232965471Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.232965+00	2024-12-12 05:16:42.466362+00	\N	\N
20e931a7-1e08-49ab-98b9-d07475cf34ca	2024-12-12 05:16:42.577805+00	2024-12-12 05:16:42.679965+00	e99acf18-25eb-43e8-ae44-6c289acc0574	Journals::CompletedJob	default	{"job_id": "e99acf18-25eb-43e8-ae44-6c289acc0574", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-12-12T05:11:42.453266000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.484461971Z", "scheduled_at": "2024-12-12T05:16:42.484318609Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.484318+00	2024-12-12 05:16:42.679522+00	\N	\N
914d6621-16c9-446e-a409-3338feba1c13	2024-12-12 05:16:42.212341+00	2024-12-12 05:16:42.306864+00	86046dbe-9816-4ea3-a533-00c784fb7bf9	Journals::CompletedJob	default	{"job_id": "86046dbe-9816-4ea3-a533-00c784fb7bf9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-12-12T05:11:42.060742000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.088504833Z", "scheduled_at": "2024-12-12T05:16:42.088370218Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.08837+00	2024-12-12 05:16:42.306637+00	\N	\N
be36898a-6f43-467e-88cb-615138f964e9	2024-12-12 05:16:42.416689+00	2024-12-12 05:16:42.502286+00	7b0b6212-a9fd-4ec8-8289-6346f1891dd8	Notifications::WorkflowJob	default	{"job_id": "7b0b6212-a9fd-4ec8-8289-6346f1891dd8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.278518942Z", "scheduled_at": "2024-12-12T05:16:42.278400578Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.2784+00	2024-12-12 05:16:42.502013+00	\N	\N
3c2922c6-e70f-46b2-bc03-dd56cf1b4215	2024-12-12 05:16:42.612806+00	2024-12-12 05:16:42.711162+00	ea254c61-c12f-4455-8140-7a4b76d90914	Journals::CompletedJob	default	{"job_id": "ea254c61-c12f-4455-8140-7a4b76d90914", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-12-12T05:11:42.524089000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.554939585Z", "scheduled_at": "2024-12-12T05:16:42.554464575Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.554464+00	2024-12-12 05:16:42.710933+00	\N	\N
74f994b5-f4fa-4f22-bf7c-dd940a29c883	2024-12-12 05:16:42.256432+00	2024-12-12 05:16:42.384304+00	ec3595d2-5c0a-4572-aea6-c1539975a439	Journals::CompletedJob	default	{"job_id": "ec3595d2-5c0a-4572-aea6-c1539975a439", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-12-12T05:11:42.095862000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.107373762Z", "scheduled_at": "2024-12-12T05:16:42.107239999Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.107239+00	2024-12-12 05:16:42.384068+00	\N	\N
3e54fcfb-98d2-4ba3-b16c-a502a49e68d0	2024-12-12 05:16:42.496658+00	2024-12-12 05:16:42.621139+00	8e17ff0a-d9a8-40cf-a048-aa561c2cec92	Journals::CompletedJob	default	{"job_id": "8e17ff0a-d9a8-40cf-a048-aa561c2cec92", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-12-12T05:11:42.339676000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.360943181Z", "scheduled_at": "2024-12-12T05:16:42.360740447Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.36074+00	2024-12-12 05:16:42.620877+00	\N	\N
d977efc1-1798-48ee-bf9b-5896790251b2	2024-12-12 05:16:42.733798+00	2024-12-12 05:16:42.820874+00	e134d110-eecd-4c17-be08-0b12f97f185e	Notifications::WorkflowJob	default	{"job_id": "e134d110-eecd-4c17-be08-0b12f97f185e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.684695013Z", "scheduled_at": "2024-12-12T05:16:42.684014032Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.684014+00	2024-12-12 05:16:42.820599+00	\N	\N
b5d616b0-e55d-4e12-8c5a-1427accf8b0e	2024-12-12 05:16:42.330279+00	2024-12-12 05:16:42.490873+00	a39465e9-24bd-43bc-b5db-c218ff2fa9f1	Journals::CompletedJob	default	{"job_id": "a39465e9-24bd-43bc-b5db-c218ff2fa9f1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-12-12T05:11:42.145799000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.157371694Z", "scheduled_at": "2024-12-12T05:16:42.157235065Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.157234+00	2024-12-12 05:16:42.490602+00	\N	\N
1f6afb21-40df-426e-825f-8f1d4196eae7	2024-12-12 05:16:42.604282+00	2024-12-12 05:16:42.688166+00	e74221f1-5e78-445d-9092-9a1e7496bb91	Notifications::WorkflowJob	default	{"job_id": "e74221f1-5e78-445d-9092-9a1e7496bb91", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.549344474Z", "scheduled_at": "2024-12-12T05:16:42.549220209Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.54922+00	2024-12-12 05:16:42.687906+00	\N	\N
d8fe0c70-2351-4f13-a0a6-e4a76a6469d9	2024-12-12 05:16:42.807881+00	2024-12-12 05:16:42.88645+00	5ca7ff7d-d2fc-4adb-acc4-d674431c1997	Journals::CompletedJob	default	{"job_id": "5ca7ff7d-d2fc-4adb-acc4-d674431c1997", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-12-12T05:11:42.729658000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.764750834Z", "scheduled_at": "2024-12-12T05:16:42.764546006Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.764546+00	2024-12-12 05:16:42.886328+00	\N	\N
d9afc66c-a9d1-4499-b175-dcece3cb43f1	2024-12-12 05:16:42.583471+00	2024-12-12 05:16:42.670054+00	9362d382-ef3d-49f9-84be-5c936c7b9a44	Notifications::WorkflowJob	default	{"job_id": "9362d382-ef3d-49f9-84be-5c936c7b9a44", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.511675583Z", "scheduled_at": "2024-12-12T05:16:42.511545948Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.511545+00	2024-12-12 05:16:42.669792+00	\N	\N
1ef10f7e-442b-451b-be70-88b4a90ecaa9	2024-12-12 05:16:42.841477+00	2024-12-12 05:16:42.916835+00	08ece3ee-c27c-4973-a229-d772102f85a3	Journals::CompletedJob	default	{"job_id": "08ece3ee-c27c-4973-a229-d772102f85a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-12-12T05:11:42.780668000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.805123478Z", "scheduled_at": "2024-12-12T05:16:42.804425134Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.804425+00	2024-12-12 05:16:42.916721+00	\N	\N
1fc8eeea-f740-4cd5-9af7-939dea1ed7d6	2024-12-12 05:16:43.217365+00	2024-12-12 05:16:43.225207+00	8fd1420b-e596-4873-bbba-c2b06dd2a312	Notifications::WorkflowJob	default	{"job_id": "8fd1420b-e596-4873-bbba-c2b06dd2a312", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.212171751Z", "scheduled_at": "2024-12-12T05:16:43.212041163Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:43.212041+00	2024-12-12 05:16:43.225043+00	\N	\N
103d877a-f39e-4d98-9d99-a0f027a8024e	2024-12-12 05:16:43.291817+00	2024-12-12 05:16:43.299184+00	5d70a5b5-8f92-4a97-9bc4-06dc7dcd543b	Notifications::WorkflowJob	default	{"job_id": "5d70a5b5-8f92-4a97-9bc4-06dc7dcd543b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.287876930Z", "scheduled_at": "2024-12-12T05:16:43.287756972Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:43.287757+00	2024-12-12 05:16:43.298958+00	\N	\N
f0b515b9-7d38-42b8-b4b0-ff38aeb05bff	2024-12-12 05:16:42.655901+00	2024-12-12 05:16:42.746091+00	f5af16f3-320f-4281-be56-5504c5b2709f	Notifications::WorkflowJob	default	{"job_id": "f5af16f3-320f-4281-be56-5504c5b2709f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.614290787Z", "scheduled_at": "2024-12-12T05:16:42.614173184Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.614173+00	2024-12-12 05:16:42.745844+00	\N	\N
85d0ae58-fc16-4299-95c4-c19e4cf2c184	2024-12-12 05:16:42.71787+00	2024-12-12 05:16:42.848084+00	73f93a95-a8ce-4938-9970-341178a1e1de	Journals::CompletedJob	default	{"job_id": "73f93a95-a8ce-4938-9970-341178a1e1de", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-12-12T05:11:42.629794000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.646351222Z", "scheduled_at": "2024-12-12T05:16:42.645856144Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.645856+00	2024-12-12 05:16:42.847843+00	\N	\N
ccc9105c-0755-4a5d-997b-309ec46b2a7b	2024-12-12 05:16:42.786623+00	2024-12-12 05:16:42.895033+00	2fb44986-5d9a-4da5-a03e-f20d87f567d0	Journals::CompletedJob	default	{"job_id": "2fb44986-5d9a-4da5-a03e-f20d87f567d0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-12-12T05:11:42.703113000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.722459003Z", "scheduled_at": "2024-12-12T05:16:42.722319469Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.722319+00	2024-12-12 05:16:42.894769+00	\N	\N
\.


--
-- Data for Name: good_job_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_job_processes (id, created_at, updated_at, state) FROM stdin;
35597fb2-9c10-4344-b371-45df93f8f08e	2024-12-12 06:29:50.830073+00	2024-12-12 06:36:21.803089+00	{"id": "35597fb2-9c10-4344-b371-45df93f8f08e", "pid": 137, "hostname": "96f20339f336", "proctitle": "/app/vendor/bundle/ruby/3.3.0/bin/good_job", "schedulers": [{"name": "GoodJob::Scheduler(queues=* max_threads=20)", "queues": "*", "max_cache": 10000, "max_threads": 20, "active_cache": 0, "execution_at": "2024-12-12T06:30:00.468Z", "active_threads": 0, "check_queue_at": "2024-12-12T06:36:20.797Z", "available_cache": 10000, "available_threads": 20, "empty_executions_count": 43, "total_executions_count": 3, "errored_executions_count": 0, "succeeded_executions_count": 3}], "cron_enabled": true, "preserve_job_records": true, "total_executions_count": 3, "database_connection_pool": {"size": 17, "active": 1}, "retry_on_unhandled_error": false, "total_empty_executions_count": 43, "total_errored_executions_count": 0, "total_succeeded_executions_count": 3}
\.


--
-- Data for Name: good_job_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_job_settings (id, created_at, updated_at, key, value) FROM stdin;
\.


--
-- Data for Name: good_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_jobs (id, queue_name, priority, serialized_params, scheduled_at, performed_at, finished_at, error, created_at, updated_at, active_job_id, concurrency_key, cron_key, retried_good_job_id, cron_at, batch_id, batch_callback_id, is_discrete, executions_count, job_class, error_event, labels) FROM stdin;
44d9c410-9509-4d4c-b976-c64cde3cf3a4	default	10	{"job_id": "44d9c410-9509-4d4c-b976-c64cde3cf3a4", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 1, "queue_name": "default", "enqueued_at": "2024-12-12T05:12:23.100651401Z", "scheduled_at": "2024-12-12T05:17:23.099299430Z", "provider_job_id": "44d9c410-9509-4d4c-b976-c64cde3cf3a4", "exception_executions": {"[GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError]": 1}}	2024-12-12 05:17:23.099299+00	2024-12-12 05:17:23.105185+00	2024-12-12 05:17:23.140176+00	\N	2024-12-12 05:11:13.564379+00	2024-12-12 05:17:23.142194+00	44d9c410-9509-4d4c-b976-c64cde3cf3a4	WorkPackagesProgressJob	\N	\N	\N	\N	\N	t	2	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	\N	\N
c3b435e4-90dc-4914-966f-0abc6c883e90	default	5	{"job_id": "c3b435e4-90dc-4914-966f-0abc6c883e90", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [2, {"value": "2024-12-12T05:11:39.194667000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.243156738Z", "scheduled_at": "2024-12-12T05:16:39.241993764Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.241993+00	2024-12-12 05:16:39.247827+00	2024-12-12 05:16:39.294957+00	\N	2024-12-12 05:11:39.243595+00	2024-12-12 05:16:39.297305+00	c3b435e4-90dc-4914-966f-0abc6c883e90	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
8fdacb5c-85b7-4bfd-813b-46b278778ed0	default	5	{"job_id": "8fdacb5c-85b7-4bfd-813b-46b278778ed0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/1"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.084780340Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.112371+00	2024-12-12 05:11:39.117729+00	2024-12-12 05:11:39.160913+00	\N	2024-12-12 05:11:39.112371+00	2024-12-12 05:11:39.163633+00	8fdacb5c-85b7-4bfd-813b-46b278778ed0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d84ec7a0-b2fd-4eda-bf7f-895cb1ba6ae9	default	10	{"job_id": "d84ec7a0-b2fd-4eda-bf7f-895cb1ba6ae9", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [{"current_mode": "field", "previous_mode": null, "_aj_ruby2_keywords": ["current_mode", "previous_mode"]}], "job_class": "WorkPackages::Progress::MigrateValuesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:13.388283600Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:13.422922+00	2024-12-12 05:12:22.983369+00	2024-12-12 05:12:23.116433+00	\N	2024-12-12 05:11:13.422922+00	2024-12-12 05:12:23.139399+00	d84ec7a0-b2fd-4eda-bf7f-895cb1ba6ae9	WorkPackagesProgressJob	\N	\N	\N	\N	\N	t	1	WorkPackages::Progress::MigrateValuesJob	\N	\N
57cdaf17-1cec-44f1-a80d-2edfef4e4c3f	default	0	{"job_id": "57cdaf17-1cec-44f1-a80d-2edfef4e4c3f", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.066178061Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.066545+00	2024-12-12 05:30:00.131587+00	2024-12-12 05:30:00.196525+00	\N	2024-12-12 05:30:00.066545+00	2024-12-12 05:30:00.197913+00	57cdaf17-1cec-44f1-a80d-2edfef4e4c3f	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 05:30:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
e7e93f49-774b-4c11-a67b-7a53714788c6	default	5	{"job_id": "e7e93f49-774b-4c11-a67b-7a53714788c6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/2"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.213919402Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.214795+00	2024-12-12 05:11:39.216711+00	2024-12-12 05:11:39.238161+00	\N	2024-12-12 05:11:39.214795+00	2024-12-12 05:11:39.239776+00	e7e93f49-774b-4c11-a67b-7a53714788c6	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b528a40f-f6c5-437b-beab-d8a7dd7573f7	default	0	{"job_id": "b528a40f-f6c5-437b-beab-d8a7dd7573f7", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.050323783Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.050913+00	2024-12-12 05:30:00.091543+00	2024-12-12 05:30:00.143001+00	\N	2024-12-12 05:30:00.050913+00	2024-12-12 05:30:00.145276+00	b528a40f-f6c5-437b-beab-d8a7dd7573f7	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 05:30:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
e8689e9f-ae25-4e8c-9f2c-ed1778fcc1ea	default	5	{"job_id": "e8689e9f-ae25-4e8c-9f2c-ed1778fcc1ea", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.156772224Z", "scheduled_at": "2024-12-12T05:16:39.155371550Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.155371+00	2024-12-12 05:16:39.162543+00	2024-12-12 05:16:39.192985+00	\N	2024-12-12 05:11:39.158407+00	2024-12-12 05:16:39.195454+00	e8689e9f-ae25-4e8c-9f2c-ed1778fcc1ea	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0d44cf95-4b60-4779-a86a-a9d794aa5ade	default	0	{"job_id": "0d44cf95-4b60-4779-a86a-a9d794aa5ade", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:15:00.060213328Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:15:00.065371+00	2024-12-12 05:15:00.106072+00	2024-12-12 05:15:00.226793+00	\N	2024-12-12 05:15:00.065371+00	2024-12-12 05:15:00.232016+00	0d44cf95-4b60-4779-a86a-a9d794aa5ade	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 05:15:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
72db92c2-55ad-437b-b0ac-530c5497d4be	default	0	{"job_id": "72db92c2-55ad-437b-b0ac-530c5497d4be", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:15:00.114937146Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:15:00.115744+00	2024-12-12 05:15:00.137881+00	2024-12-12 05:15:00.232627+00	\N	2024-12-12 05:15:00.115744+00	2024-12-12 05:15:00.234383+00	72db92c2-55ad-437b-b0ac-530c5497d4be	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 05:15:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
bcf13854-4cd3-4458-8886-0a14b103e8e9	default	5	{"job_id": "bcf13854-4cd3-4458-8886-0a14b103e8e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.235807032Z", "scheduled_at": "2024-12-12T05:16:39.235626340Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.235626+00	2024-12-12 05:16:39.240271+00	2024-12-12 05:16:39.253711+00	\N	2024-12-12 05:11:39.236111+00	2024-12-12 05:16:39.256495+00	bcf13854-4cd3-4458-8886-0a14b103e8e9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b7c7b7bf-c114-4c04-9f10-a7a685e6c538	default	0	{"job_id": "b7c7b7bf-c114-4c04-9f10-a7a685e6c538", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:30:00.013147603Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:30:00.017337+00	2024-12-12 05:30:00.073209+00	2024-12-12 05:30:00.087324+00	\N	2024-12-12 05:30:00.017337+00	2024-12-12 05:30:00.090986+00	b7c7b7bf-c114-4c04-9f10-a7a685e6c538	\N	LdapGroups::SynchronizationJob	\N	2024-12-12 05:30:00+00	\N	\N	t	1	LdapGroups::SynchronizationJob	\N	\N
4d747ab4-d6dc-40cc-b570-be76af04342f	default	5	{"job_id": "4d747ab4-d6dc-40cc-b570-be76af04342f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/3"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.458837279Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.45911+00	2024-12-12 05:11:39.460855+00	2024-12-12 05:11:39.471773+00	\N	2024-12-12 05:11:39.45911+00	2024-12-12 05:11:39.472727+00	4d747ab4-d6dc-40cc-b570-be76af04342f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9ee19c6c-b7ce-4ebc-b593-4482f75c9f8e	default	5	{"job_id": "9ee19c6c-b7ce-4ebc-b593-4482f75c9f8e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.553265292Z", "scheduled_at": "2024-12-12T05:16:39.553088647Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.553088+00	2024-12-12 05:16:39.560826+00	2024-12-12 05:16:39.580307+00	\N	2024-12-12 05:11:39.55346+00	2024-12-12 05:16:39.590418+00	9ee19c6c-b7ce-4ebc-b593-4482f75c9f8e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8d386dbf-3946-41d5-8d45-d02c4f249a88	default	5	{"job_id": "8d386dbf-3946-41d5-8d45-d02c4f249a88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.470209316Z", "scheduled_at": "2024-12-12T05:16:39.470032391Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.470032+00	2024-12-12 05:16:39.475074+00	2024-12-12 05:16:39.504283+00	\N	2024-12-12 05:11:39.470407+00	2024-12-12 05:16:39.506728+00	8d386dbf-3946-41d5-8d45-d02c4f249a88	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d613a89f-279d-4956-9aaf-7062e09dba42	default	5	{"job_id": "d613a89f-279d-4956-9aaf-7062e09dba42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.542097333Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.542331+00	2024-12-12 05:11:39.543789+00	2024-12-12 05:11:39.554665+00	\N	2024-12-12 05:11:39.542331+00	2024-12-12 05:11:39.555496+00	d613a89f-279d-4956-9aaf-7062e09dba42	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
09fe791e-f28d-4ec0-a63c-6f813b90d79a	default	5	{"job_id": "09fe791e-f28d-4ec0-a63c-6f813b90d79a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [3, {"value": "2024-12-12T05:11:39.450982000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.475621040Z", "scheduled_at": "2024-12-12T05:16:39.474989503Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.474989+00	2024-12-12 05:16:39.493407+00	2024-12-12 05:16:39.519653+00	\N	2024-12-12 05:11:39.475958+00	2024-12-12 05:16:39.522126+00	09fe791e-f28d-4ec0-a63c-6f813b90d79a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2c62ebfb-717f-414e-8f2b-30bf89bfd440	default	5	{"job_id": "2c62ebfb-717f-414e-8f2b-30bf89bfd440", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-12-12T05:11:39.507931000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.556843231Z", "scheduled_at": "2024-12-12T05:16:39.556631700Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.556631+00	2024-12-12 05:16:39.566311+00	2024-12-12 05:16:39.592384+00	\N	2024-12-12 05:11:39.55743+00	2024-12-12 05:16:39.59422+00	2c62ebfb-717f-414e-8f2b-30bf89bfd440	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
6b1333e9-bb0a-41ed-9745-9dc39db9181e	default	5	{"job_id": "6b1333e9-bb0a-41ed-9745-9dc39db9181e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.576956340Z", "scheduled_at": "2024-12-12T05:16:39.576660960Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.576661+00	2024-12-12 05:16:39.594717+00	2024-12-12 05:16:39.61131+00	\N	2024-12-12 05:11:39.577164+00	2024-12-12 05:16:39.620525+00	6b1333e9-bb0a-41ed-9745-9dc39db9181e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6e3925d3-4c5f-47e1-b7f9-437e395e8ce0	default	5	{"job_id": "6e3925d3-4c5f-47e1-b7f9-437e395e8ce0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.568893103Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.569252+00	2024-12-12 05:11:39.570388+00	2024-12-12 05:11:39.578404+00	\N	2024-12-12 05:11:39.569252+00	2024-12-12 05:11:39.579313+00	6e3925d3-4c5f-47e1-b7f9-437e395e8ce0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
dab273d4-b283-4476-9483-3be2d8c8c267	default	0	{"job_id": "dab273d4-b283-4476-9483-3be2d8c8c267", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:15:00.009283719Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:15:00.010087+00	2024-12-11 10:15:00.03816+00	2024-12-11 10:15:00.062808+00	\N	2024-12-11 10:15:00.010087+00	2024-12-11 10:15:00.078218+00	dab273d4-b283-4476-9483-3be2d8c8c267	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-11 10:15:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
3b719e0b-ad68-4daa-932b-6633e9aeebb1	default	5	{"job_id": "3b719e0b-ad68-4daa-932b-6633e9aeebb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-12-12T05:11:39.567864000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.580619470Z", "scheduled_at": "2024-12-12T05:16:39.580402559Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.580402+00	2024-12-12 05:16:39.602267+00	2024-12-12 05:16:39.692071+00	\N	2024-12-12 05:11:39.580783+00	2024-12-12 05:16:39.701978+00	3b719e0b-ad68-4daa-932b-6633e9aeebb1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
355f2ffc-ffab-4ed0-a804-d894c206edb7	default	5	{"job_id": "355f2ffc-ffab-4ed0-a804-d894c206edb7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.598320208Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.598516+00	2024-12-12 05:11:39.599782+00	2024-12-12 05:11:39.607771+00	\N	2024-12-12 05:11:39.598516+00	2024-12-12 05:11:39.608659+00	355f2ffc-ffab-4ed0-a804-d894c206edb7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
90751669-e99a-4a8a-a27b-9661baccb8a0	default	0	{"job_id": "90751669-e99a-4a8a-a27b-9661baccb8a0", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:15:00.022511171Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:15:00.022921+00	2024-12-11 10:15:00.083665+00	2024-12-11 10:15:00.118426+00	\N	2024-12-11 10:15:00.022921+00	2024-12-11 10:15:00.119952+00	90751669-e99a-4a8a-a27b-9661baccb8a0	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-11 10:15:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
d42cf4dd-d3a3-4ed2-9966-a2df389757b0	default	5	{"job_id": "d42cf4dd-d3a3-4ed2-9966-a2df389757b0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.606051316Z", "scheduled_at": "2024-12-12T05:16:39.605875794Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.605875+00	2024-12-12 05:16:39.615046+00	2024-12-12 05:16:39.678375+00	\N	2024-12-12 05:11:39.606245+00	2024-12-12 05:16:39.696229+00	d42cf4dd-d3a3-4ed2-9966-a2df389757b0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6b9e366d-bf22-4553-affd-1d07d55d8300	default	5	{"job_id": "6b9e366d-bf22-4553-affd-1d07d55d8300", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.615712000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.640018815Z", "scheduled_at": "2024-12-12T05:16:39.639810440Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.63981+00	2024-12-12 05:16:39.728592+00	2024-12-12 05:16:39.777046+00	\N	2024-12-12 05:11:39.640177+00	2024-12-12 05:16:39.787455+00	6b9e366d-bf22-4553-affd-1d07d55d8300	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
7d548bbe-9349-402b-9f72-d45c7f3a8eab	default	5	{"job_id": "7d548bbe-9349-402b-9f72-d45c7f3a8eab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.624264765Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.624459+00	2024-12-12 05:11:39.625842+00	2024-12-12 05:11:39.637965+00	\N	2024-12-12 05:11:39.624459+00	2024-12-12 05:11:39.638827+00	7d548bbe-9349-402b-9f72-d45c7f3a8eab	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c36ac149-fe78-4d44-a165-1d2fd7440c80	default	5	{"job_id": "c36ac149-fe78-4d44-a165-1d2fd7440c80", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-12-12T05:11:39.588643000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.610061766Z", "scheduled_at": "2024-12-12T05:16:39.609833914Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.609833+00	2024-12-12 05:16:39.68256+00	2024-12-12 05:16:39.732201+00	\N	2024-12-12 05:11:39.610239+00	2024-12-12 05:16:39.746432+00	c36ac149-fe78-4d44-a165-1d2fd7440c80	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c08034e0-4001-4f3f-ab46-026a678463b7	default	5	{"job_id": "c08034e0-4001-4f3f-ab46-026a678463b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.635439429Z", "scheduled_at": "2024-12-12T05:16:39.635268495Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.635268+00	2024-12-12 05:16:39.718356+00	2024-12-12 05:16:39.762847+00	\N	2024-12-12 05:11:39.635629+00	2024-12-12 05:16:39.776672+00	c08034e0-4001-4f3f-ab46-026a678463b7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
27f293ea-996d-420a-bb0e-291ccf15a996	default	5	{"job_id": "27f293ea-996d-420a-bb0e-291ccf15a996", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.679687096Z", "scheduled_at": "2024-12-12T05:16:39.679498428Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.679498+00	2024-12-12 05:16:39.797142+00	2024-12-12 05:16:39.894356+00	\N	2024-12-12 05:11:39.679895+00	2024-12-12 05:16:39.964019+00	27f293ea-996d-420a-bb0e-291ccf15a996	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
41360ba7-bd8f-46e1-a9d6-e891e67107db	default	0	{"job_id": "41360ba7-bd8f-46e1-a9d6-e891e67107db", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:15:00.121716539Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:15:00.122706+00	2024-12-12 03:15:00.179093+00	2024-12-12 03:15:00.342005+00	\N	2024-12-12 03:15:00.122706+00	2024-12-12 03:15:00.346568+00	41360ba7-bd8f-46e1-a9d6-e891e67107db	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 03:15:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
13dadf80-2237-4336-891f-2095675482bb	default	0	{"job_id": "13dadf80-2237-4336-891f-2095675482bb", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:15:00.058268248Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:15:00.08677+00	2024-12-12 03:15:00.137807+00	2024-12-12 03:15:00.367374+00	\N	2024-12-12 03:15:00.08677+00	2024-12-12 03:15:00.369675+00	13dadf80-2237-4336-891f-2095675482bb	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 03:15:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
ba10f053-5591-4d77-ab57-c7503710b78d	default	5	{"job_id": "ba10f053-5591-4d77-ab57-c7503710b78d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.652602578Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.652796+00	2024-12-12 05:11:39.653981+00	2024-12-12 05:11:39.661319+00	\N	2024-12-12 05:11:39.652796+00	2024-12-12 05:11:39.662264+00	ba10f053-5591-4d77-ab57-c7503710b78d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bee5d49f-63b8-4872-858a-6c2cb3553c4d	default	0	{"job_id": "bee5d49f-63b8-4872-858a-6c2cb3553c4d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.009356246Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.009851+00	2024-12-11 10:30:00.050327+00	2024-12-11 10:30:00.081422+00	\N	2024-12-11 10:30:00.009851+00	2024-12-11 10:30:00.086403+00	bee5d49f-63b8-4872-858a-6c2cb3553c4d	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-11 10:30:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
b5b426b5-6ef6-44c8-8c77-7293a53e819c	default	5	{"job_id": "b5b426b5-6ef6-44c8-8c77-7293a53e819c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.659846032Z", "scheduled_at": "2024-12-12T05:16:39.659653488Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.659653+00	2024-12-12 05:16:39.736671+00	2024-12-12 05:16:39.779294+00	\N	2024-12-12 05:11:39.660058+00	2024-12-12 05:16:39.790457+00	b5b426b5-6ef6-44c8-8c77-7293a53e819c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
99f3eb89-3249-43a2-8aca-8b5587343262	default	0	{"job_id": "99f3eb89-3249-43a2-8aca-8b5587343262", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.028158610Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.02864+00	2024-12-11 10:30:00.069741+00	2024-12-11 10:30:00.088667+00	\N	2024-12-11 10:30:00.02864+00	2024-12-11 10:30:00.09367+00	99f3eb89-3249-43a2-8aca-8b5587343262	\N	LdapGroups::SynchronizationJob	\N	2024-12-11 10:30:00+00	\N	\N	t	1	LdapGroups::SynchronizationJob	\N	\N
5a213f90-ea86-44ac-b69a-a39f3d5af2f9	default	0	{"job_id": "5a213f90-ea86-44ac-b69a-a39f3d5af2f9", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:30:00.037498548Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:30:00.037651+00	2024-12-11 10:30:00.077261+00	2024-12-11 10:30:00.101042+00	\N	2024-12-11 10:30:00.037651+00	2024-12-11 10:30:00.102611+00	5a213f90-ea86-44ac-b69a-a39f3d5af2f9	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-11 10:30:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
cb2088cd-a018-4cd8-967c-ca174f27724f	default	5	{"job_id": "cb2088cd-a018-4cd8-967c-ca174f27724f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.671533305Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.671724+00	2024-12-12 05:11:39.672891+00	2024-12-12 05:11:39.681388+00	\N	2024-12-12 05:11:39.671724+00	2024-12-12 05:11:39.682218+00	cb2088cd-a018-4cd8-967c-ca174f27724f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0f57c48c-257e-4078-b3ae-f1a8d228c069	default	5	{"job_id": "0f57c48c-257e-4078-b3ae-f1a8d228c069", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/81"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:07.562474026Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:17:07.576158+00	2024-12-12 03:17:07.605238+00	2024-12-12 03:17:07.697787+00	\N	2024-12-12 03:17:07.576158+00	2024-12-12 03:17:07.698991+00	0f57c48c-257e-4078-b3ae-f1a8d228c069	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0fb96a69-92be-4c65-8498-41845b81b28b	default	5	{"job_id": "0fb96a69-92be-4c65-8498-41845b81b28b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.643963000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.663679295Z", "scheduled_at": "2024-12-12T05:16:39.663452906Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.663452+00	2024-12-12 05:16:39.773268+00	2024-12-12 05:16:39.83187+00	\N	2024-12-12 05:11:39.66386+00	2024-12-12 05:16:39.881003+00	0fb96a69-92be-4c65-8498-41845b81b28b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0220cb3a-647c-49fd-b8ab-4fb7e899559b	default	5	{"job_id": "0220cb3a-647c-49fd-b8ab-4fb7e899559b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.670563000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.683439695Z", "scheduled_at": "2024-12-12T05:16:39.683218256Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.683218+00	2024-12-12 05:16:39.798211+00	2024-12-12 05:16:39.98061+00	\N	2024-12-12 05:11:39.683611+00	2024-12-12 05:16:40.041032+00	0220cb3a-647c-49fd-b8ab-4fb7e899559b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
70b58a97-85cd-4648-8a3b-63ee73a6be89	default	5	{"job_id": "70b58a97-85cd-4648-8a3b-63ee73a6be89", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/81"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:31.196586319Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:17:31.209216+00	2024-12-12 03:17:31.241947+00	2024-12-12 03:17:31.265234+00	\N	2024-12-12 03:17:31.209216+00	2024-12-12 03:17:31.267201+00	70b58a97-85cd-4648-8a3b-63ee73a6be89	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4501076c-06c5-4906-acee-2d373e68c093	default	5	{"job_id": "4501076c-06c5-4906-acee-2d373e68c093", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.706996619Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.707192+00	2024-12-12 05:11:39.708182+00	2024-12-12 05:11:39.715838+00	\N	2024-12-12 05:11:39.707192+00	2024-12-12 05:11:39.716596+00	4501076c-06c5-4906-acee-2d373e68c093	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
96c84240-0c36-457d-9e2c-bf494f42ee51	default	0	{"job_id": "96c84240-0c36-457d-9e2c-bf494f42ee51", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.034581711Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.059757+00	2024-12-11 10:00:00.125531+00	2024-12-11 10:00:00.468614+00	\N	2024-12-11 10:00:00.059757+00	2024-12-11 10:00:00.471427+00	96c84240-0c36-457d-9e2c-bf494f42ee51	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-11 10:00:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
b0688e97-6e69-49fe-82fb-97da60e92b8d	default	0	{"job_id": "b0688e97-6e69-49fe-82fb-97da60e92b8d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.087238984Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.088277+00	2024-12-11 10:00:00.151622+00	2024-12-11 10:00:00.420017+00	\N	2024-12-11 10:00:00.088277+00	2024-12-11 10:00:00.424971+00	b0688e97-6e69-49fe-82fb-97da60e92b8d	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-11 10:00:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
7796ff26-8747-4f86-8d2e-8bf96f264adc	default	5	{"job_id": "7796ff26-8747-4f86-8d2e-8bf96f264adc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-12-12T05:11:39.690221000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.718270529Z", "scheduled_at": "2024-12-12T05:16:39.718061292Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.718061+00	2024-12-12 05:16:39.788307+00	2024-12-12 05:16:40.036614+00	\N	2024-12-12 05:11:39.71843+00	2024-12-12 05:16:40.096555+00	7796ff26-8747-4f86-8d2e-8bf96f264adc	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c76379a3-8375-451c-9e91-32cff2cfeeed	default	0	{"job_id": "c76379a3-8375-451c-9e91-32cff2cfeeed", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:00:00.099758627Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:00:00.100142+00	2024-12-11 10:00:00.415681+00	2024-12-11 10:00:00.439496+00	\N	2024-12-11 10:00:00.100142+00	2024-12-11 10:00:00.442169+00	c76379a3-8375-451c-9e91-32cff2cfeeed	\N	LdapGroups::SynchronizationJob	\N	2024-12-11 10:00:00+00	\N	\N	t	1	LdapGroups::SynchronizationJob	\N	\N
454e316a-27fc-40d5-9fd8-eaa74628734f	default	5	{"job_id": "454e316a-27fc-40d5-9fd8-eaa74628734f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.731513080Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.73171+00	2024-12-12 05:11:39.733121+00	2024-12-12 05:11:39.739564+00	\N	2024-12-12 05:11:39.73171+00	2024-12-12 05:11:39.740812+00	454e316a-27fc-40d5-9fd8-eaa74628734f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
883c0f20-a5c0-46fa-ae44-fe5678822fef	default	5	{"job_id": "883c0f20-a5c0-46fa-ae44-fe5678822fef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.750032890Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.750219+00	2024-12-12 05:11:39.751204+00	2024-12-12 05:11:39.75809+00	\N	2024-12-12 05:11:39.750219+00	2024-12-12 05:11:39.758803+00	883c0f20-a5c0-46fa-ae44-fe5678822fef	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b0667920-1841-4687-9a9a-20d3bed5fc51	default	5	{"job_id": "b0667920-1841-4687-9a9a-20d3bed5fc51", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.738305710Z", "scheduled_at": "2024-12-12T05:16:39.738139445Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.738139+00	2024-12-12 05:16:39.799434+00	2024-12-12 05:16:39.908312+00	\N	2024-12-12 05:11:39.73849+00	2024-12-12 05:16:39.970188+00	b0667920-1841-4687-9a9a-20d3bed5fc51	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f2f93f58-072d-40e4-bb55-d73915f30b73	default	5	{"job_id": "f2f93f58-072d-40e4-bb55-d73915f30b73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.713918353Z", "scheduled_at": "2024-12-12T05:16:39.713748551Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.713748+00	2024-12-12 05:16:39.801134+00	2024-12-12 05:16:39.932585+00	\N	2024-12-12 05:11:39.714201+00	2024-12-12 05:16:39.989829+00	f2f93f58-072d-40e4-bb55-d73915f30b73	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c29244ec-3b73-43b8-8343-bedead59d6d2	default	5	{"job_id": "c29244ec-3b73-43b8-8343-bedead59d6d2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.756819969Z", "scheduled_at": "2024-12-12T05:16:39.756582469Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.756582+00	2024-12-12 05:16:39.825264+00	2024-12-12 05:16:39.994498+00	\N	2024-12-12 05:11:39.757017+00	2024-12-12 05:16:40.058064+00	c29244ec-3b73-43b8-8343-bedead59d6d2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
18950377-0230-4572-a224-b4dc6a23846e	default	5	{"job_id": "18950377-0230-4572-a224-b4dc6a23846e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.722974000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.741962268Z", "scheduled_at": "2024-12-12T05:16:39.741752230Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.741752+00	2024-12-12 05:16:39.809049+00	2024-12-12 05:16:40.003114+00	\N	2024-12-12 05:11:39.742122+00	2024-12-12 05:16:40.071532+00	18950377-0230-4572-a224-b4dc6a23846e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
106e6c38-457e-4a66-b1bb-bc4263b58eaf	default	7	{"job_id": "106e6c38-457e-4a66-b1bb-bc4263b58eaf", "locale": "en", "priority": 7, "timezone": "UTC", "arguments": [], "job_class": "Storages::ManageStorageIntegrationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:01:00.018425847Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:01:00.019023+00	2024-12-11 10:01:00.029172+00	2024-12-11 10:01:00.048741+00	\N	2024-12-11 10:01:00.019023+00	2024-12-11 10:01:00.050056+00	106e6c38-457e-4a66-b1bb-bc4263b58eaf	Storages::ManageStorageIntegrationsJob	Storages::ManageStorageIntegrationsJob	\N	2024-12-11 10:01:00+00	\N	\N	t	1	Storages::ManageStorageIntegrationsJob	\N	\N
1e23f241-a41c-472b-82ac-a62db4aec576	default	5	{"job_id": "1e23f241-a41c-472b-82ac-a62db4aec576", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.787075000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.810797891Z", "scheduled_at": "2024-12-12T05:16:39.810594967Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.810595+00	2024-12-12 05:16:39.956131+00	2024-12-12 05:16:40.209447+00	\N	2024-12-12 05:11:39.810954+00	2024-12-12 05:16:40.280961+00	1e23f241-a41c-472b-82ac-a62db4aec576	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
5f4a7f00-f237-48f3-90c5-e19354f534a9	default	5	{"job_id": "5f4a7f00-f237-48f3-90c5-e19354f534a9", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.460841609Z", "scheduled_at": "2024-12-11T10:11:51.459093765Z", "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:11:51.459093+00	2024-12-11 10:11:51.464002+00	2024-12-11 10:11:51.483845+00	\N	2024-12-11 10:06:51.462353+00	2024-12-11 10:11:51.488783+00	5f4a7f00-f237-48f3-90c5-e19354f534a9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6ef3dd58-4742-4683-8a72-de28d2a0855e	default	5	{"job_id": "6ef3dd58-4742-4683-8a72-de28d2a0855e", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/80"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.298760920Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:06:51.311583+00	2024-12-11 10:06:51.337741+00	2024-12-11 10:06:51.466493+00	\N	2024-12-11 10:06:51.311583+00	2024-12-11 10:06:51.467606+00	6ef3dd58-4742-4683-8a72-de28d2a0855e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
44fa0c75-5d7f-4a12-940f-0eaf1a16ed53	default	5	{"job_id": "44fa0c75-5d7f-4a12-940f-0eaf1a16ed53", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.772922349Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.773114+00	2024-12-12 05:11:39.774104+00	2024-12-12 05:11:39.781246+00	\N	2024-12-12 05:11:39.773114+00	2024-12-12 05:11:39.782118+00	44fa0c75-5d7f-4a12-940f-0eaf1a16ed53	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
175a69dc-8d18-48b7-9090-89c6caacd2ce	default	5	{"job_id": "175a69dc-8d18-48b7-9090-89c6caacd2ce", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [80, {"value": "2024-12-11T10:06:51.258816000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, true], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-11T10:06:51.326107766Z", "scheduled_at": "2024-12-11T10:11:51.316779096Z", "provider_job_id": null, "exception_executions": {}}	2024-12-11 10:11:51.316778+00	2024-12-11 10:11:51.319682+00	2024-12-11 10:11:51.3427+00	\N	2024-12-11 10:06:51.326615+00	2024-12-11 10:11:51.345539+00	175a69dc-8d18-48b7-9090-89c6caacd2ce	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3d8d65b4-e5f8-4bcd-9223-fd7318646c37	default	5	{"job_id": "3d8d65b4-e5f8-4bcd-9223-fd7318646c37", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.798672588Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.798898+00	2024-12-12 05:11:39.800102+00	2024-12-12 05:11:39.808339+00	\N	2024-12-12 05:11:39.798898+00	2024-12-12 05:11:39.809236+00	3d8d65b4-e5f8-4bcd-9223-fd7318646c37	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c556477a-2565-463d-abdc-64def4036d20	default	5	{"job_id": "c556477a-2565-463d-abdc-64def4036d20", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.779682076Z", "scheduled_at": "2024-12-12T05:16:39.779520079Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.77952+00	2024-12-12 05:16:39.842459+00	2024-12-12 05:16:40.01995+00	\N	2024-12-12 05:11:39.779866+00	2024-12-12 05:16:40.084561+00	c556477a-2565-463d-abdc-64def4036d20	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
793b77cd-044a-4a13-85e0-b73ecfa9f2eb	default	5	{"job_id": "793b77cd-044a-4a13-85e0-b73ecfa9f2eb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.749243000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.760021615Z", "scheduled_at": "2024-12-12T05:16:39.759797631Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.759797+00	2024-12-12 05:16:39.819929+00	2024-12-12 05:16:40.044159+00	\N	2024-12-12 05:11:39.760197+00	2024-12-12 05:16:40.106593+00	793b77cd-044a-4a13-85e0-b73ecfa9f2eb	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
4e8f7703-8fa5-4371-9247-1b121da61313	default	5	{"job_id": "4e8f7703-8fa5-4371-9247-1b121da61313", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.806933790Z", "scheduled_at": "2024-12-12T05:16:39.806621529Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.806621+00	2024-12-12 05:16:39.938404+00	2024-12-12 05:16:40.116042+00	\N	2024-12-12 05:11:39.80712+00	2024-12-12 05:16:40.172149+00	4e8f7703-8fa5-4371-9247-1b121da61313	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
df191477-cf92-4125-a435-64e9b3f9c23e	default	5	{"job_id": "df191477-cf92-4125-a435-64e9b3f9c23e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-12-12T05:11:39.762828000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.783172780Z", "scheduled_at": "2024-12-12T05:16:39.782974935Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.782974+00	2024-12-12 05:16:39.852538+00	2024-12-12 05:16:40.128724+00	\N	2024-12-12 05:11:39.783325+00	2024-12-12 05:16:40.186955+00	df191477-cf92-4125-a435-64e9b3f9c23e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
00a6e9ed-2fa4-4a48-98de-bddb19a674aa	default	5	{"job_id": "00a6e9ed-2fa4-4a48-98de-bddb19a674aa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.830992000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.858539458Z", "scheduled_at": "2024-12-12T05:16:39.858235442Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.858235+00	2024-12-12 05:16:40.07577+00	2024-12-12 05:16:40.448684+00	\N	2024-12-12 05:11:39.858697+00	2024-12-12 05:16:40.50422+00	00a6e9ed-2fa4-4a48-98de-bddb19a674aa	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
cc5aba9b-3b27-450d-99ae-7bd06e2ad9c4	default	5	{"job_id": "cc5aba9b-3b27-450d-99ae-7bd06e2ad9c4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.816769256Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.817079+00	2024-12-12 05:11:39.818088+00	2024-12-12 05:11:39.825309+00	\N	2024-12-12 05:11:39.817079+00	2024-12-12 05:11:39.826204+00	cc5aba9b-3b27-450d-99ae-7bd06e2ad9c4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
33141995-4d04-441c-be71-9543df2f2293	default	5	{"job_id": "33141995-4d04-441c-be71-9543df2f2293", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:07.692067625Z", "scheduled_at": "2024-12-12T03:22:07.690253835Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:22:07.690253+00	2024-12-12 05:31:22.88964+00	2024-12-12 05:31:22.902654+00	\N	2024-12-12 03:17:07.693587+00	2024-12-12 05:31:22.905761+00	33141995-4d04-441c-be71-9543df2f2293	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7f4c0149-d6bf-40eb-a836-9a59f6da9f58	default	0	{"job_id": "7f4c0149-d6bf-40eb-a836-9a59f6da9f58", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:45:00.019520272Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:45:00.019807+00	2024-12-12 05:45:00.04638+00	2024-12-12 05:45:00.057286+00	\N	2024-12-12 05:45:00.019807+00	2024-12-12 05:45:00.058384+00	7f4c0149-d6bf-40eb-a836-9a59f6da9f58	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 05:45:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
5ea957c7-a2de-4ea8-a758-43f69ffec957	default	5	{"job_id": "5ea957c7-a2de-4ea8-a758-43f69ffec957", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.847268463Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.847457+00	2024-12-12 05:11:39.848552+00	2024-12-12 05:11:39.856166+00	\N	2024-12-12 05:11:39.847457+00	2024-12-12 05:11:39.857274+00	5ea957c7-a2de-4ea8-a758-43f69ffec957	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b6c54e10-04c0-4402-8e5e-5c7f8471e36a	default	0	{"job_id": "b6c54e10-04c0-4402-8e5e-5c7f8471e36a", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:45:00.006350401Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:45:00.006637+00	2024-12-12 05:45:00.026927+00	2024-12-12 05:45:00.034187+00	\N	2024-12-12 05:45:00.006637+00	2024-12-12 05:45:00.035508+00	b6c54e10-04c0-4402-8e5e-5c7f8471e36a	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 05:45:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
dd189965-029a-488d-b5b9-e91a3167716d	default	5	{"job_id": "dd189965-029a-488d-b5b9-e91a3167716d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.824040012Z", "scheduled_at": "2024-12-12T05:16:39.823878005Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.823877+00	2024-12-12 05:16:40.022901+00	2024-12-12 05:16:40.200407+00	\N	2024-12-12 05:11:39.824216+00	2024-12-12 05:16:40.261108+00	dd189965-029a-488d-b5b9-e91a3167716d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bfff0189-055d-4878-89d6-6b60be06525e	default	5	{"job_id": "bfff0189-055d-4878-89d6-6b60be06525e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.854803148Z", "scheduled_at": "2024-12-12T05:16:39.854376991Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.854377+00	2024-12-12 05:16:40.103452+00	2024-12-12 05:16:40.284485+00	\N	2024-12-12 05:11:39.854992+00	2024-12-12 05:16:40.346451+00	bfff0189-055d-4878-89d6-6b60be06525e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
15f59e44-7569-4187-9f86-7c58d7903415	default	5	{"job_id": "15f59e44-7569-4187-9f86-7c58d7903415", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-12-12T05:11:39.815975000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.827868455Z", "scheduled_at": "2024-12-12T05:16:39.827548770Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.827548+00	2024-12-12 05:16:40.045834+00	2024-12-12 05:16:40.316591+00	\N	2024-12-12 05:11:39.828028+00	2024-12-12 05:16:40.377157+00	15f59e44-7569-4187-9f86-7c58d7903415	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
59235f6f-f167-4277-8dae-dd8a4e77c0a4	default	5	{"job_id": "59235f6f-f167-4277-8dae-dd8a4e77c0a4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.873164779Z", "scheduled_at": "2024-12-12T05:16:39.872995117Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.872995+00	2024-12-12 05:16:40.145521+00	2024-12-12 05:16:40.348602+00	\N	2024-12-12 05:11:39.873349+00	2024-12-12 05:16:40.402404+00	59235f6f-f167-4277-8dae-dd8a4e77c0a4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
520ebc91-b056-470a-819c-4ce87dfada23	default	0	{"job_id": "520ebc91-b056-470a-819c-4ce87dfada23", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.015498159Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.015646+00	2024-12-12 06:00:00.04725+00	2024-12-12 06:00:00.075951+00	\N	2024-12-12 06:00:00.015646+00	2024-12-12 06:00:00.077174+00	520ebc91-b056-470a-819c-4ce87dfada23	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 06:00:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
6730de29-0179-4b3b-a245-0be4845edbce	default	5	{"job_id": "6730de29-0179-4b3b-a245-0be4845edbce", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.865752796Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.86594+00	2024-12-12 05:11:39.867027+00	2024-12-12 05:11:39.874522+00	\N	2024-12-12 05:11:39.86594+00	2024-12-12 05:11:39.875513+00	6730de29-0179-4b3b-a245-0be4845edbce	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f25ce4d2-89d0-4517-a66f-e7a4efdf53cd	default	5	{"job_id": "f25ce4d2-89d0-4517-a66f-e7a4efdf53cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.881035000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.917221844Z", "scheduled_at": "2024-12-12T05:16:39.915757440Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.915757+00	2024-12-12 05:16:40.226453+00	2024-12-12 05:16:40.569209+00	\N	2024-12-12 05:11:39.917396+00	2024-12-12 05:16:40.633901+00	f25ce4d2-89d0-4517-a66f-e7a4efdf53cd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
1e529fd6-eeb7-4c0b-8d9e-aeeea8ab5722	default	5	{"job_id": "1e529fd6-eeb7-4c0b-8d9e-aeeea8ab5722", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.921022000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.941389976Z", "scheduled_at": "2024-12-12T05:16:39.940828833Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.940829+00	2024-12-12 05:16:40.249964+00	2024-12-12 05:16:40.471224+00	\N	2024-12-12 05:11:39.941554+00	2024-12-12 05:16:40.528436+00	1e529fd6-eeb7-4c0b-8d9e-aeeea8ab5722	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e9c8c92b-3eb5-4ede-a31a-52aa64c44704	default	5	{"job_id": "e9c8c92b-3eb5-4ede-a31a-52aa64c44704", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T03:17:31.258084648Z", "scheduled_at": "2024-12-12T03:22:31.257795258Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 03:22:31.257795+00	2024-12-12 05:31:22.895037+00	2024-12-12 05:31:22.903985+00	\N	2024-12-12 03:17:31.25874+00	2024-12-12 05:31:22.905184+00	e9c8c92b-3eb5-4ede-a31a-52aa64c44704	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7131e9b5-541e-4bee-b5dc-337e6ff393dc	default	5	{"job_id": "7131e9b5-541e-4bee-b5dc-337e6ff393dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.901858364Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.902045+00	2024-12-12 05:11:39.903131+00	2024-12-12 05:11:39.913855+00	\N	2024-12-12 05:11:39.902045+00	2024-12-12 05:11:39.914806+00	7131e9b5-541e-4bee-b5dc-337e6ff393dc	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
393d774c-da05-4297-bbde-41d91624df49	default	5	{"job_id": "393d774c-da05-4297-bbde-41d91624df49", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.930460127Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.930652+00	2024-12-12 05:11:39.931952+00	2024-12-12 05:11:39.939083+00	\N	2024-12-12 05:11:39.930652+00	2024-12-12 05:11:39.93988+00	393d774c-da05-4297-bbde-41d91624df49	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0c18000f-ff98-4a0a-9269-46d3960c7717	default	5	{"job_id": "0c18000f-ff98-4a0a-9269-46d3960c7717", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.911443216Z", "scheduled_at": "2024-12-12T05:16:39.910107776Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.910107+00	2024-12-12 05:16:40.173786+00	2024-12-12 05:16:40.374753+00	\N	2024-12-12 05:11:39.911649+00	2024-12-12 05:16:40.424335+00	0c18000f-ff98-4a0a-9269-46d3960c7717	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
242cc540-cb9b-4782-8ad7-601f7164345b	default	5	{"job_id": "242cc540-cb9b-4782-8ad7-601f7164345b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-12-12T05:11:39.864781000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.877646760Z", "scheduled_at": "2024-12-12T05:16:39.876851804Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.876851+00	2024-12-12 05:16:40.152564+00	2024-12-12 05:16:40.404232+00	\N	2024-12-12 05:11:39.877819+00	2024-12-12 05:16:40.474954+00	242cc540-cb9b-4782-8ad7-601f7164345b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3f682f21-fb16-4dba-a0c3-73ed655a85ea	default	5	{"job_id": "3f682f21-fb16-4dba-a0c3-73ed655a85ea", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.937718720Z", "scheduled_at": "2024-12-12T05:16:39.937568265Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.937568+00	2024-12-12 05:16:40.238551+00	2024-12-12 05:16:40.422233+00	\N	2024-12-12 05:11:39.937905+00	2024-12-12 05:16:40.484536+00	3f682f21-fb16-4dba-a0c3-73ed655a85ea	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
edc9b1f0-d37f-4d05-8812-859c4709dbde	default	5	{"job_id": "edc9b1f0-d37f-4d05-8812-859c4709dbde", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.947018000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.958854226Z", "scheduled_at": "2024-12-12T05:16:39.958668514Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.958668+00	2024-12-12 05:16:40.286051+00	2024-12-12 05:16:40.494731+00	\N	2024-12-12 05:11:39.959025+00	2024-12-12 05:16:40.558569+00	edc9b1f0-d37f-4d05-8812-859c4709dbde	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
a00bc308-e1a5-40c3-9ed4-ad0c344b2dac	default	5	{"job_id": "a00bc308-e1a5-40c3-9ed4-ad0c344b2dac", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.947828234Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.948012+00	2024-12-12 05:11:39.949188+00	2024-12-12 05:11:39.956241+00	\N	2024-12-12 05:11:39.948012+00	2024-12-12 05:11:39.957207+00	a00bc308-e1a5-40c3-9ed4-ad0c344b2dac	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c0d16f39-7385-4be6-ae12-ba54ae4b9d4e	default	5	{"job_id": "c0d16f39-7385-4be6-ae12-ba54ae4b9d4e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.974191685Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:39.974386+00	2024-12-12 05:11:39.975506+00	2024-12-12 05:11:39.986726+00	\N	2024-12-12 05:11:39.974386+00	2024-12-12 05:11:39.987594+00	c0d16f39-7385-4be6-ae12-ba54ae4b9d4e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c347c7e8-358c-4ee8-a770-0753c1b9c4e6	default	5	{"job_id": "c347c7e8-358c-4ee8-a770-0753c1b9c4e6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.954767864Z", "scheduled_at": "2024-12-12T05:16:39.954619893Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.954619+00	2024-12-12 05:16:40.265748+00	2024-12-12 05:16:40.458756+00	\N	2024-12-12 05:11:39.95495+00	2024-12-12 05:16:40.511721+00	c347c7e8-358c-4ee8-a770-0753c1b9c4e6	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a96cae93-61ff-4162-843f-ae2ffabab199	default	5	{"job_id": "a96cae93-61ff-4162-843f-ae2ffabab199", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.983948783Z", "scheduled_at": "2024-12-12T05:16:39.983792677Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.983792+00	2024-12-12 05:16:40.29973+00	2024-12-12 05:16:40.480495+00	\N	2024-12-12 05:11:39.984275+00	2024-12-12 05:16:40.535448+00	a96cae93-61ff-4162-843f-ae2ffabab199	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
aeecb719-ec0c-4b75-9aad-f67386f7e3d3	default	5	{"job_id": "aeecb719-ec0c-4b75-9aad-f67386f7e3d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-12-12T05:11:39.961736000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:39.989339787Z", "scheduled_at": "2024-12-12T05:16:39.989152592Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:39.989152+00	2024-12-12 05:16:40.370907+00	2024-12-12 05:16:40.760601+00	\N	2024-12-12 05:11:39.989504+00	2024-12-12 05:16:40.790606+00	aeecb719-ec0c-4b75-9aad-f67386f7e3d3	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
96527050-aeec-4e61-963e-57966864cd23	default	5	{"job_id": "96527050-aeec-4e61-963e-57966864cd23", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.001720746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.001914+00	2024-12-12 05:11:40.003011+00	2024-12-12 05:11:40.009846+00	\N	2024-12-12 05:11:40.001914+00	2024-12-12 05:11:40.010729+00	96527050-aeec-4e61-963e-57966864cd23	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
aad3e900-a1a5-4583-82fb-db39dbf256e2	default	5	{"job_id": "aad3e900-a1a5-4583-82fb-db39dbf256e2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:39.993512000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.011857832Z", "scheduled_at": "2024-12-12T05:16:40.011681417Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.011681+00	2024-12-12 05:16:40.452548+00	2024-12-12 05:16:40.696376+00	\N	2024-12-12 05:11:40.012014+00	2024-12-12 05:16:40.7639+00	aad3e900-a1a5-4583-82fb-db39dbf256e2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
61d5324e-76e7-4515-ba6b-9e802b2fa1f5	default	5	{"job_id": "61d5324e-76e7-4515-ba6b-9e802b2fa1f5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:40.017469000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.029524395Z", "scheduled_at": "2024-12-12T05:16:40.029061398Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.029061+00	2024-12-12 05:16:40.524347+00	2024-12-12 05:16:40.767727+00	\N	2024-12-12 05:11:40.029692+00	2024-12-12 05:16:40.800012+00	61d5324e-76e7-4515-ba6b-9e802b2fa1f5	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e95db8c6-9131-434f-a08c-550914aa86b4	default	5	{"job_id": "e95db8c6-9131-434f-a08c-550914aa86b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.018295098Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.018486+00	2024-12-12 05:11:40.019565+00	2024-12-12 05:11:40.027271+00	\N	2024-12-12 05:11:40.018486+00	2024-12-12 05:11:40.028057+00	e95db8c6-9131-434f-a08c-550914aa86b4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7ba5b681-f1a0-48f3-b6b4-98cff8e87645	default	5	{"job_id": "7ba5b681-f1a0-48f3-b6b4-98cff8e87645", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.043608820Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.043798+00	2024-12-12 05:11:40.044916+00	2024-12-12 05:11:40.052392+00	\N	2024-12-12 05:11:40.043798+00	2024-12-12 05:11:40.053184+00	7ba5b681-f1a0-48f3-b6b4-98cff8e87645	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4358ab45-6909-4238-9c59-dfe18ec7e870	default	5	{"job_id": "4358ab45-6909-4238-9c59-dfe18ec7e870", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.008330829Z", "scheduled_at": "2024-12-12T05:16:40.008184011Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.008183+00	2024-12-12 05:16:40.381586+00	2024-12-12 05:16:40.551946+00	\N	2024-12-12 05:11:40.008511+00	2024-12-12 05:16:40.614797+00	4358ab45-6909-4238-9c59-dfe18ec7e870	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b21df8b3-b513-44a7-86ba-2e4a30b46ae4	default	5	{"job_id": "b21df8b3-b513-44a7-86ba-2e4a30b46ae4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.025671846Z", "scheduled_at": "2024-12-12T05:16:40.024773103Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.024773+00	2024-12-12 05:16:40.465623+00	2024-12-12 05:16:40.636999+00	\N	2024-12-12 05:11:40.025881+00	2024-12-12 05:16:40.695667+00	b21df8b3-b513-44a7-86ba-2e4a30b46ae4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
08b8466b-b762-408b-9cd9-f9f4946e443f	default	5	{"job_id": "08b8466b-b762-408b-9cd9-f9f4946e443f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.051037186Z", "scheduled_at": "2024-12-12T05:16:40.050639643Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.050639+00	2024-12-12 05:16:40.545933+00	2024-12-12 05:16:40.736338+00	\N	2024-12-12 05:11:40.051231+00	2024-12-12 05:16:40.779127+00	08b8466b-b762-408b-9cd9-f9f4946e443f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
257c694a-d8ee-48e7-9858-42f5623e75cf	default	5	{"job_id": "257c694a-d8ee-48e7-9858-42f5623e75cf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.096936832Z", "scheduled_at": "2024-12-12T05:16:40.096720622Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.09672+00	2024-12-12 05:16:40.673863+00	2024-12-12 05:16:40.813462+00	\N	2024-12-12 05:11:40.097126+00	2024-12-12 05:16:40.860379+00	257c694a-d8ee-48e7-9858-42f5623e75cf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
35fb11af-0abf-46dc-9d9b-675475e9eb2d	default	5	{"job_id": "35fb11af-0abf-46dc-9d9b-675475e9eb2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.062363846Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.062554+00	2024-12-12 05:11:40.06366+00	2024-12-12 05:11:40.072695+00	\N	2024-12-12 05:11:40.062554+00	2024-12-12 05:11:40.073565+00	35fb11af-0abf-46dc-9d9b-675475e9eb2d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ae186a59-e036-4725-a410-814c10cd3d4f	default	5	{"job_id": "ae186a59-e036-4725-a410-814c10cd3d4f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.088345182Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.088539+00	2024-12-12 05:11:40.089663+00	2024-12-12 05:11:40.098503+00	\N	2024-12-12 05:11:40.088539+00	2024-12-12 05:11:40.099426+00	ae186a59-e036-4725-a410-814c10cd3d4f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
20cc6fde-9c69-4d36-a610-7b865c471cd4	default	5	{"job_id": "20cc6fde-9c69-4d36-a610-7b865c471cd4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.070538364Z", "scheduled_at": "2024-12-12T05:16:40.070395253Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.070395+00	2024-12-12 05:16:40.603676+00	2024-12-12 05:16:40.779402+00	\N	2024-12-12 05:11:40.070724+00	2024-12-12 05:16:40.814582+00	20cc6fde-9c69-4d36-a610-7b865c471cd4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e819fd7e-9bc7-4daa-9ab5-9ad15ea38394	default	5	{"job_id": "e819fd7e-9bc7-4daa-9ab5-9ad15ea38394", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-12-12T05:11:40.079898000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.100553755Z", "scheduled_at": "2024-12-12T05:16:40.100381138Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.100381+00	2024-12-12 05:16:40.686119+00	2024-12-12 05:16:40.850512+00	\N	2024-12-12 05:11:40.100707+00	2024-12-12 05:16:40.905465+00	e819fd7e-9bc7-4daa-9ab5-9ad15ea38394	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
bc159cc0-cca4-4838-af39-27e4278d60b8	default	5	{"job_id": "bc159cc0-cca4-4838-af39-27e4278d60b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-12-12T05:11:40.032201000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.054285660Z", "scheduled_at": "2024-12-12T05:16:40.054114075Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.054114+00	2024-12-12 05:16:40.579959+00	2024-12-12 05:16:40.925712+00	\N	2024-12-12 05:11:40.05444+00	2024-12-12 05:16:40.954597+00	bc159cc0-cca4-4838-af39-27e4278d60b8	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
674b786d-6173-4e70-bca6-6f99864f481d	default	5	{"job_id": "674b786d-6173-4e70-bca6-6f99864f481d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-12-12T05:11:40.060131000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.075164820Z", "scheduled_at": "2024-12-12T05:16:40.074910949Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.07491+00	2024-12-12 05:16:40.657332+00	2024-12-12 05:16:40.937172+00	\N	2024-12-12 05:11:40.075327+00	2024-12-12 05:16:40.961645+00	674b786d-6173-4e70-bca6-6f99864f481d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
79cf40ab-f98b-4ce5-b0fa-40c6c5fd2c0d	default	5	{"job_id": "79cf40ab-f98b-4ce5-b0fa-40c6c5fd2c0d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-12-12T05:11:40.105614000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.116751774Z", "scheduled_at": "2024-12-12T05:16:40.116582984Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.116582+00	2024-12-12 05:16:40.712818+00	2024-12-12 05:16:40.960188+00	\N	2024-12-12 05:11:40.116916+00	2024-12-12 05:16:40.983898+00	79cf40ab-f98b-4ce5-b0fa-40c6c5fd2c0d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
5c6eec33-856c-4826-b7dc-ab2d63bee43a	default	5	{"job_id": "5c6eec33-856c-4826-b7dc-ab2d63bee43a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.106409550Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.106599+00	2024-12-12 05:11:40.107666+00	2024-12-12 05:11:40.114918+00	\N	2024-12-12 05:11:40.106599+00	2024-12-12 05:11:40.115678+00	5c6eec33-856c-4826-b7dc-ab2d63bee43a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6015f296-da11-4c99-acd7-cd2c78d41267	default	5	{"job_id": "6015f296-da11-4c99-acd7-cd2c78d41267", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.128613880Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.128815+00	2024-12-12 05:11:40.129963+00	2024-12-12 05:11:40.137049+00	\N	2024-12-12 05:11:40.128815+00	2024-12-12 05:11:40.13782+00	6015f296-da11-4c99-acd7-cd2c78d41267	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7dd09a0e-eaec-4c9c-b3c1-66c4a4206e70	default	5	{"job_id": "7dd09a0e-eaec-4c9c-b3c1-66c4a4206e70", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.113606926Z", "scheduled_at": "2024-12-12T05:16:40.113466320Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.113466+00	2024-12-12 05:16:40.700472+00	2024-12-12 05:16:40.837285+00	\N	2024-12-12 05:11:40.11379+00	2024-12-12 05:16:40.878564+00	7dd09a0e-eaec-4c9c-b3c1-66c4a4206e70	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2c957247-54e2-4c5d-a451-d44c35b5219f	default	5	{"job_id": "2c957247-54e2-4c5d-a451-d44c35b5219f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.135718481Z", "scheduled_at": "2024-12-12T05:16:40.135577334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.135577+00	2024-12-12 05:16:40.738722+00	2024-12-12 05:16:40.859253+00	\N	2024-12-12 05:11:40.1359+00	2024-12-12 05:16:40.916579+00	2c957247-54e2-4c5d-a451-d44c35b5219f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
75f87ccf-7881-4848-b7b0-f0427a8a2ed4	default	5	{"job_id": "75f87ccf-7881-4848-b7b0-f0427a8a2ed4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-12-12T05:11:40.120523000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.138894007Z", "scheduled_at": "2024-12-12T05:16:40.138726089Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.138726+00	2024-12-12 05:16:40.748565+00	2024-12-12 05:16:40.903254+00	\N	2024-12-12 05:11:40.139047+00	2024-12-12 05:16:40.948315+00	75f87ccf-7881-4848-b7b0-f0427a8a2ed4	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
fe958cbf-402c-4530-8d06-148763ab5a77	default	5	{"job_id": "fe958cbf-402c-4530-8d06-148763ab5a77", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.157438644Z", "scheduled_at": "2024-12-12T05:16:40.157297557Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.157297+00	2024-12-12 05:16:40.784303+00	2024-12-12 05:16:40.931884+00	\N	2024-12-12 05:11:40.157627+00	2024-12-12 05:16:40.957487+00	fe958cbf-402c-4530-8d06-148763ab5a77	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
37f3cc91-19c7-4454-b81c-d0adbb71db4d	default	5	{"job_id": "37f3cc91-19c7-4454-b81c-d0adbb71db4d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.150616679Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.15081+00	2024-12-12 05:11:40.151896+00	2024-12-12 05:11:40.158746+00	\N	2024-12-12 05:11:40.15081+00	2024-12-12 05:11:40.159639+00	37f3cc91-19c7-4454-b81c-d0adbb71db4d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e371569c-fa5c-489f-8763-713b7dd8ba0f	default	5	{"job_id": "e371569c-fa5c-489f-8763-713b7dd8ba0f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.175106450Z", "scheduled_at": "2024-12-12T05:16:40.174967106Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.174967+00	2024-12-12 05:16:40.840626+00	2024-12-12 05:16:40.965765+00	\N	2024-12-12 05:11:40.175287+00	2024-12-12 05:16:40.988042+00	e371569c-fa5c-489f-8763-713b7dd8ba0f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e37bf894-5245-44d1-9ec1-0ee590d75bdc	default	5	{"job_id": "e37bf894-5245-44d1-9ec1-0ee590d75bdc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.184770000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.213626654Z", "scheduled_at": "2024-12-12T05:16:40.213097321Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.213097+00	2024-12-12 05:16:40.936184+00	2024-12-12 05:16:41.031746+00	\N	2024-12-12 05:11:40.213791+00	2024-12-12 05:16:41.070909+00	e37bf894-5245-44d1-9ec1-0ee590d75bdc	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
9e4eaea0-af8d-42f4-a1aa-6e7e4e709f98	default	5	{"job_id": "9e4eaea0-af8d-42f4-a1aa-6e7e4e709f98", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.168387400Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.168574+00	2024-12-12 05:11:40.169695+00	2024-12-12 05:11:40.176545+00	\N	2024-12-12 05:11:40.168574+00	2024-12-12 05:11:40.177441+00	9e4eaea0-af8d-42f4-a1aa-6e7e4e709f98	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
424099b7-1539-4aa6-9296-d285a0030f6e	default	0	{"job_id": "424099b7-1539-4aa6-9296-d285a0030f6e", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.022068026Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.022367+00	2024-12-12 06:00:00.05935+00	2024-12-12 06:00:00.080198+00	\N	2024-12-12 06:00:00.022367+00	2024-12-12 06:00:00.081803+00	424099b7-1539-4aa6-9296-d285a0030f6e	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 06:00:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
123e0b96-93d7-47c9-a304-9ea76e92c3f2	default	5	{"job_id": "123e0b96-93d7-47c9-a304-9ea76e92c3f2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.196870266Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.197558+00	2024-12-12 05:11:40.198969+00	2024-12-12 05:11:40.207479+00	\N	2024-12-12 05:11:40.197558+00	2024-12-12 05:11:40.208291+00	123e0b96-93d7-47c9-a304-9ea76e92c3f2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d6247004-8fde-4364-a96f-64391b6fd3ee	default	5	{"job_id": "d6247004-8fde-4364-a96f-64391b6fd3ee", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.142513000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.161382286Z", "scheduled_at": "2024-12-12T05:16:40.161205942Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.161206+00	2024-12-12 05:16:40.795273+00	2024-12-12 05:16:40.951423+00	\N	2024-12-12 05:11:40.161541+00	2024-12-12 05:16:40.970311+00	d6247004-8fde-4364-a96f-64391b6fd3ee	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
55dcd337-c41d-4a0d-831f-023ce4d14120	default	5	{"job_id": "55dcd337-c41d-4a0d-831f-023ce4d14120", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.205905435Z", "scheduled_at": "2024-12-12T05:16:40.205772433Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.205772+00	2024-12-12 05:16:40.92302+00	2024-12-12 05:16:40.995861+00	\N	2024-12-12 05:11:40.206088+00	2024-12-12 05:16:41.013531+00	55dcd337-c41d-4a0d-831f-023ce4d14120	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d9f7c587-66ff-4a72-8590-3bc09fac255b	default	5	{"job_id": "d9f7c587-66ff-4a72-8590-3bc09fac255b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-12-12T05:11:40.167304000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.179530232Z", "scheduled_at": "2024-12-12T05:16:40.178735105Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.178735+00	2024-12-12 05:16:40.898549+00	2024-12-12 05:16:41.000198+00	\N	2024-12-12 05:11:40.179706+00	2024-12-12 05:16:41.020322+00	d9f7c587-66ff-4a72-8590-3bc09fac255b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e6df5b6d-40ca-4f46-870b-a366e1f01af1	default	5	{"job_id": "e6df5b6d-40ca-4f46-870b-a366e1f01af1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.217201000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.236660596Z", "scheduled_at": "2024-12-12T05:16:40.236501194Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.236501+00	2024-12-12 05:16:40.955223+00	2024-12-12 05:16:41.045603+00	\N	2024-12-12 05:11:40.236822+00	2024-12-12 05:16:41.08549+00	e6df5b6d-40ca-4f46-870b-a366e1f01af1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
96878028-c7b0-482f-afad-3b97c9cb331e	default	0	{"job_id": "96878028-c7b0-482f-afad-3b97c9cb331e", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:00:00.003733193Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:00:00.004193+00	2024-12-12 06:00:00.036569+00	2024-12-12 06:00:00.04486+00	\N	2024-12-12 06:00:00.004193+00	2024-12-12 06:00:00.048473+00	96878028-c7b0-482f-afad-3b97c9cb331e	\N	LdapGroups::SynchronizationJob	\N	2024-12-12 06:00:00+00	\N	\N	t	1	LdapGroups::SynchronizationJob	\N	\N
c45588ee-fce5-4456-8d93-6f9e2a37913a	default	5	{"job_id": "c45588ee-fce5-4456-8d93-6f9e2a37913a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.226176342Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.226368+00	2024-12-12 05:11:40.227783+00	2024-12-12 05:11:40.234819+00	\N	2024-12-12 05:11:40.226368+00	2024-12-12 05:11:40.235603+00	c45588ee-fce5-4456-8d93-6f9e2a37913a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e76529c9-672f-47da-8750-6996270eafff	default	5	{"job_id": "e76529c9-672f-47da-8750-6996270eafff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.243473746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.243665+00	2024-12-12 05:11:40.244757+00	2024-12-12 05:11:40.251466+00	\N	2024-12-12 05:11:40.243665+00	2024-12-12 05:11:40.252226+00	e76529c9-672f-47da-8750-6996270eafff	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d396fc89-4071-4576-b3c9-bbc36dde223a	default	5	{"job_id": "d396fc89-4071-4576-b3c9-bbc36dde223a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.233499166Z", "scheduled_at": "2024-12-12T05:16:40.233364912Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.233365+00	2024-12-12 05:16:40.948755+00	2024-12-12 05:16:41.00715+00	\N	2024-12-12 05:11:40.233684+00	2024-12-12 05:16:41.029047+00	d396fc89-4071-4576-b3c9-bbc36dde223a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
27b342bf-8fab-460a-b942-bcfe58a3da85	default	5	{"job_id": "27b342bf-8fab-460a-b942-bcfe58a3da85", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.250189210Z", "scheduled_at": "2024-12-12T05:16:40.250054334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.250054+00	2024-12-12 05:16:40.972018+00	2024-12-12 05:16:41.036083+00	\N	2024-12-12 05:11:40.250367+00	2024-12-12 05:16:41.076658+00	27b342bf-8fab-460a-b942-bcfe58a3da85	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
be30b1cf-957f-4e26-9c4e-adc44ffaff8a	default	5	{"job_id": "be30b1cf-957f-4e26-9c4e-adc44ffaff8a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.242629000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.253282641Z", "scheduled_at": "2024-12-12T05:16:40.253125303Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.253125+00	2024-12-12 05:16:40.98599+00	2024-12-12 05:16:41.080945+00	\N	2024-12-12 05:11:40.253441+00	2024-12-12 05:16:41.110696+00	be30b1cf-957f-4e26-9c4e-adc44ffaff8a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
21f600c6-e401-4d8b-adb3-f30f233ed491	default	5	{"job_id": "21f600c6-e401-4d8b-adb3-f30f233ed491", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.268084376Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.268271+00	2024-12-12 05:11:40.269372+00	2024-12-12 05:11:40.276174+00	\N	2024-12-12 05:11:40.268271+00	2024-12-12 05:11:40.277185+00	21f600c6-e401-4d8b-adb3-f30f233ed491	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
fc5bebdc-ea55-4cd6-ba14-44a518634c41	default	5	{"job_id": "fc5bebdc-ea55-4cd6-ba14-44a518634c41", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-12-12T05:11:40.256049000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.278274413Z", "scheduled_at": "2024-12-12T05:16:40.278117365Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.278117+00	2024-12-12 05:16:40.99783+00	2024-12-12 05:16:41.189552+00	\N	2024-12-12 05:11:40.278425+00	2024-12-12 05:16:41.225314+00	fc5bebdc-ea55-4cd6-ba14-44a518634c41	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2781ac8b-d2d5-4616-a18b-51ea828cff67	default	7	{"job_id": "2781ac8b-d2d5-4616-a18b-51ea828cff67", "locale": "en", "priority": 7, "timezone": "UTC", "arguments": [], "job_class": "Storages::ManageStorageIntegrationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:01:00.010693028Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:01:00.01203+00	2024-12-12 06:01:00.023181+00	2024-12-12 06:01:00.056778+00	\N	2024-12-12 06:01:00.01203+00	2024-12-12 06:01:00.058739+00	2781ac8b-d2d5-4616-a18b-51ea828cff67	Storages::ManageStorageIntegrationsJob	Storages::ManageStorageIntegrationsJob	\N	2024-12-12 06:01:00+00	\N	\N	t	1	Storages::ManageStorageIntegrationsJob	\N	\N
65d8c496-1e4d-4303-87d5-3310e4a806c2	default	5	{"job_id": "65d8c496-1e4d-4303-87d5-3310e4a806c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.284520226Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.284703+00	2024-12-12 05:11:40.285783+00	2024-12-12 05:11:40.292271+00	\N	2024-12-12 05:11:40.284703+00	2024-12-12 05:11:40.293196+00	65d8c496-1e4d-4303-87d5-3310e4a806c2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
50fa8501-919c-4f33-a88a-d90736206e1d	default	0	{"job_id": "50fa8501-919c-4f33-a88a-d90736206e1d", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:15:00.007742278Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:15:00.007964+00	2024-12-12 06:15:00.030301+00	2024-12-12 06:15:00.042707+00	\N	2024-12-12 06:15:00.007964+00	2024-12-12 06:15:00.044303+00	50fa8501-919c-4f33-a88a-d90736206e1d	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 06:15:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
41a380d4-975a-4d39-81fa-44af42f88916	default	0	{"job_id": "41a380d4-975a-4d39-81fa-44af42f88916", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:15:00.021437499Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:15:00.021737+00	2024-12-12 06:15:00.055203+00	2024-12-12 06:15:00.083678+00	\N	2024-12-12 06:15:00.021737+00	2024-12-12 06:15:00.085357+00	41a380d4-975a-4d39-81fa-44af42f88916	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 06:15:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
3a8fb5e2-228e-4fb6-be8c-b92960486d28	default	5	{"job_id": "3a8fb5e2-228e-4fb6-be8c-b92960486d28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.306851898Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.307043+00	2024-12-12 05:11:40.308124+00	2024-12-12 05:11:40.315076+00	\N	2024-12-12 05:11:40.307043+00	2024-12-12 05:11:40.315841+00	3a8fb5e2-228e-4fb6-be8c-b92960486d28	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f3aecf6f-cbe3-4236-a5e0-ff97f96ee360	default	5	{"job_id": "f3aecf6f-cbe3-4236-a5e0-ff97f96ee360", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.274731149Z", "scheduled_at": "2024-12-12T05:16:40.274600302Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.2746+00	2024-12-12 05:16:40.993798+00	2024-12-12 05:16:41.077636+00	\N	2024-12-12 05:11:40.274912+00	2024-12-12 05:16:41.104506+00	f3aecf6f-cbe3-4236-a5e0-ff97f96ee360	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2b507715-486d-4705-98b4-ff49eabb79e3	default	5	{"job_id": "2b507715-486d-4705-98b4-ff49eabb79e3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.290996087Z", "scheduled_at": "2024-12-12T05:16:40.290863867Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.290863+00	2024-12-12 05:16:41.008628+00	2024-12-12 05:16:41.095954+00	\N	2024-12-12 05:11:40.291175+00	2024-12-12 05:16:41.136924+00	2b507715-486d-4705-98b4-ff49eabb79e3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
98ae185a-3805-4bd6-b2d4-8c21653da9a5	default	5	{"job_id": "98ae185a-3805-4bd6-b2d4-8c21653da9a5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.313793742Z", "scheduled_at": "2024-12-12T05:16:40.313662153Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.313662+00	2024-12-12 05:16:41.022904+00	2024-12-12 05:16:41.114428+00	\N	2024-12-12 05:11:40.313973+00	2024-12-12 05:16:41.170448+00	98ae185a-3805-4bd6-b2d4-8c21653da9a5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
fa628f48-18d3-4915-abe5-d3dd3caa5ae2	default	5	{"job_id": "fa628f48-18d3-4915-abe5-d3dd3caa5ae2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-12-12T05:11:40.283728000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.294376191Z", "scheduled_at": "2024-12-12T05:16:40.294222731Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.294222+00	2024-12-12 05:16:41.019048+00	2024-12-12 05:16:41.182367+00	\N	2024-12-12 05:11:40.294525+00	2024-12-12 05:16:41.215769+00	fa628f48-18d3-4915-abe5-d3dd3caa5ae2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
9f6435b0-2f97-4648-b4cf-aefa521aaecf	default	5	{"job_id": "9f6435b0-2f97-4648-b4cf-aefa521aaecf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.323108470Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.32329+00	2024-12-12 05:11:40.324343+00	2024-12-12 05:11:40.331384+00	\N	2024-12-12 05:11:40.32329+00	2024-12-12 05:11:40.332137+00	9f6435b0-2f97-4648-b4cf-aefa521aaecf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
96d619ba-0553-45d4-99ae-4b45e4ae50c2	default	5	{"job_id": "96d619ba-0553-45d4-99ae-4b45e4ae50c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/17"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.762100310Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.762328+00	2024-12-12 05:11:40.763519+00	2024-12-12 05:11:40.775164+00	\N	2024-12-12 05:11:40.762328+00	2024-12-12 05:11:40.775974+00	96d619ba-0553-45d4-99ae-4b45e4ae50c2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c4ea7dd5-b37d-49ff-bd75-e11647a974b9	default	5	{"job_id": "c4ea7dd5-b37d-49ff-bd75-e11647a974b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.330115786Z", "scheduled_at": "2024-12-12T05:16:40.329981512Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.329981+00	2024-12-12 05:16:41.034946+00	2024-12-12 05:16:41.142527+00	\N	2024-12-12 05:11:40.330292+00	2024-12-12 05:16:41.188897+00	c4ea7dd5-b37d-49ff-bd75-e11647a974b9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5e5383bb-3980-486d-aa97-7541bec5a410	default	5	{"job_id": "5e5383bb-3980-486d-aa97-7541bec5a410", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-12-12T05:11:40.298688000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.316909656Z", "scheduled_at": "2024-12-12T05:16:40.316741187Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.316741+00	2024-12-12 05:16:41.02568+00	2024-12-12 05:16:41.16257+00	\N	2024-12-12 05:11:40.317063+00	2024-12-12 05:16:41.201132+00	5e5383bb-3980-486d-aa97-7541bec5a410	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
7c9c5059-6301-4a02-a84d-505bf8d9d7a3	default	5	{"job_id": "7c9c5059-6301-4a02-a84d-505bf8d9d7a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.773757618Z", "scheduled_at": "2024-12-12T05:16:40.773628964Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.773628+00	2024-12-12 05:16:41.060798+00	2024-12-12 05:16:41.174902+00	\N	2024-12-12 05:11:40.773936+00	2024-12-12 05:16:41.210188+00	7c9c5059-6301-4a02-a84d-505bf8d9d7a3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
da7794f8-6f33-45a4-83dc-265b4b265fc9	default	5	{"job_id": "da7794f8-6f33-45a4-83dc-265b4b265fc9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-12-12T05:11:40.322317000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.333203877Z", "scheduled_at": "2024-12-12T05:16:40.333044966Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.333045+00	2024-12-12 05:16:41.052478+00	2024-12-12 05:16:41.228513+00	\N	2024-12-12 05:11:40.333363+00	2024-12-12 05:16:41.260194+00	da7794f8-6f33-45a4-83dc-265b4b265fc9	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
9b64196f-d115-4989-a0ec-93726de05e41	default	5	{"job_id": "9b64196f-d115-4989-a0ec-93726de05e41", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/18"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.969106006Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.96931+00	2024-12-12 05:11:40.970468+00	2024-12-12 05:11:40.979612+00	\N	2024-12-12 05:11:40.96931+00	2024-12-12 05:11:40.980536+00	9b64196f-d115-4989-a0ec-93726de05e41	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f09ab1d8-6ae2-4999-bd9e-8ff4f3dbb4af	default	5	{"job_id": "f09ab1d8-6ae2-4999-bd9e-8ff4f3dbb4af", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.105115973Z", "scheduled_at": "2024-12-12T05:16:41.104973954Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.104974+00	2024-12-12 05:16:41.190572+00	2024-12-12 05:16:41.286157+00	\N	2024-12-12 05:11:41.105303+00	2024-12-12 05:16:41.321655+00	f09ab1d8-6ae2-4999-bd9e-8ff4f3dbb4af	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6544e3d1-b597-4212-a7de-9794b2582da7	default	5	{"job_id": "6544e3d1-b597-4212-a7de-9794b2582da7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [20, {"value": "2024-12-12T05:11:41.088301000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.110874965Z", "scheduled_at": "2024-12-12T05:16:41.108671720Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.108671+00	2024-12-12 05:16:41.19928+00	2024-12-12 05:16:41.337017+00	\N	2024-12-12 05:11:41.111443+00	2024-12-12 05:16:41.360239+00	6544e3d1-b597-4212-a7de-9794b2582da7	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2d0500d6-a7ee-4cba-823b-b554ed15e4a2	default	5	{"job_id": "2d0500d6-a7ee-4cba-823b-b554ed15e4a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/19"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.998031300Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:40.998221+00	2024-12-12 05:11:40.999308+00	2024-12-12 05:11:41.007123+00	\N	2024-12-12 05:11:40.998221+00	2024-12-12 05:11:41.007897+00	2d0500d6-a7ee-4cba-823b-b554ed15e4a2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d3d2fb23-fba7-4ba6-882b-0d3648e848a8	default	5	{"job_id": "d3d2fb23-fba7-4ba6-882b-0d3648e848a8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/20"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.094451729Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.094646+00	2024-12-12 05:11:41.095829+00	2024-12-12 05:11:41.10646+00	\N	2024-12-12 05:11:41.094646+00	2024-12-12 05:11:41.107229+00	d3d2fb23-fba7-4ba6-882b-0d3648e848a8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e9797f50-702a-4ad2-a30f-4028350deb5a	default	5	{"job_id": "e9797f50-702a-4ad2-a30f-4028350deb5a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.005787616Z", "scheduled_at": "2024-12-12T05:16:41.005648171Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.005648+00	2024-12-12 05:16:41.108623+00	2024-12-12 05:16:41.233514+00	\N	2024-12-12 05:11:41.00598+00	2024-12-12 05:16:41.26856+00	e9797f50-702a-4ad2-a30f-4028350deb5a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6d608530-f489-479e-8cb0-9e22044e4cc9	default	5	{"job_id": "6d608530-f489-479e-8cb0-9e22044e4cc9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:40.978116788Z", "scheduled_at": "2024-12-12T05:16:40.977884097Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:40.977884+00	2024-12-12 05:16:41.101392+00	2024-12-12 05:16:41.238218+00	\N	2024-12-12 05:11:40.978307+00	2024-12-12 05:16:41.274666+00	6d608530-f489-479e-8cb0-9e22044e4cc9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
16764864-5540-4153-93cf-c23937f417dd	default	5	{"job_id": "16764864-5540-4153-93cf-c23937f417dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [19, {"value": "2024-12-12T05:11:40.988961000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.010007280Z", "scheduled_at": "2024-12-12T05:16:41.009731287Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.009731+00	2024-12-12 05:16:41.138444+00	2024-12-12 05:16:41.266279+00	\N	2024-12-12 05:11:41.01021+00	2024-12-12 05:16:41.296394+00	16764864-5540-4153-93cf-c23937f417dd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f004feca-eee6-489f-a668-6e44e66c9f9a	default	5	{"job_id": "f004feca-eee6-489f-a668-6e44e66c9f9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.317883414Z", "scheduled_at": "2024-12-12T05:16:41.317759038Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.317759+00	2024-12-12 05:16:41.366311+00	2024-12-12 05:16:41.411995+00	\N	2024-12-12 05:11:41.318067+00	2024-12-12 05:16:41.433429+00	f004feca-eee6-489f-a668-6e44e66c9f9a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a29e16ba-85fd-4029-ab08-21ead8ccfe48	default	5	{"job_id": "a29e16ba-85fd-4029-ab08-21ead8ccfe48", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-12-12T05:11:41.289724000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.321232421Z", "scheduled_at": "2024-12-12T05:16:41.321096032Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.321095+00	2024-12-12 05:16:41.368203+00	2024-12-12 05:16:41.42102+00	\N	2024-12-12 05:11:41.321383+00	2024-12-12 05:16:41.442071+00	a29e16ba-85fd-4029-ab08-21ead8ccfe48	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
94a8ef01-20fa-420f-87fc-cd6874ea317a	default	5	{"job_id": "94a8ef01-20fa-420f-87fc-cd6874ea317a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/21"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.262336339Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.262523+00	2024-12-12 05:11:41.264329+00	2024-12-12 05:11:41.274092+00	\N	2024-12-12 05:11:41.262523+00	2024-12-12 05:11:41.274921+00	94a8ef01-20fa-420f-87fc-cd6874ea317a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
03caeeec-83ef-4654-a827-70753effb389	default	5	{"job_id": "03caeeec-83ef-4654-a827-70753effb389", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.309377899Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.309574+00	2024-12-12 05:11:41.311688+00	2024-12-12 05:11:41.319276+00	\N	2024-12-12 05:11:41.309574+00	2024-12-12 05:11:41.320096+00	03caeeec-83ef-4654-a827-70753effb389	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
853b12bb-d074-4d74-97af-fbd679ebf8ef	default	5	{"job_id": "853b12bb-d074-4d74-97af-fbd679ebf8ef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.272075823Z", "scheduled_at": "2024-12-12T05:16:41.271756358Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.271756+00	2024-12-12 05:16:41.319586+00	2024-12-12 05:16:41.38744+00	\N	2024-12-12 05:11:41.272262+00	2024-12-12 05:16:41.405526+00	853b12bb-d074-4d74-97af-fbd679ebf8ef	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d8d33613-ccbc-41ad-a676-a760913af035	default	5	{"job_id": "d8d33613-ccbc-41ad-a676-a760913af035", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [21, {"value": "2024-12-12T05:11:41.254043000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.277438313Z", "scheduled_at": "2024-12-12T05:16:41.277153764Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.277153+00	2024-12-12 05:16:41.328661+00	2024-12-12 05:16:41.396501+00	\N	2024-12-12 05:11:41.277627+00	2024-12-12 05:16:41.412936+00	d8d33613-ccbc-41ad-a676-a760913af035	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
46002419-9b91-468c-a788-64a68603067e	default	5	{"job_id": "46002419-9b91-468c-a788-64a68603067e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.330304879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.330493+00	2024-12-12 05:11:41.331707+00	2024-12-12 05:11:41.339125+00	\N	2024-12-12 05:11:41.330493+00	2024-12-12 05:11:41.33994+00	46002419-9b91-468c-a788-64a68603067e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a4f4e6c0-4436-4238-ac5d-55e5773883fa	default	5	{"job_id": "a4f4e6c0-4436-4238-ac5d-55e5773883fa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-12-12T05:11:41.329266000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.341081397Z", "scheduled_at": "2024-12-12T05:16:41.340937975Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.340938+00	2024-12-12 05:16:41.375285+00	2024-12-12 05:16:41.480168+00	\N	2024-12-12 05:11:41.341237+00	2024-12-12 05:16:41.495749+00	a4f4e6c0-4436-4238-ac5d-55e5773883fa	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0a4a5441-3a13-4fcd-b4ba-8865dd12ab73	default	5	{"job_id": "0a4a5441-3a13-4fcd-b4ba-8865dd12ab73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.368175272Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.368365+00	2024-12-12 05:11:41.369868+00	2024-12-12 05:11:41.377693+00	\N	2024-12-12 05:11:41.368365+00	2024-12-12 05:11:41.378514+00	0a4a5441-3a13-4fcd-b4ba-8865dd12ab73	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
19ba3f49-8ae5-49c1-b95e-7a7a3438b084	default	5	{"job_id": "19ba3f49-8ae5-49c1-b95e-7a7a3438b084", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.396608015Z", "scheduled_at": "2024-12-12T05:16:41.396487186Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.396487+00	2024-12-12 05:16:41.422055+00	2024-12-12 05:16:41.489213+00	\N	2024-12-12 05:11:41.396798+00	2024-12-12 05:16:41.503985+00	19ba3f49-8ae5-49c1-b95e-7a7a3438b084	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c300834c-5e27-47b9-94c0-8a8d10715146	default	5	{"job_id": "c300834c-5e27-47b9-94c0-8a8d10715146", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.388535799Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.388725+00	2024-12-12 05:11:41.38998+00	2024-12-12 05:11:41.398039+00	\N	2024-12-12 05:11:41.388725+00	2024-12-12 05:11:41.398855+00	c300834c-5e27-47b9-94c0-8a8d10715146	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
75395ba8-39a7-438d-a328-1b8e1acb7a8e	default	5	{"job_id": "75395ba8-39a7-438d-a328-1b8e1acb7a8e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.337627663Z", "scheduled_at": "2024-12-12T05:16:41.337508047Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.337508+00	2024-12-12 05:16:41.372762+00	2024-12-12 05:16:41.417718+00	\N	2024-12-12 05:11:41.337809+00	2024-12-12 05:16:41.43965+00	75395ba8-39a7-438d-a328-1b8e1acb7a8e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a6518bdf-c4f1-4324-8431-bec00dd73b7e	default	5	{"job_id": "a6518bdf-c4f1-4324-8431-bec00dd73b7e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.376054752Z", "scheduled_at": "2024-12-12T05:16:41.375923053Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.375922+00	2024-12-12 05:16:41.397532+00	2024-12-12 05:16:41.450045+00	\N	2024-12-12 05:11:41.376249+00	2024-12-12 05:16:41.477809+00	a6518bdf-c4f1-4324-8431-bec00dd73b7e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4c04150f-db07-46b0-a2a7-4bd79c6e608c	default	5	{"job_id": "4c04150f-db07-46b0-a2a7-4bd79c6e608c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-12-12T05:11:41.348647000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.379866424Z", "scheduled_at": "2024-12-12T05:16:41.379725036Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.379724+00	2024-12-12 05:16:41.403073+00	2024-12-12 05:16:41.472477+00	\N	2024-12-12 05:11:41.380022+00	2024-12-12 05:16:41.486283+00	4c04150f-db07-46b0-a2a7-4bd79c6e608c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
02dc4eca-cf10-4afd-a675-dae20eb493a7	default	5	{"job_id": "02dc4eca-cf10-4afd-a675-dae20eb493a7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.465637334Z", "scheduled_at": "2024-12-12T05:16:41.465519170Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.465519+00	2024-12-12 05:16:41.49441+00	2024-12-12 05:16:41.53751+00	\N	2024-12-12 05:11:41.465821+00	2024-12-12 05:16:41.552746+00	02dc4eca-cf10-4afd-a675-dae20eb493a7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
217c112e-1839-42c6-83c0-6d9f361e842c	default	5	{"job_id": "217c112e-1839-42c6-83c0-6d9f361e842c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.420803697Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.421007+00	2024-12-12 05:11:41.422501+00	2024-12-12 05:11:41.430243+00	\N	2024-12-12 05:11:41.421007+00	2024-12-12 05:11:41.431056+00	217c112e-1839-42c6-83c0-6d9f361e842c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a01eb811-44b6-44ef-98d4-b1bd744d311b	default	5	{"job_id": "a01eb811-44b6-44ef-98d4-b1bd744d311b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.457710415Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.457898+00	2024-12-12 05:11:41.4596+00	2024-12-12 05:11:41.467003+00	\N	2024-12-12 05:11:41.457898+00	2024-12-12 05:11:41.467776+00	a01eb811-44b6-44ef-98d4-b1bd744d311b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9b3ca3bc-1797-408a-9cb3-baa6ac115575	default	5	{"job_id": "9b3ca3bc-1797-408a-9cb3-baa6ac115575", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-12-12T05:11:41.387566000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.399987919Z", "scheduled_at": "2024-12-12T05:16:41.399850488Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.39985+00	2024-12-12 05:16:41.42317+00	2024-12-12 05:16:41.507058+00	\N	2024-12-12 05:11:41.400142+00	2024-12-12 05:16:41.524693+00	9b3ca3bc-1797-408a-9cb3-baa6ac115575	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
1a202862-0d6f-46e5-91e3-a0358b1df2ec	default	5	{"job_id": "1a202862-0d6f-46e5-91e3-a0358b1df2ec", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.428713354Z", "scheduled_at": "2024-12-12T05:16:41.428596403Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.428596+00	2024-12-12 05:16:41.463757+00	2024-12-12 05:16:41.515894+00	\N	2024-12-12 05:11:41.428917+00	2024-12-12 05:16:41.53016+00	1a202862-0d6f-46e5-91e3-a0358b1df2ec	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
652ccdbf-dbd7-4225-a663-1d169bef8446	default	5	{"job_id": "652ccdbf-dbd7-4225-a663-1d169bef8446", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-12-12T05:11:41.407032000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.432185934Z", "scheduled_at": "2024-12-12T05:16:41.432047031Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.432047+00	2024-12-12 05:16:41.454693+00	2024-12-12 05:16:41.522914+00	\N	2024-12-12 05:11:41.432339+00	2024-12-12 05:16:41.534617+00	652ccdbf-dbd7-4225-a663-1d169bef8446	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
65b98263-e360-40d0-9edc-1f55dd3bb2b7	default	5	{"job_id": "65b98263-e360-40d0-9edc-1f55dd3bb2b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.436597000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.468853086Z", "scheduled_at": "2024-12-12T05:16:41.468716798Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.468716+00	2024-12-12 05:16:41.496389+00	2024-12-12 05:16:41.547196+00	\N	2024-12-12 05:11:41.46902+00	2024-12-12 05:16:41.561777+00	65b98263-e360-40d0-9edc-1f55dd3bb2b7	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2b218527-ba61-4a67-a6c4-72712a594b1b	default	5	{"job_id": "2b218527-ba61-4a67-a6c4-72712a594b1b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.476151000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.488227706Z", "scheduled_at": "2024-12-12T05:16:41.488089384Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.488089+00	2024-12-12 05:16:41.514546+00	2024-12-12 05:16:41.563925+00	\N	2024-12-12 05:11:41.488375+00	2024-12-12 05:16:41.579135+00	2b218527-ba61-4a67-a6c4-72712a594b1b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
ac55ea5a-aea9-4491-b112-0e7b3d4a15dc	default	5	{"job_id": "ac55ea5a-aea9-4491-b112-0e7b3d4a15dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.477346750Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.477535+00	2024-12-12 05:11:41.478952+00	2024-12-12 05:11:41.486121+00	\N	2024-12-12 05:11:41.477535+00	2024-12-12 05:11:41.486957+00	ac55ea5a-aea9-4491-b112-0e7b3d4a15dc	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a4185266-fb2e-483c-ae3a-2e686da65a28	default	5	{"job_id": "a4185266-fb2e-483c-ae3a-2e686da65a28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.547485803Z", "scheduled_at": "2024-12-12T05:16:41.547365334Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.547365+00	2024-12-12 05:16:41.568568+00	2024-12-12 05:16:41.618168+00	\N	2024-12-12 05:11:41.547669+00	2024-12-12 05:16:41.631186+00	a4185266-fb2e-483c-ae3a-2e686da65a28	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
387f9cac-a42f-48d5-a602-b8bc42b59f88	default	5	{"job_id": "387f9cac-a42f-48d5-a602-b8bc42b59f88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.506856943Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.50705+00	2024-12-12 05:11:41.508384+00	2024-12-12 05:11:41.51614+00	\N	2024-12-12 05:11:41.50705+00	2024-12-12 05:11:41.516966+00	387f9cac-a42f-48d5-a602-b8bc42b59f88	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
38020831-55b0-493c-851a-b904b33ffc58	default	5	{"job_id": "38020831-55b0-493c-851a-b904b33ffc58", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.484712015Z", "scheduled_at": "2024-12-12T05:16:41.484597338Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.484597+00	2024-12-12 05:16:41.50937+00	2024-12-12 05:16:41.554403+00	\N	2024-12-12 05:11:41.484894+00	2024-12-12 05:16:41.566767+00	38020831-55b0-493c-851a-b904b33ffc58	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f2480275-23d5-40d4-a2a0-94cd8ebbedb3	default	5	{"job_id": "f2480275-23d5-40d4-a2a0-94cd8ebbedb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.514617056Z", "scheduled_at": "2024-12-12T05:16:41.514495596Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.514495+00	2024-12-12 05:16:41.538276+00	2024-12-12 05:16:41.582874+00	\N	2024-12-12 05:11:41.514801+00	2024-12-12 05:16:41.606958+00	f2480275-23d5-40d4-a2a0-94cd8ebbedb3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
788d48ec-8182-4ade-81a7-83cf90a257dd	default	5	{"job_id": "788d48ec-8182-4ade-81a7-83cf90a257dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-12-12T05:11:41.493085000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.518109172Z", "scheduled_at": "2024-12-12T05:16:41.517973104Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.517972+00	2024-12-12 05:16:41.540594+00	2024-12-12 05:16:41.613449+00	\N	2024-12-12 05:11:41.518259+00	2024-12-12 05:16:41.625693+00	788d48ec-8182-4ade-81a7-83cf90a257dd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d4d49186-49e2-45db-a5e1-61e4b26b7891	default	5	{"job_id": "d4d49186-49e2-45db-a5e1-61e4b26b7891", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.539321113Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.539518+00	2024-12-12 05:11:41.541017+00	2024-12-12 05:11:41.548864+00	\N	2024-12-12 05:11:41.539518+00	2024-12-12 05:11:41.549735+00	d4d49186-49e2-45db-a5e1-61e4b26b7891	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ad868684-e514-4328-aa54-278df3e3c199	default	5	{"job_id": "ad868684-e514-4328-aa54-278df3e3c199", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.566526038Z", "scheduled_at": "2024-12-12T05:16:41.566409567Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.566409+00	2024-12-12 05:16:41.600249+00	2024-12-12 05:16:41.638076+00	\N	2024-12-12 05:11:41.566704+00	2024-12-12 05:16:41.659282+00	ad868684-e514-4328-aa54-278df3e3c199	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8ffa6d8e-1cc3-460f-9a81-c30c0d001cc1	default	5	{"job_id": "8ffa6d8e-1cc3-460f-9a81-c30c0d001cc1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.572765000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.595701436Z", "scheduled_at": "2024-12-12T05:16:41.595546072Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.595546+00	2024-12-12 05:16:41.620521+00	2024-12-12 05:16:41.696049+00	\N	2024-12-12 05:11:41.595869+00	2024-12-12 05:16:41.725288+00	8ffa6d8e-1cc3-460f-9a81-c30c0d001cc1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
730e909f-fcab-4a58-b52b-cd94c91870b9	default	5	{"job_id": "730e909f-fcab-4a58-b52b-cd94c91870b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.559207361Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.559401+00	2024-12-12 05:11:41.560842+00	2024-12-12 05:11:41.567862+00	\N	2024-12-12 05:11:41.559401+00	2024-12-12 05:11:41.568636+00	730e909f-fcab-4a58-b52b-cd94c91870b9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3712c2cb-20b8-4891-b17c-29d07c3619d9	default	5	{"job_id": "3712c2cb-20b8-4891-b17c-29d07c3619d9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.584994290Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.585186+00	2024-12-12 05:11:41.586358+00	2024-12-12 05:11:41.593618+00	\N	2024-12-12 05:11:41.585186+00	2024-12-12 05:11:41.59453+00	3712c2cb-20b8-4891-b17c-29d07c3619d9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c1d1e538-51a5-4d8a-af4e-692b39db8fdd	default	5	{"job_id": "c1d1e538-51a5-4d8a-af4e-692b39db8fdd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.522121000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.551091304Z", "scheduled_at": "2024-12-12T05:16:41.550951169Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.550951+00	2024-12-12 05:16:41.575103+00	2024-12-12 05:16:41.632725+00	\N	2024-12-12 05:11:41.551248+00	2024-12-12 05:16:41.644021+00	c1d1e538-51a5-4d8a-af4e-692b39db8fdd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
eef22eec-13db-4f3f-802c-a4470a9c8848	default	5	{"job_id": "eef22eec-13db-4f3f-802c-a4470a9c8848", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-12-12T05:11:41.557949000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.569765225Z", "scheduled_at": "2024-12-12T05:16:41.569629658Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.569629+00	2024-12-12 05:16:41.603349+00	2024-12-12 05:16:41.646021+00	\N	2024-12-12 05:11:41.569915+00	2024-12-12 05:16:41.666497+00	eef22eec-13db-4f3f-802c-a4470a9c8848	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
21e8d1dd-82e5-49f4-a3e9-561bebafb0ec	default	5	{"job_id": "21e8d1dd-82e5-49f4-a3e9-561bebafb0ec", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.591759968Z", "scheduled_at": "2024-12-12T05:16:41.591643848Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.591643+00	2024-12-12 05:16:41.619132+00	2024-12-12 05:16:41.667907+00	\N	2024-12-12 05:11:41.591937+00	2024-12-12 05:16:41.692066+00	21e8d1dd-82e5-49f4-a3e9-561bebafb0ec	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5190745c-c619-440d-bc91-26315ad352c7	default	5	{"job_id": "5190745c-c619-440d-bc91-26315ad352c7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.653310129Z", "scheduled_at": "2024-12-12T05:16:41.653190712Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.65319+00	2024-12-12 05:16:41.685997+00	2024-12-12 05:16:41.756187+00	\N	2024-12-12 05:11:41.653493+00	2024-12-12 05:16:41.794511+00	5190745c-c619-440d-bc91-26315ad352c7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
fe8dff05-5a69-49da-9b7d-4adb591f1dbf	default	5	{"job_id": "fe8dff05-5a69-49da-9b7d-4adb591f1dbf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.633679000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.656622054Z", "scheduled_at": "2024-12-12T05:16:41.656483160Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.656483+00	2024-12-12 05:16:41.688974+00	2024-12-12 05:16:41.787691+00	\N	2024-12-12 05:11:41.65677+00	2024-12-12 05:16:41.807242+00	fe8dff05-5a69-49da-9b7d-4adb591f1dbf	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2daea336-81d8-447c-9ab2-d0692a0678e8	default	5	{"job_id": "2daea336-81d8-447c-9ab2-d0692a0678e8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.617768256Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.617961+00	2024-12-12 05:11:41.619538+00	2024-12-12 05:11:41.626782+00	\N	2024-12-12 05:11:41.617961+00	2024-12-12 05:11:41.627729+00	2daea336-81d8-447c-9ab2-d0692a0678e8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6f92d2ff-6f67-4629-b894-fc5c7f8efcff	default	5	{"job_id": "6f92d2ff-6f67-4629-b894-fc5c7f8efcff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.645791271Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.645984+00	2024-12-12 05:11:41.647521+00	2024-12-12 05:11:41.654693+00	\N	2024-12-12 05:11:41.645984+00	2024-12-12 05:11:41.655498+00	6f92d2ff-6f67-4629-b894-fc5c7f8efcff	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
42c2061e-6662-48e9-8877-337f66b41b33	default	5	{"job_id": "42c2061e-6662-48e9-8877-337f66b41b33", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.625103426Z", "scheduled_at": "2024-12-12T05:16:41.624985532Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.624985+00	2024-12-12 05:16:41.648853+00	2024-12-12 05:16:41.721439+00	\N	2024-12-12 05:11:41.625287+00	2024-12-12 05:16:41.740681+00	42c2061e-6662-48e9-8877-337f66b41b33	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
30c4a113-23df-407f-b140-adca54cf3012	default	5	{"job_id": "30c4a113-23df-407f-b140-adca54cf3012", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.600012000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.629019385Z", "scheduled_at": "2024-12-12T05:16:41.628729666Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.628729+00	2024-12-12 05:16:41.653358+00	2024-12-12 05:16:41.731193+00	\N	2024-12-12 05:11:41.629207+00	2024-12-12 05:16:41.752426+00	30c4a113-23df-407f-b140-adca54cf3012	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
90ea7e1d-00ff-4cbf-9995-5cf816867318	default	0	{"job_id": "90ea7e1d-00ff-4cbf-9995-5cf816867318", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.099955531Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.102608+00	2024-12-12 06:30:00.248198+00	2024-12-12 06:30:00.457427+00	\N	2024-12-12 06:30:00.102608+00	2024-12-12 06:30:00.46098+00	90ea7e1d-00ff-4cbf-9995-5cf816867318	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-12-12 06:30:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
8bef7c8b-e509-436b-b010-670b4caaab53	default	5	{"job_id": "8bef7c8b-e509-436b-b010-670b4caaab53", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.665666489Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.665852+00	2024-12-12 05:11:41.667083+00	2024-12-12 05:11:41.674105+00	\N	2024-12-12 05:11:41.665852+00	2024-12-12 05:11:41.674906+00	8bef7c8b-e509-436b-b010-670b4caaab53	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8cf66b9e-1fbc-4616-a23a-3f800db9ccba	default	5	{"job_id": "8cf66b9e-1fbc-4616-a23a-3f800db9ccba", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.724521522Z", "scheduled_at": "2024-12-12T05:16:41.724355617Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.724355+00	2024-12-12 05:16:41.760994+00	2024-12-12 05:16:41.885363+00	\N	2024-12-12 05:11:41.724777+00	2024-12-12 05:16:41.93376+00	8cf66b9e-1fbc-4616-a23a-3f800db9ccba	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f88c715d-87b1-4e5a-b5fa-4484afda6c25	default	5	{"job_id": "f88c715d-87b1-4e5a-b5fa-4484afda6c25", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.679831000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.706174050Z", "scheduled_at": "2024-12-12T05:16:41.706009418Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.706009+00	2024-12-12 05:16:41.744205+00	2024-12-12 05:16:41.909993+00	\N	2024-12-12 05:11:41.70636+00	2024-12-12 05:16:41.98433+00	f88c715d-87b1-4e5a-b5fa-4484afda6c25	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3cbaeb98-cf10-4f75-a056-97a9d5653b5c	default	0	{"job_id": "3cbaeb98-cf10-4f75-a056-97a9d5653b5c", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.037395333Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.07085+00	2024-12-12 06:30:00.127695+00	2024-12-12 06:30:00.229629+00	\N	2024-12-12 06:30:00.07085+00	2024-12-12 06:30:00.28106+00	3cbaeb98-cf10-4f75-a056-97a9d5653b5c	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-12-12 06:30:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
711574e4-53cf-443a-99a2-075bc1615a8b	default	5	{"job_id": "711574e4-53cf-443a-99a2-075bc1615a8b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.694495071Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.694691+00	2024-12-12 05:11:41.696204+00	2024-12-12 05:11:41.703746+00	\N	2024-12-12 05:11:41.694691+00	2024-12-12 05:11:41.7048+00	711574e4-53cf-443a-99a2-075bc1615a8b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
480bc58c-caa6-4c4b-8956-10227afb1b42	default	0	{"job_id": "480bc58c-caa6-4c4b-8956-10227afb1b42", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "LdapGroups::SynchronizationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T06:30:00.113889910Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 06:30:00.114564+00	2024-12-12 06:30:00.306144+00	2024-12-12 06:30:00.385486+00	\N	2024-12-12 06:30:00.114564+00	2024-12-12 06:30:00.451202+00	480bc58c-caa6-4c4b-8956-10227afb1b42	\N	LdapGroups::SynchronizationJob	\N	2024-12-12 06:30:00+00	\N	\N	t	1	LdapGroups::SynchronizationJob	\N	\N
e2aa8d90-3427-4e55-a4c5-69d62261e16b	default	5	{"job_id": "e2aa8d90-3427-4e55-a4c5-69d62261e16b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.715419507Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.715619+00	2024-12-12 05:11:41.717007+00	2024-12-12 05:11:41.726776+00	\N	2024-12-12 05:11:41.715619+00	2024-12-12 05:11:41.727894+00	e2aa8d90-3427-4e55-a4c5-69d62261e16b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a7aeba4a-8dcb-4af4-85ff-7993bb6d1c12	default	5	{"job_id": "a7aeba4a-8dcb-4af4-85ff-7993bb6d1c12", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.672608181Z", "scheduled_at": "2024-12-12T05:16:41.672488475Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.672488+00	2024-12-12 05:16:41.714204+00	2024-12-12 05:16:41.794862+00	\N	2024-12-12 05:11:41.672789+00	2024-12-12 05:16:41.837132+00	a7aeba4a-8dcb-4af4-85ff-7993bb6d1c12	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2ee50b3e-7ad5-452e-aec9-57385cd3ddb3	default	5	{"job_id": "2ee50b3e-7ad5-452e-aec9-57385cd3ddb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-12-12T05:11:41.664189000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.676221869Z", "scheduled_at": "2024-12-12T05:16:41.675990802Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.67599+00	2024-12-12 05:16:41.716221+00	2024-12-12 05:16:41.811826+00	\N	2024-12-12 05:11:41.676394+00	2024-12-12 05:16:41.859401+00	2ee50b3e-7ad5-452e-aec9-57385cd3ddb3	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b1199811-8054-47f8-ac11-efa3cc59c4c5	default	5	{"job_id": "b1199811-8054-47f8-ac11-efa3cc59c4c5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.702170485Z", "scheduled_at": "2024-12-12T05:16:41.702052992Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.702052+00	2024-12-12 05:16:41.74152+00	2024-12-12 05:16:41.843001+00	\N	2024-12-12 05:11:41.702351+00	2024-12-12 05:16:41.886334+00	b1199811-8054-47f8-ac11-efa3cc59c4c5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cf3d8952-4e06-41e0-a70e-2f4a70402e31	default	5	{"job_id": "cf3d8952-4e06-41e0-a70e-2f4a70402e31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.732652000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.758298360Z", "scheduled_at": "2024-12-12T05:16:41.758161561Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.758161+00	2024-12-12 05:16:41.813934+00	2024-12-12 05:16:42.053726+00	\N	2024-12-12 05:11:41.758451+00	2024-12-12 05:16:42.083041+00	cf3d8952-4e06-41e0-a70e-2f4a70402e31	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
cf0b2824-8864-436c-ad31-fb03cb660db3	default	5	{"job_id": "cf0b2824-8864-436c-ad31-fb03cb660db3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.744346164Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.744538+00	2024-12-12 05:11:41.745644+00	2024-12-12 05:11:41.75659+00	\N	2024-12-12 05:11:41.744538+00	2024-12-12 05:11:41.757344+00	cf0b2824-8864-436c-ad31-fb03cb660db3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
99d5ba99-9195-4c6f-85d3-fe357e25e186	default	5	{"job_id": "99d5ba99-9195-4c6f-85d3-fe357e25e186", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.764761455Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.764974+00	2024-12-12 05:11:41.766065+00	2024-12-12 05:11:41.776037+00	\N	2024-12-12 05:11:41.764974+00	2024-12-12 05:11:41.777294+00	99d5ba99-9195-4c6f-85d3-fe357e25e186	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
863c4065-c7bb-4943-9eed-6e89435c28a1	default	5	{"job_id": "863c4065-c7bb-4943-9eed-6e89435c28a1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-12-12T05:11:41.714337000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.729704954Z", "scheduled_at": "2024-12-12T05:16:41.729541254Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.729541+00	2024-12-12 05:16:41.76518+00	2024-12-12 05:16:41.930819+00	\N	2024-12-12 05:11:41.729877+00	2024-12-12 05:16:41.991105+00	863c4065-c7bb-4943-9eed-6e89435c28a1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d9c3a443-a665-436e-9f19-1da2c9135721	default	5	{"job_id": "d9c3a443-a665-436e-9f19-1da2c9135721", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.755089711Z", "scheduled_at": "2024-12-12T05:16:41.754969433Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.754969+00	2024-12-12 05:16:41.807998+00	2024-12-12 05:16:41.966534+00	\N	2024-12-12 05:11:41.755275+00	2024-12-12 05:16:42.007943+00	d9c3a443-a665-436e-9f19-1da2c9135721	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
219beae2-7ac4-4489-b242-d84f6b118aaf	default	5	{"job_id": "219beae2-7ac4-4489-b242-d84f6b118aaf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.773675935Z", "scheduled_at": "2024-12-12T05:16:41.773555507Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.773555+00	2024-12-12 05:16:41.832669+00	2024-12-12 05:16:41.996289+00	\N	2024-12-12 05:11:41.773861+00	2024-12-12 05:16:42.027382+00	219beae2-7ac4-4489-b242-d84f6b118aaf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6cd7e33f-982c-4efe-a1b8-9397071f6da4	default	5	{"job_id": "6cd7e33f-982c-4efe-a1b8-9397071f6da4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-12-12T05:11:41.763922000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.778869116Z", "scheduled_at": "2024-12-12T05:16:41.778703382Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.778703+00	2024-12-12 05:16:41.82016+00	2024-12-12 05:16:42.039087+00	\N	2024-12-12 05:11:41.779057+00	2024-12-12 05:16:42.066092+00	6cd7e33f-982c-4efe-a1b8-9397071f6da4	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0bd7b9db-b80a-47be-bc23-52450342420a	default	5	{"job_id": "0bd7b9db-b80a-47be-bc23-52450342420a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.799756189Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.799967+00	2024-12-12 05:11:41.801519+00	2024-12-12 05:11:41.808877+00	\N	2024-12-12 05:11:41.799967+00	2024-12-12 05:11:41.810119+00	0bd7b9db-b80a-47be-bc23-52450342420a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d852cb95-5643-4e5e-b60d-281c83c8985e	default	5	{"job_id": "d852cb95-5643-4e5e-b60d-281c83c8985e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.819419185Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.819602+00	2024-12-12 05:11:41.820918+00	2024-12-12 05:11:41.829778+00	\N	2024-12-12 05:11:41.819602+00	2024-12-12 05:11:41.830738+00	d852cb95-5643-4e5e-b60d-281c83c8985e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3e1b6fc2-ea6a-4aca-9ae5-9a3701f3fe66	default	5	{"job_id": "3e1b6fc2-ea6a-4aca-9ae5-9a3701f3fe66", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.807427004Z", "scheduled_at": "2024-12-12T05:16:41.807183312Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.807183+00	2024-12-12 05:16:41.889024+00	2024-12-12 05:16:42.03033+00	\N	2024-12-12 05:11:41.807614+00	2024-12-12 05:16:42.05723+00	3e1b6fc2-ea6a-4aca-9ae5-9a3701f3fe66	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
62e70fee-4ea9-4956-8aa1-510269b1646f	default	5	{"job_id": "62e70fee-4ea9-4956-8aa1-510269b1646f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.827507741Z", "scheduled_at": "2024-12-12T05:16:41.827350994Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.827351+00	2024-12-12 05:16:41.896771+00	2024-12-12 05:16:42.043466+00	\N	2024-12-12 05:11:41.827717+00	2024-12-12 05:16:42.070986+00	62e70fee-4ea9-4956-8aa1-510269b1646f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9830447d-5ca4-492e-99dd-83eea1ae1d38	default	5	{"job_id": "9830447d-5ca4-492e-99dd-83eea1ae1d38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-12-12T05:11:41.782618000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.811296866Z", "scheduled_at": "2024-12-12T05:16:41.811164525Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.811164+00	2024-12-12 05:16:41.891403+00	2024-12-12 05:16:42.04704+00	\N	2024-12-12 05:11:41.811446+00	2024-12-12 05:16:42.074677+00	9830447d-5ca4-492e-99dd-83eea1ae1d38	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
796e6e5b-395b-4b9a-8e1d-d1c8f4cdce2e	default	5	{"job_id": "796e6e5b-395b-4b9a-8e1d-d1c8f4cdce2e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.861272465Z", "scheduled_at": "2024-12-12T05:16:41.861151185Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.861151+00	2024-12-12 05:16:41.969364+00	2024-12-12 05:16:42.080544+00	\N	2024-12-12 05:11:41.861453+00	2024-12-12 05:16:42.106971+00	796e6e5b-395b-4b9a-8e1d-d1c8f4cdce2e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
30f7f5c5-75a9-49e0-9715-efa158f32f61	default	5	{"job_id": "30f7f5c5-75a9-49e0-9715-efa158f32f61", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-12-12T05:11:41.818173000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.831994242Z", "scheduled_at": "2024-12-12T05:16:41.831725322Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.831725+00	2024-12-12 05:16:41.931719+00	2024-12-12 05:16:42.098373+00	\N	2024-12-12 05:11:41.83215+00	2024-12-12 05:16:42.123693+00	30f7f5c5-75a9-49e0-9715-efa158f32f61	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
03b23537-164b-42b0-8724-cfa9e985192c	default	5	{"job_id": "03b23537-164b-42b0-8724-cfa9e985192c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.853464772Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.853658+00	2024-12-12 05:11:41.855196+00	2024-12-12 05:11:41.86282+00	\N	2024-12-12 05:11:41.853658+00	2024-12-12 05:11:41.863641+00	03b23537-164b-42b0-8724-cfa9e985192c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f7f9e998-bf58-4159-bf3d-2fc80ceed3c6	default	5	{"job_id": "f7f9e998-bf58-4159-bf3d-2fc80ceed3c6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.868153000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.890514079Z", "scheduled_at": "2024-12-12T05:16:41.890377871Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.890377+00	2024-12-12 05:16:42.015997+00	2024-12-12 05:16:42.119614+00	\N	2024-12-12 05:11:41.890666+00	2024-12-12 05:16:42.138959+00	f7f9e998-bf58-4159-bf3d-2fc80ceed3c6	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c15da142-4fb3-4772-ac89-d443e9d09af2	default	5	{"job_id": "c15da142-4fb3-4772-ac89-d443e9d09af2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.897905000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.909398139Z", "scheduled_at": "2024-12-12T05:16:41.909211155Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.909211+00	2024-12-12 05:16:42.059099+00	2024-12-12 05:16:42.145103+00	\N	2024-12-12 05:11:41.909595+00	2024-12-12 05:16:42.168416+00	c15da142-4fb3-4772-ac89-d443e9d09af2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
57b33fc8-e3e6-4492-9630-50797996d91c	default	5	{"job_id": "57b33fc8-e3e6-4492-9630-50797996d91c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.879798967Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.879986+00	2024-12-12 05:11:41.881566+00	2024-12-12 05:11:41.888497+00	\N	2024-12-12 05:11:41.879986+00	2024-12-12 05:11:41.889344+00	57b33fc8-e3e6-4492-9630-50797996d91c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d56e8ef2-c400-4907-8ef3-000aeb001443	default	5	{"job_id": "d56e8ef2-c400-4907-8ef3-000aeb001443", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.898899887Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.899088+00	2024-12-12 05:11:41.900336+00	2024-12-12 05:11:41.907161+00	\N	2024-12-12 05:11:41.899088+00	2024-12-12 05:11:41.908069+00	d56e8ef2-c400-4907-8ef3-000aeb001443	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
fcf405a3-3a21-415a-b89f-b81d1b5296d1	default	5	{"job_id": "fcf405a3-3a21-415a-b89f-b81d1b5296d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.887139215Z", "scheduled_at": "2024-12-12T05:16:41.887022624Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.887022+00	2024-12-12 05:16:42.001437+00	2024-12-12 05:16:42.090515+00	\N	2024-12-12 05:11:41.887317+00	2024-12-12 05:16:42.116233+00	fcf405a3-3a21-415a-b89f-b81d1b5296d1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e504b9e1-fa04-4033-a5df-ff769990603f	default	5	{"job_id": "e504b9e1-fa04-4033-a5df-ff769990603f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-12-12T05:11:41.835833000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.864844763Z", "scheduled_at": "2024-12-12T05:16:41.864712082Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.864712+00	2024-12-12 05:16:41.999434+00	2024-12-12 05:16:42.104263+00	\N	2024-12-12 05:11:41.865008+00	2024-12-12 05:16:42.127081+00	e504b9e1-fa04-4033-a5df-ff769990603f	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
1e417181-2382-4579-90b8-723820c3d8d1	default	5	{"job_id": "1e417181-2382-4579-90b8-723820c3d8d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.905812155Z", "scheduled_at": "2024-12-12T05:16:41.905692298Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.905692+00	2024-12-12 05:16:42.032472+00	2024-12-12 05:16:42.112789+00	\N	2024-12-12 05:11:41.905994+00	2024-12-12 05:16:42.133624+00	1e417181-2382-4579-90b8-723820c3d8d1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3f75ad1f-98f4-4501-b37b-e940ff0c1a90	default	5	{"job_id": "3f75ad1f-98f4-4501-b37b-e940ff0c1a90", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-12-12T05:11:41.912893000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.936093949Z", "scheduled_at": "2024-12-12T05:16:41.935954866Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.935955+00	2024-12-12 05:16:42.08451+00	2024-12-12 05:16:42.234417+00	\N	2024-12-12 05:11:41.936246+00	2024-12-12 05:16:42.259957+00	3f75ad1f-98f4-4501-b37b-e940ff0c1a90	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
8a851b62-3f3b-432f-983d-e8683734433a	default	5	{"job_id": "8a851b62-3f3b-432f-983d-e8683734433a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.924812844Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.925017+00	2024-12-12 05:11:41.926605+00	2024-12-12 05:11:41.933903+00	\N	2024-12-12 05:11:41.925017+00	2024-12-12 05:11:41.934739+00	8a851b62-3f3b-432f-983d-e8683734433a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
91e2003b-4778-4191-ae43-8ebb3bd40b97	default	5	{"job_id": "91e2003b-4778-4191-ae43-8ebb3bd40b97", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-12-12T05:11:41.942761000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.954350990Z", "scheduled_at": "2024-12-12T05:16:41.954106187Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.954106+00	2024-12-12 05:16:42.11165+00	2024-12-12 05:16:42.258048+00	\N	2024-12-12 05:11:41.954507+00	2024-12-12 05:16:42.28689+00	91e2003b-4778-4191-ae43-8ebb3bd40b97	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
4ff24af5-bdf8-494e-8c46-946311ccca63	default	5	{"job_id": "4ff24af5-bdf8-494e-8c46-946311ccca63", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.943817292Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.944002+00	2024-12-12 05:11:41.945246+00	2024-12-12 05:11:41.952312+00	\N	2024-12-12 05:11:41.944002+00	2024-12-12 05:11:41.953111+00	4ff24af5-bdf8-494e-8c46-946311ccca63	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f4b8350e-3fc9-4231-9ec7-b9c392f3767b	default	5	{"job_id": "f4b8350e-3fc9-4231-9ec7-b9c392f3767b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.932484321Z", "scheduled_at": "2024-12-12T05:16:41.932364544Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.932364+00	2024-12-12 05:16:42.077369+00	2024-12-12 05:16:42.150875+00	\N	2024-12-12 05:11:41.932666+00	2024-12-12 05:16:42.175857+00	f4b8350e-3fc9-4231-9ec7-b9c392f3767b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
84660288-f772-4716-bc09-0b20822b1e38	default	5	{"job_id": "84660288-f772-4716-bc09-0b20822b1e38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.950958011Z", "scheduled_at": "2024-12-12T05:16:41.950841250Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.950841+00	2024-12-12 05:16:42.096848+00	2024-12-12 05:16:42.174065+00	\N	2024-12-12 05:11:41.95114+00	2024-12-12 05:16:42.200224+00	84660288-f772-4716-bc09-0b20822b1e38	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
10f7b38c-4229-48d8-a022-5ceaa0429aca	default	5	{"job_id": "10f7b38c-4229-48d8-a022-5ceaa0429aca", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.976588624Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.976784+00	2024-12-12 05:11:41.978336+00	2024-12-12 05:11:41.985644+00	\N	2024-12-12 05:11:41.976784+00	2024-12-12 05:11:41.986471+00	10f7b38c-4229-48d8-a022-5ceaa0429aca	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4ffefb53-cbfc-486a-996c-69ac895f6451	default	5	{"job_id": "4ffefb53-cbfc-486a-996c-69ac895f6451", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.002997841Z", "scheduled_at": "2024-12-12T05:16:42.002879036Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.002878+00	2024-12-12 05:16:42.14779+00	2024-12-12 05:16:42.229329+00	\N	2024-12-12 05:11:42.00318+00	2024-12-12 05:16:42.253712+00	4ffefb53-cbfc-486a-996c-69ac895f6451	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0ae37e36-1b13-4cc5-b8b9-594330a9af20	default	5	{"job_id": "0ae37e36-1b13-4cc5-b8b9-594330a9af20", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-12-12T05:11:41.994991000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.006347729Z", "scheduled_at": "2024-12-12T05:16:42.006212422Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.006212+00	2024-12-12 05:16:42.152128+00	2024-12-12 05:16:42.311652+00	\N	2024-12-12 05:11:42.006499+00	2024-12-12 05:16:42.335149+00	0ae37e36-1b13-4cc5-b8b9-594330a9af20	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2c34cd19-5232-4991-84a3-94c1cb1b4fb1	default	5	{"job_id": "2c34cd19-5232-4991-84a3-94c1cb1b4fb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.996058143Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:41.996247+00	2024-12-12 05:11:41.997502+00	2024-12-12 05:11:42.004373+00	\N	2024-12-12 05:11:41.996247+00	2024-12-12 05:11:42.005198+00	2c34cd19-5232-4991-84a3-94c1cb1b4fb1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3e7596fa-a3a7-4b2b-b7ea-1863aa705eb1	default	5	{"job_id": "3e7596fa-a3a7-4b2b-b7ea-1863aa705eb1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.027797529Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.027986+00	2024-12-12 05:11:42.029655+00	2024-12-12 05:11:42.036611+00	\N	2024-12-12 05:11:42.027986+00	2024-12-12 05:11:42.037449+00	3e7596fa-a3a7-4b2b-b7ea-1863aa705eb1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7e10fce1-46de-49f5-ad14-df36b16bab09	default	5	{"job_id": "7e10fce1-46de-49f5-ad14-df36b16bab09", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.984147647Z", "scheduled_at": "2024-12-12T05:16:41.984027600Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.984027+00	2024-12-12 05:16:42.134703+00	2024-12-12 05:16:42.209215+00	\N	2024-12-12 05:11:41.984329+00	2024-12-12 05:16:42.241165+00	7e10fce1-46de-49f5-ad14-df36b16bab09	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
67ddc475-bd3c-4c18-bf17-37318c717768	default	5	{"job_id": "67ddc475-bd3c-4c18-bf17-37318c717768", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-12-12T05:11:41.958908000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:41.987777615Z", "scheduled_at": "2024-12-12T05:16:41.987636868Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:41.987637+00	2024-12-12 05:16:42.14204+00	2024-12-12 05:16:42.238743+00	\N	2024-12-12 05:11:41.987935+00	2024-12-12 05:16:42.264939+00	67ddc475-bd3c-4c18-bf17-37318c717768	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b1d7dd42-cbf4-46d4-9b5c-6cb5bc2f4adf	default	5	{"job_id": "b1d7dd42-cbf4-46d4-9b5c-6cb5bc2f4adf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.035242727Z", "scheduled_at": "2024-12-12T05:16:42.035124253Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.035124+00	2024-12-12 05:16:42.155361+00	2024-12-12 05:16:42.246607+00	\N	2024-12-12 05:11:42.03543+00	2024-12-12 05:16:42.271725+00	b1d7dd42-cbf4-46d4-9b5c-6cb5bc2f4adf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7823103e-c249-4054-be64-e53035da898a	default	5	{"job_id": "7823103e-c249-4054-be64-e53035da898a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-12-12T05:11:42.045751000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.057024596Z", "scheduled_at": "2024-12-12T05:16:42.056877838Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.056877+00	2024-12-12 05:16:42.197201+00	2024-12-12 05:16:42.320483+00	\N	2024-12-12 05:11:42.057177+00	2024-12-12 05:16:42.350337+00	7823103e-c249-4054-be64-e53035da898a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
239747a1-0641-4d11-b448-acbbd04d8412	default	5	{"job_id": "239747a1-0641-4d11-b448-acbbd04d8412", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.046755540Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.04694+00	2024-12-12 05:11:42.04828+00	2024-12-12 05:11:42.055101+00	\N	2024-12-12 05:11:42.04694+00	2024-12-12 05:11:42.055896+00	239747a1-0641-4d11-b448-acbbd04d8412	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9bb48d66-689b-45f5-a49f-3b47ac1e17e0	default	5	{"job_id": "9bb48d66-689b-45f5-a49f-3b47ac1e17e0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.077732271Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.077922+00	2024-12-12 05:11:42.079573+00	2024-12-12 05:11:42.086582+00	\N	2024-12-12 05:11:42.077922+00	2024-12-12 05:11:42.087374+00	9bb48d66-689b-45f5-a49f-3b47ac1e17e0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
318e57f1-25f7-4ebb-9f3d-d024d7155527	default	5	{"job_id": "318e57f1-25f7-4ebb-9f3d-d024d7155527", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.053762776Z", "scheduled_at": "2024-12-12T05:16:42.053646065Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.053646+00	2024-12-12 05:16:42.1881+00	2024-12-12 05:16:42.268981+00	\N	2024-12-12 05:11:42.053943+00	2024-12-12 05:16:42.295802+00	318e57f1-25f7-4ebb-9f3d-d024d7155527	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
66101ee3-aa29-4601-859e-744f1c9a75a3	default	5	{"job_id": "66101ee3-aa29-4601-859e-744f1c9a75a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-12-12T05:11:42.010370000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.038593035Z", "scheduled_at": "2024-12-12T05:16:42.038461986Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.038461+00	2024-12-12 05:16:42.181665+00	2024-12-12 05:16:42.276452+00	\N	2024-12-12 05:11:42.038742+00	2024-12-12 05:16:42.303261+00	66101ee3-aa29-4601-859e-744f1c9a75a3	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
77890532-7b6f-41a0-991a-74aa3c7f7435	default	5	{"job_id": "77890532-7b6f-41a0-991a-74aa3c7f7435", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.085032724Z", "scheduled_at": "2024-12-12T05:16:42.084915412Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.084915+00	2024-12-12 05:16:42.201948+00	2024-12-12 05:16:42.284452+00	\N	2024-12-12 05:11:42.085212+00	2024-12-12 05:16:42.309572+00	77890532-7b6f-41a0-991a-74aa3c7f7435	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
86046dbe-9816-4ea3-a533-00c784fb7bf9	default	5	{"job_id": "86046dbe-9816-4ea3-a533-00c784fb7bf9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-12-12T05:11:42.060742000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.088504833Z", "scheduled_at": "2024-12-12T05:16:42.088370218Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.08837+00	2024-12-12 05:16:42.212341+00	2024-12-12 05:16:42.306637+00	\N	2024-12-12 05:11:42.088655+00	2024-12-12 05:16:42.326688+00	86046dbe-9816-4ea3-a533-00c784fb7bf9	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d1c1f1de-d557-45d9-be69-bad2262b2614	default	5	{"job_id": "d1c1f1de-d557-45d9-be69-bad2262b2614", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.153936154Z", "scheduled_at": "2024-12-12T05:16:42.153816778Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.153816+00	2024-12-12 05:16:42.316857+00	2024-12-12 05:16:42.406943+00	\N	2024-12-12 05:11:42.154117+00	2024-12-12 05:16:42.434166+00	d1c1f1de-d557-45d9-be69-bad2262b2614	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
00d092a9-b0bd-414c-971b-977a1df0783c	default	5	{"job_id": "00d092a9-b0bd-414c-971b-977a1df0783c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.096877746Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.097073+00	2024-12-12 05:11:42.098401+00	2024-12-12 05:11:42.10547+00	\N	2024-12-12 05:11:42.097073+00	2024-12-12 05:11:42.106259+00	00d092a9-b0bd-414c-971b-977a1df0783c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
34702ddb-1877-4409-bb1e-384adfdd62c3	default	5	{"job_id": "34702ddb-1877-4409-bb1e-384adfdd62c3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.128294321Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.128483+00	2024-12-12 05:11:42.130086+00	2024-12-12 05:11:42.136875+00	\N	2024-12-12 05:11:42.128483+00	2024-12-12 05:11:42.137688+00	34702ddb-1877-4409-bb1e-384adfdd62c3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
de2232fc-b4e4-4f9a-84d2-52e27d18703f	default	5	{"job_id": "de2232fc-b4e4-4f9a-84d2-52e27d18703f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.104105560Z", "scheduled_at": "2024-12-12T05:16:42.103989050Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.103988+00	2024-12-12 05:16:42.225127+00	2024-12-12 05:16:42.302648+00	\N	2024-12-12 05:11:42.104282+00	2024-12-12 05:16:42.323533+00	de2232fc-b4e4-4f9a-84d2-52e27d18703f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b5313fc8-17c5-4be2-9985-e0b9dc7c8f9a	default	5	{"job_id": "b5313fc8-17c5-4be2-9985-e0b9dc7c8f9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.135539929Z", "scheduled_at": "2024-12-12T05:16:42.135419771Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.135419+00	2024-12-12 05:16:42.26185+00	2024-12-12 05:16:42.332138+00	\N	2024-12-12 05:11:42.135721+00	2024-12-12 05:16:42.359172+00	b5313fc8-17c5-4be2-9985-e0b9dc7c8f9a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
63261828-fc17-4a82-b186-d1d621efae87	default	5	{"job_id": "63261828-fc17-4a82-b186-d1d621efae87", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-12-12T05:11:42.111325000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.138802050Z", "scheduled_at": "2024-12-12T05:16:42.138668387Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.138668+00	2024-12-12 05:16:42.288824+00	2024-12-12 05:16:42.376301+00	\N	2024-12-12 05:11:42.138953+00	2024-12-12 05:16:42.402388+00	63261828-fc17-4a82-b186-d1d621efae87	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
ec3595d2-5c0a-4572-aea6-c1539975a439	default	5	{"job_id": "ec3595d2-5c0a-4572-aea6-c1539975a439", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-12-12T05:11:42.095862000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.107373762Z", "scheduled_at": "2024-12-12T05:16:42.107239999Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.107239+00	2024-12-12 05:16:42.256432+00	2024-12-12 05:16:42.384068+00	\N	2024-12-12 05:11:42.107524+00	2024-12-12 05:16:42.409119+00	ec3595d2-5c0a-4572-aea6-c1539975a439	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
004b298f-075c-4666-9f30-93a75c011abf	default	5	{"job_id": "004b298f-075c-4666-9f30-93a75c011abf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.146958244Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.14715+00	2024-12-12 05:11:42.148379+00	2024-12-12 05:11:42.155327+00	\N	2024-12-12 05:11:42.14715+00	2024-12-12 05:11:42.156128+00	004b298f-075c-4666-9f30-93a75c011abf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d7ff8860-7a4d-4200-b286-7b9292649c6d	default	5	{"job_id": "d7ff8860-7a4d-4200-b286-7b9292649c6d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.194243000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.217487946Z", "scheduled_at": "2024-12-12T05:16:42.217353200Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.217353+00	2024-12-12 05:16:42.364793+00	2024-12-12 05:16:42.460725+00	\N	2024-12-12 05:11:42.217642+00	2024-12-12 05:16:42.485342+00	d7ff8860-7a4d-4200-b286-7b9292649c6d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3a6b6c72-cfcc-49c5-9103-ef9ad8a71130	default	5	{"job_id": "3a6b6c72-cfcc-49c5-9103-ef9ad8a71130", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.178967051Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.179163+00	2024-12-12 05:11:42.180702+00	2024-12-12 05:11:42.188807+00	\N	2024-12-12 05:11:42.179163+00	2024-12-12 05:11:42.189614+00	3a6b6c72-cfcc-49c5-9103-ef9ad8a71130	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a39465e9-24bd-43bc-b5db-c218ff2fa9f1	default	5	{"job_id": "a39465e9-24bd-43bc-b5db-c218ff2fa9f1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-12-12T05:11:42.145799000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.157371694Z", "scheduled_at": "2024-12-12T05:16:42.157235065Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.157234+00	2024-12-12 05:16:42.330279+00	2024-12-12 05:16:42.490602+00	\N	2024-12-12 05:11:42.157642+00	2024-12-12 05:16:42.517985+00	a39465e9-24bd-43bc-b5db-c218ff2fa9f1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
97fed273-19ad-4d6e-9798-79007dd0a194	default	5	{"job_id": "97fed273-19ad-4d6e-9798-79007dd0a194", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.206478336Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.206676+00	2024-12-12 05:11:42.208171+00	2024-12-12 05:11:42.21553+00	\N	2024-12-12 05:11:42.206676+00	2024-12-12 05:11:42.216346+00	97fed273-19ad-4d6e-9798-79007dd0a194	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2df54fa4-7f06-4aaa-9df3-8ba213e3d5e9	default	5	{"job_id": "2df54fa4-7f06-4aaa-9df3-8ba213e3d5e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.187446847Z", "scheduled_at": "2024-12-12T05:16:42.187324345Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.187324+00	2024-12-12 05:16:42.337999+00	2024-12-12 05:16:42.420542+00	\N	2024-12-12 05:11:42.187636+00	2024-12-12 05:16:42.447271+00	2df54fa4-7f06-4aaa-9df3-8ba213e3d5e9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7d399117-b351-46b7-8311-783feef5b62c	default	5	{"job_id": "7d399117-b351-46b7-8311-783feef5b62c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.214158237Z", "scheduled_at": "2024-12-12T05:16:42.214041225Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.214041+00	2024-12-12 05:16:42.351792+00	2024-12-12 05:16:42.432355+00	\N	2024-12-12 05:11:42.214336+00	2024-12-12 05:16:42.462685+00	7d399117-b351-46b7-8311-783feef5b62c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2a193219-6be6-4fa2-b51f-3dd536bfbad2	default	5	{"job_id": "2a193219-6be6-4fa2-b51f-3dd536bfbad2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-12-12T05:11:42.162091000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.190744636Z", "scheduled_at": "2024-12-12T05:16:42.190611563Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.190611+00	2024-12-12 05:16:42.34317+00	2024-12-12 05:16:42.442458+00	\N	2024-12-12 05:11:42.190893+00	2024-12-12 05:16:42.471123+00	2a193219-6be6-4fa2-b51f-3dd536bfbad2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2f6c05df-7d9d-4bb7-96ec-93bcc540d7ff	default	5	{"job_id": "2f6c05df-7d9d-4bb7-96ec-93bcc540d7ff", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.225842396Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.226075+00	2024-12-12 05:11:42.227539+00	2024-12-12 05:11:42.234564+00	\N	2024-12-12 05:11:42.226075+00	2024-12-12 05:11:42.235366+00	2f6c05df-7d9d-4bb7-96ec-93bcc540d7ff	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a2914155-a44b-4ab1-9956-90e54735de1b	default	5	{"job_id": "a2914155-a44b-4ab1-9956-90e54735de1b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.252672881Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.252867+00	2024-12-12 05:11:42.254105+00	2024-12-12 05:11:42.261498+00	\N	2024-12-12 05:11:42.252867+00	2024-12-12 05:11:42.262441+00	a2914155-a44b-4ab1-9956-90e54735de1b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
19ec265c-5d0a-4ac3-8436-f6e0cef67128	default	5	{"job_id": "19ec265c-5d0a-4ac3-8436-f6e0cef67128", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.233081982Z", "scheduled_at": "2024-12-12T05:16:42.232965471Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.232965+00	2024-12-12 05:16:42.377474+00	2024-12-12 05:16:42.466362+00	\N	2024-12-12 05:11:42.233263+00	2024-12-12 05:16:42.493905+00	19ec265c-5d0a-4ac3-8436-f6e0cef67128	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
513c2b83-8ae8-4469-8e9e-66600ce8dbad	default	5	{"job_id": "513c2b83-8ae8-4469-8e9e-66600ce8dbad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.260028978Z", "scheduled_at": "2024-12-12T05:16:42.259889123Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.259889+00	2024-12-12 05:16:42.390894+00	2024-12-12 05:16:42.473076+00	\N	2024-12-12 05:11:42.260227+00	2024-12-12 05:16:42.503572+00	513c2b83-8ae8-4469-8e9e-66600ce8dbad	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d91e8c12-8e41-4fa4-9b0e-181c994c0fa4	default	5	{"job_id": "d91e8c12-8e41-4fa4-9b0e-181c994c0fa4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.224768000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.236503074Z", "scheduled_at": "2024-12-12T05:16:42.236368539Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.236368+00	2024-12-12 05:16:42.385631+00	2024-12-12 05:16:42.482777+00	\N	2024-12-12 05:11:42.236673+00	2024-12-12 05:16:42.50981+00	d91e8c12-8e41-4fa4-9b0e-181c994c0fa4	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
353a33df-ec4c-4749-bd91-1d11251c33a5	default	5	{"job_id": "353a33df-ec4c-4749-bd91-1d11251c33a5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-12-12T05:11:42.239797000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.263671239Z", "scheduled_at": "2024-12-12T05:16:42.263535282Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.263535+00	2024-12-12 05:16:42.411819+00	2024-12-12 05:16:42.530223+00	\N	2024-12-12 05:11:42.263825+00	2024-12-12 05:16:42.55854+00	353a33df-ec4c-4749-bd91-1d11251c33a5	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
33e6c480-4f22-4a66-ad6a-f673f63f0a1d	default	5	{"job_id": "33e6c480-4f22-4a66-ad6a-f673f63f0a1d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.271104904Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.271291+00	2024-12-12 05:11:42.272506+00	2024-12-12 05:11:42.28023+00	\N	2024-12-12 05:11:42.271291+00	2024-12-12 05:11:42.281043+00	33e6c480-4f22-4a66-ad6a-f673f63f0a1d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a6954c98-5aa5-4361-8f32-073f3e52668c	default	5	{"job_id": "a6954c98-5aa5-4361-8f32-073f3e52668c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-12-12T05:11:42.270144000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.282202220Z", "scheduled_at": "2024-12-12T05:16:42.282070381Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.28207+00	2024-12-12 05:16:42.422728+00	2024-12-12 05:16:42.546771+00	\N	2024-12-12 05:11:42.28235+00	2024-12-12 05:16:42.575523+00	a6954c98-5aa5-4361-8f32-073f3e52668c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
800c48ff-5fb9-46c1-8c8b-8df67e9045e1	default	5	{"job_id": "800c48ff-5fb9-46c1-8c8b-8df67e9045e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.309298720Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.309541+00	2024-12-12 05:11:42.311827+00	2024-12-12 05:11:42.322809+00	\N	2024-12-12 05:11:42.309541+00	2024-12-12 05:11:42.324863+00	800c48ff-5fb9-46c1-8c8b-8df67e9045e1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2ef5c0ed-6114-49ce-ad0d-60ca9d989afe	default	5	{"job_id": "2ef5c0ed-6114-49ce-ad0d-60ca9d989afe", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.354742693Z", "scheduled_at": "2024-12-12T05:16:42.354611004Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.35461+00	2024-12-12 05:16:42.489192+00	2024-12-12 05:16:42.573206+00	\N	2024-12-12 05:11:42.35494+00	2024-12-12 05:16:42.602516+00	2ef5c0ed-6114-49ce-ad0d-60ca9d989afe	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0fe98cbf-293b-46cb-853a-ad64bb94a90e	default	5	{"job_id": "0fe98cbf-293b-46cb-853a-ad64bb94a90e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.340636555Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.340826+00	2024-12-12 05:11:42.343237+00	2024-12-12 05:11:42.356852+00	\N	2024-12-12 05:11:42.340826+00	2024-12-12 05:11:42.358503+00	0fe98cbf-293b-46cb-853a-ad64bb94a90e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7b0b6212-a9fd-4ec8-8289-6346f1891dd8	default	5	{"job_id": "7b0b6212-a9fd-4ec8-8289-6346f1891dd8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.278518942Z", "scheduled_at": "2024-12-12T05:16:42.278400578Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.2784+00	2024-12-12 05:16:42.416689+00	2024-12-12 05:16:42.502013+00	\N	2024-12-12 05:11:42.278698+00	2024-12-12 05:16:42.527195+00	7b0b6212-a9fd-4ec8-8289-6346f1891dd8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d94a0356-d5d2-4a63-b76c-3d80facfe242	default	5	{"job_id": "d94a0356-d5d2-4a63-b76c-3d80facfe242", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.320667409Z", "scheduled_at": "2024-12-12T05:16:42.319604566Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.319604+00	2024-12-12 05:16:42.435224+00	2024-12-12 05:16:42.515979+00	\N	2024-12-12 05:11:42.320861+00	2024-12-12 05:16:42.542869+00	d94a0356-d5d2-4a63-b76c-3d80facfe242	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
62dc0511-3627-441b-be8b-499061e2ef60	default	5	{"job_id": "62dc0511-3627-441b-be8b-499061e2ef60", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-12-12T05:11:42.286053000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.327269509Z", "scheduled_at": "2024-12-12T05:16:42.327127560Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.327127+00	2024-12-12 05:16:42.448838+00	2024-12-12 05:16:42.539552+00	\N	2024-12-12 05:11:42.327426+00	2024-12-12 05:16:42.56596+00	62dc0511-3627-441b-be8b-499061e2ef60	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
7d400cf8-19b0-4d39-ba29-f2869940f4bc	default	5	{"job_id": "7d400cf8-19b0-4d39-ba29-f2869940f4bc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-12-12T05:11:42.370082000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.408475711Z", "scheduled_at": "2024-12-12T05:16:42.408339673Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.408339+00	2024-12-12 05:16:42.531155+00	2024-12-12 05:16:42.626275+00	\N	2024-12-12 05:11:42.409271+00	2024-12-12 05:16:42.654831+00	7d400cf8-19b0-4d39-ba29-f2869940f4bc	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2af64997-d854-4a09-87a7-63026929b180	default	5	{"job_id": "2af64997-d854-4a09-87a7-63026929b180", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.386027468Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.386217+00	2024-12-12 05:11:42.390405+00	2024-12-12 05:11:42.403866+00	\N	2024-12-12 05:11:42.386217+00	2024-12-12 05:11:42.406772+00	2af64997-d854-4a09-87a7-63026929b180	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
afbd9f05-9e18-43c3-abc5-34567c5cff3b	default	5	{"job_id": "afbd9f05-9e18-43c3-abc5-34567c5cff3b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.422184915Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.42285+00	2024-12-12 05:11:42.424113+00	2024-12-12 05:11:42.437382+00	\N	2024-12-12 05:11:42.42285+00	2024-12-12 05:11:42.440548+00	afbd9f05-9e18-43c3-abc5-34567c5cff3b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
53893000-32b6-4873-bec8-d453f63a6af8	default	5	{"job_id": "53893000-32b6-4873-bec8-d453f63a6af8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.399529960Z", "scheduled_at": "2024-12-12T05:16:42.399411536Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.399411+00	2024-12-12 05:16:42.520627+00	2024-12-12 05:16:42.60074+00	\N	2024-12-12 05:11:42.400237+00	2024-12-12 05:16:42.62914+00	53893000-32b6-4873-bec8-d453f63a6af8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8e17ff0a-d9a8-40cf-a048-aa561c2cec92	default	5	{"job_id": "8e17ff0a-d9a8-40cf-a048-aa561c2cec92", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-12-12T05:11:42.339676000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.360943181Z", "scheduled_at": "2024-12-12T05:16:42.360740447Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.36074+00	2024-12-12 05:16:42.496658+00	2024-12-12 05:16:42.620877+00	\N	2024-12-12 05:11:42.362193+00	2024-12-12 05:16:42.649072+00	8e17ff0a-d9a8-40cf-a048-aa561c2cec92	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
8bb29984-aa43-4e13-a0e3-61dd7efbe758	default	5	{"job_id": "8bb29984-aa43-4e13-a0e3-61dd7efbe758", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.434036601Z", "scheduled_at": "2024-12-12T05:16:42.433917536Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.433917+00	2024-12-12 05:16:42.545394+00	2024-12-12 05:16:42.636745+00	\N	2024-12-12 05:11:42.434627+00	2024-12-12 05:16:42.667029+00	8bb29984-aa43-4e13-a0e3-61dd7efbe758	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
20d2482b-eca3-4683-b796-49065238612c	default	5	{"job_id": "20d2482b-eca3-4683-b796-49065238612c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-12-12T05:11:42.420692000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.442919591Z", "scheduled_at": "2024-12-12T05:16:42.442751012Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.44275+00	2024-12-12 05:16:42.553898+00	2024-12-12 05:16:42.683943+00	\N	2024-12-12 05:11:42.443738+00	2024-12-12 05:16:42.712301+00	20d2482b-eca3-4683-b796-49065238612c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e99acf18-25eb-43e8-ae44-6c289acc0574	default	5	{"job_id": "e99acf18-25eb-43e8-ae44-6c289acc0574", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-12-12T05:11:42.453266000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.484461971Z", "scheduled_at": "2024-12-12T05:16:42.484318609Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.484318+00	2024-12-12 05:16:42.577805+00	2024-12-12 05:16:42.679522+00	\N	2024-12-12 05:11:42.484623+00	2024-12-12 05:16:42.707098+00	e99acf18-25eb-43e8-ae44-6c289acc0574	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
4c1609cd-e989-42d6-afef-49fef0103988	default	5	{"job_id": "4c1609cd-e989-42d6-afef-49fef0103988", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.468821047Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.469025+00	2024-12-12 05:11:42.470916+00	2024-12-12 05:11:42.481933+00	\N	2024-12-12 05:11:42.469025+00	2024-12-12 05:11:42.483043+00	4c1609cd-e989-42d6-afef-49fef0103988	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
64af2838-aa3c-4db2-a8d4-2afaebfbb8ab	default	5	{"job_id": "64af2838-aa3c-4db2-a8d4-2afaebfbb8ab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.499145252Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.499333+00	2024-12-12 05:11:42.500875+00	2024-12-12 05:11:42.514878+00	\N	2024-12-12 05:11:42.499333+00	2024-12-12 05:11:42.516909+00	64af2838-aa3c-4db2-a8d4-2afaebfbb8ab	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1cc809b1-27aa-4827-8da2-e8059514eae0	default	5	{"job_id": "1cc809b1-27aa-4827-8da2-e8059514eae0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.480251213Z", "scheduled_at": "2024-12-12T05:16:42.480121747Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.480121+00	2024-12-12 05:16:42.568957+00	2024-12-12 05:16:42.652863+00	\N	2024-12-12 05:11:42.480441+00	2024-12-12 05:16:42.682413+00	1cc809b1-27aa-4827-8da2-e8059514eae0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9362d382-ef3d-49f9-84be-5c936c7b9a44	default	5	{"job_id": "9362d382-ef3d-49f9-84be-5c936c7b9a44", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.511675583Z", "scheduled_at": "2024-12-12T05:16:42.511545948Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.511545+00	2024-12-12 05:16:42.583471+00	2024-12-12 05:16:42.669792+00	\N	2024-12-12 05:11:42.511866+00	2024-12-12 05:16:42.698746+00	9362d382-ef3d-49f9-84be-5c936c7b9a44	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e74221f1-5e78-445d-9092-9a1e7496bb91	default	5	{"job_id": "e74221f1-5e78-445d-9092-9a1e7496bb91", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.549344474Z", "scheduled_at": "2024-12-12T05:16:42.549220209Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.54922+00	2024-12-12 05:16:42.604282+00	2024-12-12 05:16:42.687906+00	\N	2024-12-12 05:11:42.549529+00	2024-12-12 05:16:42.716851+00	e74221f1-5e78-445d-9092-9a1e7496bb91	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8cf442ff-f16a-433e-a77d-fde8feb122cd	default	5	{"job_id": "8cf442ff-f16a-433e-a77d-fde8feb122cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-12-12T05:11:42.498160000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.518178855Z", "scheduled_at": "2024-12-12T05:16:42.518046244Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.518046+00	2024-12-12 05:16:42.592717+00	2024-12-12 05:16:42.724203+00	\N	2024-12-12 05:11:42.518784+00	2024-12-12 05:16:42.756526+00	8cf442ff-f16a-433e-a77d-fde8feb122cd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3b0976c9-aea3-4040-9746-cef17e90a5f5	default	5	{"job_id": "3b0976c9-aea3-4040-9746-cef17e90a5f5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.539004774Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.539197+00	2024-12-12 05:11:42.541083+00	2024-12-12 05:11:42.552081+00	\N	2024-12-12 05:11:42.539197+00	2024-12-12 05:11:42.552956+00	3b0976c9-aea3-4040-9746-cef17e90a5f5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
390af1e7-697d-4bf4-ad58-7d33ebfcb26e	default	5	{"job_id": "390af1e7-697d-4bf4-ad58-7d33ebfcb26e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-12-12T05:11:42.588933000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.619506580Z", "scheduled_at": "2024-12-12T05:16:42.619367767Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.619367+00	2024-12-12 05:16:42.661801+00	2024-12-12 05:16:42.768997+00	\N	2024-12-12 05:11:42.619941+00	2024-12-12 05:16:42.795295+00	390af1e7-697d-4bf4-ad58-7d33ebfcb26e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
762bcb6e-0c63-4ea8-959e-2c921a93c801	default	5	{"job_id": "762bcb6e-0c63-4ea8-959e-2c921a93c801", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-12-12T05:11:42.564398000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.582683311Z", "scheduled_at": "2024-12-12T05:16:42.582550549Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.58255+00	2024-12-12 05:16:42.645972+00	2024-12-12 05:16:42.77581+00	\N	2024-12-12 05:11:42.583177+00	2024-12-12 05:16:42.803199+00	762bcb6e-0c63-4ea8-959e-2c921a93c801	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0e3fecc5-a7fa-4e73-9540-b002abc79b45	default	5	{"job_id": "0e3fecc5-a7fa-4e73-9540-b002abc79b45", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.566076546Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.566268+00	2024-12-12 05:11:42.568069+00	2024-12-12 05:11:42.579921+00	\N	2024-12-12 05:11:42.566268+00	2024-12-12 05:11:42.581469+00	0e3fecc5-a7fa-4e73-9540-b002abc79b45	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
123f8421-edb0-4335-9f87-1ad1f543baae	default	5	{"job_id": "123f8421-edb0-4335-9f87-1ad1f543baae", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.603545158Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.604025+00	2024-12-12 05:11:42.605909+00	2024-12-12 05:11:42.616987+00	\N	2024-12-12 05:11:42.604025+00	2024-12-12 05:11:42.617885+00	123f8421-edb0-4335-9f87-1ad1f543baae	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ea254c61-c12f-4455-8140-7a4b76d90914	default	5	{"job_id": "ea254c61-c12f-4455-8140-7a4b76d90914", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-12-12T05:11:42.524089000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.554939585Z", "scheduled_at": "2024-12-12T05:16:42.554464575Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.554464+00	2024-12-12 05:16:42.612806+00	2024-12-12 05:16:42.710933+00	\N	2024-12-12 05:11:42.555102+00	2024-12-12 05:16:42.73709+00	ea254c61-c12f-4455-8140-7a4b76d90914	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
7a9160f3-34b2-4811-bbea-b90a7a0e8ca3	default	5	{"job_id": "7a9160f3-34b2-4811-bbea-b90a7a0e8ca3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.577416452Z", "scheduled_at": "2024-12-12T05:16:42.577295042Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.577295+00	2024-12-12 05:16:42.63096+00	2024-12-12 05:16:42.715407+00	\N	2024-12-12 05:11:42.577924+00	2024-12-12 05:16:42.748599+00	7a9160f3-34b2-4811-bbea-b90a7a0e8ca3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f5af16f3-320f-4281-be56-5504c5b2709f	default	5	{"job_id": "f5af16f3-320f-4281-be56-5504c5b2709f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.614290787Z", "scheduled_at": "2024-12-12T05:16:42.614173184Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.614173+00	2024-12-12 05:16:42.655901+00	2024-12-12 05:16:42.745844+00	\N	2024-12-12 05:11:42.614786+00	2024-12-12 05:16:42.77769+00	f5af16f3-320f-4281-be56-5504c5b2709f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0b25f365-f9d7-40fa-9cca-7cd767d62c66	default	5	{"job_id": "0b25f365-f9d7-40fa-9cca-7cd767d62c66", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-12-12T05:11:42.651970000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.691182314Z", "scheduled_at": "2024-12-12T05:16:42.690640016Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.69064+00	2024-12-12 05:16:42.746943+00	2024-12-12 05:16:42.835587+00	\N	2024-12-12 05:11:42.691349+00	2024-12-12 05:16:42.860416+00	0b25f365-f9d7-40fa-9cca-7cd767d62c66	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3784ce7b-8768-448b-856b-8942bd4f975c	default	5	{"job_id": "3784ce7b-8768-448b-856b-8942bd4f975c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.631148107Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.631332+00	2024-12-12 05:11:42.633425+00	2024-12-12 05:11:42.643398+00	\N	2024-12-12 05:11:42.631332+00	2024-12-12 05:11:42.644686+00	3784ce7b-8768-448b-856b-8942bd4f975c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8fc4e55c-b86e-4b05-b8b3-8fd897162e7a	default	5	{"job_id": "8fc4e55c-b86e-4b05-b8b3-8fd897162e7a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.671863762Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.672057+00	2024-12-12 05:11:42.674288+00	2024-12-12 05:11:42.68744+00	\N	2024-12-12 05:11:42.672057+00	2024-12-12 05:11:42.689522+00	8fc4e55c-b86e-4b05-b8b3-8fd897162e7a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6d08cf20-1ed7-4d76-95ae-250369e6626a	default	5	{"job_id": "6d08cf20-1ed7-4d76-95ae-250369e6626a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.641101125Z", "scheduled_at": "2024-12-12T05:16:42.640982981Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.640983+00	2024-12-12 05:16:42.689302+00	2024-12-12 05:16:42.780885+00	\N	2024-12-12 05:11:42.641283+00	2024-12-12 05:16:42.809908+00	6d08cf20-1ed7-4d76-95ae-250369e6626a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e134d110-eecd-4c17-be08-0b12f97f185e	default	5	{"job_id": "e134d110-eecd-4c17-be08-0b12f97f185e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.684695013Z", "scheduled_at": "2024-12-12T05:16:42.684014032Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.684014+00	2024-12-12 05:16:42.733798+00	2024-12-12 05:16:42.820599+00	\N	2024-12-12 05:11:42.685584+00	2024-12-12 05:16:42.846931+00	e134d110-eecd-4c17-be08-0b12f97f185e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
73f93a95-a8ce-4938-9970-341178a1e1de	default	5	{"job_id": "73f93a95-a8ce-4938-9970-341178a1e1de", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-12-12T05:11:42.629794000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.646351222Z", "scheduled_at": "2024-12-12T05:16:42.645856144Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.645856+00	2024-12-12 05:16:42.71787+00	2024-12-12 05:16:42.847843+00	\N	2024-12-12 05:11:42.646518+00	2024-12-12 05:16:42.867781+00	73f93a95-a8ce-4938-9970-341178a1e1de	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b9e23133-ae87-47aa-ade0-d9ff4352425b	default	5	{"job_id": "b9e23133-ae87-47aa-ade0-d9ff4352425b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.704053622Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.704243+00	2024-12-12 05:11:42.707415+00	2024-12-12 05:11:42.718637+00	\N	2024-12-12 05:11:42.704243+00	2024-12-12 05:11:42.720454+00	b9e23133-ae87-47aa-ade0-d9ff4352425b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2fb44986-5d9a-4da5-a03e-f20d87f567d0	default	5	{"job_id": "2fb44986-5d9a-4da5-a03e-f20d87f567d0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-12-12T05:11:42.703113000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.722459003Z", "scheduled_at": "2024-12-12T05:16:42.722319469Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.722319+00	2024-12-12 05:16:42.786623+00	2024-12-12 05:16:42.894769+00	\N	2024-12-12 05:11:42.722614+00	2024-12-12 05:16:42.9096+00	2fb44986-5d9a-4da5-a03e-f20d87f567d0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d3ae65ac-4700-4035-8cce-ed142e37bc2d	default	5	{"job_id": "d3ae65ac-4700-4035-8cce-ed142e37bc2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.745230849Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.745421+00	2024-12-12 05:11:42.748186+00	2024-12-12 05:11:42.760617+00	\N	2024-12-12 05:11:42.745421+00	2024-12-12 05:11:42.76258+00	d3ae65ac-4700-4035-8cce-ed142e37bc2d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
eb60d7e7-35a3-4fa9-b003-ad78a52aa47a	default	5	{"job_id": "eb60d7e7-35a3-4fa9-b003-ad78a52aa47a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.797734368Z", "scheduled_at": "2024-12-12T05:16:42.797562332Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.797562+00	2024-12-12 05:16:42.834006+00	2024-12-12 05:16:42.900982+00	\N	2024-12-12 05:11:42.798499+00	2024-12-12 05:16:42.912413+00	eb60d7e7-35a3-4fa9-b003-ad78a52aa47a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3ec9396e-c6e0-4f23-bb11-cdf426ddf1b7	default	5	{"job_id": "3ec9396e-c6e0-4f23-bb11-cdf426ddf1b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.781856235Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:42.782202+00	2024-12-12 05:11:42.785089+00	2024-12-12 05:11:42.801082+00	\N	2024-12-12 05:11:42.782202+00	2024-12-12 05:11:42.802323+00	3ec9396e-c6e0-4f23-bb11-cdf426ddf1b7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3954f6db-9e72-4194-839d-52ddab70a3e8	default	5	{"job_id": "3954f6db-9e72-4194-839d-52ddab70a3e8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.716796355Z", "scheduled_at": "2024-12-12T05:16:42.716661088Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.71666+00	2024-12-12 05:16:42.773411+00	2024-12-12 05:16:42.852535+00	\N	2024-12-12 05:11:42.717006+00	2024-12-12 05:16:42.873205+00	3954f6db-9e72-4194-839d-52ddab70a3e8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9690f241-9db0-495f-8a79-acb01ec22037	default	5	{"job_id": "9690f241-9db0-495f-8a79-acb01ec22037", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.758259095Z", "scheduled_at": "2024-12-12T05:16:42.757628831Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.757628+00	2024-12-12 05:16:42.799526+00	2024-12-12 05:16:42.87348+00	\N	2024-12-12 05:11:42.758452+00	2024-12-12 05:16:42.892054+00	9690f241-9db0-495f-8a79-acb01ec22037	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5ca7ff7d-d2fc-4adb-acc4-d674431c1997	default	5	{"job_id": "5ca7ff7d-d2fc-4adb-acc4-d674431c1997", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-12-12T05:11:42.729658000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.764750834Z", "scheduled_at": "2024-12-12T05:16:42.764546006Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.764546+00	2024-12-12 05:16:42.807881+00	2024-12-12 05:16:42.886328+00	\N	2024-12-12 05:11:42.765026+00	2024-12-12 05:16:42.906266+00	5ca7ff7d-d2fc-4adb-acc4-d674431c1997	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
08ece3ee-c27c-4973-a229-d772102f85a3	default	5	{"job_id": "08ece3ee-c27c-4973-a229-d772102f85a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-12-12T05:11:42.780668000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:42.805123478Z", "scheduled_at": "2024-12-12T05:16:42.804425134Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:42.804425+00	2024-12-12 05:16:42.841477+00	2024-12-12 05:16:42.916721+00	\N	2024-12-12 05:11:42.805375+00	2024-12-12 05:16:42.921641+00	08ece3ee-c27c-4973-a229-d772102f85a3	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
af59599b-eafa-46b7-8043-2139e3d643ad	default	5	{"job_id": "af59599b-eafa-46b7-8043-2139e3d643ad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/45"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.203842450Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:43.204038+00	2024-12-12 05:11:43.205126+00	2024-12-12 05:11:43.213597+00	\N	2024-12-12 05:11:43.204038+00	2024-12-12 05:11:43.214322+00	af59599b-eafa-46b7-8043-2139e3d643ad	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8fd1420b-e596-4873-bbba-c2b06dd2a312	default	5	{"job_id": "8fd1420b-e596-4873-bbba-c2b06dd2a312", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.212171751Z", "scheduled_at": "2024-12-12T05:16:43.212041163Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:43.212041+00	2024-12-12 05:16:43.217365+00	2024-12-12 05:16:43.225043+00	\N	2024-12-12 05:11:43.212363+00	2024-12-12 05:16:43.226296+00	8fd1420b-e596-4873-bbba-c2b06dd2a312	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a428a492-8728-4b1a-810c-a368439ea1ed	default	5	{"job_id": "a428a492-8728-4b1a-810c-a368439ea1ed", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/46"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.281392354Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:11:43.281584+00	2024-12-12 05:11:43.282599+00	2024-12-12 05:11:43.289141+00	\N	2024-12-12 05:11:43.281584+00	2024-12-12 05:11:43.289936+00	a428a492-8728-4b1a-810c-a368439ea1ed	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5d70a5b5-8f92-4a97-9bc4-06dc7dcd543b	default	5	{"job_id": "5d70a5b5-8f92-4a97-9bc4-06dc7dcd543b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-12-12T05:11:43.287876930Z", "scheduled_at": "2024-12-12T05:16:43.287756972Z", "provider_job_id": null, "exception_executions": {}}	2024-12-12 05:16:43.287757+00	2024-12-12 05:16:43.291817+00	2024-12-12 05:16:43.298958+00	\N	2024-12-12 05:11:43.288048+00	2024-12-12 05:16:43.300423+00	5d70a5b5-8f92-4a97-9bc4-06dc7dcd543b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
\.


--
-- Data for Name: grid_widgets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.grid_widgets (id, start_row, end_row, start_column, end_column, identifier, options, grid_id) FROM stdin;
1	1	2	1	2	work_package_query	---\n:query_id: 5\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '1'\n	1
2	1	2	2	3	work_package_query	---\n:query_id: 6\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '7'\n	1
3	1	2	3	4	work_package_query	---\n:query_id: 7\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '12'\n	1
4	1	2	4	5	work_package_query	---\n:query_id: 8\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '14'\n	1
5	1	2	1	2	work_package_query	---\n:query_id: 9\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
6	1	2	2	3	work_package_query	---\n:query_id: 10\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
7	1	2	3	4	work_package_query	---\n:query_id: 11\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
8	1	2	4	5	work_package_query	---\n:query_id: 12\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
9	1	2	1	2	work_package_query	---\n:query_id: 13\n:filters:\n- :parent:\n    :operator: "="\n    :values:\n    - '2'\n	3
10	1	2	2	3	work_package_query	---\n:query_id: 14\n:filters:\n- :parent:\n    :operator: "="\n    :values:\n    - '10'\n	3
11	1	2	1	2	work_package_query	---\n:query_id: 19\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '1'\n	4
12	1	2	2	3	work_package_query	---\n:query_id: 20\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '7'\n	4
13	1	2	3	4	work_package_query	---\n:query_id: 21\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '12'\n	4
14	1	2	4	5	work_package_query	---\n:query_id: 22\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '14'\n	4
15	1	2	1	2	work_package_query	---\n:query_id: 23\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	5
16	1	2	2	3	work_package_query	---\n:query_id: 24\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	5
17	1	2	3	4	work_package_query	---\n:query_id: 25\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	5
18	1	2	4	5	work_package_query	---\n:query_id: 26\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	5
19	1	2	1	3	custom_text	---\ntext: "![Teaser](/api/v3/attachments/1/content)"\nname: Welcome\n	6
20	2	5	1	2	custom_text	---\nname: Getting started\ntext: |\n  We are glad you joined! We suggest to try a few things to get started in OpenProject.\n\n  Discover the most important features with our [Guided Tour]({{opSetting:base_url}}/projects/demo-project/work_packages/?start_onboarding_tour=true).\n\n  _Try the following steps:_\n\n  1. *Invite new members to your project*: &rightarrow; Go to [Members]({{opSetting:base_url}}/projects/demo-project/members) in the project navigation.\n  2. *View the work in your project*: &rightarrow; Go to [Work packages]({{opSetting:base_url}}/projects/demo-project/work_packages) in the project navigation.\n  3. *Create a new work package*: &rightarrow; Go to [Work packages &rightarrow; Create]({{opSetting:base_url}}/projects/demo-project/work_packages/new).\n  4. *Create and update a project plan*: &rightarrow; Go to [Project plan]({{opSetting:base_url}}/projects/demo-project/work_packages?query_id=1) in the project navigation.\n  5. *Activate further modules*: &rightarrow; Go to [Project settings &rightarrow; Modules]({{opSetting:base_url}}/projects/demo-project/settings/modules).\n  6. *Complete your tasks in the project*: &rightarrow; Go to [Work packages &rightarrow; Tasks]({{opSetting:base_url}}/projects/demo-project/work_packages/details/3/overview?query_id=3).\n\n  Here you will find our [User Guides](https://www.openproject.org/docs/user-guide/).\n  Please let us know if you have any questions or need support. Contact us: [support[at]openproject.com](mailto:support@openproject.com).\n	6
21	2	3	2	3	project_status	\N	6
22	3	4	2	3	project_description	\N	6
23	4	5	2	3	members	---\nname: Members\n	6
24	5	6	1	3	work_packages_overview	---\nname: Work packages\n	6
25	6	7	1	3	work_packages_table	---\nqueryId: '2'\nname: Milestones\n	6
26	1	2	1	3	custom_text	---\ntext: "![Teaser](/api/v3/attachments/2/content)"\nname: Welcome\n	7
27	2	5	1	2	custom_text	---\nname: Getting started\ntext: |\n  We are glad you joined! We suggest to try a few things to get started in OpenProject.\n\n  _Try the following steps:_\n\n  1. *Invite new members to your project*: &rightarrow; Go to [Members]({{opSetting:base_url}}/projects/your-scrum-project/members) in the project navigation.\n  2. *View your Product backlog and Sprint backlogs*: &rightarrow; Go to [Backlogs]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) in the project navigation.\n  3. *View your Task board*: &rightarrow; Go to [Backlogs]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) &rightarrow; Click on right arrow on Sprint &rightarrow; Select [Task Board](/projects/your-scrum-project/sprints/3/taskboard).\n  4. *Create a new work package*: &rightarrow; Go to [Work packages &rightarrow; Create]({{opSetting:base_url}}/projects/your-scrum-project/work_packages/new).\n  5. *Create and update a project plan*: &rightarrow; Go to [Project plan](/projects/your-scrum-project/work_packages?query_id=15) in the project navigation.\n  6. *Create a Sprint wiki*: &rightarrow; Go to [Backlogs]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and open the sprint wiki from the right drop down menu in a sprint. You can edit the [wiki template]({{opSetting:base_url}}/projects/your-scrum-project/wiki/) based on your needs.\n  7. *Activate further modules*: &rightarrow; Go to [Project settings &rightarrow; Modules]({{opSetting:base_url}}/projects/your-scrum-project/settings/modules).\n\n  Here you will find our [User Guides](https://www.openproject.org/docs/user-guide/).\n  Please let us know if you have any questions or need support. Contact us: [support[at]openproject.com](mailto:support@openproject.com).\n	7
28	2	3	2	3	project_status	\N	7
29	3	4	2	3	project_description	\N	7
30	4	5	2	3	members	---\nname: Members\n	7
31	5	6	1	3	work_packages_overview	---\nname: Work packages\n	7
32	6	7	1	3	work_packages_table	---\nqueryId: '15'\nname: Project plan\n	7
\.


--
-- Data for Name: grids; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.grids (id, row_count, column_count, type, user_id, created_at, updated_at, project_id, name, options) FROM stdin;
1	1	4	Boards::Grid	\N	2024-12-12 05:11:40.454613+00	2024-12-12 05:11:40.454613+00	1	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n:filters:\n- :type:\n    :operator: "="\n    :values:\n    - '1'\n
2	1	4	Boards::Grid	\N	2024-12-12 05:11:40.595089+00	2024-12-12 05:11:40.595089+00	1	Basic board	---\nhighlightingMode: priority\n
3	1	2	Boards::Grid	\N	2024-12-12 05:11:40.696264+00	2024-12-12 05:11:40.696264+00	1	Work breakdown structure	---\ntype: action\nattribute: subtasks\n
4	1	4	Boards::Grid	\N	2024-12-12 05:11:42.925996+00	2024-12-12 05:11:42.925996+00	2	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n
5	1	4	Boards::Grid	\N	2024-12-12 05:11:43.087193+00	2024-12-12 05:11:43.087193+00	2	Task board	---\nhighlightingMode: priority\n
6	6	2	Grids::Overview	\N	2024-12-12 05:11:43.158663+00	2024-12-12 05:11:43.158663+00	1	\N	\N
7	6	2	Grids::Overview	\N	2024-12-12 05:11:43.267369+00	2024-12-12 05:11:43.267369+00	2	\N	\N
\.


--
-- Data for Name: group_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_users (group_id, user_id, id) FROM stdin;
\.


--
-- Data for Name: hierarchical_item_hierarchies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.hierarchical_item_hierarchies (ancestor_id, descendant_id, generations) FROM stdin;
\.


--
-- Data for Name: hierarchical_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.hierarchical_items (id, parent_id, sort_order, label, short, is_deleted, created_at, updated_at, custom_field_id) FROM stdin;
\.


--
-- Data for Name: ical_token_query_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ical_token_query_assignments (id, ical_token_id, query_id, created_at, updated_at, name) FROM stdin;
\.


--
-- Data for Name: ifc_models; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ifc_models (id, title, created_at, updated_at, project_id, uploader_id, is_default, conversion_status, conversion_error_message) FROM stdin;
\.


--
-- Data for Name: job_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_statuses (id, reference_type, reference_id, message, created_at, updated_at, status, user_id, job_id, payload) FROM stdin;
\.


--
-- Data for Name: journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.journals (id, journable_type, journable_id, user_id, notes, created_at, version, updated_at, data_type, data_id, cause, validity_period) FROM stdin;
1	Project	1	3		2024-12-12 05:11:38.990077+00	1	2024-12-12 05:11:38.990077+00	Journal::ProjectJournal	1	{}	["2024-12-12 05:11:38.990077+00",)
2	News	1	3		2024-12-12 05:11:39.194667+00	1	2024-12-12 05:11:39.194667+00	Journal::NewsJournal	1	{}	["2024-12-12 05:11:39.194667+00",)
3	WikiPage	1	3		2024-12-12 05:11:39.450982+00	1	2024-12-12 05:11:39.450982+00	Journal::WikiPageJournal	1	{}	["2024-12-12 05:11:39.450982+00",)
4	WorkPackage	1	3		2024-12-12 05:11:39.507931+00	1	2024-12-12 05:11:39.567864+00	Journal::WorkPackageJournal	2	{}	["2024-12-12 05:11:39.507931+00",)
7	WorkPackage	4	3		2024-12-12 05:11:39.643963+00	1	2024-12-12 05:11:39.690221+00	Journal::WorkPackageJournal	7	{}	["2024-12-12 05:11:39.643963+00",)
8	WorkPackage	5	3		2024-12-12 05:11:39.722974+00	1	2024-12-12 05:11:39.762828+00	Journal::WorkPackageJournal	10	{}	["2024-12-12 05:11:39.722974+00",)
9	WorkPackage	6	3		2024-12-12 05:11:39.787075+00	1	2024-12-12 05:11:39.830992+00	Journal::WorkPackageJournal	13	{}	["2024-12-12 05:11:39.787075+00",)
6	WorkPackage	3	3		2024-12-12 05:11:39.615712+00	1	2024-12-12 05:11:39.881035+00	Journal::WorkPackageJournal	15	{}	["2024-12-12 05:11:39.615712+00",)
10	WorkPackage	7	3		2024-12-12 05:11:39.921022+00	1	2024-12-12 05:11:39.961736+00	Journal::WorkPackageJournal	18	{}	["2024-12-12 05:11:39.921022+00",)
11	WorkPackage	8	3		2024-12-12 05:11:39.993512+00	1	2024-12-12 05:11:40.032201+00	Journal::WorkPackageJournal	21	{}	["2024-12-12 05:11:39.993512+00",)
5	WorkPackage	2	3		2024-12-12 05:11:39.588643+00	1	2024-12-12 05:11:40.060131+00	Journal::WorkPackageJournal	22	{}	["2024-12-12 05:11:39.588643+00",)
12	WorkPackage	9	3		2024-12-12 05:11:40.079898+00	1	2024-12-12 05:11:40.105614+00	Journal::WorkPackageJournal	24	{}	["2024-12-12 05:11:40.079898+00",)
14	WorkPackage	11	3		2024-12-12 05:11:40.142513+00	1	2024-12-12 05:11:40.18477+00	Journal::WorkPackageJournal	28	{}	["2024-12-12 05:11:40.142513+00",)
15	WorkPackage	12	3		2024-12-12 05:11:40.217201+00	1	2024-12-12 05:11:40.256049+00	Journal::WorkPackageJournal	31	{}	["2024-12-12 05:11:40.217201+00",)
13	WorkPackage	10	3		2024-12-12 05:11:40.120523+00	1	2024-12-12 05:11:40.283728+00	Journal::WorkPackageJournal	32	{}	["2024-12-12 05:11:40.120523+00",)
16	WorkPackage	13	3		2024-12-12 05:11:40.298688+00	1	2024-12-12 05:11:40.322317+00	Journal::WorkPackageJournal	34	{}	["2024-12-12 05:11:40.298688+00",)
17	Meeting	1	3		2024-12-12 05:11:40.747628+00	1	2024-12-12 05:11:40.747628+00	Journal::MeetingJournal	1	{}	["2024-12-12 05:11:40.747628+00",)
18	Project	2	3		2024-12-12 05:11:40.931787+00	1	2024-12-12 05:11:40.931787+00	Journal::ProjectJournal	2	{}	["2024-12-12 05:11:40.931787+00",)
19	News	2	3		2024-12-12 05:11:40.988961+00	1	2024-12-12 05:11:40.988961+00	Journal::NewsJournal	2	{}	["2024-12-12 05:11:40.988961+00",)
20	WikiPage	2	3		2024-12-12 05:11:41.088301+00	1	2024-12-12 05:11:41.088301+00	Journal::WikiPageJournal	2	{}	["2024-12-12 05:11:41.088301+00",)
21	WikiPage	3	3		2024-12-12 05:11:41.254043+00	1	2024-12-12 05:11:41.254043+00	Journal::WikiPageJournal	3	{}	["2024-12-12 05:11:41.254043+00",)
22	WorkPackage	14	3		2024-12-12 05:11:41.289724+00	1	2024-12-12 05:11:41.329266+00	Journal::WorkPackageJournal	36	{}	["2024-12-12 05:11:41.289724+00",)
23	WorkPackage	15	3		2024-12-12 05:11:41.348647+00	1	2024-12-12 05:11:41.387566+00	Journal::WorkPackageJournal	38	{}	["2024-12-12 05:11:41.348647+00",)
25	WorkPackage	17	3		2024-12-12 05:11:41.436597+00	1	2024-12-12 05:11:41.493085+00	Journal::WorkPackageJournal	42	{}	["2024-12-12 05:11:41.436597+00",)
26	WorkPackage	18	3		2024-12-12 05:11:41.522121+00	1	2024-12-12 05:11:41.572765+00	Journal::WorkPackageJournal	45	{}	["2024-12-12 05:11:41.522121+00",)
28	WorkPackage	20	3		2024-12-12 05:11:41.633679+00	1	2024-12-12 05:11:41.679831+00	Journal::WorkPackageJournal	49	{}	["2024-12-12 05:11:41.633679+00",)
27	WorkPackage	19	3		2024-12-12 05:11:41.600012+00	1	2024-12-12 05:11:41.732652+00	Journal::WorkPackageJournal	51	{}	["2024-12-12 05:11:41.600012+00",)
24	WorkPackage	16	3		2024-12-12 05:11:41.407032+00	1	2024-12-12 05:11:41.763922+00	Journal::WorkPackageJournal	52	{}	["2024-12-12 05:11:41.407032+00",)
29	WorkPackage	21	3		2024-12-12 05:11:41.782618+00	1	2024-12-12 05:11:41.818173+00	Journal::WorkPackageJournal	54	{}	["2024-12-12 05:11:41.782618+00",)
31	WorkPackage	23	3		2024-12-12 05:11:41.868153+00	1	2024-12-12 05:11:41.912893+00	Journal::WorkPackageJournal	58	{}	["2024-12-12 05:11:41.868153+00",)
30	WorkPackage	22	3		2024-12-12 05:11:41.835833+00	1	2024-12-12 05:11:41.942761+00	Journal::WorkPackageJournal	59	{}	["2024-12-12 05:11:41.835833+00",)
32	WorkPackage	24	3		2024-12-12 05:11:41.958908+00	1	2024-12-12 05:11:41.994991+00	Journal::WorkPackageJournal	61	{}	["2024-12-12 05:11:41.958908+00",)
33	WorkPackage	25	3		2024-12-12 05:11:42.01037+00	1	2024-12-12 05:11:42.045751+00	Journal::WorkPackageJournal	63	{}	["2024-12-12 05:11:42.01037+00",)
34	WorkPackage	26	3		2024-12-12 05:11:42.060742+00	1	2024-12-12 05:11:42.095862+00	Journal::WorkPackageJournal	65	{}	["2024-12-12 05:11:42.060742+00",)
35	WorkPackage	27	3		2024-12-12 05:11:42.111325+00	1	2024-12-12 05:11:42.145799+00	Journal::WorkPackageJournal	67	{}	["2024-12-12 05:11:42.111325+00",)
37	WorkPackage	29	3		2024-12-12 05:11:42.194243+00	1	2024-12-12 05:11:42.239797+00	Journal::WorkPackageJournal	71	{}	["2024-12-12 05:11:42.194243+00",)
36	WorkPackage	28	3		2024-12-12 05:11:42.162091+00	1	2024-12-12 05:11:42.270144+00	Journal::WorkPackageJournal	72	{}	["2024-12-12 05:11:42.162091+00",)
38	WorkPackage	30	3		2024-12-12 05:11:42.286053+00	1	2024-12-12 05:11:42.339676+00	Journal::WorkPackageJournal	74	{}	["2024-12-12 05:11:42.286053+00",)
39	WorkPackage	31	3		2024-12-12 05:11:42.370082+00	1	2024-12-12 05:11:42.420692+00	Journal::WorkPackageJournal	76	{}	["2024-12-12 05:11:42.370082+00",)
40	WorkPackage	32	3		2024-12-12 05:11:42.453266+00	1	2024-12-12 05:11:42.49816+00	Journal::WorkPackageJournal	78	{}	["2024-12-12 05:11:42.453266+00",)
41	WorkPackage	33	3		2024-12-12 05:11:42.524089+00	1	2024-12-12 05:11:42.564398+00	Journal::WorkPackageJournal	80	{}	["2024-12-12 05:11:42.524089+00",)
42	WorkPackage	34	3		2024-12-12 05:11:42.588933+00	1	2024-12-12 05:11:42.629794+00	Journal::WorkPackageJournal	82	{}	["2024-12-12 05:11:42.588933+00",)
43	WorkPackage	35	3		2024-12-12 05:11:42.65197+00	1	2024-12-12 05:11:42.703113+00	Journal::WorkPackageJournal	84	{}	["2024-12-12 05:11:42.65197+00",)
44	WorkPackage	36	3		2024-12-12 05:11:42.729658+00	1	2024-12-12 05:11:42.780668+00	Journal::WorkPackageJournal	86	{}	["2024-12-12 05:11:42.729658+00",)
45	Attachment	1	3		2024-12-12 05:11:43.196223+00	1	2024-12-12 05:11:43.196223+00	Journal::AttachmentJournal	1	{}	["2024-12-12 05:11:43.196223+00",)
46	Attachment	2	3		2024-12-12 05:11:43.276447+00	1	2024-12-12 05:11:43.276447+00	Journal::AttachmentJournal	2	{}	["2024-12-12 05:11:43.276447+00",)
\.


--
-- Data for Name: labor_budget_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.labor_budget_items (id, budget_id, hours, user_id, comments, amount) FROM stdin;
\.


--
-- Data for Name: last_project_folders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.last_project_folders (id, project_storage_id, origin_folder_id, mode, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ldap_auth_sources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ldap_auth_sources (id, name, host, port, account, account_password, base_dn, attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, attr_admin, created_at, updated_at, tls_mode, filter_string, verify_peer, tls_certificate_string) FROM stdin;
\.


--
-- Data for Name: ldap_groups_memberships; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ldap_groups_memberships (id, user_id, group_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ldap_groups_synchronized_filters; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ldap_groups_synchronized_filters (id, name, group_name_attribute, filter_string, ldap_auth_source_id, created_at, updated_at, base_dn, sync_users) FROM stdin;
\.


--
-- Data for Name: ldap_groups_synchronized_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ldap_groups_synchronized_groups (id, group_id, ldap_auth_source_id, created_at, updated_at, dn, users_count, filter_id, sync_users) FROM stdin;
\.


--
-- Data for Name: material_budget_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.material_budget_items (id, budget_id, units, cost_type_id, comments, amount) FROM stdin;
\.


--
-- Data for Name: meeting_agenda_item_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_agenda_item_journals (id, journal_id, agenda_item_id, author_id, title, notes, "position", duration_in_minutes, start_time, end_time, work_package_id, item_type, presenter_id) FROM stdin;
\.


--
-- Data for Name: meeting_agenda_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_agenda_items (id, meeting_id, author_id, title, notes, "position", duration_in_minutes, start_time, end_time, created_at, updated_at, work_package_id, item_type, lock_version, presenter_id, meeting_section_id) FROM stdin;
1	1	4	Good news	What went well this week?	1	5	2024-12-13 10:00:00	2024-12-13 10:05:00	2024-12-12 05:11:40.799021	2024-12-12 05:11:40.90985	\N	0	0	4	1
2	1	4	Updates from development team	News and focused topics for the upcoming week.	2	5	2024-12-13 10:05:00	2024-12-13 10:10:00	2024-12-12 05:11:40.817575	2024-12-12 05:11:40.90985	\N	0	0	4	1
3	1	4	Updates from product team	News and focused topics for the upcoming week.	3	5	2024-12-13 10:10:00	2024-12-13 10:15:00	2024-12-12 05:11:40.827815	2024-12-12 05:11:40.90985	\N	0	0	4	1
4	1	4	Updates from marketing team	News and focused topics for the upcoming week.	4	5	2024-12-13 10:15:00	2024-12-13 10:20:00	2024-12-12 05:11:40.840315	2024-12-12 05:11:40.90985	\N	0	0	4	1
5	1	4	\N	**Today's topic**: Organizing the open-source conference.	5	5	2024-12-13 10:20:00	2024-12-13 10:25:00	2024-12-12 05:11:40.850621	2024-12-12 05:11:40.90985	2	1	0	4	1
6	1	4	Updates from sales team	News and focused topics for the upcoming week.	6	5	2024-12-13 10:25:00	2024-12-13 10:30:00	2024-12-12 05:11:40.862909	2024-12-12 05:11:40.90985	\N	0	0	4	1
7	1	4	Review of quarterly goals	Assessing the status and progress of the defined quarterly goals.	7	5	2024-12-13 10:30:00	2024-12-13 10:35:00	2024-12-12 05:11:40.874675	2024-12-12 05:11:40.90985	\N	0	0	4	1
8	1	4	Core values feedback	Highlight employees who have lived the core values this week.	8	5	2024-12-13 10:35:00	2024-12-13 10:40:00	2024-12-12 05:11:40.886784	2024-12-12 05:11:40.90985	\N	0	0	4	1
9	1	4	General topics	Solving or discussing topics together.	9	20	2024-12-13 10:40:00	2024-12-13 11:00:00	2024-12-12 05:11:40.899517	2024-12-12 05:11:40.90985	\N	0	0	4	1
\.


--
-- Data for Name: meeting_content_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_content_journals (id, meeting_id, author_id, text, locked) FROM stdin;
\.


--
-- Data for Name: meeting_contents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_contents (id, type, meeting_id, author_id, text, lock_version, created_at, updated_at, locked) FROM stdin;
\.


--
-- Data for Name: meeting_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_journals (id, title, author_id, project_id, location, start_time, duration, state) FROM stdin;
1	Weekly	4	1	\N	2024-12-13 10:00:00+00	1	0
\.


--
-- Data for Name: meeting_participants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_participants (id, user_id, meeting_id, email, name, invited, attended, created_at, updated_at) FROM stdin;
1	4	1	\N	\N	t	\N	2024-12-12 05:11:40.749156+00	2024-12-12 05:11:40.749156+00
\.


--
-- Data for Name: meeting_sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_sections (id, "position", title, meeting_id, created_at, updated_at) FROM stdin;
1	1		1	2024-12-12 05:11:40.792386+00	2024-12-12 05:11:40.792386+00
\.


--
-- Data for Name: meetings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meetings (id, title, author_id, project_id, location, start_time, duration, created_at, updated_at, state, type, lock_version) FROM stdin;
1	Weekly	4	1	\N	2024-12-13 10:00:00+00	1	2024-12-12 05:11:40.747628+00	2024-12-12 05:11:40.747628+00	0	StructuredMeeting	0
\.


--
-- Data for Name: member_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.member_roles (id, member_id, role_id, inherited_from) FROM stdin;
1	1	11	\N
2	2	11	\N
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.members (id, user_id, project_id, created_at, updated_at, entity_type, entity_id) FROM stdin;
1	4	1	2024-12-12 05:11:39.186856+00	2024-12-12 05:11:39.189746+00	\N	\N
2	4	2	2024-12-12 05:11:40.987123+00	2024-12-12 05:11:40.988433+00	\N	\N
\.


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu_items (id, name, title, parent_id, options, navigatable_id, type) FROM stdin;
1	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	1	MenuItems::WikiMenuItem
2	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	2	MenuItems::WikiMenuItem
\.


--
-- Data for Name: message_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.message_journals (id, forum_id, parent_id, subject, content, author_id, locked, sticky) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, forum_id, parent_id, subject, content, author_id, replies_count, last_reply_id, created_at, updated_at, locked, sticky, sticked_on) FROM stdin;
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news (id, project_id, title, summary, description, author_id, created_at, comments_count, updated_at) FROM stdin;
1	1	Welcome to your demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	The actual news	4	2024-12-12 05:11:39.194667+00	0	2024-12-12 05:11:39.194667+00
2	2	Welcome to your Scrum demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	This is the news content.	4	2024-12-12 05:11:40.988961+00	0	2024-12-12 05:11:40.988961+00
\.


--
-- Data for Name: news_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news_journals (id, project_id, title, summary, description, author_id, comments_count) FROM stdin;
1	1	Welcome to your demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	The actual news	4	0
2	2	Welcome to your Scrum demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	This is the news content.	4	0
\.


--
-- Data for Name: non_working_days; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.non_working_days (id, name, date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification_settings (id, project_id, user_id, watched, mentioned, created_at, updated_at, work_package_commented, work_package_created, work_package_processed, work_package_prioritized, work_package_scheduled, news_added, news_commented, document_added, forum_messages, wiki_page_added, wiki_page_updated, membership_added, membership_updated, start_date, due_date, overdue, assignee, responsible, shared) FROM stdin;
1	\N	4	t	t	2024-12-12 05:11:38.551536+00	2024-12-12 05:11:38.551536+00	f	f	f	f	f	f	f	f	f	f	f	f	f	1	1	\N	t	t	t
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, subject, read_ian, reason, recipient_id, actor_id, resource_type, resource_id, journal_id, created_at, updated_at, mail_reminder_sent, mail_alert_sent) FROM stdin;
\.


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_access_grants (id, resource_owner_id, application_id, token, expires_in, redirect_uri, created_at, revoked_at, scopes, code_challenge, code_challenge_method) FROM stdin;
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_access_tokens (id, resource_owner_id, application_id, token, refresh_token, expires_in, revoked_at, created_at, scopes, previous_refresh_token) FROM stdin;
\.


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_applications (id, name, uid, secret, owner_type, owner_id, client_credentials_user_id, redirect_uri, scopes, confidential, created_at, updated_at, integration_type, integration_id, enabled, builtin) FROM stdin;
1	OpenProject Mobile App	DgJZ7Rat23xHZbcq_nxPg5RUuxljonLCN7V7N7GoBAA	9e3b07aacd9b6842cbb3194f083ac4af41dc042a27c86910c58b30668e619a3c	User	1	\N	openprojectapp://oauth-callback		f	2024-12-12 05:11:38.798509+00	2024-12-12 05:11:38.798509+00	\N	\N	f	t
\.


--
-- Data for Name: oauth_client_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_client_tokens (id, oauth_client_id, user_id, access_token, refresh_token, token_type, expires_in, scope, created_at, updated_at, lock_version) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_clients (id, client_id, client_secret, integration_type, integration_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oidc_user_session_links; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oidc_user_session_links (id, oidc_session, session_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ordered_work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ordered_work_packages (id, "position", query_id, work_package_id) FROM stdin;
1	0	9	8
2	1	9	11
3	0	10	7
4	0	11	3
5	0	23	16
6	1	23	25
7	2	23	27
8	0	24	14
9	0	25	26
10	0	26	24
\.


--
-- Data for Name: paper_trail_audits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.paper_trail_audits (id, item_type, item_id, event, whodunnit, stack, object, object_changes, created_at) FROM stdin;
\.


--
-- Data for Name: project_custom_field_project_mappings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_custom_field_project_mappings (id, custom_field_id, project_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: project_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_journals (id, name, description, public, parent_id, identifier, active, templated, status_code, status_explanation) FROM stdin;
1	Demo project	This is a short summary of the goals of this demo project.	t	\N	demo-project	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.
2	Scrum project	This is a short summary of the goals of this demo Scrum project.	t	\N	your-scrum-project	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.
\.


--
-- Data for Name: project_life_cycle_step_definitions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_life_cycle_step_definitions (id, type, name, "position", color_id, created_at, updated_at) FROM stdin;
1	Project::StageDefinition	Initiating	1	145	2024-12-12 05:11:36.756646+00	2024-12-12 05:11:36.756646+00
2	Project::GateDefinition	Ready for Planning	2	146	2024-12-12 05:11:36.770811+00	2024-12-12 05:11:36.770811+00
3	Project::StageDefinition	Planning	3	147	2024-12-12 05:11:36.774821+00	2024-12-12 05:11:36.774821+00
4	Project::GateDefinition	Ready for Executing	4	146	2024-12-12 05:11:36.778468+00	2024-12-12 05:11:36.778468+00
5	Project::StageDefinition	Executing	5	148	2024-12-12 05:11:36.781773+00	2024-12-12 05:11:36.781773+00
6	Project::GateDefinition	Ready for Closing	6	146	2024-12-12 05:11:36.785664+00	2024-12-12 05:11:36.785664+00
7	Project::StageDefinition	Closing	7	149	2024-12-12 05:11:36.78806+00	2024-12-12 05:11:36.78806+00
\.


--
-- Data for Name: project_life_cycle_steps; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_life_cycle_steps (id, type, start_date, end_date, active, project_id, definition_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: project_queries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_queries (id, name, user_id, filters, selects, orders, created_at, updated_at, public) FROM stdin;
\.


--
-- Data for Name: project_storages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_storages (id, project_id, storage_id, creator_id, created_at, updated_at, project_folder_id, project_folder_mode) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.projects (id, name, description, public, parent_id, created_at, updated_at, identifier, lft, rgt, active, templated, status_code, status_explanation, settings) FROM stdin;
1	Demo project	This is a short summary of the goals of this demo project.	t	\N	2024-12-12 05:11:38.990077+00	2024-12-12 05:11:38.990077+00	demo-project	1	2	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.	{}
2	Scrum project	This is a short summary of the goals of this demo Scrum project.	t	\N	2024-12-12 05:11:40.931787+00	2024-12-12 05:11:40.931787+00	your-scrum-project	3	4	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.	{}
\.


--
-- Data for Name: projects_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.projects_types (project_id, type_id) FROM stdin;
1	1
1	2
1	3
2	1
2	2
2	3
2	5
2	6
2	7
\.


--
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.queries (id, project_id, name, filters, user_id, public, column_names, sort_criteria, group_by, display_sums, timeline_visible, show_hierarchies, timeline_zoom_level, timeline_labels, highlighting_mode, highlighted_attributes, created_at, updated_at, display_representation, starred, include_subprojects, timestamps) FROM stdin;
1	1	Project plan	---\nstatus_id:\n  :operator: o\n  :values: []\n	4	t	---\n- :id\n- :type\n- :subject\n- :status\n- :start_date\n- :due_date\n- :duration\n- :assigned_to\n	---\n- - id\n  - asc\n	\N	f	t	t	5	\N	\N	\N	2024-12-12 05:11:39.317591+00	2024-12-12 05:11:39.317591+00	\N	t	t	\N
2	1	Milestones	---\ntype_id:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	---\n- :id\n- :type\n- :subject\n- :status\n- :start_date\n- :due_date\n	---\n- - id\n  - asc\n	\N	f	t	f	5	\N	\N	\N	2024-12-12 05:11:39.361753+00	2024-12-12 05:11:39.361753+00	\N	f	t	\N
3	1	Tasks	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	---\n- :id\n- :subject\n- :priority\n- :status\n- :assigned_to\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:39.399243+00	2024-12-12 05:11:39.399243+00	\N	f	t	\N
4	1	Team planner	---\nassigned_to_id:\n  :operator: "="\n  :values:\n  - '4'\n	4	t	\N	\N	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:39.431019+00	2024-12-12 05:11:39.431019+00	\N	f	t	\N
5	1	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.356395+00	2024-12-12 05:11:40.356395+00	\N	f	t	\N
6	1	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.377888+00	2024-12-12 05:11:40.377888+00	\N	f	t	\N
7	1	Closed	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '12'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.398152+00	2024-12-12 05:11:40.398152+00	\N	f	t	\N
8	1	Rejected	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '14'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.418315+00	2024-12-12 05:11:40.418315+00	\N	f	t	\N
9	1	Wish list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:40.51483+00	2024-12-12 05:11:40.51483+00	\N	f	t	\N
10	1	Short list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:40.538184+00	2024-12-12 05:11:40.538184+00	\N	f	t	\N
11	1	Priority list for today	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:40.560205+00	2024-12-12 05:11:40.560205+00	\N	f	t	\N
12	1	Never	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:40.580804+00	2024-12-12 05:11:40.580804+00	\N	f	t	\N
13	1	Organize open source conference	---\nstatus_id:\n  :operator: o\n  :values:\n  - ''\nparent:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.654944+00	2024-12-12 05:11:40.654944+00	\N	f	t	\N
14	1	Follow-up tasks	---\nstatus_id:\n  :operator: o\n  :values:\n  - ''\nparent:\n  :operator: "="\n  :values:\n  - '10'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:40.679905+00	2024-12-12 05:11:40.679905+00	\N	f	t	\N
15	2	Project plan	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '2'\n  - '3'\n	4	t	\N	---\n- - id\n  - asc\n	\N	f	t	f	5	\N	\N	\N	2024-12-12 05:11:41.150996+00	2024-12-12 05:11:41.150996+00	\N	f	t	\N
16	2	Product backlog	---\nstatus_id:\n  :operator: o\n  :values: []\nversion_id:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	---\n- :id\n- :type\n- :subject\n- :priority\n- :status\n- :assigned_to\n- :story_points\n	---\n- - status\n  - asc\n	status	f	f	f	5	\N	\N	\N	2024-12-12 05:11:41.185606+00	2024-12-12 05:11:41.185606+00	\N	f	t	\N
17	2	Sprint 1	---\nstatus_id:\n  :operator: o\n  :values: []\nversion_id:\n  :operator: "="\n  :values:\n  - '3'\n	4	t	---\n- :id\n- :type\n- :subject\n- :priority\n- :status\n- :assigned_to\n- :done_ratio\n- :story_points\n	\N	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:41.219093+00	2024-12-12 05:11:41.219093+00	\N	f	t	\N
18	2	Tasks	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	\N	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:41.239685+00	2024-12-12 05:11:41.239685+00	\N	f	t	\N
19	2	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:42.829674+00	2024-12-12 05:11:42.829674+00	\N	f	t	\N
20	2	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:42.854062+00	2024-12-12 05:11:42.854062+00	\N	f	t	\N
21	2	Closed	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '12'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:42.880662+00	2024-12-12 05:11:42.880662+00	\N	f	t	\N
22	2	Rejected	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '14'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-12-12 05:11:42.906483+00	2024-12-12 05:11:42.906483+00	\N	f	t	\N
23	2	Wish list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:42.989877+00	2024-12-12 05:11:42.989877+00	\N	f	t	\N
24	2	Short list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:43.020198+00	2024-12-12 05:11:43.020198+00	\N	f	t	\N
25	2	Priority list for today	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:43.045132+00	2024-12-12 05:11:43.045132+00	\N	f	t	\N
26	2	Never	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-12-12 05:11:43.069195+00	2024-12-12 05:11:43.069195+00	\N	f	t	\N
\.


--
-- Data for Name: rates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rates (id, valid_from, rate, type, project_id, user_id, cost_type_id) FROM stdin;
\.


--
-- Data for Name: recaptcha_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recaptcha_entries (id, user_id, created_at, updated_at, version) FROM stdin;
\.


--
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.relations (id, from_id, to_id, lag, description, relation_type) FROM stdin;
1	13	10	\N	\N	follows
2	9	2	\N	\N	follows
3	8	3	\N	\N	follows
4	7	3	\N	\N	follows
5	36	35	\N	\N	follows
6	34	33	\N	\N	follows
7	32	31	\N	\N	follows
\.


--
-- Data for Name: remote_identities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.remote_identities (id, user_id, oauth_client_id, origin_user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: repositories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.repositories (id, project_id, url, login, password, root_url, type, path_encoding, log_encoding, scm_type, required_storage_bytes, storage_updated_at) FROM stdin;
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_permissions (id, permission, role_id, created_at, updated_at) FROM stdin;
1	view_work_packages	1	2024-12-12 05:11:12.995977+00	2024-12-12 05:11:12.995977+00
2	edit_work_packages	1	2024-12-12 05:11:12.99951+00	2024-12-12 05:11:12.99951+00
3	work_package_assigned	1	2024-12-12 05:11:13.001372+00	2024-12-12 05:11:13.001372+00
4	add_work_package_notes	1	2024-12-12 05:11:13.001941+00	2024-12-12 05:11:13.001941+00
5	edit_own_work_package_notes	1	2024-12-12 05:11:13.002417+00	2024-12-12 05:11:13.002417+00
6	manage_work_package_relations	1	2024-12-12 05:11:13.002846+00	2024-12-12 05:11:13.002846+00
7	copy_work_packages	1	2024-12-12 05:11:13.003487+00	2024-12-12 05:11:13.003487+00
8	export_work_packages	1	2024-12-12 05:11:13.004674+00	2024-12-12 05:11:13.004674+00
9	view_own_time_entries	1	2024-12-12 05:11:13.005906+00	2024-12-12 05:11:13.005906+00
10	log_own_time	1	2024-12-12 05:11:13.006519+00	2024-12-12 05:11:13.006519+00
11	edit_own_time_entries	1	2024-12-12 05:11:13.012016+00	2024-12-12 05:11:13.012016+00
12	show_github_content	1	2024-12-12 05:11:13.014066+00	2024-12-12 05:11:13.014066+00
13	view_file_links	1	2024-12-12 05:11:13.01467+00	2024-12-12 05:11:13.01467+00
14	view_work_packages	2	2024-12-12 05:11:13.043283+00	2024-12-12 05:11:13.043283+00
15	work_package_assigned	2	2024-12-12 05:11:13.043835+00	2024-12-12 05:11:13.043835+00
16	add_work_package_notes	2	2024-12-12 05:11:13.044287+00	2024-12-12 05:11:13.044287+00
17	add_work_package_attachments	2	2024-12-12 05:11:13.044691+00	2024-12-12 05:11:13.044691+00
18	edit_own_work_package_notes	2	2024-12-12 05:11:13.045375+00	2024-12-12 05:11:13.045375+00
19	export_work_packages	2	2024-12-12 05:11:13.046673+00	2024-12-12 05:11:13.046673+00
20	view_own_time_entries	2	2024-12-12 05:11:13.047669+00	2024-12-12 05:11:13.047669+00
21	log_own_time	2	2024-12-12 05:11:13.048409+00	2024-12-12 05:11:13.048409+00
22	edit_own_time_entries	2	2024-12-12 05:11:13.049048+00	2024-12-12 05:11:13.049048+00
23	show_github_content	2	2024-12-12 05:11:13.049736+00	2024-12-12 05:11:13.049736+00
24	view_file_links	2	2024-12-12 05:11:13.050829+00	2024-12-12 05:11:13.050829+00
25	view_work_packages	3	2024-12-12 05:11:13.060446+00	2024-12-12 05:11:13.060446+00
26	export_work_packages	3	2024-12-12 05:11:13.060908+00	2024-12-12 05:11:13.060908+00
27	show_github_content	3	2024-12-12 05:11:13.061919+00	2024-12-12 05:11:13.061919+00
28	add_work_package_attachments	2	2024-12-12 05:11:13.094917+00	2024-12-12 05:11:13.094917+00
29	view_project_query	4	2024-12-12 05:11:13.615388+00	2024-12-12 05:11:13.615388+00
30	view_project_query	5	2024-12-12 05:11:13.622543+00	2024-12-12 05:11:13.622543+00
31	edit_project_query	5	2024-12-12 05:11:13.623358+00	2024-12-12 05:11:13.623358+00
32	view_work_packages	7	2024-12-12 05:11:36.290097+00	2024-12-12 05:11:36.290097+00
33	view_calendar	7	2024-12-12 05:11:36.291195+00	2024-12-12 05:11:36.291195+00
34	comment_news	7	2024-12-12 05:11:36.291937+00	2024-12-12 05:11:36.291937+00
35	view_wiki_pages	7	2024-12-12 05:11:36.292866+00	2024-12-12 05:11:36.292866+00
36	view_project_attributes	7	2024-12-12 05:11:36.293773+00	2024-12-12 05:11:36.293773+00
37	show_board_views	7	2024-12-12 05:11:36.296616+00	2024-12-12 05:11:36.296616+00
38	share_calendars	7	2024-12-12 05:11:36.298685+00	2024-12-12 05:11:36.298685+00
39	show_github_content	7	2024-12-12 05:11:36.299626+00	2024-12-12 05:11:36.299626+00
40	view_file_links	7	2024-12-12 05:11:36.300471+00	2024-12-12 05:11:36.300471+00
41	view_project	7	2024-12-12 05:11:36.301169+00	2024-12-12 05:11:36.301169+00
42	search_project	7	2024-12-12 05:11:36.303315+00	2024-12-12 05:11:36.303315+00
43	view_news	7	2024-12-12 05:11:36.30426+00	2024-12-12 05:11:36.30426+00
44	view_messages	7	2024-12-12 05:11:36.304755+00	2024-12-12 05:11:36.304755+00
45	view_project_activity	7	2024-12-12 05:11:36.307822+00	2024-12-12 05:11:36.307822+00
46	view_work_packages	8	2024-12-12 05:11:36.328227+00	2024-12-12 05:11:36.328227+00
47	view_wiki_pages	8	2024-12-12 05:11:36.329309+00	2024-12-12 05:11:36.329309+00
48	view_project_attributes	8	2024-12-12 05:11:36.330099+00	2024-12-12 05:11:36.330099+00
49	view_file_links	8	2024-12-12 05:11:36.331322+00	2024-12-12 05:11:36.331322+00
50	view_project	8	2024-12-12 05:11:36.334948+00	2024-12-12 05:11:36.334948+00
51	search_project	8	2024-12-12 05:11:36.33577+00	2024-12-12 05:11:36.33577+00
52	view_news	8	2024-12-12 05:11:36.337024+00	2024-12-12 05:11:36.337024+00
53	view_messages	8	2024-12-12 05:11:36.337675+00	2024-12-12 05:11:36.337675+00
54	view_project_activity	8	2024-12-12 05:11:36.341078+00	2024-12-12 05:11:36.341078+00
55	view_work_packages	9	2024-12-12 05:11:36.404318+00	2024-12-12 05:11:36.404318+00
56	export_work_packages	9	2024-12-12 05:11:36.404996+00	2024-12-12 05:11:36.404996+00
57	add_work_packages	9	2024-12-12 05:11:36.407115+00	2024-12-12 05:11:36.407115+00
58	move_work_packages	9	2024-12-12 05:11:36.407878+00	2024-12-12 05:11:36.407878+00
59	edit_work_packages	9	2024-12-12 05:11:36.408307+00	2024-12-12 05:11:36.408307+00
60	assign_versions	9	2024-12-12 05:11:36.408881+00	2024-12-12 05:11:36.408881+00
61	work_package_assigned	9	2024-12-12 05:11:36.40986+00	2024-12-12 05:11:36.40986+00
62	add_work_package_notes	9	2024-12-12 05:11:36.410487+00	2024-12-12 05:11:36.410487+00
63	edit_own_work_package_notes	9	2024-12-12 05:11:36.410848+00	2024-12-12 05:11:36.410848+00
64	manage_work_package_relations	9	2024-12-12 05:11:36.411316+00	2024-12-12 05:11:36.411316+00
65	manage_subtasks	9	2024-12-12 05:11:36.411666+00	2024-12-12 05:11:36.411666+00
66	save_queries	9	2024-12-12 05:11:36.411984+00	2024-12-12 05:11:36.411984+00
67	view_work_package_watchers	9	2024-12-12 05:11:36.412418+00	2024-12-12 05:11:36.412418+00
68	add_work_package_watchers	9	2024-12-12 05:11:36.413242+00	2024-12-12 05:11:36.413242+00
69	delete_work_package_watchers	9	2024-12-12 05:11:36.413667+00	2024-12-12 05:11:36.413667+00
70	view_calendar	9	2024-12-12 05:11:36.414001+00	2024-12-12 05:11:36.414001+00
71	comment_news	9	2024-12-12 05:11:36.414316+00	2024-12-12 05:11:36.414316+00
72	manage_news	9	2024-12-12 05:11:36.414784+00	2024-12-12 05:11:36.414784+00
73	view_time_entries	9	2024-12-12 05:11:36.415102+00	2024-12-12 05:11:36.415102+00
74	view_own_time_entries	9	2024-12-12 05:11:36.41541+00	2024-12-12 05:11:36.41541+00
75	edit_own_time_entries	9	2024-12-12 05:11:36.415715+00	2024-12-12 05:11:36.415715+00
76	view_timelines	9	2024-12-12 05:11:36.416015+00	2024-12-12 05:11:36.416015+00
77	edit_timelines	9	2024-12-12 05:11:36.416308+00	2024-12-12 05:11:36.416308+00
78	delete_timelines	9	2024-12-12 05:11:36.416603+00	2024-12-12 05:11:36.416603+00
79	view_reportings	9	2024-12-12 05:11:36.417071+00	2024-12-12 05:11:36.417071+00
80	edit_reportings	9	2024-12-12 05:11:36.417462+00	2024-12-12 05:11:36.417462+00
81	delete_reportings	9	2024-12-12 05:11:36.41779+00	2024-12-12 05:11:36.41779+00
82	manage_wiki	9	2024-12-12 05:11:36.418102+00	2024-12-12 05:11:36.418102+00
83	rename_wiki_pages	9	2024-12-12 05:11:36.419344+00	2024-12-12 05:11:36.419344+00
84	change_wiki_parent_page	9	2024-12-12 05:11:36.42032+00	2024-12-12 05:11:36.42032+00
85	delete_wiki_pages	9	2024-12-12 05:11:36.420813+00	2024-12-12 05:11:36.420813+00
86	view_wiki_pages	9	2024-12-12 05:11:36.421876+00	2024-12-12 05:11:36.421876+00
87	export_wiki_pages	9	2024-12-12 05:11:36.422502+00	2024-12-12 05:11:36.422502+00
88	view_wiki_edits	9	2024-12-12 05:11:36.424848+00	2024-12-12 05:11:36.424848+00
89	edit_wiki_pages	9	2024-12-12 05:11:36.425279+00	2024-12-12 05:11:36.425279+00
90	delete_wiki_pages_attachments	9	2024-12-12 05:11:36.425801+00	2024-12-12 05:11:36.425801+00
91	protect_wiki_pages	9	2024-12-12 05:11:36.429476+00	2024-12-12 05:11:36.429476+00
92	list_attachments	9	2024-12-12 05:11:36.430235+00	2024-12-12 05:11:36.430235+00
93	add_messages	9	2024-12-12 05:11:36.430608+00	2024-12-12 05:11:36.430608+00
94	edit_own_messages	9	2024-12-12 05:11:36.430993+00	2024-12-12 05:11:36.430993+00
95	delete_own_messages	9	2024-12-12 05:11:36.431291+00	2024-12-12 05:11:36.431291+00
96	browse_repository	9	2024-12-12 05:11:36.431575+00	2024-12-12 05:11:36.431575+00
97	view_changesets	9	2024-12-12 05:11:36.431857+00	2024-12-12 05:11:36.431857+00
98	commit_access	9	2024-12-12 05:11:36.432186+00	2024-12-12 05:11:36.432186+00
99	view_commit_author_statistics	9	2024-12-12 05:11:36.433177+00	2024-12-12 05:11:36.433177+00
100	view_members	9	2024-12-12 05:11:36.433497+00	2024-12-12 05:11:36.433497+00
101	view_team_planner	9	2024-12-12 05:11:36.433976+00	2024-12-12 05:11:36.433976+00
102	view_shared_work_packages	9	2024-12-12 05:11:36.434296+00	2024-12-12 05:11:36.434296+00
103	copy_work_packages	9	2024-12-12 05:11:36.435227+00	2024-12-12 05:11:36.435227+00
104	add_work_package_attachments	9	2024-12-12 05:11:36.435547+00	2024-12-12 05:11:36.435547+00
105	view_project_attributes	9	2024-12-12 05:11:36.435818+00	2024-12-12 05:11:36.435818+00
106	view_master_backlog	9	2024-12-12 05:11:36.436085+00	2024-12-12 05:11:36.436085+00
107	view_taskboards	9	2024-12-12 05:11:36.436349+00	2024-12-12 05:11:36.436349+00
108	show_board_views	9	2024-12-12 05:11:36.437119+00	2024-12-12 05:11:36.437119+00
109	manage_public_queries	9	2024-12-12 05:11:36.43755+00	2024-12-12 05:11:36.43755+00
110	manage_board_views	9	2024-12-12 05:11:36.437841+00	2024-12-12 05:11:36.437841+00
111	share_calendars	9	2024-12-12 05:11:36.438105+00	2024-12-12 05:11:36.438105+00
112	view_cost_rates	9	2024-12-12 05:11:36.438366+00	2024-12-12 05:11:36.438366+00
113	log_own_costs	9	2024-12-12 05:11:36.438629+00	2024-12-12 05:11:36.438629+00
114	edit_own_cost_entries	9	2024-12-12 05:11:36.438888+00	2024-12-12 05:11:36.438888+00
115	view_budgets	9	2024-12-12 05:11:36.439373+00	2024-12-12 05:11:36.439373+00
116	view_own_cost_entries	9	2024-12-12 05:11:36.441219+00	2024-12-12 05:11:36.441219+00
117	log_own_time	9	2024-12-12 05:11:36.441592+00	2024-12-12 05:11:36.441592+00
118	save_cost_reports	9	2024-12-12 05:11:36.443072+00	2024-12-12 05:11:36.443072+00
119	save_private_cost_reports	9	2024-12-12 05:11:36.443693+00	2024-12-12 05:11:36.443693+00
120	view_documents	9	2024-12-12 05:11:36.444028+00	2024-12-12 05:11:36.444028+00
121	manage_documents	9	2024-12-12 05:11:36.444304+00	2024-12-12 05:11:36.444304+00
122	show_github_content	9	2024-12-12 05:11:36.444561+00	2024-12-12 05:11:36.444561+00
123	create_meetings	9	2024-12-12 05:11:36.444988+00	2024-12-12 05:11:36.444988+00
124	edit_meetings	9	2024-12-12 05:11:36.445665+00	2024-12-12 05:11:36.445665+00
125	delete_meetings	9	2024-12-12 05:11:36.446103+00	2024-12-12 05:11:36.446103+00
126	view_meetings	9	2024-12-12 05:11:36.446392+00	2024-12-12 05:11:36.446392+00
127	create_meeting_agendas	9	2024-12-12 05:11:36.44665+00	2024-12-12 05:11:36.44665+00
128	manage_agendas	9	2024-12-12 05:11:36.44751+00	2024-12-12 05:11:36.44751+00
129	close_meeting_agendas	9	2024-12-12 05:11:36.447792+00	2024-12-12 05:11:36.447792+00
130	send_meeting_agendas_notification	9	2024-12-12 05:11:36.448222+00	2024-12-12 05:11:36.448222+00
131	send_meeting_agendas_icalendar	9	2024-12-12 05:11:36.448778+00	2024-12-12 05:11:36.448778+00
132	create_meeting_minutes	9	2024-12-12 05:11:36.449129+00	2024-12-12 05:11:36.449129+00
133	send_meeting_minutes_notification	9	2024-12-12 05:11:36.449446+00	2024-12-12 05:11:36.449446+00
134	meetings_send_invite	9	2024-12-12 05:11:36.449732+00	2024-12-12 05:11:36.449732+00
135	view_file_links	9	2024-12-12 05:11:36.450005+00	2024-12-12 05:11:36.450005+00
136	manage_file_links	9	2024-12-12 05:11:36.45028+00	2024-12-12 05:11:36.45028+00
137	read_files	9	2024-12-12 05:11:36.450546+00	2024-12-12 05:11:36.450546+00
138	write_files	9	2024-12-12 05:11:36.450819+00	2024-12-12 05:11:36.450819+00
139	create_files	9	2024-12-12 05:11:36.4515+00	2024-12-12 05:11:36.4515+00
140	delete_files	9	2024-12-12 05:11:36.452085+00	2024-12-12 05:11:36.452085+00
141	share_files	9	2024-12-12 05:11:36.452486+00	2024-12-12 05:11:36.452486+00
142	view_project	9	2024-12-12 05:11:36.453332+00	2024-12-12 05:11:36.453332+00
143	search_project	9	2024-12-12 05:11:36.454561+00	2024-12-12 05:11:36.454561+00
144	view_news	9	2024-12-12 05:11:36.457069+00	2024-12-12 05:11:36.457069+00
145	view_messages	9	2024-12-12 05:11:36.457524+00	2024-12-12 05:11:36.457524+00
146	view_project_activity	9	2024-12-12 05:11:36.45811+00	2024-12-12 05:11:36.45811+00
147	view_work_packages	10	2024-12-12 05:11:36.487306+00	2024-12-12 05:11:36.487306+00
148	add_work_package_notes	10	2024-12-12 05:11:36.48825+00	2024-12-12 05:11:36.48825+00
149	edit_own_work_package_notes	10	2024-12-12 05:11:36.488642+00	2024-12-12 05:11:36.488642+00
150	save_queries	10	2024-12-12 05:11:36.490663+00	2024-12-12 05:11:36.490663+00
151	view_calendar	10	2024-12-12 05:11:36.492439+00	2024-12-12 05:11:36.492439+00
152	comment_news	10	2024-12-12 05:11:36.493361+00	2024-12-12 05:11:36.493361+00
153	view_timelines	10	2024-12-12 05:11:36.493913+00	2024-12-12 05:11:36.493913+00
154	view_reportings	10	2024-12-12 05:11:36.494261+00	2024-12-12 05:11:36.494261+00
155	view_wiki_pages	10	2024-12-12 05:11:36.494548+00	2024-12-12 05:11:36.494548+00
156	export_wiki_pages	10	2024-12-12 05:11:36.494853+00	2024-12-12 05:11:36.494853+00
157	list_attachments	10	2024-12-12 05:11:36.495154+00	2024-12-12 05:11:36.495154+00
158	add_messages	10	2024-12-12 05:11:36.495481+00	2024-12-12 05:11:36.495481+00
159	edit_own_messages	10	2024-12-12 05:11:36.495905+00	2024-12-12 05:11:36.495905+00
160	delete_own_messages	10	2024-12-12 05:11:36.496233+00	2024-12-12 05:11:36.496233+00
161	browse_repository	10	2024-12-12 05:11:36.496526+00	2024-12-12 05:11:36.496526+00
162	view_changesets	10	2024-12-12 05:11:36.496806+00	2024-12-12 05:11:36.496806+00
163	view_commit_author_statistics	10	2024-12-12 05:11:36.497119+00	2024-12-12 05:11:36.497119+00
164	view_team_planner	10	2024-12-12 05:11:36.497411+00	2024-12-12 05:11:36.497411+00
165	view_shared_work_packages	10	2024-12-12 05:11:36.497693+00	2024-12-12 05:11:36.497693+00
166	view_project_attributes	10	2024-12-12 05:11:36.497971+00	2024-12-12 05:11:36.497971+00
167	view_master_backlog	10	2024-12-12 05:11:36.498249+00	2024-12-12 05:11:36.498249+00
168	view_taskboards	10	2024-12-12 05:11:36.498526+00	2024-12-12 05:11:36.498526+00
169	show_board_views	10	2024-12-12 05:11:36.498806+00	2024-12-12 05:11:36.498806+00
170	share_calendars	10	2024-12-12 05:11:36.499083+00	2024-12-12 05:11:36.499083+00
171	view_documents	10	2024-12-12 05:11:36.499381+00	2024-12-12 05:11:36.499381+00
172	show_github_content	10	2024-12-12 05:11:36.499666+00	2024-12-12 05:11:36.499666+00
173	view_meetings	10	2024-12-12 05:11:36.499943+00	2024-12-12 05:11:36.499943+00
174	view_file_links	10	2024-12-12 05:11:36.500223+00	2024-12-12 05:11:36.500223+00
175	read_files	10	2024-12-12 05:11:36.5005+00	2024-12-12 05:11:36.5005+00
176	view_project	10	2024-12-12 05:11:36.500779+00	2024-12-12 05:11:36.500779+00
177	search_project	10	2024-12-12 05:11:36.501083+00	2024-12-12 05:11:36.501083+00
178	view_news	10	2024-12-12 05:11:36.501372+00	2024-12-12 05:11:36.501372+00
179	view_messages	10	2024-12-12 05:11:36.501652+00	2024-12-12 05:11:36.501652+00
180	view_project_activity	10	2024-12-12 05:11:36.50193+00	2024-12-12 05:11:36.50193+00
181	archive_project	11	2024-12-12 05:11:36.511534+00	2024-12-12 05:11:36.511534+00
182	edit_project	11	2024-12-12 05:11:36.511874+00	2024-12-12 05:11:36.511874+00
183	select_project_modules	11	2024-12-12 05:11:36.512245+00	2024-12-12 05:11:36.512245+00
184	view_project_attributes	11	2024-12-12 05:11:36.51265+00	2024-12-12 05:11:36.51265+00
185	edit_project_attributes	11	2024-12-12 05:11:36.512972+00	2024-12-12 05:11:36.512972+00
186	select_project_custom_fields	11	2024-12-12 05:11:36.513294+00	2024-12-12 05:11:36.513294+00
187	manage_members	11	2024-12-12 05:11:36.513602+00	2024-12-12 05:11:36.513602+00
188	view_members	11	2024-12-12 05:11:36.513901+00	2024-12-12 05:11:36.513901+00
189	manage_versions	11	2024-12-12 05:11:36.514188+00	2024-12-12 05:11:36.514188+00
190	manage_types	11	2024-12-12 05:11:36.514467+00	2024-12-12 05:11:36.514467+00
191	select_custom_fields	11	2024-12-12 05:11:36.514746+00	2024-12-12 05:11:36.514746+00
192	add_subprojects	11	2024-12-12 05:11:36.515025+00	2024-12-12 05:11:36.515025+00
193	copy_projects	11	2024-12-12 05:11:36.515304+00	2024-12-12 05:11:36.515304+00
194	view_work_packages	11	2024-12-12 05:11:36.515598+00	2024-12-12 05:11:36.515598+00
195	add_work_packages	11	2024-12-12 05:11:36.51589+00	2024-12-12 05:11:36.51589+00
196	edit_work_packages	11	2024-12-12 05:11:36.516168+00	2024-12-12 05:11:36.516168+00
197	move_work_packages	11	2024-12-12 05:11:36.516446+00	2024-12-12 05:11:36.516446+00
198	copy_work_packages	11	2024-12-12 05:11:36.516726+00	2024-12-12 05:11:36.516726+00
199	add_work_package_notes	11	2024-12-12 05:11:36.517049+00	2024-12-12 05:11:36.517049+00
200	edit_work_package_notes	11	2024-12-12 05:11:36.517364+00	2024-12-12 05:11:36.517364+00
201	edit_own_work_package_notes	11	2024-12-12 05:11:36.517741+00	2024-12-12 05:11:36.517741+00
202	add_work_package_attachments	11	2024-12-12 05:11:36.518062+00	2024-12-12 05:11:36.518062+00
203	manage_categories	11	2024-12-12 05:11:36.51836+00	2024-12-12 05:11:36.51836+00
204	export_work_packages	11	2024-12-12 05:11:36.518654+00	2024-12-12 05:11:36.518654+00
205	delete_work_packages	11	2024-12-12 05:11:36.518938+00	2024-12-12 05:11:36.518938+00
206	manage_work_package_relations	11	2024-12-12 05:11:36.519221+00	2024-12-12 05:11:36.519221+00
207	manage_subtasks	11	2024-12-12 05:11:36.519501+00	2024-12-12 05:11:36.519501+00
208	manage_public_queries	11	2024-12-12 05:11:36.51978+00	2024-12-12 05:11:36.51978+00
209	save_queries	11	2024-12-12 05:11:36.520057+00	2024-12-12 05:11:36.520057+00
210	view_work_package_watchers	11	2024-12-12 05:11:36.520333+00	2024-12-12 05:11:36.520333+00
211	add_work_package_watchers	11	2024-12-12 05:11:36.520609+00	2024-12-12 05:11:36.520609+00
212	delete_work_package_watchers	11	2024-12-12 05:11:36.520886+00	2024-12-12 05:11:36.520886+00
213	share_work_packages	11	2024-12-12 05:11:36.521215+00	2024-12-12 05:11:36.521215+00
214	view_shared_work_packages	11	2024-12-12 05:11:36.521516+00	2024-12-12 05:11:36.521516+00
215	assign_versions	11	2024-12-12 05:11:36.521815+00	2024-12-12 05:11:36.521815+00
216	change_work_package_status	11	2024-12-12 05:11:36.522112+00	2024-12-12 05:11:36.522112+00
217	work_package_assigned	11	2024-12-12 05:11:36.522407+00	2024-12-12 05:11:36.522407+00
218	manage_news	11	2024-12-12 05:11:36.5227+00	2024-12-12 05:11:36.5227+00
219	comment_news	11	2024-12-12 05:11:36.523008+00	2024-12-12 05:11:36.523008+00
220	view_wiki_pages	11	2024-12-12 05:11:36.523322+00	2024-12-12 05:11:36.523322+00
221	list_attachments	11	2024-12-12 05:11:36.523619+00	2024-12-12 05:11:36.523619+00
222	manage_wiki	11	2024-12-12 05:11:36.523908+00	2024-12-12 05:11:36.523908+00
223	manage_wiki_menu	11	2024-12-12 05:11:36.524201+00	2024-12-12 05:11:36.524201+00
224	rename_wiki_pages	11	2024-12-12 05:11:36.524483+00	2024-12-12 05:11:36.524483+00
225	change_wiki_parent_page	11	2024-12-12 05:11:36.524761+00	2024-12-12 05:11:36.524761+00
226	delete_wiki_pages	11	2024-12-12 05:11:36.52506+00	2024-12-12 05:11:36.52506+00
227	export_wiki_pages	11	2024-12-12 05:11:36.52537+00	2024-12-12 05:11:36.52537+00
228	view_wiki_edits	11	2024-12-12 05:11:36.52567+00	2024-12-12 05:11:36.52567+00
229	edit_wiki_pages	11	2024-12-12 05:11:36.525949+00	2024-12-12 05:11:36.525949+00
230	delete_wiki_pages_attachments	11	2024-12-12 05:11:36.526236+00	2024-12-12 05:11:36.526236+00
231	protect_wiki_pages	11	2024-12-12 05:11:36.5266+00	2024-12-12 05:11:36.5266+00
232	browse_repository	11	2024-12-12 05:11:36.527033+00	2024-12-12 05:11:36.527033+00
233	commit_access	11	2024-12-12 05:11:36.527468+00	2024-12-12 05:11:36.527468+00
234	manage_repository	11	2024-12-12 05:11:36.527949+00	2024-12-12 05:11:36.527949+00
235	view_changesets	11	2024-12-12 05:11:36.528354+00	2024-12-12 05:11:36.528354+00
236	view_commit_author_statistics	11	2024-12-12 05:11:36.528678+00	2024-12-12 05:11:36.528678+00
237	manage_forums	11	2024-12-12 05:11:36.529108+00	2024-12-12 05:11:36.529108+00
238	add_messages	11	2024-12-12 05:11:36.529446+00	2024-12-12 05:11:36.529446+00
239	edit_messages	11	2024-12-12 05:11:36.529735+00	2024-12-12 05:11:36.529735+00
240	edit_own_messages	11	2024-12-12 05:11:36.530014+00	2024-12-12 05:11:36.530014+00
241	delete_messages	11	2024-12-12 05:11:36.530294+00	2024-12-12 05:11:36.530294+00
242	delete_own_messages	11	2024-12-12 05:11:36.530604+00	2024-12-12 05:11:36.530604+00
243	view_documents	11	2024-12-12 05:11:36.530911+00	2024-12-12 05:11:36.530911+00
244	manage_documents	11	2024-12-12 05:11:36.531208+00	2024-12-12 05:11:36.531208+00
245	view_time_entries	11	2024-12-12 05:11:36.531508+00	2024-12-12 05:11:36.531508+00
246	view_own_time_entries	11	2024-12-12 05:11:36.531818+00	2024-12-12 05:11:36.531818+00
247	log_own_time	11	2024-12-12 05:11:36.532163+00	2024-12-12 05:11:36.532163+00
248	log_time	11	2024-12-12 05:11:36.532454+00	2024-12-12 05:11:36.532454+00
249	edit_own_time_entries	11	2024-12-12 05:11:36.532737+00	2024-12-12 05:11:36.532737+00
250	edit_time_entries	11	2024-12-12 05:11:36.533059+00	2024-12-12 05:11:36.533059+00
251	manage_project_activities	11	2024-12-12 05:11:36.533376+00	2024-12-12 05:11:36.533376+00
252	view_own_hourly_rate	11	2024-12-12 05:11:36.533691+00	2024-12-12 05:11:36.533691+00
253	view_hourly_rates	11	2024-12-12 05:11:36.533996+00	2024-12-12 05:11:36.533996+00
254	edit_own_hourly_rate	11	2024-12-12 05:11:36.534292+00	2024-12-12 05:11:36.534292+00
255	edit_hourly_rates	11	2024-12-12 05:11:36.534586+00	2024-12-12 05:11:36.534586+00
256	view_cost_rates	11	2024-12-12 05:11:36.534873+00	2024-12-12 05:11:36.534873+00
257	log_own_costs	11	2024-12-12 05:11:36.535151+00	2024-12-12 05:11:36.535151+00
258	log_costs	11	2024-12-12 05:11:36.535429+00	2024-12-12 05:11:36.535429+00
259	edit_own_cost_entries	11	2024-12-12 05:11:36.535708+00	2024-12-12 05:11:36.535708+00
260	edit_cost_entries	11	2024-12-12 05:11:36.536006+00	2024-12-12 05:11:36.536006+00
261	view_cost_entries	11	2024-12-12 05:11:36.536299+00	2024-12-12 05:11:36.536299+00
262	view_own_cost_entries	11	2024-12-12 05:11:36.536576+00	2024-12-12 05:11:36.536576+00
263	save_cost_reports	11	2024-12-12 05:11:36.536855+00	2024-12-12 05:11:36.536855+00
264	save_private_cost_reports	11	2024-12-12 05:11:36.537178+00	2024-12-12 05:11:36.537178+00
265	view_meetings	11	2024-12-12 05:11:36.537502+00	2024-12-12 05:11:36.537502+00
266	create_meetings	11	2024-12-12 05:11:36.537806+00	2024-12-12 05:11:36.537806+00
267	edit_meetings	11	2024-12-12 05:11:36.538102+00	2024-12-12 05:11:36.538102+00
268	delete_meetings	11	2024-12-12 05:11:36.538396+00	2024-12-12 05:11:36.538396+00
269	meetings_send_invite	11	2024-12-12 05:11:36.538696+00	2024-12-12 05:11:36.538696+00
270	create_meeting_agendas	11	2024-12-12 05:11:36.538978+00	2024-12-12 05:11:36.538978+00
271	manage_agendas	11	2024-12-12 05:11:36.539259+00	2024-12-12 05:11:36.539259+00
272	close_meeting_agendas	11	2024-12-12 05:11:36.539538+00	2024-12-12 05:11:36.539538+00
273	send_meeting_agendas_notification	11	2024-12-12 05:11:36.539827+00	2024-12-12 05:11:36.539827+00
274	send_meeting_agendas_icalendar	11	2024-12-12 05:11:36.540116+00	2024-12-12 05:11:36.540116+00
275	create_meeting_minutes	11	2024-12-12 05:11:36.540406+00	2024-12-12 05:11:36.540406+00
276	send_meeting_minutes_notification	11	2024-12-12 05:11:36.540687+00	2024-12-12 05:11:36.540687+00
277	view_master_backlog	11	2024-12-12 05:11:36.540977+00	2024-12-12 05:11:36.540977+00
278	view_taskboards	11	2024-12-12 05:11:36.541281+00	2024-12-12 05:11:36.541281+00
279	select_done_statuses	11	2024-12-12 05:11:36.541576+00	2024-12-12 05:11:36.541576+00
280	update_sprints	11	2024-12-12 05:11:36.541855+00	2024-12-12 05:11:36.541855+00
281	show_github_content	11	2024-12-12 05:11:36.542189+00	2024-12-12 05:11:36.542189+00
282	show_gitlab_content	11	2024-12-12 05:11:36.542595+00	2024-12-12 05:11:36.542595+00
283	show_board_views	11	2024-12-12 05:11:36.543018+00	2024-12-12 05:11:36.543018+00
284	manage_board_views	11	2024-12-12 05:11:36.543473+00	2024-12-12 05:11:36.543473+00
285	manage_overview	11	2024-12-12 05:11:36.543887+00	2024-12-12 05:11:36.543887+00
286	view_budgets	11	2024-12-12 05:11:36.544208+00	2024-12-12 05:11:36.544208+00
287	edit_budgets	11	2024-12-12 05:11:36.544499+00	2024-12-12 05:11:36.544499+00
288	view_team_planner	11	2024-12-12 05:11:36.544784+00	2024-12-12 05:11:36.544784+00
289	manage_team_planner	11	2024-12-12 05:11:36.545134+00	2024-12-12 05:11:36.545134+00
290	view_calendar	11	2024-12-12 05:11:36.545497+00	2024-12-12 05:11:36.545497+00
291	manage_calendars	11	2024-12-12 05:11:36.545918+00	2024-12-12 05:11:36.545918+00
292	share_calendars	11	2024-12-12 05:11:36.546241+00	2024-12-12 05:11:36.546241+00
293	manage_files_in_project	11	2024-12-12 05:11:36.546547+00	2024-12-12 05:11:36.546547+00
294	read_files	11	2024-12-12 05:11:36.546848+00	2024-12-12 05:11:36.546848+00
295	write_files	11	2024-12-12 05:11:36.547136+00	2024-12-12 05:11:36.547136+00
296	create_files	11	2024-12-12 05:11:36.547417+00	2024-12-12 05:11:36.547417+00
297	delete_files	11	2024-12-12 05:11:36.547696+00	2024-12-12 05:11:36.547696+00
298	share_files	11	2024-12-12 05:11:36.54799+00	2024-12-12 05:11:36.54799+00
299	view_file_links	11	2024-12-12 05:11:36.548326+00	2024-12-12 05:11:36.548326+00
300	manage_file_links	11	2024-12-12 05:11:36.54873+00	2024-12-12 05:11:36.54873+00
301	view_ifc_models	11	2024-12-12 05:11:36.549073+00	2024-12-12 05:11:36.549073+00
302	manage_ifc_models	11	2024-12-12 05:11:36.549389+00	2024-12-12 05:11:36.549389+00
303	view_linked_issues	11	2024-12-12 05:11:36.549705+00	2024-12-12 05:11:36.549705+00
304	manage_bcf	11	2024-12-12 05:11:36.550004+00	2024-12-12 05:11:36.550004+00
305	delete_bcf	11	2024-12-12 05:11:36.55029+00	2024-12-12 05:11:36.55029+00
306	save_bcf_queries	11	2024-12-12 05:11:36.550587+00	2024-12-12 05:11:36.550587+00
307	manage_public_bcf_queries	11	2024-12-12 05:11:36.550884+00	2024-12-12 05:11:36.550884+00
308	view_project	11	2024-12-12 05:11:36.551169+00	2024-12-12 05:11:36.551169+00
309	search_project	11	2024-12-12 05:11:36.551447+00	2024-12-12 05:11:36.551447+00
310	view_news	11	2024-12-12 05:11:36.551745+00	2024-12-12 05:11:36.551745+00
311	view_messages	11	2024-12-12 05:11:36.552042+00	2024-12-12 05:11:36.552042+00
312	view_project_activity	11	2024-12-12 05:11:36.552328+00	2024-12-12 05:11:36.552328+00
313	manage_overview	11	2024-12-12 05:11:43.344985+00	2024-12-12 05:11:43.344985+00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, "position", builtin, type, created_at, updated_at) FROM stdin;
1	Work package editor	1	5	WorkPackageRole	2024-12-12 05:11:12.990611+00	2024-12-12 05:11:12.990611+00
2	Work package commenter	2	4	WorkPackageRole	2024-12-12 05:11:13.021772+00	2024-12-12 05:11:13.021772+00
9	Member	3	0	ProjectRole	2024-12-12 05:11:36.391246+00	2024-12-12 05:11:36.391246+00
10	Reader	4	0	ProjectRole	2024-12-12 05:11:36.479515+00	2024-12-12 05:11:36.479515+00
3	Work package viewer	6	3	WorkPackageRole	2024-12-12 05:11:13.057359+00	2024-12-12 05:11:36.510547+00
4	Project query viewer	7	6	ProjectQueryRole	2024-12-12 05:11:13.610036+00	2024-12-12 05:11:36.510547+00
5	Project query editor	8	7	ProjectQueryRole	2024-12-12 05:11:13.619695+00	2024-12-12 05:11:36.510547+00
6	Standard global role	9	8	GlobalRole	2024-12-12 05:11:13.772283+00	2024-12-12 05:11:36.510547+00
7	Non member	10	1	ProjectRole	2024-12-12 05:11:36.250668+00	2024-12-12 05:11:36.510547+00
8	Anonymous	11	2	ProjectRole	2024-12-12 05:11:36.31999+00	2024-12-12 05:11:36.510547+00
11	Project admin	5	0	ProjectRole	2024-12-12 05:11:36.508405+00	2024-12-12 05:11:36.508405+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schema_migrations (version) FROM stdin;
10000000000000
20100528100562
20120214103300
20130214130336
20160331190036
20170703075208
20170705134348
20170818063404
20170829095701
20171023190036
20171106074835
20171129145631
20171218205557
20171219145752
20180105130053
20180108132929
20180116065518
20180117065255
20180122135443
20180123092002
20180125082205
20180213155320
20180221151038
20180305130811
20180323130704
20180323133404
20180323135408
20180323140208
20180323151208
20180419061910
20180504144320
20180510184732
20180518130559
20180524084654
20180524113516
20180706150714
20180717102331
20180801072018
20180830120550
20180903110212
20180924141838
20181101132712
20181112125034
20181118193730
20181121174153
20181214103300
20190124081710
20190129083842
20190205090102
20190207155607
20190220080647
20190227163226
20190301122554
20190312083304
20190411122815
20190502102512
20190507132517
20190509071101
20190527095959
20190603060951
20190618115620
20190619143049
20190710132957
20190716071941
20190719123448
20190722082648
20190724093332
20190823090211
20190826083604
20190905130336
20190920102446
20190923111902
20190923123858
20191029155327
20191106132533
20191112111040
20191114090353
20191115141154
20191119144123
20191121140202
20191216135213
20200114091135
20200115090742
20200123163818
20200206101135
20200217061622
20200217090016
20200217155632
20200220171133
20200302100431
20200310092237
20200325101528
20200326102408
20200327074416
20200403105252
20200415131633
20200420122713
20200420133116
20200422105623
20200427082928
20200427121606
20200428105404
20200504085933
20200522131255
20200522140244
20200527130633
20200610083854
20200610124259
20200625133727
20200708065116
20200803081038
20200807083950
20200807083952
20200810152654
20200820140526
20200903064009
20200907090753
20200914092212
20200924085508
20200925084550
20201001184404
20201005120137
20201005184411
20201105154216
20201125121949
20210126112238
20210127134438
20210214205545
20210219092709
20210221230446
20210310101840
20210331085058
20210407110000
20210427065703
20210510193438
20210512121322
20210519141244
20210521080035
20210615150558
20210616145324
20210616191052
20210618125430
20210618132206
20210628185054
20210701073944
20210701082511
20210713081724
20210726065912
20210726070813
20210802114054
20210825183540
20210902201126
20210910092414
20210914065555
20210915154656
20210917190141
20210922123908
20210928133538
20211005080304
20211005135637
20211011204301
20211015110000
20211015110001
20211015110002
20211022143726
20211026061420
20211101152840
20211102161932
20211103120946
20211104151329
20211117195121
20211118203332
20211130161501
20211209092519
20220106145037
20220113144323
20220113144759
20220121090847
20220202140507
20220223095355
20220302123642
20220319211253
20220323083000
20220408080838
20220414085531
20220426132637
20220428071221
20220503093844
20220511124930
20220517113828
20220518154147
20220525154549
20220608213712
20220614132200
20220615213015
20220620132922
20220622151721
20220629061540
20220629073727
20220707192304
20220712132505
20220712165928
20220714145356
20220804112533
20220811061024
20220815072420
20220817154403
20220818074150
20220818074159
20220830074821
20220830092057
20220831073113
20220831081937
20220909153412
20220911182835
20220918165443
20220922200908
20220926124435
20220929114423
20220930133418
20221017073431
20221017184204
20221018160449
20221026132134
20221027151959
20221028070534
20221029194419
20221115082403
20221122072857
20221129074635
20221130150352
20221201140825
20221202130039
20221213092910
20230105073117
20230105134940
20230123092649
20230130134630
20230306083203
20230309104056
20230314093106
20230314165213
20230315103437
20230315183431
20230315184533
20230316080525
20230321194150
20230322135932
20230328154645
20230420063148
20230420071113
20230421154500
20230502094813
20230508150835
20230512153303
20230517075214
20230531093004
20230601082746
20230606083221
20230607101213
20230608151123
20230613155001
20230622074222
20230627133534
20230713144232
20230717104700
20230718084649
20230721123022
20230725165505
20230726061920
20230726112130
20230731153909
20230802085026
20230803113215
20230808080001
20230808140921
20230810074642
20230816141222
20230823113310
20230824130730
20230829122717
20230829151629
20230905090205
20230905126002
20230911093530
20230911102918
20230912185647
20230918135247
20231002141527
20231003151656
20231005113307
20231009135807
20231012124745
20231013114720
20231017093339
20231020154219
20231024150429
20231025144701
20231026111049
20231027102747
20231031133334
20231105194747
20231109080454
20231119192222
20231123111357
20231128080650
20231201085450
20231205143648
20231208143303
20231212131603
20231227100753
20240104172050
20240115112549
20240116165933
20240123151246
20240123151247
20240123151248
20240123151249
20240123151250
20240123151251
20240123151252
20240131130134
20240131130149
20240201115019
20240206085104
20240206173841
20240207075946
20240208100316
20240222155909
20240227154544
20240229133250
20240306083241
20240306154734
20240306154735
20240306154736
20240306154737
20240307094432
20240307102541
20240307190126
20240311111957
20240313102951
20240325150312
20240328154805
20240402065214
20240402072213
20240404074025
20240405131352
20240405135016
20240408093541
20240408132459
20240408161233
20240410060041
20240418110249
20240422141623
20240424093311
20240424160513
20240430143313
20240501083852
20240501093751
20240502081436
20240506091102
20240513135928
20240516102219
20240519123921
20240522073759
20240527070439
20240610130953
20240611105232
20240620115412
20240624103354
20240625075139
20240703131639
20240715183144
20240801105918
20240805104004
20240806144333
20240808125617
20240808133947
20240813131647
20240820123011
20240821121856
20240829140616
20240909151818
20240917105829
20240920152544
20240924114246
20240930122522
20241001205821
20241002151949
20241015081341
20241025072902
20241030154245
20241120103858
20241121094113
20241125104347
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, session_id, data, updated_at, user_id) FROM stdin;
43	2::1fac772cf0bb545b93763a352ac8497896f452a0ed47114727b5680dcf620776	BAh7AA==\n	2024-12-12 06:34:09.519684+00	\N
44	2::817dd712515ec99bb44e7a08ac54ef797181463947a73db3f9194c9f827112fc	BAh7AA==\n	2024-12-12 06:34:09.573857+00	\N
45	2::1953a2334d4e03c3cbbf0dfcdb14886e16907152afed7cf6576b435f50579e1d	BAh7AA==\n	2024-12-12 06:34:09.586369+00	\N
46	2::cc7607efd59fec5ca24fef0062b4f282556ee3c1fc858693278ff8712eb55395	BAh7AA==\n	2024-12-12 06:34:09.599798+00	\N
47	2::f82b70c25fd0a174f1206ad505afcb6aafcec637a816bdce31ff6b9367237c53	BAh7AA==\n	2024-12-12 06:34:09.616768+00	\N
48	2::03ddfd91b2c46575d1c8fffe049ed04020d16f84c2c31f1245d6058e3b011fac	BAh7AA==\n	2024-12-12 06:34:09.63424+00	\N
49	2::8265cd9dab708b68f873aa0334355e165238654fd3750dc148e0700303896f10	BAh7AA==\n	2024-12-12 06:34:09.642771+00	\N
50	2::a990ec2cbd9935f20541e4b516db391586958b36c348b20e6f4a54a3ec460fdc	BAh7AA==\n	2024-12-12 06:34:09.65123+00	\N
51	2::84439a196954cbee5646db181bbaf1aab5ccb5ee4dbc6be266a3aca531de0f60	BAh7AA==\n	2024-12-12 06:34:09.661384+00	\N
52	2::c5b7c747b352382333de89121f37d3c353b89b3780e66ab1e77df3a32e8ab985	BAh7AA==\n	2024-12-12 06:34:09.671668+00	\N
53	2::5af100dcac304a89587b8958550a659faf99974b16a7563c0000b1a51dfdc5a0	BAh7AA==\n	2024-12-12 06:34:09.679867+00	\N
54	2::81fd14318521bc4ec5a8cef2d3fa946e46611537f4adc07d7558de5197920615	BAh7AA==\n	2024-12-12 06:34:09.690998+00	\N
55	2::fc230efc3315921252ef2eee77f25d8c7ab70f614b63ac3675850a8a6993d9ec	BAh7AA==\n	2024-12-12 06:34:09.702273+00	\N
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (id, name, value, updated_at) FROM stdin;
1	working_days	---\n- 1\n- 2\n- 3\n- 4\n- 5\n	2024-12-12 05:11:04.772445+00
2	lookbook_enabled	f	2024-12-12 05:11:37.880069+00
3	additional_host_names	[]	2024-12-12 05:11:37.886768+00
4	fog	{}	2024-12-12 05:11:37.892274+00
5	feature_primerized_work_package_activities_active	f	2024-12-12 05:11:37.897964+00
6	feature_built_in_oauth_applications_active	f	2024-12-12 05:11:37.90108+00
7	feature_generate_pdf_from_work_package_active	f	2024-12-12 05:11:37.904127+00
8	feature_stages_and_gates_active	f	2024-12-12 05:11:37.907995+00
9	session_cookie_name	_open_project_session	2024-12-12 05:11:37.910704+00
10	plugin_openproject_auth_saml	---\nproviders:\n	2024-12-12 05:11:37.919025+00
11	costs_currency	EUR	2024-12-12 05:11:37.921763+00
12	costs_currency_format	%n %u	2024-12-12 05:11:37.924927+00
13	allow_tracking_start_and_end_times	f	2024-12-12 05:11:37.92834+00
14	enforce_tracking_start_and_end_times	f	2024-12-12 05:11:37.931203+00
15	feature_track_start_and_end_times_for_time_entries_active	f	2024-12-12 05:11:37.933898+00
16	cost_reporting_cache_filter_classes	true	2024-12-12 05:11:37.936636+00
18	plugin_openproject_avatars	---\nenable_gravatars: true\nenable_local_avatars: true\n	2024-12-12 05:11:37.950197+00
19	plugin_openproject_two_factor_authentication	---\nactive_strategies:\n- :totp\n- :webauthn\nenforced: false\nallow_remember_for_days: 0\n	2024-12-12 05:11:37.956814+00
20	feature_deploy_targets_active	f	2024-12-12 05:11:37.959868+00
21	plugin_openproject_github_integration	---\ngithub_user_id:\n	2024-12-12 05:11:37.965687+00
22	plugin_openproject_ldap_groups	{}	2024-12-12 05:11:37.970983+00
23	plugin_openproject_recaptcha	---\nrecaptcha_type: disabled\nresponse_limit: 5000\n	2024-12-12 05:11:37.97723+00
24	recaptcha_via_hcaptcha	f	2024-12-12 05:11:37.980375+00
25	ical_enabled	true	2024-12-12 05:11:37.983065+00
26	feature_storage_file_picking_select_all_active	f	2024-12-12 05:11:37.98612+00
27	plugin_openproject_bim	{}	2024-12-12 05:11:37.98879+00
28	available_languages	---\n- ca\n- cs\n- de\n- el\n- en\n- es\n- fr\n- hu\n- id\n- it\n- ja\n- ko\n- lt\n- nl\n- 'no'\n- pl\n- pt-BR\n- pt-PT\n- ro\n- ru\n- sk\n- sl\n- sv\n- tr\n- uk\n- vi\n- zh-CN\n- zh-TW\n	2024-12-12 05:11:37.995465+00
29	rate_limiting	{}	2024-12-12 05:11:37.998355+00
30	activity_days_default	30	2024-12-12 05:11:38.001723+00
31	apiv3_cors_enabled	f	2024-12-12 05:11:38.004623+00
32	apiv3_cors_origins	[]	2024-12-12 05:11:38.008452+00
33	apiv3_docs_enabled	true	2024-12-12 05:11:38.011938+00
34	apiv3_enable_basic_auth	true	2024-12-12 05:11:38.014822+00
35	apiv3_max_page_size	1000	2024-12-12 05:11:38.017654+00
36	apiv3_write_readonly_attributes	f	2024-12-12 05:11:38.021094+00
37	app_title	OpenProject	2024-12-12 05:11:38.023878+00
38	attachment_max_size	5120	2024-12-12 05:11:38.027288+00
39	attachment_whitelist	[]	2024-12-12 05:11:38.03001+00
40	attachments_grace_period	180	2024-12-12 05:11:38.032874+00
41	antivirus_scan_mode	disabled	2024-12-12 05:11:38.035469+00
42	antivirus_scan_action	quarantine	2024-12-12 05:11:38.049998+00
43	autofetch_changesets	true	2024-12-12 05:11:38.052156+00
44	autologin	0	2024-12-12 05:11:38.054348+00
45	autologin_cookie_name	autologin	2024-12-12 05:11:38.056433+00
46	autologin_cookie_path	/	2024-12-12 05:11:38.058881+00
47	avatar_link_expiry_seconds	86400	2024-12-12 05:11:38.061736+00
48	backup_enabled	true	2024-12-12 05:11:38.064169+00
49	backup_daily_limit	3	2024-12-12 05:11:38.066725+00
50	backup_initial_waiting_period	86400	2024-12-12 05:11:38.070307+00
51	backup_include_attachments	true	2024-12-12 05:11:38.072784+00
52	backup_attachment_size_max_sum_mb	1024	2024-12-12 05:11:38.075409+00
53	bcc_recipients	true	2024-12-12 05:11:38.078271+00
55	brute_force_block_minutes	30	2024-12-12 05:11:38.083537+00
56	brute_force_block_after_failed_logins	20	2024-12-12 05:11:38.087236+00
57	cache_formatted_text	true	2024-12-12 05:11:38.090382+00
58	total_percent_complete_mode	work_weighted_average	2024-12-12 05:11:38.093558+00
59	commit_fix_keywords	fixes,closes	2024-12-12 05:11:38.096321+00
60	commit_logs_encoding	UTF-8	2024-12-12 05:11:38.099191+00
61	commit_logtime_enabled	f	2024-12-12 05:11:38.102011+00
62	commit_ref_keywords	refs,references,IssueID	2024-12-12 05:11:38.108112+00
63	consent_info	---\nen: |-\n  ## Consent\n\n  You need to agree to the [privacy and security policy](https://www.openproject.org/data-privacy-and-security/) of this OpenProject instance.\n	2024-12-12 05:11:38.114546+00
64	consent_required	f	2024-12-12 05:11:38.118485+00
65	cross_project_work_package_relations	true	2024-12-12 05:11:38.122886+00
66	days_per_month	20	2024-12-12 05:11:38.125907+00
67	default_auto_hide_popups	true	2024-12-12 05:11:38.128664+00
68	default_comment_sort_order	asc	2024-12-12 05:11:38.131278+00
69	default_projects_modules	---\n- calendar\n- board_view\n- work_package_tracking\n- gantt\n- news\n- costs\n- wiki\n- reporting_module\n- meetings\n- backlogs\n	2024-12-12 05:11:38.137245+00
70	default_projects_public	f	2024-12-12 05:11:38.139911+00
75	development_highlight_enabled	f	2024-12-12 05:11:38.152506+00
76	diff_max_lines_displayed	1500	2024-12-12 05:11:38.154797+00
77	disable_password_choice	f	2024-12-12 05:11:38.157055+00
78	disable_password_login	f	2024-12-12 05:11:38.159528+00
79	display_subprojects_work_packages	true	2024-12-12 05:11:38.162863+00
80	drop_old_sessions_on_logout	true	2024-12-12 05:11:38.165196+00
81	drop_old_sessions_on_login	f	2024-12-12 05:11:38.167637+00
82	duration_format	hours_only	2024-12-12 05:11:38.170149+00
83	emails_salutation	firstname	2024-12-12 05:11:38.172933+00
84	emails_footer	---\nen: ''\n	2024-12-12 05:11:38.180323+00
85	emails_header	---\nen: ''\n	2024-12-12 05:11:38.191252+00
86	email_login	f	2024-12-12 05:11:38.194812+00
87	enabled_projects_columns	---\n- favored\n- name\n- project_status\n- public\n- created_at\n- latest_activity_at\n- required_disk_space\n	2024-12-12 05:11:38.200403+00
88	enabled_scm	---\n- subversion\n- git\n	2024-12-12 05:11:38.206082+00
89	feeds_enabled	true	2024-12-12 05:11:38.208723+00
90	feeds_limit	15	2024-12-12 05:11:38.211785+00
91	file_max_size_displayed	512	2024-12-12 05:11:38.214738+00
92	fog_download_url_expires_in	21600	2024-12-12 05:11:38.217268+00
93	forced_single_page_size	250	2024-12-12 05:11:38.219853+00
94	hours_per_day	8	2024-12-12 05:11:38.223495+00
95	health_checks_jobs_never_ran_minutes_ago	5	2024-12-12 05:11:38.226282+00
96	health_checks_backlog_threshold	20	2024-12-12 05:11:38.229446+00
97	gravatar_fallback_image	404	2024-12-12 05:11:38.232079+00
98	internal_password_confirmation	true	2024-12-12 05:11:38.235347+00
99	invitation_expiration_days	7	2024-12-12 05:11:38.238406+00
100	journal_aggregation_time_minutes	5	2024-12-12 05:11:38.241322+00
101	ldap_groups_disable_sync_job	f	2024-12-12 05:11:38.244212+00
102	ldap_users_disable_sync_job	f	2024-12-12 05:11:38.246874+00
103	ldap_users_sync_status	f	2024-12-12 05:11:38.249633+00
104	log_requesting_user	f	2024-12-12 05:11:38.252245+00
105	login_required	true	2024-12-12 05:11:38.256349+00
106	lost_password	true	2024-12-12 05:11:38.259103+00
107	mail_from	openproject@example.net	2024-12-12 05:11:38.261912+00
108	mail_handler_body_delimiters		2024-12-12 05:11:38.264733+00
109	mail_handler_body_delimiter_regex		2024-12-12 05:11:38.267399+00
110	mail_handler_ignore_filenames	signature.asc	2024-12-12 05:11:38.27001+00
111	mail_suffix_separators	+	2024-12-12 05:11:38.272612+00
112	notifications_hidden	f	2024-12-12 05:11:38.275212+00
113	notifications_polling_interval	60000	2024-12-12 05:11:38.27911+00
114	oauth_allow_remapping_of_existing_users	true	2024-12-12 05:11:38.281896+00
115	onboarding_video_url	https://player.vimeo.com/video/163426858?autoplay=1	2024-12-12 05:11:38.284484+00
116	onboarding_enabled	true	2024-12-12 05:11:38.288006+00
117	password_active_rules	---\n- lowercase\n- uppercase\n- numeric\n- special\n	2024-12-12 05:11:38.293765+00
118	password_count_former_banned	0	2024-12-12 05:11:38.296965+00
119	password_days_valid	0	2024-12-12 05:11:38.300317+00
120	password_min_length	10	2024-12-12 05:11:38.304766+00
121	password_min_adhered_rules	0	2024-12-12 05:11:38.313341+00
122	per_page_options	20, 100	2024-12-12 05:11:38.318717+00
123	percent_complete_on_status_closed	no_change	2024-12-12 05:11:38.321285+00
124	plain_text_mail	f	2024-12-12 05:11:38.323934+00
125	show_work_package_attachments	true	2024-12-12 05:11:38.327017+00
126	registration_footer	---\nen: ''\n	2024-12-12 05:11:38.336339+00
127	report_incoming_email_errors	true	2024-12-12 05:11:38.339491+00
128	repository_checkout_data	---\ngit:\n  enabled: 0\nsubversion:\n  enabled: 0\n	2024-12-12 05:11:38.345212+00
129	repository_log_display_limit	100	2024-12-12 05:11:38.348162+00
130	repository_storage_cache_minutes	720	2024-12-12 05:11:38.350791+00
131	repository_truncate_at	500	2024-12-12 05:11:38.35341+00
132	rest_api_enabled	true	2024-12-12 05:11:38.356044+00
133	security_badge_displayed	true	2024-12-12 05:11:38.358677+00
134	self_registration	2	2024-12-12 05:11:38.361654+00
135	sendmail_arguments	-i	2024-12-12 05:11:38.364378+00
136	sendmail_location	/usr/sbin/sendmail	2024-12-12 05:11:38.366995+00
137	session_ttl_enabled	f	2024-12-12 05:11:38.369672+00
138	session_ttl	120	2024-12-12 05:11:38.372311+00
139	show_community_links	true	2024-12-12 05:11:38.374977+00
140	show_product_version	true	2024-12-12 05:11:38.37832+00
141	show_setting_mismatch_warning	true	2024-12-12 05:11:38.381116+00
142	show_storage_information	true	2024-12-12 05:11:38.383736+00
143	show_warning_bars	true	2024-12-12 05:11:38.386549+00
144	smtp_authentication	plain	2024-12-12 05:11:38.389192+00
145	smtp_enable_starttls_auto	f	2024-12-12 05:11:38.391828+00
146	smtp_ssl	f	2024-12-12 05:11:38.394941+00
147	smtp_address		2024-12-12 05:11:38.39781+00
148	smtp_domain	your.domain.com	2024-12-12 05:11:38.400577+00
149	smtp_user_name		2024-12-12 05:11:38.403236+00
150	smtp_port	587	2024-12-12 05:11:38.405982+00
151	smtp_password		2024-12-12 05:11:38.408636+00
152	smtp_timeout	5	2024-12-12 05:11:38.411703+00
153	software_name	OpenProject	2024-12-12 05:11:38.415349+00
154	software_url	https://www.openproject.org/	2024-12-12 05:11:38.41806+00
155	sys_api_enabled	f	2024-12-12 05:11:38.420766+00
156	users_deletable_by_admins	f	2024-12-12 05:11:38.42345+00
157	user_default_theme	light	2024-12-12 05:11:38.426477+00
158	users_deletable_by_self	f	2024-12-12 05:11:38.429312+00
159	user_format	firstname_lastname	2024-12-12 05:11:38.432246+00
161	work_package_done_ratio	field	2024-12-12 05:11:38.437766+00
162	work_packages_projects_export_limit	500	2024-12-12 05:11:38.440504+00
163	work_packages_bulk_request_limit	10	2024-12-12 05:11:38.44351+00
164	work_package_list_default_highlighted_attributes	---\n- status\n- priority\n- due_date\n	2024-12-12 05:11:38.449983+00
165	work_package_list_default_columns	---\n- id\n- subject\n- type\n- status\n- assigned_to\n- priority\n	2024-12-12 05:11:38.455903+00
166	work_package_startdate_is_adddate	f	2024-12-12 05:11:38.45878+00
167	youtube_channel	https://www.youtube.com/c/OpenProjectCommunity	2024-12-12 05:11:38.461883+00
168	new_project_user_role_id	11	2024-12-12 05:11:38.465081+00
169	commit_fix_status_id	12	2024-12-12 05:11:38.467986+00
170	default_language	en	2024-12-12 05:11:38.470342+00
17	plugin_openproject_backlogs	---\nstory_types:\n- 4\n- 5\n- 6\n- 7\ntask_type: 1\npoints_burn_direction: up\nwiki_template: ''\n	2024-12-12 05:11:38.496858+00
171	welcome_title	Welcome to OpenProject!	2024-12-12 05:11:38.811573+00
172	welcome_text	OpenProject is the leading open source project management software. It supports classic, agile as well as hybrid project management and gives you full control over your data.\n\nCore features and use cases:\n\n* [Project Portfolio Management](https://www.openproject.org/collaboration-software-features/project-portfolio-management/)\n* [Project Planning and Scheduling](https://www.openproject.org/collaboration-software-features/project-planning-scheduling/)\n* [Task Management and Issue Tracking](https://www.openproject.org/collaboration-software-features/task-management/)\n* [Agile Boards (Scrum and Kanban)](https://www.openproject.org/collaboration-software-features/agile-project-management/)\n* [Requirements Management and Release Planning](https://www.openproject.org/collaboration-software-features/product-development/)\n* [Time and Cost Tracking, Budgets](https://www.openproject.org/collaboration-software-features/time-tracking/)\n* [Team Collaboration and Documentation](https://www.openproject.org/collaboration-software-features/team-collaboration/)\n\nWelcome to the future of project management.\n\nFor Admins: You can change this welcome text [here]({{opSetting:base_url}}/admin/settings/general).\n	2024-12-12 05:11:38.814651+00
160	welcome_on_homescreen	1	2024-12-12 05:11:38.818135+00
74	demo_view_of_type_gantt_seeded	true	2024-12-12 05:11:39.341273+00
72	demo_view_of_type_work_packages_table_seeded	true	2024-12-12 05:11:39.382363+00
73	demo_view_of_type_team_planner_seeded	true	2024-12-12 05:11:39.440967+00
54	boards_demo_data_available	true	2024-12-12 05:11:40.502284+00
71	demo_projects_available	true	2024-12-12 05:11:40.913306+00
173	installation_uuid	cadf990b-6443-43a5-9234-acddc27df5b9	2024-12-12 05:25:15.524738+00
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.statuses (id, name, is_closed, is_default, "position", default_done_ratio, created_at, updated_at, color_id, is_readonly, excluded_from_totals) FROM stdin;
1	New	f	t	1	0	2024-12-12 05:11:36.813728+00	2024-12-12 05:11:36.813728+00	92	f	f
2	In specification	f	f	2	10	2024-12-12 05:11:36.819594+00	2024-12-12 05:11:36.819594+00	77	f	f
3	Specified	f	f	3	20	2024-12-12 05:11:36.825753+00	2024-12-12 05:11:36.825753+00	77	f	f
4	Confirmed	f	f	4	20	2024-12-12 05:11:36.831115+00	2024-12-12 05:11:36.831115+00	57	f	f
5	To be scheduled	f	f	5	20	2024-12-12 05:11:36.836058+00	2024-12-12 05:11:36.836058+00	127	f	f
6	Scheduled	f	f	6	20	2024-12-12 05:11:36.84121+00	2024-12-12 05:11:36.84121+00	117	f	f
7	In progress	f	f	7	40	2024-12-12 05:11:36.847439+00	2024-12-12 05:11:36.847439+00	50	f	f
8	Developed	f	f	8	70	2024-12-12 05:11:36.852389+00	2024-12-12 05:11:36.852389+00	108	f	f
9	In testing	f	f	9	80	2024-12-12 05:11:36.857705+00	2024-12-12 05:11:36.857705+00	90	f	f
10	Tested	f	f	10	90	2024-12-12 05:11:36.864135+00	2024-12-12 05:11:36.864135+00	101	f	f
11	Test failed	f	f	11	70	2024-12-12 05:11:36.868958+00	2024-12-12 05:11:36.868958+00	30	f	f
12	Closed	t	f	12	100	2024-12-12 05:11:36.874058+00	2024-12-12 05:11:36.874058+00	18	f	f
13	On hold	f	f	13	0	2024-12-12 05:11:36.879331+00	2024-12-12 05:11:36.879331+00	138	f	f
14	Rejected	t	f	14	0	2024-12-12 05:11:36.885999+00	2024-12-12 05:11:36.885999+00	28	f	f
\.


--
-- Data for Name: storages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.storages (id, provider_type, name, host, creator_id, created_at, updated_at, provider_fields, health_status, health_changed_at, health_reason, health_checked_at) FROM stdin;
\.


--
-- Data for Name: storages_file_links_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.storages_file_links_journals (id, journal_id, file_link_id, link_name, storage_name) FROM stdin;
\.


--
-- Data for Name: time_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.time_entries (id, project_id, user_id, work_package_id, hours, comments, activity_id, spent_on, tyear, tmonth, tweek, created_at, updated_at, overridden_costs, costs, rate_id, logged_by_id, ongoing, start_time, time_zone) FROM stdin;
\.


--
-- Data for Name: time_entry_activities_projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.time_entry_activities_projects (id, activity_id, project_id, active) FROM stdin;
\.


--
-- Data for Name: time_entry_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.time_entry_journals (id, project_id, user_id, work_package_id, hours, comments, activity_id, spent_on, tyear, tmonth, tweek, overridden_costs, costs, rate_id, logged_by_id, start_time, time_zone) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tokens (id, user_id, type, value, created_at, expires_on, data) FROM stdin;
68	4	Token::RSS	149102a6a0b4ab86df4e2ae50762a07dafb9273a71dd91d699bcf524a1418d54	2024-12-12 05:33:24.63857+00	\N	\N
\.


--
-- Data for Name: two_factor_authentication_devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.two_factor_authentication_devices (id, type, "default", active, channel, phone_number, identifier, created_at, updated_at, last_used_at, otp_secret, user_id, webauthn_external_id, webauthn_public_key, webauthn_sign_count) FROM stdin;
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.types (id, name, "position", is_in_roadmap, is_milestone, is_default, color_id, created_at, updated_at, is_standard, attribute_groups, description) FROM stdin;
1	Task	1	t	f	t	2	2024-12-12 05:11:36.901006+00	2024-12-12 05:11:36.901006+00	f	\N	
2	Milestone	2	f	t	t	4	2024-12-12 05:11:36.90639+00	2024-12-12 05:11:36.90639+00	f	\N	
3	Phase	3	f	f	t	140	2024-12-12 05:11:36.911777+00	2024-12-12 05:11:36.911777+00	f	\N	
4	Feature	4	t	f	f	70	2024-12-12 05:11:36.916377+00	2024-12-12 05:11:36.916377+00	f	\N	
5	Epic	5	t	f	f	60	2024-12-12 05:11:36.920445+00	2024-12-12 05:11:36.920445+00	f	\N	
6	User story	6	t	f	f	3	2024-12-12 05:11:36.924687+00	2024-12-12 05:11:36.924687+00	f	\N	
7	Bug	7	t	f	f	32	2024-12-12 05:11:36.929406+00	2024-12-12 05:11:36.929406+00	f	\N	
\.


--
-- Data for Name: user_passwords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_passwords (id, user_id, hashed_password, salt, created_at, updated_at, type) FROM stdin;
2	4	$2a$12$0zAlqud9QLGpaweNQbqX5OlXf1ZvEBw9mJMcZClf.ZBZIobh.OFjG	\N	2024-12-12 05:25:14.981866+00	2024-12-12 05:25:14.981866+00	UserPassword::Bcrypt
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_preferences (id, user_id, settings, created_at, updated_at) FROM stdin;
1	4	{"backlogs_task_color": "#7FDCFD", "backlogs_versions_default_fold_state": "open"}	2024-12-12 05:11:13.657993+00	2024-12-12 05:33:53.098871+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, login, firstname, lastname, mail, admin, status, last_login_on, language, ldap_auth_source_id, created_at, updated_at, type, identity_url, first_login, force_password_change, failed_login_count, last_failed_login_on, consented_at, webauthn_id) FROM stdin;
2					f	3	\N		\N	2024-12-12 05:11:03.287698+00	2024-12-12 05:11:03.287698+00	DeletedUser	\N	t	f	0	\N	\N	\N
1			System		t	1	\N		\N	2024-12-12 05:11:02.715041+00	2024-12-12 05:11:02.715041+00	SystemUser	\N	f	f	0	\N	\N	\N
3			Anonymous		f	1	\N		\N	2024-12-12 05:11:36.175787+00	2024-12-12 05:11:36.175787+00	AnonymousUser	\N	t	f	0	\N	\N	\N
4	admin	OpenProject	Admin	admin@example.net	t	1	2024-12-12 05:25:15.410612+00	en	\N	2024-12-12 05:11:38.547071+00	2024-12-12 05:25:15.41561+00	User	\N	f	f	0	2024-12-12 05:24:51.087099+00	\N	\N
\.


--
-- Data for Name: version_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.version_settings (id, project_id, version_id, display, created_at, updated_at) FROM stdin;
1	2	1	3	2024-12-12 05:11:41.128922+00	2024-12-12 05:11:41.128922+00
2	2	2	3	2024-12-12 05:11:41.131594+00	2024-12-12 05:11:41.131594+00
3	2	3	2	2024-12-12 05:11:41.133+00	2024-12-12 05:11:41.133+00
4	2	4	2	2024-12-12 05:11:41.134329+00	2024-12-12 05:11:41.134329+00
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.versions (id, project_id, name, description, effective_date, created_at, updated_at, wiki_page_title, status, sharing, start_date) FROM stdin;
1	2	Bug Backlog		\N	2024-12-12 05:11:41.062376+00	2024-12-12 05:11:41.062376+00	\N	open	none	\N
2	2	Product Backlog		\N	2024-12-12 05:11:41.07407+00	2024-12-12 05:11:41.07407+00	\N	open	none	\N
3	2	Sprint 1		\N	2024-12-12 05:11:41.077038+00	2024-12-12 05:11:41.11422+00	Sprint 1	open	none	\N
4	2	Sprint 2		\N	2024-12-12 05:11:41.117333+00	2024-12-12 05:11:41.117333+00	\N	open	none	\N
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.views (id, query_id, options, type, created_at, updated_at) FROM stdin;
1	1	{}	gantt	2024-12-12 05:11:39.338651+00	2024-12-12 05:11:39.338651+00
2	2	{}	work_packages_table	2024-12-12 05:11:39.380654+00	2024-12-12 05:11:39.380654+00
3	3	{}	work_packages_table	2024-12-12 05:11:39.416465+00	2024-12-12 05:11:39.416465+00
4	4	{}	team_planner	2024-12-12 05:11:39.43782+00	2024-12-12 05:11:39.43782+00
5	15	{}	gantt	2024-12-12 05:11:41.163729+00	2024-12-12 05:11:41.163729+00
6	16	{}	work_packages_table	2024-12-12 05:11:41.202766+00	2024-12-12 05:11:41.202766+00
7	17	{}	work_packages_table	2024-12-12 05:11:41.230921+00	2024-12-12 05:11:41.230921+00
8	18	{}	work_packages_table	2024-12-12 05:11:41.24659+00	2024-12-12 05:11:41.24659+00
\.


--
-- Data for Name: watchers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.watchers (id, watchable_type, watchable_id, user_id) FROM stdin;
1	News	1	4
2	Meeting	1	4
3	News	2	4
\.


--
-- Data for Name: webhooks_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhooks_events (id, name, webhooks_webhook_id) FROM stdin;
\.


--
-- Data for Name: webhooks_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhooks_logs (id, webhooks_webhook_id, event_name, url, request_headers, request_body, response_code, response_headers, response_body, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webhooks_projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhooks_projects (id, project_id, webhooks_webhook_id) FROM stdin;
\.


--
-- Data for Name: webhooks_webhooks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhooks_webhooks (id, name, url, description, secret, enabled, all_projects, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wiki_page_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wiki_page_journals (id, author_id, text) FROM stdin;
1	4	_In this wiki you can collaboratively create and edit pages and sub-pages to create a project wiki._\n\n**You can:**\n\n* Insert text and images, also with copy and paste from other documents\n* Create a page hierarchy with parent pages\n* Include wiki pages to the project menu\n* Use macros to include, e.g. table of contents, work package lists, or Gantt charts\n* Include wiki pages in other text fields, e.g. project overview page\n* Include links to other documents\n* View the change history\n* View as Markdown\n\nMore information: [https://www.openproject.org/docs/user-guide/wiki/](https://www.openproject.org/docs/user-guide/wiki/)\n
2	1	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the [Task board](/projects/your-scrum-project/sprints/3/taskboard).\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down [Sprint Impediments](/projects/your-scrum-project/sprints/3/taskboard).\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n
3	4	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the Task board.\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down Sprint Impediments.\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n
\.


--
-- Data for Name: wiki_pages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wiki_pages (id, wiki_id, title, created_at, protected, parent_id, slug, updated_at, author_id, text, lock_version) FROM stdin;
1	1	Wiki	2024-12-12 05:11:39.450982+00	f	\N	wiki	2024-12-12 05:11:39.450982+00	4	_In this wiki you can collaboratively create and edit pages and sub-pages to create a project wiki._\n\n**You can:**\n\n* Insert text and images, also with copy and paste from other documents\n* Create a page hierarchy with parent pages\n* Include wiki pages to the project menu\n* Use macros to include, e.g. table of contents, work package lists, or Gantt charts\n* Include wiki pages in other text fields, e.g. project overview page\n* Include links to other documents\n* View the change history\n* View as Markdown\n\nMore information: [https://www.openproject.org/docs/user-guide/wiki/](https://www.openproject.org/docs/user-guide/wiki/)\n	0
2	2	Sprint 1	2024-12-12 05:11:41.088301+00	f	\N	sprint-1	2024-12-12 05:11:41.088301+00	1	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the [Task board](/projects/your-scrum-project/sprints/3/taskboard).\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down [Sprint Impediments](/projects/your-scrum-project/sprints/3/taskboard).\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n	0
3	2	Wiki	2024-12-12 05:11:41.254043+00	f	\N	wiki	2024-12-12 05:11:41.254043+00	4	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the Task board.\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down Sprint Impediments.\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n	0
\.


--
-- Data for Name: wiki_redirects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wiki_redirects (id, wiki_id, title, redirects_to, created_at) FROM stdin;
\.


--
-- Data for Name: wikis; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wikis (id, project_id, start_page, status, created_at, updated_at) FROM stdin;
1	1	Wiki	1	2024-12-12 05:11:39.005774+00	2024-12-12 05:11:39.452944+00
2	2	Wiki	1	2024-12-12 05:11:40.937878+00	2024-12-12 05:11:41.25509+00
\.


--
-- Data for Name: work_package_hierarchies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.work_package_hierarchies (ancestor_id, descendant_id, generations) FROM stdin;
1	1	0
2	2	0
3	3	0
2	3	1
4	4	0
3	4	1
2	4	2
5	5	0
3	5	1
2	5	2
6	6	0
3	6	1
2	6	2
7	7	0
2	7	1
8	8	0
2	8	1
9	9	0
10	10	0
11	11	0
10	11	1
12	12	0
10	12	1
13	13	0
14	14	0
15	15	0
16	16	0
17	17	0
16	17	1
18	18	0
16	18	1
19	19	0
16	19	1
20	20	0
19	20	1
16	20	2
21	21	0
22	22	0
23	23	0
22	23	1
24	24	0
25	25	0
26	26	0
27	27	0
28	28	0
29	29	0
28	29	1
30	30	0
31	31	0
32	32	0
33	33	0
34	34	0
35	35	0
36	36	0
\.


--
-- Data for Name: work_package_journals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.work_package_journals (id, type_id, project_id, subject, description, due_date, category_id, status_id, assigned_to_id, priority_id, version_id, author_id, done_ratio, estimated_hours, start_date, parent_id, responsible_id, budget_id, story_points, remaining_hours, derived_estimated_hours, schedule_manually, duration, ignore_non_working_days, derived_remaining_hours, derived_done_ratio) FROM stdin;
2	2	1	Start of project		2024-12-08	\N	12	4	8	\N	4	\N	\N	2024-12-08	\N	\N	\N	\N	\N	\N	f	1	t	\N	\N
7	1	1	Send invitation to speakers		2024-12-09	\N	7	4	8	\N	4	\N	\N	2024-12-09	3	\N	\N	\N	\N	\N	f	1	f	\N	\N
10	1	1	Contact sponsoring partners		2024-12-10	\N	1	4	8	\N	4	\N	\N	2024-12-09	3	\N	\N	\N	\N	\N	f	2	f	\N	\N
13	1	1	Create sponsorship brochure and hand-outs		2024-12-12	\N	1	4	8	\N	4	\N	\N	2024-12-09	3	\N	\N	\N	\N	\N	f	4	f	\N	\N
15	1	1	Set date and location of conference		2024-12-12	\N	7	4	8	\N	4	\N	\N	2024-12-09	2	\N	\N	\N	\N	\N	f	4	f	\N	\N
18	1	1	Invite attendees to conference		2024-12-13	\N	1	4	8	\N	4	\N	\N	2024-12-13	2	\N	\N	\N	\N	\N	f	1	f	\N	\N
21	1	1	Setup conference website		2024-12-23	\N	1	4	8	\N	4	\N	\N	2024-12-13	2	\N	\N	\N	\N	\N	f	7	f	\N	\N
22	3	1	Organize open source conference		2024-12-23	\N	7	4	8	\N	4	\N	\N	2024-12-09	\N	\N	\N	\N	\N	\N	f	11	f	\N	\N
24	2	1	Conference		2024-12-24	\N	6	4	8	\N	4	\N	\N	2024-12-24	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
28	1	1	Upload presentations to website		2025-01-08	\N	1	4	8	\N	4	\N	\N	2024-12-30	10	\N	\N	\N	\N	\N	f	8	f	\N	\N
31	1	1	Party for conference supporters :-)	*   [ ] Beer\n*   [ ] Snacks\n*   [ ] Music\n*   [ ] Even more beer	2025-01-09	\N	1	4	8	\N	4	\N	\N	2025-01-09	10	\N	\N	\N	\N	\N	f	1	f	\N	\N
32	3	1	Follow-up tasks		2025-01-09	\N	5	4	8	\N	4	\N	\N	2024-12-30	\N	\N	\N	\N	\N	\N	f	9	f	\N	\N
34	2	1	End of project		2025-01-10	\N	1	4	8	\N	4	\N	\N	2025-01-10	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
36	6	2	New login screen		\N	\N	2	4	8	2	4	\N	\N	2024-12-09	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N
38	7	2	Password reset does not send email		\N	\N	4	4	8	1	4	\N	\N	2024-12-09	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N
42	6	2	Newsletter registration form		\N	\N	7	4	8	2	4	\N	\N	2024-12-09	16	\N	\N	\N	\N	\N	f	\N	f	\N	\N
45	6	2	Implement product tour		\N	\N	2	4	8	2	4	\N	\N	2024-12-09	16	\N	\N	\N	\N	\N	f	\N	f	\N	\N
49	1	2	Create wireframes for new landing page		2025-01-06	\N	7	4	8	3	4	\N	\N	2025-01-06	19	\N	\N	\N	\N	\N	f	1	f	\N	\N
51	6	2	New landing page		2025-01-06	\N	3	4	8	3	4	\N	\N	2025-01-06	16	\N	\N	3	\N	\N	f	1	f	\N	\N
52	5	2	New website		2025-01-06	\N	3	4	8	\N	4	\N	\N	2024-12-09	\N	\N	\N	\N	\N	\N	f	21	f	\N	\N
54	6	2	Contact form		2024-12-30	\N	3	4	8	3	4	\N	\N	2024-12-30	\N	\N	\N	1	\N	\N	f	1	f	\N	\N
58	1	2	Make screenshots for feature tour		\N	\N	12	4	8	3	4	\N	\N	2024-12-09	22	\N	\N	\N	\N	\N	f	\N	f	\N	\N
59	6	2	Feature carousel		\N	\N	3	4	8	3	4	\N	\N	2024-12-09	\N	\N	\N	5	\N	\N	f	\N	f	\N	\N
61	7	2	Wrong hover color		2024-12-30	\N	14	4	8	3	4	\N	\N	2024-12-30	\N	\N	\N	1	\N	\N	f	1	f	\N	\N
63	6	2	SSL certificate		2024-12-31	\N	3	4	8	2	4	\N	\N	2024-12-31	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
65	6	2	Set-up Staging environment		2025-01-01	\N	2	4	8	2	4	\N	\N	2025-01-01	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
67	6	2	Choose a content management system		2025-01-02	\N	3	4	8	2	4	\N	\N	2025-01-02	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
71	1	2	Set up navigation concept for website.		2025-01-03	\N	2	4	8	3	4	\N	\N	2025-01-03	28	\N	\N	\N	\N	\N	f	1	f	\N	\N
72	6	2	Website navigation structure		2025-01-03	\N	3	4	8	3	4	\N	\N	2025-01-03	\N	\N	\N	3	\N	\N	f	1	f	\N	\N
74	6	2	Internal link structure		2025-01-03	\N	12	4	8	2	4	\N	\N	2025-01-03	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
76	3	2	Develop v1.0		2024-12-25	\N	7	4	8	\N	4	\N	\N	2024-12-23	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
78	2	2	Release v1.0		2024-12-27	\N	1	4	8	\N	4	\N	\N	2024-12-27	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
80	3	2	Develop v1.1		2025-01-01	\N	1	4	8	\N	4	\N	\N	2024-12-30	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
82	2	2	Release v1.1		2025-01-03	\N	1	4	8	\N	4	\N	\N	2025-01-03	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
84	3	2	Develop v2.0		2025-01-08	\N	1	4	8	\N	4	\N	\N	2025-01-06	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
86	2	2	Release v2.0		2025-01-10	\N	1	4	8	\N	4	\N	\N	2025-01-10	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
\.


--
-- Data for Name: work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.work_packages (id, type_id, project_id, subject, description, due_date, category_id, status_id, assigned_to_id, priority_id, version_id, author_id, lock_version, done_ratio, estimated_hours, created_at, updated_at, start_date, responsible_id, budget_id, "position", story_points, remaining_hours, derived_estimated_hours, schedule_manually, parent_id, duration, ignore_non_working_days, derived_remaining_hours, derived_done_ratio, project_life_cycle_step_id) FROM stdin;
1	2	1	Start of project	\N	2024-12-08	\N	12	4	8	\N	4	0	\N	\N	2024-12-12 05:11:39.507931+00	2024-12-12 05:11:39.567864+00	2024-12-08	\N	\N	1	\N	\N	\N	f	\N	1	t	\N	\N	\N
4	1	1	Send invitation to speakers		2024-12-09	\N	7	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.643963+00	2024-12-12 05:11:39.690221+00	2024-12-09	\N	\N	1	\N	\N	\N	f	3	1	f	\N	\N	\N
5	1	1	Contact sponsoring partners		2024-12-10	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.722974+00	2024-12-12 05:11:39.762828+00	2024-12-09	\N	\N	1	\N	\N	\N	f	3	2	f	\N	\N	\N
6	1	1	Create sponsorship brochure and hand-outs		2024-12-12	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.787075+00	2024-12-12 05:11:39.830992+00	2024-12-09	\N	\N	1	\N	\N	\N	f	3	4	f	\N	\N	\N
3	1	1	Set date and location of conference		2024-12-12	\N	7	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.615712+00	2024-12-12 05:11:39.881035+00	2024-12-09	\N	\N	1	\N	\N	\N	f	2	4	f	\N	\N	\N
7	1	1	Invite attendees to conference		2024-12-13	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.921022+00	2024-12-12 05:11:39.961736+00	2024-12-13	\N	\N	1	\N	\N	\N	f	2	1	f	\N	\N	\N
8	1	1	Setup conference website		2024-12-23	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:39.993512+00	2024-12-12 05:11:40.032201+00	2024-12-13	\N	\N	1	\N	\N	\N	f	2	7	f	\N	\N	\N
2	3	1	Organize open source conference		2024-12-23	\N	7	4	8	\N	4	0	\N	\N	2024-12-12 05:11:39.588643+00	2024-12-12 05:11:40.060131+00	2024-12-09	\N	\N	1	\N	\N	\N	f	\N	11	f	\N	\N	\N
9	2	1	Conference		2024-12-24	\N	6	4	8	\N	4	0	\N	\N	2024-12-12 05:11:40.079898+00	2024-12-12 05:11:40.105614+00	2024-12-24	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
11	1	1	Upload presentations to website		2025-01-08	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:40.142513+00	2024-12-12 05:11:40.18477+00	2024-12-30	\N	\N	1	\N	\N	\N	f	10	8	f	\N	\N	\N
12	1	1	Party for conference supporters :-)	*   [ ] Beer\n*   [ ] Snacks\n*   [ ] Music\n*   [ ] Even more beer	2025-01-09	\N	1	4	8	\N	4	1	\N	\N	2024-12-12 05:11:40.217201+00	2024-12-12 05:11:40.256049+00	2025-01-09	\N	\N	1	\N	\N	\N	f	10	1	f	\N	\N	\N
10	3	1	Follow-up tasks		2025-01-09	\N	5	4	8	\N	4	0	\N	\N	2024-12-12 05:11:40.120523+00	2024-12-12 05:11:40.283728+00	2024-12-30	\N	\N	1	\N	\N	\N	f	\N	9	f	\N	\N	\N
13	2	1	End of project	\N	2025-01-10	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:40.298688+00	2024-12-12 05:11:40.322317+00	2025-01-10	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
15	7	2	Password reset does not send email	\N	\N	\N	4	4	8	1	4	0	\N	\N	2024-12-12 05:11:41.348647+00	2024-12-12 05:11:41.387566+00	2024-12-09	\N	\N	1	\N	\N	\N	f	\N	\N	f	\N	\N	\N
16	5	2	New website	\N	2025-01-06	\N	3	4	8	\N	4	0	\N	\N	2024-12-12 05:11:41.407032+00	2024-12-12 05:11:41.763922+00	2024-12-09	\N	\N	1	\N	\N	\N	f	\N	21	f	\N	\N	\N
20	1	2	Create wireframes for new landing page	\N	2025-01-06	\N	7	4	8	3	4	1	\N	\N	2024-12-12 05:11:41.633679+00	2024-12-12 05:11:41.679831+00	2025-01-06	\N	\N	1	\N	\N	\N	f	19	1	f	\N	\N	\N
19	6	2	New landing page	\N	2025-01-06	\N	3	4	8	3	4	1	\N	\N	2024-12-12 05:11:41.600012+00	2024-12-12 05:11:41.732652+00	2025-01-06	\N	\N	2	3	\N	\N	f	16	1	f	\N	\N	\N
23	1	2	Make screenshots for feature tour	\N	\N	\N	12	4	8	3	4	1	\N	\N	2024-12-12 05:11:41.868153+00	2024-12-12 05:11:41.912893+00	2024-12-09	\N	\N	1	\N	\N	\N	f	22	\N	f	\N	\N	\N
22	6	2	Feature carousel	\N	\N	\N	3	4	8	3	4	0	\N	\N	2024-12-12 05:11:41.835833+00	2024-12-12 05:11:41.942761+00	2024-12-09	\N	\N	3	5	\N	\N	f	\N	\N	f	\N	\N	\N
24	7	2	Wrong hover color	\N	2024-12-30	\N	14	4	8	3	4	0	\N	\N	2024-12-12 05:11:41.958908+00	2024-12-12 05:11:41.994991+00	2024-12-30	\N	\N	4	1	\N	\N	f	\N	1	f	\N	\N	\N
25	6	2	SSL certificate	\N	2024-12-31	\N	3	4	8	2	4	0	\N	\N	2024-12-12 05:11:42.01037+00	2024-12-12 05:11:42.045751+00	2024-12-31	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
26	6	2	Set-up Staging environment	\N	2025-01-01	\N	2	4	8	2	4	0	\N	\N	2024-12-12 05:11:42.060742+00	2024-12-12 05:11:42.095862+00	2025-01-01	\N	\N	2	\N	\N	\N	f	\N	1	f	\N	\N	\N
21	6	2	Contact form	\N	2024-12-30	\N	3	4	8	3	4	0	\N	\N	2024-12-12 05:11:41.782618+00	2024-12-12 05:11:41.818173+00	2024-12-30	\N	\N	8	1	\N	\N	f	\N	1	f	\N	\N	\N
29	1	2	Set up navigation concept for website.	\N	2025-01-03	\N	2	4	8	3	4	1	\N	\N	2024-12-12 05:11:42.194243+00	2024-12-12 05:11:42.239797+00	2025-01-03	\N	\N	1	\N	\N	\N	f	28	1	f	\N	\N	\N
28	6	2	Website navigation structure	\N	2025-01-03	\N	3	4	8	3	4	0	\N	\N	2024-12-12 05:11:42.162091+00	2024-12-12 05:11:42.270144+00	2025-01-03	\N	\N	7	3	\N	\N	f	\N	1	f	\N	\N	\N
18	6	2	Implement product tour	\N	\N	\N	2	4	8	2	4	1	\N	\N	2024-12-12 05:11:41.522121+00	2024-12-12 05:11:41.572765+00	2024-12-09	\N	\N	7	\N	\N	\N	f	16	\N	f	\N	\N	\N
14	6	2	New login screen	\N	\N	\N	2	4	8	2	4	0	\N	\N	2024-12-12 05:11:41.289724+00	2024-12-12 05:11:41.329266+00	2024-12-09	\N	\N	6	\N	\N	\N	f	\N	\N	f	\N	\N	\N
17	6	2	Newsletter registration form	\N	\N	\N	7	4	8	2	4	1	\N	\N	2024-12-12 05:11:41.436597+00	2024-12-12 05:11:41.493085+00	2024-12-09	\N	\N	11	\N	\N	\N	f	16	\N	f	\N	\N	\N
27	6	2	Choose a content management system	\N	2025-01-02	\N	3	4	8	2	4	0	\N	\N	2024-12-12 05:11:42.111325+00	2024-12-12 05:11:42.145799+00	2025-01-02	\N	\N	8	\N	\N	\N	f	\N	1	f	\N	\N	\N
30	6	2	Internal link structure	\N	2025-01-03	\N	12	4	8	2	4	0	\N	\N	2024-12-12 05:11:42.286053+00	2024-12-12 05:11:42.339676+00	2025-01-03	\N	\N	5	\N	\N	\N	f	\N	1	f	\N	\N	\N
31	3	2	Develop v1.0	\N	2024-12-25	\N	7	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.370082+00	2024-12-12 05:11:42.420692+00	2024-12-23	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
32	2	2	Release v1.0	\N	2024-12-27	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.453266+00	2024-12-12 05:11:42.49816+00	2024-12-27	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
33	3	2	Develop v1.1	\N	2025-01-01	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.524089+00	2024-12-12 05:11:42.564398+00	2024-12-30	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
34	2	2	Release v1.1	\N	2025-01-03	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.588933+00	2024-12-12 05:11:42.629794+00	2025-01-03	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
35	3	2	Develop v2.0	\N	2025-01-08	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.65197+00	2024-12-12 05:11:42.703113+00	2025-01-06	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
36	2	2	Release v2.0	\N	2025-01-10	\N	1	4	8	\N	4	0	\N	\N	2024-12-12 05:11:42.729658+00	2024-12-12 05:11:42.780668+00	2025-01-10	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.workflows (id, type_id, old_status_id, new_status_id, role_id, assignee, author) FROM stdin;
1	1	1	1	9	f	f
2	1	1	1	11	f	f
3	1	1	1	1	f	f
4	1	1	7	9	f	f
5	1	1	7	11	f	f
6	1	1	7	1	f	f
7	1	1	13	9	f	f
8	1	1	13	11	f	f
9	1	1	13	1	f	f
10	1	1	14	9	f	f
11	1	1	14	11	f	f
12	1	1	14	1	f	f
13	1	1	12	9	f	f
14	1	1	12	11	f	f
15	1	1	12	1	f	f
16	1	7	1	9	f	f
17	1	7	1	11	f	f
18	1	7	1	1	f	f
19	1	7	7	9	f	f
20	1	7	7	11	f	f
21	1	7	7	1	f	f
22	1	7	13	9	f	f
23	1	7	13	11	f	f
24	1	7	13	1	f	f
25	1	7	14	9	f	f
26	1	7	14	11	f	f
27	1	7	14	1	f	f
28	1	7	12	9	f	f
29	1	7	12	11	f	f
30	1	7	12	1	f	f
31	1	13	1	9	f	f
32	1	13	1	11	f	f
33	1	13	1	1	f	f
34	1	13	7	9	f	f
35	1	13	7	11	f	f
36	1	13	7	1	f	f
37	1	13	13	9	f	f
38	1	13	13	11	f	f
39	1	13	13	1	f	f
40	1	13	14	9	f	f
41	1	13	14	11	f	f
42	1	13	14	1	f	f
43	1	13	12	9	f	f
44	1	13	12	11	f	f
45	1	13	12	1	f	f
46	1	14	1	9	f	f
47	1	14	1	11	f	f
48	1	14	1	1	f	f
49	1	14	7	9	f	f
50	1	14	7	11	f	f
51	1	14	7	1	f	f
52	1	14	13	9	f	f
53	1	14	13	11	f	f
54	1	14	13	1	f	f
55	1	14	14	9	f	f
56	1	14	14	11	f	f
57	1	14	14	1	f	f
58	1	14	12	9	f	f
59	1	14	12	11	f	f
60	1	14	12	1	f	f
61	1	12	1	9	f	f
62	1	12	1	11	f	f
63	1	12	1	1	f	f
64	1	12	7	9	f	f
65	1	12	7	11	f	f
66	1	12	7	1	f	f
67	1	12	13	9	f	f
68	1	12	13	11	f	f
69	1	12	13	1	f	f
70	1	12	14	9	f	f
71	1	12	14	11	f	f
72	1	12	14	1	f	f
73	1	12	12	9	f	f
74	1	12	12	11	f	f
75	1	12	12	1	f	f
76	2	1	1	9	f	f
77	2	1	1	11	f	f
78	2	1	1	1	f	f
79	2	1	5	9	f	f
80	2	1	5	11	f	f
81	2	1	5	1	f	f
82	2	1	6	9	f	f
83	2	1	6	11	f	f
84	2	1	6	1	f	f
85	2	1	7	9	f	f
86	2	1	7	11	f	f
87	2	1	7	1	f	f
88	2	1	13	9	f	f
89	2	1	13	11	f	f
90	2	1	13	1	f	f
91	2	1	14	9	f	f
92	2	1	14	11	f	f
93	2	1	14	1	f	f
94	2	1	12	9	f	f
95	2	1	12	11	f	f
96	2	1	12	1	f	f
97	2	5	1	9	f	f
98	2	5	1	11	f	f
99	2	5	1	1	f	f
100	2	5	5	9	f	f
101	2	5	5	11	f	f
102	2	5	5	1	f	f
103	2	5	6	9	f	f
104	2	5	6	11	f	f
105	2	5	6	1	f	f
106	2	5	7	9	f	f
107	2	5	7	11	f	f
108	2	5	7	1	f	f
109	2	5	13	9	f	f
110	2	5	13	11	f	f
111	2	5	13	1	f	f
112	2	5	14	9	f	f
113	2	5	14	11	f	f
114	2	5	14	1	f	f
115	2	5	12	9	f	f
116	2	5	12	11	f	f
117	2	5	12	1	f	f
118	2	6	1	9	f	f
119	2	6	1	11	f	f
120	2	6	1	1	f	f
121	2	6	5	9	f	f
122	2	6	5	11	f	f
123	2	6	5	1	f	f
124	2	6	6	9	f	f
125	2	6	6	11	f	f
126	2	6	6	1	f	f
127	2	6	7	9	f	f
128	2	6	7	11	f	f
129	2	6	7	1	f	f
130	2	6	13	9	f	f
131	2	6	13	11	f	f
132	2	6	13	1	f	f
133	2	6	14	9	f	f
134	2	6	14	11	f	f
135	2	6	14	1	f	f
136	2	6	12	9	f	f
137	2	6	12	11	f	f
138	2	6	12	1	f	f
139	2	7	1	9	f	f
140	2	7	1	11	f	f
141	2	7	1	1	f	f
142	2	7	5	9	f	f
143	2	7	5	11	f	f
144	2	7	5	1	f	f
145	2	7	6	9	f	f
146	2	7	6	11	f	f
147	2	7	6	1	f	f
148	2	7	7	9	f	f
149	2	7	7	11	f	f
150	2	7	7	1	f	f
151	2	7	13	9	f	f
152	2	7	13	11	f	f
153	2	7	13	1	f	f
154	2	7	14	9	f	f
155	2	7	14	11	f	f
156	2	7	14	1	f	f
157	2	7	12	9	f	f
158	2	7	12	11	f	f
159	2	7	12	1	f	f
160	2	13	1	9	f	f
161	2	13	1	11	f	f
162	2	13	1	1	f	f
163	2	13	5	9	f	f
164	2	13	5	11	f	f
165	2	13	5	1	f	f
166	2	13	6	9	f	f
167	2	13	6	11	f	f
168	2	13	6	1	f	f
169	2	13	7	9	f	f
170	2	13	7	11	f	f
171	2	13	7	1	f	f
172	2	13	13	9	f	f
173	2	13	13	11	f	f
174	2	13	13	1	f	f
175	2	13	14	9	f	f
176	2	13	14	11	f	f
177	2	13	14	1	f	f
178	2	13	12	9	f	f
179	2	13	12	11	f	f
180	2	13	12	1	f	f
181	2	14	1	9	f	f
182	2	14	1	11	f	f
183	2	14	1	1	f	f
184	2	14	5	9	f	f
185	2	14	5	11	f	f
186	2	14	5	1	f	f
187	2	14	6	9	f	f
188	2	14	6	11	f	f
189	2	14	6	1	f	f
190	2	14	7	9	f	f
191	2	14	7	11	f	f
192	2	14	7	1	f	f
193	2	14	13	9	f	f
194	2	14	13	11	f	f
195	2	14	13	1	f	f
196	2	14	14	9	f	f
197	2	14	14	11	f	f
198	2	14	14	1	f	f
199	2	14	12	9	f	f
200	2	14	12	11	f	f
201	2	14	12	1	f	f
202	2	12	1	9	f	f
203	2	12	1	11	f	f
204	2	12	1	1	f	f
205	2	12	5	9	f	f
206	2	12	5	11	f	f
207	2	12	5	1	f	f
208	2	12	6	9	f	f
209	2	12	6	11	f	f
210	2	12	6	1	f	f
211	2	12	7	9	f	f
212	2	12	7	11	f	f
213	2	12	7	1	f	f
214	2	12	13	9	f	f
215	2	12	13	11	f	f
216	2	12	13	1	f	f
217	2	12	14	9	f	f
218	2	12	14	11	f	f
219	2	12	14	1	f	f
220	2	12	12	9	f	f
221	2	12	12	11	f	f
222	2	12	12	1	f	f
223	3	1	1	9	f	f
224	3	1	1	11	f	f
225	3	1	1	1	f	f
226	3	1	5	9	f	f
227	3	1	5	11	f	f
228	3	1	5	1	f	f
229	3	1	6	9	f	f
230	3	1	6	11	f	f
231	3	1	6	1	f	f
232	3	1	7	9	f	f
233	3	1	7	11	f	f
234	3	1	7	1	f	f
235	3	1	13	9	f	f
236	3	1	13	11	f	f
237	3	1	13	1	f	f
238	3	1	14	9	f	f
239	3	1	14	11	f	f
240	3	1	14	1	f	f
241	3	1	12	9	f	f
242	3	1	12	11	f	f
243	3	1	12	1	f	f
244	3	5	1	9	f	f
245	3	5	1	11	f	f
246	3	5	1	1	f	f
247	3	5	5	9	f	f
248	3	5	5	11	f	f
249	3	5	5	1	f	f
250	3	5	6	9	f	f
251	3	5	6	11	f	f
252	3	5	6	1	f	f
253	3	5	7	9	f	f
254	3	5	7	11	f	f
255	3	5	7	1	f	f
256	3	5	13	9	f	f
257	3	5	13	11	f	f
258	3	5	13	1	f	f
259	3	5	14	9	f	f
260	3	5	14	11	f	f
261	3	5	14	1	f	f
262	3	5	12	9	f	f
263	3	5	12	11	f	f
264	3	5	12	1	f	f
265	3	6	1	9	f	f
266	3	6	1	11	f	f
267	3	6	1	1	f	f
268	3	6	5	9	f	f
269	3	6	5	11	f	f
270	3	6	5	1	f	f
271	3	6	6	9	f	f
272	3	6	6	11	f	f
273	3	6	6	1	f	f
274	3	6	7	9	f	f
275	3	6	7	11	f	f
276	3	6	7	1	f	f
277	3	6	13	9	f	f
278	3	6	13	11	f	f
279	3	6	13	1	f	f
280	3	6	14	9	f	f
281	3	6	14	11	f	f
282	3	6	14	1	f	f
283	3	6	12	9	f	f
284	3	6	12	11	f	f
285	3	6	12	1	f	f
286	3	7	1	9	f	f
287	3	7	1	11	f	f
288	3	7	1	1	f	f
289	3	7	5	9	f	f
290	3	7	5	11	f	f
291	3	7	5	1	f	f
292	3	7	6	9	f	f
293	3	7	6	11	f	f
294	3	7	6	1	f	f
295	3	7	7	9	f	f
296	3	7	7	11	f	f
297	3	7	7	1	f	f
298	3	7	13	9	f	f
299	3	7	13	11	f	f
300	3	7	13	1	f	f
301	3	7	14	9	f	f
302	3	7	14	11	f	f
303	3	7	14	1	f	f
304	3	7	12	9	f	f
305	3	7	12	11	f	f
306	3	7	12	1	f	f
307	3	13	1	9	f	f
308	3	13	1	11	f	f
309	3	13	1	1	f	f
310	3	13	5	9	f	f
311	3	13	5	11	f	f
312	3	13	5	1	f	f
313	3	13	6	9	f	f
314	3	13	6	11	f	f
315	3	13	6	1	f	f
316	3	13	7	9	f	f
317	3	13	7	11	f	f
318	3	13	7	1	f	f
319	3	13	13	9	f	f
320	3	13	13	11	f	f
321	3	13	13	1	f	f
322	3	13	14	9	f	f
323	3	13	14	11	f	f
324	3	13	14	1	f	f
325	3	13	12	9	f	f
326	3	13	12	11	f	f
327	3	13	12	1	f	f
328	3	14	1	9	f	f
329	3	14	1	11	f	f
330	3	14	1	1	f	f
331	3	14	5	9	f	f
332	3	14	5	11	f	f
333	3	14	5	1	f	f
334	3	14	6	9	f	f
335	3	14	6	11	f	f
336	3	14	6	1	f	f
337	3	14	7	9	f	f
338	3	14	7	11	f	f
339	3	14	7	1	f	f
340	3	14	13	9	f	f
341	3	14	13	11	f	f
342	3	14	13	1	f	f
343	3	14	14	9	f	f
344	3	14	14	11	f	f
345	3	14	14	1	f	f
346	3	14	12	9	f	f
347	3	14	12	11	f	f
348	3	14	12	1	f	f
349	3	12	1	9	f	f
350	3	12	1	11	f	f
351	3	12	1	1	f	f
352	3	12	5	9	f	f
353	3	12	5	11	f	f
354	3	12	5	1	f	f
355	3	12	6	9	f	f
356	3	12	6	11	f	f
357	3	12	6	1	f	f
358	3	12	7	9	f	f
359	3	12	7	11	f	f
360	3	12	7	1	f	f
361	3	12	13	9	f	f
362	3	12	13	11	f	f
363	3	12	13	1	f	f
364	3	12	14	9	f	f
365	3	12	14	11	f	f
366	3	12	14	1	f	f
367	3	12	12	9	f	f
368	3	12	12	11	f	f
369	3	12	12	1	f	f
370	4	1	1	9	f	f
371	4	1	1	11	f	f
372	4	1	1	1	f	f
373	4	1	2	9	f	f
374	4	1	2	11	f	f
375	4	1	2	1	f	f
376	4	1	3	9	f	f
377	4	1	3	11	f	f
378	4	1	3	1	f	f
379	4	1	7	9	f	f
380	4	1	7	11	f	f
381	4	1	7	1	f	f
382	4	1	8	9	f	f
383	4	1	8	11	f	f
384	4	1	8	1	f	f
385	4	1	9	9	f	f
386	4	1	9	11	f	f
387	4	1	9	1	f	f
388	4	1	10	9	f	f
389	4	1	10	11	f	f
390	4	1	10	1	f	f
391	4	1	11	9	f	f
392	4	1	11	11	f	f
393	4	1	11	1	f	f
394	4	1	13	9	f	f
395	4	1	13	11	f	f
396	4	1	13	1	f	f
397	4	1	14	9	f	f
398	4	1	14	11	f	f
399	4	1	14	1	f	f
400	4	1	12	9	f	f
401	4	1	12	11	f	f
402	4	1	12	1	f	f
403	4	2	1	9	f	f
404	4	2	1	11	f	f
405	4	2	1	1	f	f
406	4	2	2	9	f	f
407	4	2	2	11	f	f
408	4	2	2	1	f	f
409	4	2	3	9	f	f
410	4	2	3	11	f	f
411	4	2	3	1	f	f
412	4	2	7	9	f	f
413	4	2	7	11	f	f
414	4	2	7	1	f	f
415	4	2	8	9	f	f
416	4	2	8	11	f	f
417	4	2	8	1	f	f
418	4	2	9	9	f	f
419	4	2	9	11	f	f
420	4	2	9	1	f	f
421	4	2	10	9	f	f
422	4	2	10	11	f	f
423	4	2	10	1	f	f
424	4	2	11	9	f	f
425	4	2	11	11	f	f
426	4	2	11	1	f	f
427	4	2	13	9	f	f
428	4	2	13	11	f	f
429	4	2	13	1	f	f
430	4	2	14	9	f	f
431	4	2	14	11	f	f
432	4	2	14	1	f	f
433	4	2	12	9	f	f
434	4	2	12	11	f	f
435	4	2	12	1	f	f
436	4	3	1	9	f	f
437	4	3	1	11	f	f
438	4	3	1	1	f	f
439	4	3	2	9	f	f
440	4	3	2	11	f	f
441	4	3	2	1	f	f
442	4	3	3	9	f	f
443	4	3	3	11	f	f
444	4	3	3	1	f	f
445	4	3	7	9	f	f
446	4	3	7	11	f	f
447	4	3	7	1	f	f
448	4	3	8	9	f	f
449	4	3	8	11	f	f
450	4	3	8	1	f	f
451	4	3	9	9	f	f
452	4	3	9	11	f	f
453	4	3	9	1	f	f
454	4	3	10	9	f	f
455	4	3	10	11	f	f
456	4	3	10	1	f	f
457	4	3	11	9	f	f
458	4	3	11	11	f	f
459	4	3	11	1	f	f
460	4	3	13	9	f	f
461	4	3	13	11	f	f
462	4	3	13	1	f	f
463	4	3	14	9	f	f
464	4	3	14	11	f	f
465	4	3	14	1	f	f
466	4	3	12	9	f	f
467	4	3	12	11	f	f
468	4	3	12	1	f	f
469	4	7	1	9	f	f
470	4	7	1	11	f	f
471	4	7	1	1	f	f
472	4	7	2	9	f	f
473	4	7	2	11	f	f
474	4	7	2	1	f	f
475	4	7	3	9	f	f
476	4	7	3	11	f	f
477	4	7	3	1	f	f
478	4	7	7	9	f	f
479	4	7	7	11	f	f
480	4	7	7	1	f	f
481	4	7	8	9	f	f
482	4	7	8	11	f	f
483	4	7	8	1	f	f
484	4	7	9	9	f	f
485	4	7	9	11	f	f
486	4	7	9	1	f	f
487	4	7	10	9	f	f
488	4	7	10	11	f	f
489	4	7	10	1	f	f
490	4	7	11	9	f	f
491	4	7	11	11	f	f
492	4	7	11	1	f	f
493	4	7	13	9	f	f
494	4	7	13	11	f	f
495	4	7	13	1	f	f
496	4	7	14	9	f	f
497	4	7	14	11	f	f
498	4	7	14	1	f	f
499	4	7	12	9	f	f
500	4	7	12	11	f	f
501	4	7	12	1	f	f
502	4	8	1	9	f	f
503	4	8	1	11	f	f
504	4	8	1	1	f	f
505	4	8	2	9	f	f
506	4	8	2	11	f	f
507	4	8	2	1	f	f
508	4	8	3	9	f	f
509	4	8	3	11	f	f
510	4	8	3	1	f	f
511	4	8	7	9	f	f
512	4	8	7	11	f	f
513	4	8	7	1	f	f
514	4	8	8	9	f	f
515	4	8	8	11	f	f
516	4	8	8	1	f	f
517	4	8	9	9	f	f
518	4	8	9	11	f	f
519	4	8	9	1	f	f
520	4	8	10	9	f	f
521	4	8	10	11	f	f
522	4	8	10	1	f	f
523	4	8	11	9	f	f
524	4	8	11	11	f	f
525	4	8	11	1	f	f
526	4	8	13	9	f	f
527	4	8	13	11	f	f
528	4	8	13	1	f	f
529	4	8	14	9	f	f
530	4	8	14	11	f	f
531	4	8	14	1	f	f
532	4	8	12	9	f	f
533	4	8	12	11	f	f
534	4	8	12	1	f	f
535	4	9	1	9	f	f
536	4	9	1	11	f	f
537	4	9	1	1	f	f
538	4	9	2	9	f	f
539	4	9	2	11	f	f
540	4	9	2	1	f	f
541	4	9	3	9	f	f
542	4	9	3	11	f	f
543	4	9	3	1	f	f
544	4	9	7	9	f	f
545	4	9	7	11	f	f
546	4	9	7	1	f	f
547	4	9	8	9	f	f
548	4	9	8	11	f	f
549	4	9	8	1	f	f
550	4	9	9	9	f	f
551	4	9	9	11	f	f
552	4	9	9	1	f	f
553	4	9	10	9	f	f
554	4	9	10	11	f	f
555	4	9	10	1	f	f
556	4	9	11	9	f	f
557	4	9	11	11	f	f
558	4	9	11	1	f	f
559	4	9	13	9	f	f
560	4	9	13	11	f	f
561	4	9	13	1	f	f
562	4	9	14	9	f	f
563	4	9	14	11	f	f
564	4	9	14	1	f	f
565	4	9	12	9	f	f
566	4	9	12	11	f	f
567	4	9	12	1	f	f
568	4	10	1	9	f	f
569	4	10	1	11	f	f
570	4	10	1	1	f	f
571	4	10	2	9	f	f
572	4	10	2	11	f	f
573	4	10	2	1	f	f
574	4	10	3	9	f	f
575	4	10	3	11	f	f
576	4	10	3	1	f	f
577	4	10	7	9	f	f
578	4	10	7	11	f	f
579	4	10	7	1	f	f
580	4	10	8	9	f	f
581	4	10	8	11	f	f
582	4	10	8	1	f	f
583	4	10	9	9	f	f
584	4	10	9	11	f	f
585	4	10	9	1	f	f
586	4	10	10	9	f	f
587	4	10	10	11	f	f
588	4	10	10	1	f	f
589	4	10	11	9	f	f
590	4	10	11	11	f	f
591	4	10	11	1	f	f
592	4	10	13	9	f	f
593	4	10	13	11	f	f
594	4	10	13	1	f	f
595	4	10	14	9	f	f
596	4	10	14	11	f	f
597	4	10	14	1	f	f
598	4	10	12	9	f	f
599	4	10	12	11	f	f
600	4	10	12	1	f	f
601	4	11	1	9	f	f
602	4	11	1	11	f	f
603	4	11	1	1	f	f
604	4	11	2	9	f	f
605	4	11	2	11	f	f
606	4	11	2	1	f	f
607	4	11	3	9	f	f
608	4	11	3	11	f	f
609	4	11	3	1	f	f
610	4	11	7	9	f	f
611	4	11	7	11	f	f
612	4	11	7	1	f	f
613	4	11	8	9	f	f
614	4	11	8	11	f	f
615	4	11	8	1	f	f
616	4	11	9	9	f	f
617	4	11	9	11	f	f
618	4	11	9	1	f	f
619	4	11	10	9	f	f
620	4	11	10	11	f	f
621	4	11	10	1	f	f
622	4	11	11	9	f	f
623	4	11	11	11	f	f
624	4	11	11	1	f	f
625	4	11	13	9	f	f
626	4	11	13	11	f	f
627	4	11	13	1	f	f
628	4	11	14	9	f	f
629	4	11	14	11	f	f
630	4	11	14	1	f	f
631	4	11	12	9	f	f
632	4	11	12	11	f	f
633	4	11	12	1	f	f
634	4	13	1	9	f	f
635	4	13	1	11	f	f
636	4	13	1	1	f	f
637	4	13	2	9	f	f
638	4	13	2	11	f	f
639	4	13	2	1	f	f
640	4	13	3	9	f	f
641	4	13	3	11	f	f
642	4	13	3	1	f	f
643	4	13	7	9	f	f
644	4	13	7	11	f	f
645	4	13	7	1	f	f
646	4	13	8	9	f	f
647	4	13	8	11	f	f
648	4	13	8	1	f	f
649	4	13	9	9	f	f
650	4	13	9	11	f	f
651	4	13	9	1	f	f
652	4	13	10	9	f	f
653	4	13	10	11	f	f
654	4	13	10	1	f	f
655	4	13	11	9	f	f
656	4	13	11	11	f	f
657	4	13	11	1	f	f
658	4	13	13	9	f	f
659	4	13	13	11	f	f
660	4	13	13	1	f	f
661	4	13	14	9	f	f
662	4	13	14	11	f	f
663	4	13	14	1	f	f
664	4	13	12	9	f	f
665	4	13	12	11	f	f
666	4	13	12	1	f	f
667	4	14	1	9	f	f
668	4	14	1	11	f	f
669	4	14	1	1	f	f
670	4	14	2	9	f	f
671	4	14	2	11	f	f
672	4	14	2	1	f	f
673	4	14	3	9	f	f
674	4	14	3	11	f	f
675	4	14	3	1	f	f
676	4	14	7	9	f	f
677	4	14	7	11	f	f
678	4	14	7	1	f	f
679	4	14	8	9	f	f
680	4	14	8	11	f	f
681	4	14	8	1	f	f
682	4	14	9	9	f	f
683	4	14	9	11	f	f
684	4	14	9	1	f	f
685	4	14	10	9	f	f
686	4	14	10	11	f	f
687	4	14	10	1	f	f
688	4	14	11	9	f	f
689	4	14	11	11	f	f
690	4	14	11	1	f	f
691	4	14	13	9	f	f
692	4	14	13	11	f	f
693	4	14	13	1	f	f
694	4	14	14	9	f	f
695	4	14	14	11	f	f
696	4	14	14	1	f	f
697	4	14	12	9	f	f
698	4	14	12	11	f	f
699	4	14	12	1	f	f
700	4	12	1	9	f	f
701	4	12	1	11	f	f
702	4	12	1	1	f	f
703	4	12	2	9	f	f
704	4	12	2	11	f	f
705	4	12	2	1	f	f
706	4	12	3	9	f	f
707	4	12	3	11	f	f
708	4	12	3	1	f	f
709	4	12	7	9	f	f
710	4	12	7	11	f	f
711	4	12	7	1	f	f
712	4	12	8	9	f	f
713	4	12	8	11	f	f
714	4	12	8	1	f	f
715	4	12	9	9	f	f
716	4	12	9	11	f	f
717	4	12	9	1	f	f
718	4	12	10	9	f	f
719	4	12	10	11	f	f
720	4	12	10	1	f	f
721	4	12	11	9	f	f
722	4	12	11	11	f	f
723	4	12	11	1	f	f
724	4	12	13	9	f	f
725	4	12	13	11	f	f
726	4	12	13	1	f	f
727	4	12	14	9	f	f
728	4	12	14	11	f	f
729	4	12	14	1	f	f
730	4	12	12	9	f	f
731	4	12	12	11	f	f
732	4	12	12	1	f	f
733	5	1	1	9	f	f
734	5	1	1	11	f	f
735	5	1	1	1	f	f
736	5	1	2	9	f	f
737	5	1	2	11	f	f
738	5	1	2	1	f	f
739	5	1	3	9	f	f
740	5	1	3	11	f	f
741	5	1	3	1	f	f
742	5	1	7	9	f	f
743	5	1	7	11	f	f
744	5	1	7	1	f	f
745	5	1	8	9	f	f
746	5	1	8	11	f	f
747	5	1	8	1	f	f
748	5	1	9	9	f	f
749	5	1	9	11	f	f
750	5	1	9	1	f	f
751	5	1	10	9	f	f
752	5	1	10	11	f	f
753	5	1	10	1	f	f
754	5	1	11	9	f	f
755	5	1	11	11	f	f
756	5	1	11	1	f	f
757	5	1	13	9	f	f
758	5	1	13	11	f	f
759	5	1	13	1	f	f
760	5	1	14	9	f	f
761	5	1	14	11	f	f
762	5	1	14	1	f	f
763	5	1	12	9	f	f
764	5	1	12	11	f	f
765	5	1	12	1	f	f
766	5	2	1	9	f	f
767	5	2	1	11	f	f
768	5	2	1	1	f	f
769	5	2	2	9	f	f
770	5	2	2	11	f	f
771	5	2	2	1	f	f
772	5	2	3	9	f	f
773	5	2	3	11	f	f
774	5	2	3	1	f	f
775	5	2	7	9	f	f
776	5	2	7	11	f	f
777	5	2	7	1	f	f
778	5	2	8	9	f	f
779	5	2	8	11	f	f
780	5	2	8	1	f	f
781	5	2	9	9	f	f
782	5	2	9	11	f	f
783	5	2	9	1	f	f
784	5	2	10	9	f	f
785	5	2	10	11	f	f
786	5	2	10	1	f	f
787	5	2	11	9	f	f
788	5	2	11	11	f	f
789	5	2	11	1	f	f
790	5	2	13	9	f	f
791	5	2	13	11	f	f
792	5	2	13	1	f	f
793	5	2	14	9	f	f
794	5	2	14	11	f	f
795	5	2	14	1	f	f
796	5	2	12	9	f	f
797	5	2	12	11	f	f
798	5	2	12	1	f	f
799	5	3	1	9	f	f
800	5	3	1	11	f	f
801	5	3	1	1	f	f
802	5	3	2	9	f	f
803	5	3	2	11	f	f
804	5	3	2	1	f	f
805	5	3	3	9	f	f
806	5	3	3	11	f	f
807	5	3	3	1	f	f
808	5	3	7	9	f	f
809	5	3	7	11	f	f
810	5	3	7	1	f	f
811	5	3	8	9	f	f
812	5	3	8	11	f	f
813	5	3	8	1	f	f
814	5	3	9	9	f	f
815	5	3	9	11	f	f
816	5	3	9	1	f	f
817	5	3	10	9	f	f
818	5	3	10	11	f	f
819	5	3	10	1	f	f
820	5	3	11	9	f	f
821	5	3	11	11	f	f
822	5	3	11	1	f	f
823	5	3	13	9	f	f
824	5	3	13	11	f	f
825	5	3	13	1	f	f
826	5	3	14	9	f	f
827	5	3	14	11	f	f
828	5	3	14	1	f	f
829	5	3	12	9	f	f
830	5	3	12	11	f	f
831	5	3	12	1	f	f
832	5	7	1	9	f	f
833	5	7	1	11	f	f
834	5	7	1	1	f	f
835	5	7	2	9	f	f
836	5	7	2	11	f	f
837	5	7	2	1	f	f
838	5	7	3	9	f	f
839	5	7	3	11	f	f
840	5	7	3	1	f	f
841	5	7	7	9	f	f
842	5	7	7	11	f	f
843	5	7	7	1	f	f
844	5	7	8	9	f	f
845	5	7	8	11	f	f
846	5	7	8	1	f	f
847	5	7	9	9	f	f
848	5	7	9	11	f	f
849	5	7	9	1	f	f
850	5	7	10	9	f	f
851	5	7	10	11	f	f
852	5	7	10	1	f	f
853	5	7	11	9	f	f
854	5	7	11	11	f	f
855	5	7	11	1	f	f
856	5	7	13	9	f	f
857	5	7	13	11	f	f
858	5	7	13	1	f	f
859	5	7	14	9	f	f
860	5	7	14	11	f	f
861	5	7	14	1	f	f
862	5	7	12	9	f	f
863	5	7	12	11	f	f
864	5	7	12	1	f	f
865	5	8	1	9	f	f
866	5	8	1	11	f	f
867	5	8	1	1	f	f
868	5	8	2	9	f	f
869	5	8	2	11	f	f
870	5	8	2	1	f	f
871	5	8	3	9	f	f
872	5	8	3	11	f	f
873	5	8	3	1	f	f
874	5	8	7	9	f	f
875	5	8	7	11	f	f
876	5	8	7	1	f	f
877	5	8	8	9	f	f
878	5	8	8	11	f	f
879	5	8	8	1	f	f
880	5	8	9	9	f	f
881	5	8	9	11	f	f
882	5	8	9	1	f	f
883	5	8	10	9	f	f
884	5	8	10	11	f	f
885	5	8	10	1	f	f
886	5	8	11	9	f	f
887	5	8	11	11	f	f
888	5	8	11	1	f	f
889	5	8	13	9	f	f
890	5	8	13	11	f	f
891	5	8	13	1	f	f
892	5	8	14	9	f	f
893	5	8	14	11	f	f
894	5	8	14	1	f	f
895	5	8	12	9	f	f
896	5	8	12	11	f	f
897	5	8	12	1	f	f
898	5	9	1	9	f	f
899	5	9	1	11	f	f
900	5	9	1	1	f	f
901	5	9	2	9	f	f
902	5	9	2	11	f	f
903	5	9	2	1	f	f
904	5	9	3	9	f	f
905	5	9	3	11	f	f
906	5	9	3	1	f	f
907	5	9	7	9	f	f
908	5	9	7	11	f	f
909	5	9	7	1	f	f
910	5	9	8	9	f	f
911	5	9	8	11	f	f
912	5	9	8	1	f	f
913	5	9	9	9	f	f
914	5	9	9	11	f	f
915	5	9	9	1	f	f
916	5	9	10	9	f	f
917	5	9	10	11	f	f
918	5	9	10	1	f	f
919	5	9	11	9	f	f
920	5	9	11	11	f	f
921	5	9	11	1	f	f
922	5	9	13	9	f	f
923	5	9	13	11	f	f
924	5	9	13	1	f	f
925	5	9	14	9	f	f
926	5	9	14	11	f	f
927	5	9	14	1	f	f
928	5	9	12	9	f	f
929	5	9	12	11	f	f
930	5	9	12	1	f	f
931	5	10	1	9	f	f
932	5	10	1	11	f	f
933	5	10	1	1	f	f
934	5	10	2	9	f	f
935	5	10	2	11	f	f
936	5	10	2	1	f	f
937	5	10	3	9	f	f
938	5	10	3	11	f	f
939	5	10	3	1	f	f
940	5	10	7	9	f	f
941	5	10	7	11	f	f
942	5	10	7	1	f	f
943	5	10	8	9	f	f
944	5	10	8	11	f	f
945	5	10	8	1	f	f
946	5	10	9	9	f	f
947	5	10	9	11	f	f
948	5	10	9	1	f	f
949	5	10	10	9	f	f
950	5	10	10	11	f	f
951	5	10	10	1	f	f
952	5	10	11	9	f	f
953	5	10	11	11	f	f
954	5	10	11	1	f	f
955	5	10	13	9	f	f
956	5	10	13	11	f	f
957	5	10	13	1	f	f
958	5	10	14	9	f	f
959	5	10	14	11	f	f
960	5	10	14	1	f	f
961	5	10	12	9	f	f
962	5	10	12	11	f	f
963	5	10	12	1	f	f
964	5	11	1	9	f	f
965	5	11	1	11	f	f
966	5	11	1	1	f	f
967	5	11	2	9	f	f
968	5	11	2	11	f	f
969	5	11	2	1	f	f
970	5	11	3	9	f	f
971	5	11	3	11	f	f
972	5	11	3	1	f	f
973	5	11	7	9	f	f
974	5	11	7	11	f	f
975	5	11	7	1	f	f
976	5	11	8	9	f	f
977	5	11	8	11	f	f
978	5	11	8	1	f	f
979	5	11	9	9	f	f
980	5	11	9	11	f	f
981	5	11	9	1	f	f
982	5	11	10	9	f	f
983	5	11	10	11	f	f
984	5	11	10	1	f	f
985	5	11	11	9	f	f
986	5	11	11	11	f	f
987	5	11	11	1	f	f
988	5	11	13	9	f	f
989	5	11	13	11	f	f
990	5	11	13	1	f	f
991	5	11	14	9	f	f
992	5	11	14	11	f	f
993	5	11	14	1	f	f
994	5	11	12	9	f	f
995	5	11	12	11	f	f
996	5	11	12	1	f	f
997	5	13	1	9	f	f
998	5	13	1	11	f	f
999	5	13	1	1	f	f
1000	5	13	2	9	f	f
1001	5	13	2	11	f	f
1002	5	13	2	1	f	f
1003	5	13	3	9	f	f
1004	5	13	3	11	f	f
1005	5	13	3	1	f	f
1006	5	13	7	9	f	f
1007	5	13	7	11	f	f
1008	5	13	7	1	f	f
1009	5	13	8	9	f	f
1010	5	13	8	11	f	f
1011	5	13	8	1	f	f
1012	5	13	9	9	f	f
1013	5	13	9	11	f	f
1014	5	13	9	1	f	f
1015	5	13	10	9	f	f
1016	5	13	10	11	f	f
1017	5	13	10	1	f	f
1018	5	13	11	9	f	f
1019	5	13	11	11	f	f
1020	5	13	11	1	f	f
1021	5	13	13	9	f	f
1022	5	13	13	11	f	f
1023	5	13	13	1	f	f
1024	5	13	14	9	f	f
1025	5	13	14	11	f	f
1026	5	13	14	1	f	f
1027	5	13	12	9	f	f
1028	5	13	12	11	f	f
1029	5	13	12	1	f	f
1030	5	14	1	9	f	f
1031	5	14	1	11	f	f
1032	5	14	1	1	f	f
1033	5	14	2	9	f	f
1034	5	14	2	11	f	f
1035	5	14	2	1	f	f
1036	5	14	3	9	f	f
1037	5	14	3	11	f	f
1038	5	14	3	1	f	f
1039	5	14	7	9	f	f
1040	5	14	7	11	f	f
1041	5	14	7	1	f	f
1042	5	14	8	9	f	f
1043	5	14	8	11	f	f
1044	5	14	8	1	f	f
1045	5	14	9	9	f	f
1046	5	14	9	11	f	f
1047	5	14	9	1	f	f
1048	5	14	10	9	f	f
1049	5	14	10	11	f	f
1050	5	14	10	1	f	f
1051	5	14	11	9	f	f
1052	5	14	11	11	f	f
1053	5	14	11	1	f	f
1054	5	14	13	9	f	f
1055	5	14	13	11	f	f
1056	5	14	13	1	f	f
1057	5	14	14	9	f	f
1058	5	14	14	11	f	f
1059	5	14	14	1	f	f
1060	5	14	12	9	f	f
1061	5	14	12	11	f	f
1062	5	14	12	1	f	f
1063	5	12	1	9	f	f
1064	5	12	1	11	f	f
1065	5	12	1	1	f	f
1066	5	12	2	9	f	f
1067	5	12	2	11	f	f
1068	5	12	2	1	f	f
1069	5	12	3	9	f	f
1070	5	12	3	11	f	f
1071	5	12	3	1	f	f
1072	5	12	7	9	f	f
1073	5	12	7	11	f	f
1074	5	12	7	1	f	f
1075	5	12	8	9	f	f
1076	5	12	8	11	f	f
1077	5	12	8	1	f	f
1078	5	12	9	9	f	f
1079	5	12	9	11	f	f
1080	5	12	9	1	f	f
1081	5	12	10	9	f	f
1082	5	12	10	11	f	f
1083	5	12	10	1	f	f
1084	5	12	11	9	f	f
1085	5	12	11	11	f	f
1086	5	12	11	1	f	f
1087	5	12	13	9	f	f
1088	5	12	13	11	f	f
1089	5	12	13	1	f	f
1090	5	12	14	9	f	f
1091	5	12	14	11	f	f
1092	5	12	14	1	f	f
1093	5	12	12	9	f	f
1094	5	12	12	11	f	f
1095	5	12	12	1	f	f
1096	6	1	1	9	f	f
1097	6	1	1	11	f	f
1098	6	1	1	1	f	f
1099	6	1	2	9	f	f
1100	6	1	2	11	f	f
1101	6	1	2	1	f	f
1102	6	1	3	9	f	f
1103	6	1	3	11	f	f
1104	6	1	3	1	f	f
1105	6	1	7	9	f	f
1106	6	1	7	11	f	f
1107	6	1	7	1	f	f
1108	6	1	8	9	f	f
1109	6	1	8	11	f	f
1110	6	1	8	1	f	f
1111	6	1	9	9	f	f
1112	6	1	9	11	f	f
1113	6	1	9	1	f	f
1114	6	1	10	9	f	f
1115	6	1	10	11	f	f
1116	6	1	10	1	f	f
1117	6	1	11	9	f	f
1118	6	1	11	11	f	f
1119	6	1	11	1	f	f
1120	6	1	13	9	f	f
1121	6	1	13	11	f	f
1122	6	1	13	1	f	f
1123	6	1	14	9	f	f
1124	6	1	14	11	f	f
1125	6	1	14	1	f	f
1126	6	1	12	9	f	f
1127	6	1	12	11	f	f
1128	6	1	12	1	f	f
1129	6	2	1	9	f	f
1130	6	2	1	11	f	f
1131	6	2	1	1	f	f
1132	6	2	2	9	f	f
1133	6	2	2	11	f	f
1134	6	2	2	1	f	f
1135	6	2	3	9	f	f
1136	6	2	3	11	f	f
1137	6	2	3	1	f	f
1138	6	2	7	9	f	f
1139	6	2	7	11	f	f
1140	6	2	7	1	f	f
1141	6	2	8	9	f	f
1142	6	2	8	11	f	f
1143	6	2	8	1	f	f
1144	6	2	9	9	f	f
1145	6	2	9	11	f	f
1146	6	2	9	1	f	f
1147	6	2	10	9	f	f
1148	6	2	10	11	f	f
1149	6	2	10	1	f	f
1150	6	2	11	9	f	f
1151	6	2	11	11	f	f
1152	6	2	11	1	f	f
1153	6	2	13	9	f	f
1154	6	2	13	11	f	f
1155	6	2	13	1	f	f
1156	6	2	14	9	f	f
1157	6	2	14	11	f	f
1158	6	2	14	1	f	f
1159	6	2	12	9	f	f
1160	6	2	12	11	f	f
1161	6	2	12	1	f	f
1162	6	3	1	9	f	f
1163	6	3	1	11	f	f
1164	6	3	1	1	f	f
1165	6	3	2	9	f	f
1166	6	3	2	11	f	f
1167	6	3	2	1	f	f
1168	6	3	3	9	f	f
1169	6	3	3	11	f	f
1170	6	3	3	1	f	f
1171	6	3	7	9	f	f
1172	6	3	7	11	f	f
1173	6	3	7	1	f	f
1174	6	3	8	9	f	f
1175	6	3	8	11	f	f
1176	6	3	8	1	f	f
1177	6	3	9	9	f	f
1178	6	3	9	11	f	f
1179	6	3	9	1	f	f
1180	6	3	10	9	f	f
1181	6	3	10	11	f	f
1182	6	3	10	1	f	f
1183	6	3	11	9	f	f
1184	6	3	11	11	f	f
1185	6	3	11	1	f	f
1186	6	3	13	9	f	f
1187	6	3	13	11	f	f
1188	6	3	13	1	f	f
1189	6	3	14	9	f	f
1190	6	3	14	11	f	f
1191	6	3	14	1	f	f
1192	6	3	12	9	f	f
1193	6	3	12	11	f	f
1194	6	3	12	1	f	f
1195	6	7	1	9	f	f
1196	6	7	1	11	f	f
1197	6	7	1	1	f	f
1198	6	7	2	9	f	f
1199	6	7	2	11	f	f
1200	6	7	2	1	f	f
1201	6	7	3	9	f	f
1202	6	7	3	11	f	f
1203	6	7	3	1	f	f
1204	6	7	7	9	f	f
1205	6	7	7	11	f	f
1206	6	7	7	1	f	f
1207	6	7	8	9	f	f
1208	6	7	8	11	f	f
1209	6	7	8	1	f	f
1210	6	7	9	9	f	f
1211	6	7	9	11	f	f
1212	6	7	9	1	f	f
1213	6	7	10	9	f	f
1214	6	7	10	11	f	f
1215	6	7	10	1	f	f
1216	6	7	11	9	f	f
1217	6	7	11	11	f	f
1218	6	7	11	1	f	f
1219	6	7	13	9	f	f
1220	6	7	13	11	f	f
1221	6	7	13	1	f	f
1222	6	7	14	9	f	f
1223	6	7	14	11	f	f
1224	6	7	14	1	f	f
1225	6	7	12	9	f	f
1226	6	7	12	11	f	f
1227	6	7	12	1	f	f
1228	6	8	1	9	f	f
1229	6	8	1	11	f	f
1230	6	8	1	1	f	f
1231	6	8	2	9	f	f
1232	6	8	2	11	f	f
1233	6	8	2	1	f	f
1234	6	8	3	9	f	f
1235	6	8	3	11	f	f
1236	6	8	3	1	f	f
1237	6	8	7	9	f	f
1238	6	8	7	11	f	f
1239	6	8	7	1	f	f
1240	6	8	8	9	f	f
1241	6	8	8	11	f	f
1242	6	8	8	1	f	f
1243	6	8	9	9	f	f
1244	6	8	9	11	f	f
1245	6	8	9	1	f	f
1246	6	8	10	9	f	f
1247	6	8	10	11	f	f
1248	6	8	10	1	f	f
1249	6	8	11	9	f	f
1250	6	8	11	11	f	f
1251	6	8	11	1	f	f
1252	6	8	13	9	f	f
1253	6	8	13	11	f	f
1254	6	8	13	1	f	f
1255	6	8	14	9	f	f
1256	6	8	14	11	f	f
1257	6	8	14	1	f	f
1258	6	8	12	9	f	f
1259	6	8	12	11	f	f
1260	6	8	12	1	f	f
1261	6	9	1	9	f	f
1262	6	9	1	11	f	f
1263	6	9	1	1	f	f
1264	6	9	2	9	f	f
1265	6	9	2	11	f	f
1266	6	9	2	1	f	f
1267	6	9	3	9	f	f
1268	6	9	3	11	f	f
1269	6	9	3	1	f	f
1270	6	9	7	9	f	f
1271	6	9	7	11	f	f
1272	6	9	7	1	f	f
1273	6	9	8	9	f	f
1274	6	9	8	11	f	f
1275	6	9	8	1	f	f
1276	6	9	9	9	f	f
1277	6	9	9	11	f	f
1278	6	9	9	1	f	f
1279	6	9	10	9	f	f
1280	6	9	10	11	f	f
1281	6	9	10	1	f	f
1282	6	9	11	9	f	f
1283	6	9	11	11	f	f
1284	6	9	11	1	f	f
1285	6	9	13	9	f	f
1286	6	9	13	11	f	f
1287	6	9	13	1	f	f
1288	6	9	14	9	f	f
1289	6	9	14	11	f	f
1290	6	9	14	1	f	f
1291	6	9	12	9	f	f
1292	6	9	12	11	f	f
1293	6	9	12	1	f	f
1294	6	10	1	9	f	f
1295	6	10	1	11	f	f
1296	6	10	1	1	f	f
1297	6	10	2	9	f	f
1298	6	10	2	11	f	f
1299	6	10	2	1	f	f
1300	6	10	3	9	f	f
1301	6	10	3	11	f	f
1302	6	10	3	1	f	f
1303	6	10	7	9	f	f
1304	6	10	7	11	f	f
1305	6	10	7	1	f	f
1306	6	10	8	9	f	f
1307	6	10	8	11	f	f
1308	6	10	8	1	f	f
1309	6	10	9	9	f	f
1310	6	10	9	11	f	f
1311	6	10	9	1	f	f
1312	6	10	10	9	f	f
1313	6	10	10	11	f	f
1314	6	10	10	1	f	f
1315	6	10	11	9	f	f
1316	6	10	11	11	f	f
1317	6	10	11	1	f	f
1318	6	10	13	9	f	f
1319	6	10	13	11	f	f
1320	6	10	13	1	f	f
1321	6	10	14	9	f	f
1322	6	10	14	11	f	f
1323	6	10	14	1	f	f
1324	6	10	12	9	f	f
1325	6	10	12	11	f	f
1326	6	10	12	1	f	f
1327	6	11	1	9	f	f
1328	6	11	1	11	f	f
1329	6	11	1	1	f	f
1330	6	11	2	9	f	f
1331	6	11	2	11	f	f
1332	6	11	2	1	f	f
1333	6	11	3	9	f	f
1334	6	11	3	11	f	f
1335	6	11	3	1	f	f
1336	6	11	7	9	f	f
1337	6	11	7	11	f	f
1338	6	11	7	1	f	f
1339	6	11	8	9	f	f
1340	6	11	8	11	f	f
1341	6	11	8	1	f	f
1342	6	11	9	9	f	f
1343	6	11	9	11	f	f
1344	6	11	9	1	f	f
1345	6	11	10	9	f	f
1346	6	11	10	11	f	f
1347	6	11	10	1	f	f
1348	6	11	11	9	f	f
1349	6	11	11	11	f	f
1350	6	11	11	1	f	f
1351	6	11	13	9	f	f
1352	6	11	13	11	f	f
1353	6	11	13	1	f	f
1354	6	11	14	9	f	f
1355	6	11	14	11	f	f
1356	6	11	14	1	f	f
1357	6	11	12	9	f	f
1358	6	11	12	11	f	f
1359	6	11	12	1	f	f
1360	6	13	1	9	f	f
1361	6	13	1	11	f	f
1362	6	13	1	1	f	f
1363	6	13	2	9	f	f
1364	6	13	2	11	f	f
1365	6	13	2	1	f	f
1366	6	13	3	9	f	f
1367	6	13	3	11	f	f
1368	6	13	3	1	f	f
1369	6	13	7	9	f	f
1370	6	13	7	11	f	f
1371	6	13	7	1	f	f
1372	6	13	8	9	f	f
1373	6	13	8	11	f	f
1374	6	13	8	1	f	f
1375	6	13	9	9	f	f
1376	6	13	9	11	f	f
1377	6	13	9	1	f	f
1378	6	13	10	9	f	f
1379	6	13	10	11	f	f
1380	6	13	10	1	f	f
1381	6	13	11	9	f	f
1382	6	13	11	11	f	f
1383	6	13	11	1	f	f
1384	6	13	13	9	f	f
1385	6	13	13	11	f	f
1386	6	13	13	1	f	f
1387	6	13	14	9	f	f
1388	6	13	14	11	f	f
1389	6	13	14	1	f	f
1390	6	13	12	9	f	f
1391	6	13	12	11	f	f
1392	6	13	12	1	f	f
1393	6	14	1	9	f	f
1394	6	14	1	11	f	f
1395	6	14	1	1	f	f
1396	6	14	2	9	f	f
1397	6	14	2	11	f	f
1398	6	14	2	1	f	f
1399	6	14	3	9	f	f
1400	6	14	3	11	f	f
1401	6	14	3	1	f	f
1402	6	14	7	9	f	f
1403	6	14	7	11	f	f
1404	6	14	7	1	f	f
1405	6	14	8	9	f	f
1406	6	14	8	11	f	f
1407	6	14	8	1	f	f
1408	6	14	9	9	f	f
1409	6	14	9	11	f	f
1410	6	14	9	1	f	f
1411	6	14	10	9	f	f
1412	6	14	10	11	f	f
1413	6	14	10	1	f	f
1414	6	14	11	9	f	f
1415	6	14	11	11	f	f
1416	6	14	11	1	f	f
1417	6	14	13	9	f	f
1418	6	14	13	11	f	f
1419	6	14	13	1	f	f
1420	6	14	14	9	f	f
1421	6	14	14	11	f	f
1422	6	14	14	1	f	f
1423	6	14	12	9	f	f
1424	6	14	12	11	f	f
1425	6	14	12	1	f	f
1426	6	12	1	9	f	f
1427	6	12	1	11	f	f
1428	6	12	1	1	f	f
1429	6	12	2	9	f	f
1430	6	12	2	11	f	f
1431	6	12	2	1	f	f
1432	6	12	3	9	f	f
1433	6	12	3	11	f	f
1434	6	12	3	1	f	f
1435	6	12	7	9	f	f
1436	6	12	7	11	f	f
1437	6	12	7	1	f	f
1438	6	12	8	9	f	f
1439	6	12	8	11	f	f
1440	6	12	8	1	f	f
1441	6	12	9	9	f	f
1442	6	12	9	11	f	f
1443	6	12	9	1	f	f
1444	6	12	10	9	f	f
1445	6	12	10	11	f	f
1446	6	12	10	1	f	f
1447	6	12	11	9	f	f
1448	6	12	11	11	f	f
1449	6	12	11	1	f	f
1450	6	12	13	9	f	f
1451	6	12	13	11	f	f
1452	6	12	13	1	f	f
1453	6	12	14	9	f	f
1454	6	12	14	11	f	f
1455	6	12	14	1	f	f
1456	6	12	12	9	f	f
1457	6	12	12	11	f	f
1458	6	12	12	1	f	f
1459	7	1	1	9	f	f
1460	7	1	1	11	f	f
1461	7	1	1	1	f	f
1462	7	1	4	9	f	f
1463	7	1	4	11	f	f
1464	7	1	4	1	f	f
1465	7	1	7	9	f	f
1466	7	1	7	11	f	f
1467	7	1	7	1	f	f
1468	7	1	8	9	f	f
1469	7	1	8	11	f	f
1470	7	1	8	1	f	f
1471	7	1	9	9	f	f
1472	7	1	9	11	f	f
1473	7	1	9	1	f	f
1474	7	1	10	9	f	f
1475	7	1	10	11	f	f
1476	7	1	10	1	f	f
1477	7	1	11	9	f	f
1478	7	1	11	11	f	f
1479	7	1	11	1	f	f
1480	7	1	13	9	f	f
1481	7	1	13	11	f	f
1482	7	1	13	1	f	f
1483	7	1	14	9	f	f
1484	7	1	14	11	f	f
1485	7	1	14	1	f	f
1486	7	1	12	9	f	f
1487	7	1	12	11	f	f
1488	7	1	12	1	f	f
1489	7	4	1	9	f	f
1490	7	4	1	11	f	f
1491	7	4	1	1	f	f
1492	7	4	4	9	f	f
1493	7	4	4	11	f	f
1494	7	4	4	1	f	f
1495	7	4	7	9	f	f
1496	7	4	7	11	f	f
1497	7	4	7	1	f	f
1498	7	4	8	9	f	f
1499	7	4	8	11	f	f
1500	7	4	8	1	f	f
1501	7	4	9	9	f	f
1502	7	4	9	11	f	f
1503	7	4	9	1	f	f
1504	7	4	10	9	f	f
1505	7	4	10	11	f	f
1506	7	4	10	1	f	f
1507	7	4	11	9	f	f
1508	7	4	11	11	f	f
1509	7	4	11	1	f	f
1510	7	4	13	9	f	f
1511	7	4	13	11	f	f
1512	7	4	13	1	f	f
1513	7	4	14	9	f	f
1514	7	4	14	11	f	f
1515	7	4	14	1	f	f
1516	7	4	12	9	f	f
1517	7	4	12	11	f	f
1518	7	4	12	1	f	f
1519	7	7	1	9	f	f
1520	7	7	1	11	f	f
1521	7	7	1	1	f	f
1522	7	7	4	9	f	f
1523	7	7	4	11	f	f
1524	7	7	4	1	f	f
1525	7	7	7	9	f	f
1526	7	7	7	11	f	f
1527	7	7	7	1	f	f
1528	7	7	8	9	f	f
1529	7	7	8	11	f	f
1530	7	7	8	1	f	f
1531	7	7	9	9	f	f
1532	7	7	9	11	f	f
1533	7	7	9	1	f	f
1534	7	7	10	9	f	f
1535	7	7	10	11	f	f
1536	7	7	10	1	f	f
1537	7	7	11	9	f	f
1538	7	7	11	11	f	f
1539	7	7	11	1	f	f
1540	7	7	13	9	f	f
1541	7	7	13	11	f	f
1542	7	7	13	1	f	f
1543	7	7	14	9	f	f
1544	7	7	14	11	f	f
1545	7	7	14	1	f	f
1546	7	7	12	9	f	f
1547	7	7	12	11	f	f
1548	7	7	12	1	f	f
1549	7	8	1	9	f	f
1550	7	8	1	11	f	f
1551	7	8	1	1	f	f
1552	7	8	4	9	f	f
1553	7	8	4	11	f	f
1554	7	8	4	1	f	f
1555	7	8	7	9	f	f
1556	7	8	7	11	f	f
1557	7	8	7	1	f	f
1558	7	8	8	9	f	f
1559	7	8	8	11	f	f
1560	7	8	8	1	f	f
1561	7	8	9	9	f	f
1562	7	8	9	11	f	f
1563	7	8	9	1	f	f
1564	7	8	10	9	f	f
1565	7	8	10	11	f	f
1566	7	8	10	1	f	f
1567	7	8	11	9	f	f
1568	7	8	11	11	f	f
1569	7	8	11	1	f	f
1570	7	8	13	9	f	f
1571	7	8	13	11	f	f
1572	7	8	13	1	f	f
1573	7	8	14	9	f	f
1574	7	8	14	11	f	f
1575	7	8	14	1	f	f
1576	7	8	12	9	f	f
1577	7	8	12	11	f	f
1578	7	8	12	1	f	f
1579	7	9	1	9	f	f
1580	7	9	1	11	f	f
1581	7	9	1	1	f	f
1582	7	9	4	9	f	f
1583	7	9	4	11	f	f
1584	7	9	4	1	f	f
1585	7	9	7	9	f	f
1586	7	9	7	11	f	f
1587	7	9	7	1	f	f
1588	7	9	8	9	f	f
1589	7	9	8	11	f	f
1590	7	9	8	1	f	f
1591	7	9	9	9	f	f
1592	7	9	9	11	f	f
1593	7	9	9	1	f	f
1594	7	9	10	9	f	f
1595	7	9	10	11	f	f
1596	7	9	10	1	f	f
1597	7	9	11	9	f	f
1598	7	9	11	11	f	f
1599	7	9	11	1	f	f
1600	7	9	13	9	f	f
1601	7	9	13	11	f	f
1602	7	9	13	1	f	f
1603	7	9	14	9	f	f
1604	7	9	14	11	f	f
1605	7	9	14	1	f	f
1606	7	9	12	9	f	f
1607	7	9	12	11	f	f
1608	7	9	12	1	f	f
1609	7	10	1	9	f	f
1610	7	10	1	11	f	f
1611	7	10	1	1	f	f
1612	7	10	4	9	f	f
1613	7	10	4	11	f	f
1614	7	10	4	1	f	f
1615	7	10	7	9	f	f
1616	7	10	7	11	f	f
1617	7	10	7	1	f	f
1618	7	10	8	9	f	f
1619	7	10	8	11	f	f
1620	7	10	8	1	f	f
1621	7	10	9	9	f	f
1622	7	10	9	11	f	f
1623	7	10	9	1	f	f
1624	7	10	10	9	f	f
1625	7	10	10	11	f	f
1626	7	10	10	1	f	f
1627	7	10	11	9	f	f
1628	7	10	11	11	f	f
1629	7	10	11	1	f	f
1630	7	10	13	9	f	f
1631	7	10	13	11	f	f
1632	7	10	13	1	f	f
1633	7	10	14	9	f	f
1634	7	10	14	11	f	f
1635	7	10	14	1	f	f
1636	7	10	12	9	f	f
1637	7	10	12	11	f	f
1638	7	10	12	1	f	f
1639	7	11	1	9	f	f
1640	7	11	1	11	f	f
1641	7	11	1	1	f	f
1642	7	11	4	9	f	f
1643	7	11	4	11	f	f
1644	7	11	4	1	f	f
1645	7	11	7	9	f	f
1646	7	11	7	11	f	f
1647	7	11	7	1	f	f
1648	7	11	8	9	f	f
1649	7	11	8	11	f	f
1650	7	11	8	1	f	f
1651	7	11	9	9	f	f
1652	7	11	9	11	f	f
1653	7	11	9	1	f	f
1654	7	11	10	9	f	f
1655	7	11	10	11	f	f
1656	7	11	10	1	f	f
1657	7	11	11	9	f	f
1658	7	11	11	11	f	f
1659	7	11	11	1	f	f
1660	7	11	13	9	f	f
1661	7	11	13	11	f	f
1662	7	11	13	1	f	f
1663	7	11	14	9	f	f
1664	7	11	14	11	f	f
1665	7	11	14	1	f	f
1666	7	11	12	9	f	f
1667	7	11	12	11	f	f
1668	7	11	12	1	f	f
1669	7	13	1	9	f	f
1670	7	13	1	11	f	f
1671	7	13	1	1	f	f
1672	7	13	4	9	f	f
1673	7	13	4	11	f	f
1674	7	13	4	1	f	f
1675	7	13	7	9	f	f
1676	7	13	7	11	f	f
1677	7	13	7	1	f	f
1678	7	13	8	9	f	f
1679	7	13	8	11	f	f
1680	7	13	8	1	f	f
1681	7	13	9	9	f	f
1682	7	13	9	11	f	f
1683	7	13	9	1	f	f
1684	7	13	10	9	f	f
1685	7	13	10	11	f	f
1686	7	13	10	1	f	f
1687	7	13	11	9	f	f
1688	7	13	11	11	f	f
1689	7	13	11	1	f	f
1690	7	13	13	9	f	f
1691	7	13	13	11	f	f
1692	7	13	13	1	f	f
1693	7	13	14	9	f	f
1694	7	13	14	11	f	f
1695	7	13	14	1	f	f
1696	7	13	12	9	f	f
1697	7	13	12	11	f	f
1698	7	13	12	1	f	f
1699	7	14	1	9	f	f
1700	7	14	1	11	f	f
1701	7	14	1	1	f	f
1702	7	14	4	9	f	f
1703	7	14	4	11	f	f
1704	7	14	4	1	f	f
1705	7	14	7	9	f	f
1706	7	14	7	11	f	f
1707	7	14	7	1	f	f
1708	7	14	8	9	f	f
1709	7	14	8	11	f	f
1710	7	14	8	1	f	f
1711	7	14	9	9	f	f
1712	7	14	9	11	f	f
1713	7	14	9	1	f	f
1714	7	14	10	9	f	f
1715	7	14	10	11	f	f
1716	7	14	10	1	f	f
1717	7	14	11	9	f	f
1718	7	14	11	11	f	f
1719	7	14	11	1	f	f
1720	7	14	13	9	f	f
1721	7	14	13	11	f	f
1722	7	14	13	1	f	f
1723	7	14	14	9	f	f
1724	7	14	14	11	f	f
1725	7	14	14	1	f	f
1726	7	14	12	9	f	f
1727	7	14	12	11	f	f
1728	7	14	12	1	f	f
1729	7	12	1	9	f	f
1730	7	12	1	11	f	f
1731	7	12	1	1	f	f
1732	7	12	4	9	f	f
1733	7	12	4	11	f	f
1734	7	12	4	1	f	f
1735	7	12	7	9	f	f
1736	7	12	7	11	f	f
1737	7	12	7	1	f	f
1738	7	12	8	9	f	f
1739	7	12	8	11	f	f
1740	7	12	8	1	f	f
1741	7	12	9	9	f	f
1742	7	12	9	11	f	f
1743	7	12	9	1	f	f
1744	7	12	10	9	f	f
1745	7	12	10	11	f	f
1746	7	12	10	1	f	f
1747	7	12	11	9	f	f
1748	7	12	11	11	f	f
1749	7	12	11	1	f	f
1750	7	12	13	9	f	f
1751	7	12	13	11	f	f
1752	7	12	13	1	f	f
1753	7	12	14	9	f	f
1754	7	12	14	11	f	f
1755	7	12	14	1	f	f
1756	7	12	12	9	f	f
1757	7	12	12	11	f	f
1758	7	12	12	1	f	f
\.


--
-- Name: announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcements_id_seq', 1, false);


--
-- Name: attachable_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attachable_journals_id_seq', 1, false);


--
-- Name: attachment_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attachment_journals_id_seq', 2, true);


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attachments_id_seq', 2, true);


--
-- Name: attribute_help_texts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attribute_help_texts_id_seq', 1, false);


--
-- Name: auth_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_providers_id_seq', 1, false);


--
-- Name: bcf_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bcf_comments_id_seq', 1, false);


--
-- Name: bcf_issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bcf_issues_id_seq', 1, false);


--
-- Name: bcf_viewpoints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bcf_viewpoints_id_seq', 1, false);


--
-- Name: budget_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.budget_journals_id_seq', 1, false);


--
-- Name: budgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.budgets_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 2, true);


--
-- Name: changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.changes_id_seq', 1, false);


--
-- Name: changeset_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.changeset_journals_id_seq', 1, false);


--
-- Name: changesets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.changesets_id_seq', 1, false);


--
-- Name: colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.colors_id_seq', 149, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: cost_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cost_entries_id_seq', 1, false);


--
-- Name: cost_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cost_queries_id_seq', 1, false);


--
-- Name: cost_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cost_types_id_seq', 1, false);


--
-- Name: custom_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_actions_id_seq', 1, false);


--
-- Name: custom_actions_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_actions_projects_id_seq', 1, false);


--
-- Name: custom_actions_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_actions_roles_id_seq', 1, false);


--
-- Name: custom_actions_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_actions_statuses_id_seq', 1, false);


--
-- Name: custom_actions_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_actions_types_id_seq', 1, false);


--
-- Name: custom_field_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_field_sections_id_seq', 1, true);


--
-- Name: custom_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_fields_id_seq', 1, false);


--
-- Name: custom_fields_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_fields_projects_id_seq', 1, false);


--
-- Name: custom_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_options_id_seq', 1, false);


--
-- Name: custom_styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_styles_id_seq', 1, false);


--
-- Name: custom_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_values_id_seq', 1, false);


--
-- Name: customizable_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customizable_journals_id_seq', 1, false);


--
-- Name: deploy_status_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.deploy_status_checks_id_seq', 1, false);


--
-- Name: deploy_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.deploy_targets_id_seq', 1, false);


--
-- Name: design_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.design_colors_id_seq', 1, false);


--
-- Name: document_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.document_journals_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: emoji_reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.emoji_reactions_id_seq', 1, false);


--
-- Name: enabled_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enabled_modules_id_seq', 66, true);


--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprise_tokens_id_seq', 1, false);


--
-- Name: enumerations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enumerations_id_seq', 13, true);


--
-- Name: exports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.exports_id_seq', 1, false);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.favorites_id_seq', 1, false);


--
-- Name: file_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.file_links_id_seq', 1, false);


--
-- Name: forums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forums_id_seq', 1, false);


--
-- Name: github_check_runs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.github_check_runs_id_seq', 1, false);


--
-- Name: github_pull_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.github_pull_requests_id_seq', 1, false);


--
-- Name: github_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.github_users_id_seq', 1, false);


--
-- Name: gitlab_issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gitlab_issues_id_seq', 1, false);


--
-- Name: gitlab_merge_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gitlab_merge_requests_id_seq', 1, false);


--
-- Name: gitlab_pipelines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gitlab_pipelines_id_seq', 1, false);


--
-- Name: gitlab_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gitlab_users_id_seq', 1, false);


--
-- Name: grid_widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.grid_widgets_id_seq', 69, true);


--
-- Name: grids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.grids_id_seq', 41, true);


--
-- Name: group_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.group_users_id_seq', 1, false);


--
-- Name: hierarchical_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.hierarchical_items_id_seq', 1, false);


--
-- Name: ical_token_query_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ical_token_query_assignments_id_seq', 1, false);


--
-- Name: ifc_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ifc_models_id_seq', 1, false);


--
-- Name: job_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.job_statuses_id_seq', 1, false);


--
-- Name: journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.journals_id_seq', 81, true);


--
-- Name: labor_budget_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.labor_budget_items_id_seq', 1, false);


--
-- Name: last_project_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.last_project_folders_id_seq', 1, false);


--
-- Name: ldap_auth_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ldap_auth_sources_id_seq', 1, false);


--
-- Name: ldap_groups_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ldap_groups_memberships_id_seq', 1, false);


--
-- Name: ldap_groups_synchronized_filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ldap_groups_synchronized_filters_id_seq', 1, false);


--
-- Name: ldap_groups_synchronized_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ldap_groups_synchronized_groups_id_seq', 1, false);


--
-- Name: material_budget_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.material_budget_items_id_seq', 1, false);


--
-- Name: meeting_agenda_item_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_agenda_item_journals_id_seq', 1, false);


--
-- Name: meeting_agenda_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_agenda_items_id_seq', 9, true);


--
-- Name: meeting_content_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_content_journals_id_seq', 1, false);


--
-- Name: meeting_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_contents_id_seq', 1, false);


--
-- Name: meeting_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_journals_id_seq', 1, true);


--
-- Name: meeting_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_participants_id_seq', 1, true);


--
-- Name: meeting_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meeting_sections_id_seq', 1, true);


--
-- Name: meetings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meetings_id_seq', 1, true);


--
-- Name: member_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.member_roles_id_seq', 2, true);


--
-- Name: members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.members_id_seq', 2, true);


--
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 37, true);


--
-- Name: message_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.message_journals_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.news_id_seq', 2, true);


--
-- Name: news_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.news_journals_id_seq', 2, true);


--
-- Name: non_working_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.non_working_days_id_seq', 1, false);


--
-- Name: notification_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_settings_id_seq', 34, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oauth_access_grants_id_seq', 1, false);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oauth_access_tokens_id_seq', 1, false);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oauth_applications_id_seq', 1, true);


--
-- Name: oauth_client_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oauth_client_tokens_id_seq', 1, false);


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oauth_clients_id_seq', 1, false);


--
-- Name: oidc_user_session_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.oidc_user_session_links_id_seq', 1, false);


--
-- Name: ordered_work_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ordered_work_packages_id_seq', 10, true);


--
-- Name: paper_trail_audits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.paper_trail_audits_id_seq', 1, false);


--
-- Name: project_custom_field_project_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_custom_field_project_mappings_id_seq', 1, false);


--
-- Name: project_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_journals_id_seq', 38, true);


--
-- Name: project_life_cycle_step_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_life_cycle_step_definitions_id_seq', 7, true);


--
-- Name: project_life_cycle_steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_life_cycle_steps_id_seq', 1, false);


--
-- Name: project_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_queries_id_seq', 1, false);


--
-- Name: project_storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_storages_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.projects_id_seq', 37, true);


--
-- Name: queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.queries_id_seq', 59, true);


--
-- Name: rates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rates_id_seq', 1, false);


--
-- Name: recaptcha_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recaptcha_entries_id_seq', 1, false);


--
-- Name: relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.relations_id_seq', 7, true);


--
-- Name: remote_identities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.remote_identities_id_seq', 1, false);


--
-- Name: repositories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.repositories_id_seq', 1, false);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 313, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 11, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 55, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.settings_id_seq', 175, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.statuses_id_seq', 14, true);


--
-- Name: storages_file_links_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.storages_file_links_journals_id_seq', 1, false);


--
-- Name: storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.storages_id_seq', 1, false);


--
-- Name: time_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.time_entries_id_seq', 1, false);


--
-- Name: time_entry_activities_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.time_entry_activities_projects_id_seq', 1, false);


--
-- Name: time_entry_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.time_entry_journals_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tokens_id_seq', 66, true);


--
-- Name: two_factor_authentication_devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.two_factor_authentication_devices_id_seq', 1, false);


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.types_id_seq', 7, true);


--
-- Name: user_passwords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_passwords_id_seq', 35, true);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_preferences_id_seq', 34, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 37, true);


--
-- Name: version_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.version_settings_id_seq', 4, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.versions_id_seq', 4, true);


--
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.views_id_seq', 8, true);


--
-- Name: watchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.watchers_id_seq', 3, true);


--
-- Name: webhooks_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhooks_events_id_seq', 1, false);


--
-- Name: webhooks_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhooks_logs_id_seq', 1, false);


--
-- Name: webhooks_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhooks_projects_id_seq', 1, false);


--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhooks_webhooks_id_seq', 1, false);


--
-- Name: wiki_page_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wiki_page_journals_id_seq', 3, true);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wiki_pages_id_seq', 3, true);


--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wiki_redirects_id_seq', 1, false);


--
-- Name: wikis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wikis_id_seq', 37, true);


--
-- Name: work_package_journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.work_package_journals_id_seq', 86, true);


--
-- Name: work_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.work_packages_id_seq', 36, true);


--
-- Name: workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.workflows_id_seq', 1758, true);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attachable_journals attachable_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachable_journals
    ADD CONSTRAINT attachable_journals_pkey PRIMARY KEY (id);


--
-- Name: attachment_journals attachment_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachment_journals
    ADD CONSTRAINT attachment_journals_pkey PRIMARY KEY (id);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: attribute_help_texts attribute_help_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attribute_help_texts
    ADD CONSTRAINT attribute_help_texts_pkey PRIMARY KEY (id);


--
-- Name: auth_providers auth_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_providers
    ADD CONSTRAINT auth_providers_pkey PRIMARY KEY (id);


--
-- Name: bcf_comments bcf_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_comments
    ADD CONSTRAINT bcf_comments_pkey PRIMARY KEY (id);


--
-- Name: bcf_issues bcf_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_issues
    ADD CONSTRAINT bcf_issues_pkey PRIMARY KEY (id);


--
-- Name: bcf_viewpoints bcf_viewpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_viewpoints
    ADD CONSTRAINT bcf_viewpoints_pkey PRIMARY KEY (id);


--
-- Name: budget_journals budget_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budget_journals
    ADD CONSTRAINT budget_journals_pkey PRIMARY KEY (id);


--
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: changes changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (id);


--
-- Name: changeset_journals changeset_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changeset_journals
    ADD CONSTRAINT changeset_journals_pkey PRIMARY KEY (id);


--
-- Name: changesets changesets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.changesets
    ADD CONSTRAINT changesets_pkey PRIMARY KEY (id);


--
-- Name: colors colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: cost_entries cost_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_entries
    ADD CONSTRAINT cost_entries_pkey PRIMARY KEY (id);


--
-- Name: cost_queries cost_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_queries
    ADD CONSTRAINT cost_queries_pkey PRIMARY KEY (id);


--
-- Name: cost_types cost_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_types
    ADD CONSTRAINT cost_types_pkey PRIMARY KEY (id);


--
-- Name: custom_actions custom_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions
    ADD CONSTRAINT custom_actions_pkey PRIMARY KEY (id);


--
-- Name: custom_actions_projects custom_actions_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_projects
    ADD CONSTRAINT custom_actions_projects_pkey PRIMARY KEY (id);


--
-- Name: custom_actions_roles custom_actions_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_roles
    ADD CONSTRAINT custom_actions_roles_pkey PRIMARY KEY (id);


--
-- Name: custom_actions_statuses custom_actions_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_statuses
    ADD CONSTRAINT custom_actions_statuses_pkey PRIMARY KEY (id);


--
-- Name: custom_actions_types custom_actions_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_actions_types
    ADD CONSTRAINT custom_actions_types_pkey PRIMARY KEY (id);


--
-- Name: custom_field_sections custom_field_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_sections
    ADD CONSTRAINT custom_field_sections_pkey PRIMARY KEY (id);


--
-- Name: custom_fields custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields
    ADD CONSTRAINT custom_fields_pkey PRIMARY KEY (id);


--
-- Name: custom_fields_projects custom_fields_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields_projects
    ADD CONSTRAINT custom_fields_projects_pkey PRIMARY KEY (id);


--
-- Name: custom_options custom_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_options
    ADD CONSTRAINT custom_options_pkey PRIMARY KEY (id);


--
-- Name: custom_styles custom_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_styles
    ADD CONSTRAINT custom_styles_pkey PRIMARY KEY (id);


--
-- Name: custom_values custom_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_values
    ADD CONSTRAINT custom_values_pkey PRIMARY KEY (id);


--
-- Name: customizable_journals customizable_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customizable_journals
    ADD CONSTRAINT customizable_journals_pkey PRIMARY KEY (id);


--
-- Name: deploy_status_checks deploy_status_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploy_status_checks
    ADD CONSTRAINT deploy_status_checks_pkey PRIMARY KEY (id);


--
-- Name: deploy_targets deploy_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploy_targets
    ADD CONSTRAINT deploy_targets_pkey PRIMARY KEY (id);


--
-- Name: design_colors design_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.design_colors
    ADD CONSTRAINT design_colors_pkey PRIMARY KEY (id);


--
-- Name: document_journals document_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_journals
    ADD CONSTRAINT document_journals_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: emoji_reactions emoji_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emoji_reactions
    ADD CONSTRAINT emoji_reactions_pkey PRIMARY KEY (id);


--
-- Name: enabled_modules enabled_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enabled_modules
    ADD CONSTRAINT enabled_modules_pkey PRIMARY KEY (id);


--
-- Name: enterprise_tokens enterprise_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_tokens
    ADD CONSTRAINT enterprise_tokens_pkey PRIMARY KEY (id);


--
-- Name: enumerations enumerations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enumerations
    ADD CONSTRAINT enumerations_pkey PRIMARY KEY (id);


--
-- Name: exports exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exports
    ADD CONSTRAINT exports_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: file_links file_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_links
    ADD CONSTRAINT file_links_pkey PRIMARY KEY (id);


--
-- Name: forums forums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forums
    ADD CONSTRAINT forums_pkey PRIMARY KEY (id);


--
-- Name: github_check_runs github_check_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_check_runs
    ADD CONSTRAINT github_check_runs_pkey PRIMARY KEY (id);


--
-- Name: github_pull_requests github_pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_pull_requests
    ADD CONSTRAINT github_pull_requests_pkey PRIMARY KEY (id);


--
-- Name: github_users github_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.github_users
    ADD CONSTRAINT github_users_pkey PRIMARY KEY (id);


--
-- Name: gitlab_issues gitlab_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_issues
    ADD CONSTRAINT gitlab_issues_pkey PRIMARY KEY (id);


--
-- Name: gitlab_merge_requests gitlab_merge_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_merge_requests
    ADD CONSTRAINT gitlab_merge_requests_pkey PRIMARY KEY (id);


--
-- Name: gitlab_pipelines gitlab_pipelines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_pipelines
    ADD CONSTRAINT gitlab_pipelines_pkey PRIMARY KEY (id);


--
-- Name: gitlab_users gitlab_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gitlab_users
    ADD CONSTRAINT gitlab_users_pkey PRIMARY KEY (id);


--
-- Name: good_job_batches good_job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_batches
    ADD CONSTRAINT good_job_batches_pkey PRIMARY KEY (id);


--
-- Name: good_job_executions good_job_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_executions
    ADD CONSTRAINT good_job_executions_pkey PRIMARY KEY (id);


--
-- Name: good_job_processes good_job_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_processes
    ADD CONSTRAINT good_job_processes_pkey PRIMARY KEY (id);


--
-- Name: good_job_settings good_job_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_settings
    ADD CONSTRAINT good_job_settings_pkey PRIMARY KEY (id);


--
-- Name: good_jobs good_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_jobs
    ADD CONSTRAINT good_jobs_pkey PRIMARY KEY (id);


--
-- Name: grid_widgets grid_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grid_widgets
    ADD CONSTRAINT grid_widgets_pkey PRIMARY KEY (id);


--
-- Name: grids grids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grids
    ADD CONSTRAINT grids_pkey PRIMARY KEY (id);


--
-- Name: group_users group_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_users
    ADD CONSTRAINT group_users_pkey PRIMARY KEY (id);


--
-- Name: hierarchical_items hierarchical_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hierarchical_items
    ADD CONSTRAINT hierarchical_items_pkey PRIMARY KEY (id);


--
-- Name: ical_token_query_assignments ical_token_query_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ical_token_query_assignments
    ADD CONSTRAINT ical_token_query_assignments_pkey PRIMARY KEY (id);


--
-- Name: ifc_models ifc_models_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ifc_models
    ADD CONSTRAINT ifc_models_pkey PRIMARY KEY (id);


--
-- Name: job_statuses job_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_statuses
    ADD CONSTRAINT job_statuses_pkey PRIMARY KEY (id);


--
-- Name: journals journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: labor_budget_items labor_budget_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_budget_items
    ADD CONSTRAINT labor_budget_items_pkey PRIMARY KEY (id);


--
-- Name: last_project_folders last_project_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.last_project_folders
    ADD CONSTRAINT last_project_folders_pkey PRIMARY KEY (id);


--
-- Name: ldap_auth_sources ldap_auth_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_auth_sources
    ADD CONSTRAINT ldap_auth_sources_pkey PRIMARY KEY (id);


--
-- Name: ldap_groups_memberships ldap_groups_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_memberships
    ADD CONSTRAINT ldap_groups_memberships_pkey PRIMARY KEY (id);


--
-- Name: ldap_groups_synchronized_filters ldap_groups_synchronized_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_synchronized_filters
    ADD CONSTRAINT ldap_groups_synchronized_filters_pkey PRIMARY KEY (id);


--
-- Name: ldap_groups_synchronized_groups ldap_groups_synchronized_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_synchronized_groups
    ADD CONSTRAINT ldap_groups_synchronized_groups_pkey PRIMARY KEY (id);


--
-- Name: material_budget_items material_budget_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.material_budget_items
    ADD CONSTRAINT material_budget_items_pkey PRIMARY KEY (id);


--
-- Name: meeting_agenda_item_journals meeting_agenda_item_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_item_journals
    ADD CONSTRAINT meeting_agenda_item_journals_pkey PRIMARY KEY (id);


--
-- Name: meeting_agenda_items meeting_agenda_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_items
    ADD CONSTRAINT meeting_agenda_items_pkey PRIMARY KEY (id);


--
-- Name: meeting_content_journals meeting_content_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_content_journals
    ADD CONSTRAINT meeting_content_journals_pkey PRIMARY KEY (id);


--
-- Name: meeting_contents meeting_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_contents
    ADD CONSTRAINT meeting_contents_pkey PRIMARY KEY (id);


--
-- Name: meeting_journals meeting_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_journals
    ADD CONSTRAINT meeting_journals_pkey PRIMARY KEY (id);


--
-- Name: meeting_participants meeting_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_participants
    ADD CONSTRAINT meeting_participants_pkey PRIMARY KEY (id);


--
-- Name: meeting_sections meeting_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_sections
    ADD CONSTRAINT meeting_sections_pkey PRIMARY KEY (id);


--
-- Name: meetings meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meetings
    ADD CONSTRAINT meetings_pkey PRIMARY KEY (id);


--
-- Name: member_roles member_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_roles
    ADD CONSTRAINT member_roles_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- Name: message_journals message_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_journals
    ADD CONSTRAINT message_journals_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: news_journals news_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_journals
    ADD CONSTRAINT news_journals_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: journals non_overlapping_journals_validity_periods; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT non_overlapping_journals_validity_periods EXCLUDE USING gist (journable_id WITH =, journable_type WITH =, validity_period WITH &&) DEFERRABLE;


--
-- Name: non_working_days non_working_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.non_working_days
    ADD CONSTRAINT non_working_days_pkey PRIMARY KEY (id);


--
-- Name: notification_settings notification_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT notification_settings_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_tokens oauth_client_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_client_tokens
    ADD CONSTRAINT oauth_client_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oidc_user_session_links oidc_user_session_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oidc_user_session_links
    ADD CONSTRAINT oidc_user_session_links_pkey PRIMARY KEY (id);


--
-- Name: ordered_work_packages ordered_work_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ordered_work_packages
    ADD CONSTRAINT ordered_work_packages_pkey PRIMARY KEY (id);


--
-- Name: paper_trail_audits paper_trail_audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paper_trail_audits
    ADD CONSTRAINT paper_trail_audits_pkey PRIMARY KEY (id);


--
-- Name: project_custom_field_project_mappings project_custom_field_project_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_custom_field_project_mappings
    ADD CONSTRAINT project_custom_field_project_mappings_pkey PRIMARY KEY (id);


--
-- Name: project_journals project_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_journals
    ADD CONSTRAINT project_journals_pkey PRIMARY KEY (id);


--
-- Name: project_life_cycle_step_definitions project_life_cycle_step_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_step_definitions
    ADD CONSTRAINT project_life_cycle_step_definitions_pkey PRIMARY KEY (id);


--
-- Name: project_life_cycle_steps project_life_cycle_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_steps
    ADD CONSTRAINT project_life_cycle_steps_pkey PRIMARY KEY (id);


--
-- Name: project_queries project_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_queries
    ADD CONSTRAINT project_queries_pkey PRIMARY KEY (id);


--
-- Name: project_storages project_storages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storages
    ADD CONSTRAINT project_storages_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (id);


--
-- Name: rates rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_pkey PRIMARY KEY (id);


--
-- Name: recaptcha_entries recaptcha_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recaptcha_entries
    ADD CONSTRAINT recaptcha_entries_pkey PRIMARY KEY (id);


--
-- Name: relations relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);


--
-- Name: remote_identities remote_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_identities
    ADD CONSTRAINT remote_identities_pkey PRIMARY KEY (id);


--
-- Name: repositories repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: storages_file_links_journals storages_file_links_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages_file_links_journals
    ADD CONSTRAINT storages_file_links_journals_pkey PRIMARY KEY (id);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- Name: time_entries time_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT time_entries_pkey PRIMARY KEY (id);


--
-- Name: time_entry_activities_projects time_entry_activities_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_activities_projects
    ADD CONSTRAINT time_entry_activities_projects_pkey PRIMARY KEY (id);


--
-- Name: time_entry_journals time_entry_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_journals
    ADD CONSTRAINT time_entry_journals_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: two_factor_authentication_devices two_factor_authentication_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.two_factor_authentication_devices
    ADD CONSTRAINT two_factor_authentication_devices_pkey PRIMARY KEY (id);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: user_passwords user_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_passwords
    ADD CONSTRAINT user_passwords_pkey PRIMARY KEY (id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: version_settings version_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_settings
    ADD CONSTRAINT version_settings_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: views views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- Name: watchers watchers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.watchers
    ADD CONSTRAINT watchers_pkey PRIMARY KEY (id);


--
-- Name: webhooks_events webhooks_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_events
    ADD CONSTRAINT webhooks_events_pkey PRIMARY KEY (id);


--
-- Name: webhooks_logs webhooks_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_logs
    ADD CONSTRAINT webhooks_logs_pkey PRIMARY KEY (id);


--
-- Name: webhooks_projects webhooks_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_projects
    ADD CONSTRAINT webhooks_projects_pkey PRIMARY KEY (id);


--
-- Name: webhooks_webhooks webhooks_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_webhooks
    ADD CONSTRAINT webhooks_webhooks_pkey PRIMARY KEY (id);


--
-- Name: wiki_page_journals wiki_page_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_page_journals
    ADD CONSTRAINT wiki_page_journals_pkey PRIMARY KEY (id);


--
-- Name: wiki_pages wiki_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_pages
    ADD CONSTRAINT wiki_pages_pkey PRIMARY KEY (id);


--
-- Name: wiki_redirects wiki_redirects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_redirects
    ADD CONSTRAINT wiki_redirects_pkey PRIMARY KEY (id);


--
-- Name: wikis wikis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wikis
    ADD CONSTRAINT wikis_pkey PRIMARY KEY (id);


--
-- Name: work_package_journals work_package_journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_package_journals
    ADD CONSTRAINT work_package_journals_pkey PRIMARY KEY (id);


--
-- Name: work_packages work_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages
    ADD CONSTRAINT work_packages_pkey PRIMARY KEY (id);


--
-- Name: workflows workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (id);


--
-- Name: changesets_changeset_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX changesets_changeset_id ON public.changes USING btree (changeset_id);


--
-- Name: changesets_repos_rev; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX changesets_repos_rev ON public.changesets USING btree (repository_id, revision);


--
-- Name: changesets_repos_scmid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX changesets_repos_scmid ON public.changesets USING btree (repository_id, scmid);


--
-- Name: changesets_work_packages_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX changesets_work_packages_ids ON public.changesets_work_packages USING btree (changeset_id, work_package_id);


--
-- Name: custom_fields_types_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX custom_fields_types_unique ON public.custom_fields_types USING btree (custom_field_id, type_id);


--
-- Name: custom_values_customized; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX custom_values_customized ON public.custom_values USING btree (customized_type, customized_id);


--
-- Name: documents_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_project_id ON public.documents USING btree (project_id);


--
-- Name: enabled_modules_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX enabled_modules_project_id ON public.enabled_modules USING btree (project_id);


--
-- Name: forums_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX forums_project_id ON public.forums USING btree (project_id);


--
-- Name: github_pr_wp_pr_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX github_pr_wp_pr_id ON public.github_pull_requests_work_packages USING btree (github_pull_request_id);


--
-- Name: gitlab_issues_wp_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gitlab_issues_wp_issue_id ON public.gitlab_issues_work_packages USING btree (gitlab_issue_id);


--
-- Name: gitlab_mr_wp_mr_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gitlab_mr_wp_mr_id ON public.gitlab_merge_requests_work_packages USING btree (gitlab_merge_request_id);


--
-- Name: group_user_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX group_user_ids ON public.group_users USING btree (group_id, user_id);


--
-- Name: index_announcements_on_show_until_and_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_announcements_on_show_until_and_active ON public.announcements USING btree (show_until, active);


--
-- Name: index_attachable_journals_on_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachable_journals_on_attachment_id ON public.attachable_journals USING btree (attachment_id);


--
-- Name: index_attachable_journals_on_journal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachable_journals_on_journal_id ON public.attachable_journals USING btree (journal_id);


--
-- Name: index_attachments_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachments_on_author_id ON public.attachments USING btree (author_id);


--
-- Name: index_attachments_on_container_id_and_container_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachments_on_container_id_and_container_type ON public.attachments USING btree (container_id, container_type);


--
-- Name: index_attachments_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachments_on_created_at ON public.attachments USING btree (created_at);


--
-- Name: index_attachments_on_file_tsv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachments_on_file_tsv ON public.attachments USING gin (file_tsv);


--
-- Name: index_attachments_on_fulltext_tsv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attachments_on_fulltext_tsv ON public.attachments USING gin (fulltext_tsv);


--
-- Name: index_auth_providers_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_auth_providers_on_creator_id ON public.auth_providers USING btree (creator_id);


--
-- Name: index_auth_providers_on_display_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_auth_providers_on_display_name ON public.auth_providers USING btree (display_name);


--
-- Name: index_auth_providers_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_auth_providers_on_slug ON public.auth_providers USING btree (slug);


--
-- Name: index_bcf_comments_on_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_comments_on_issue_id ON public.bcf_comments USING btree (issue_id);


--
-- Name: index_bcf_comments_on_journal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_comments_on_journal_id ON public.bcf_comments USING btree (journal_id);


--
-- Name: index_bcf_comments_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_comments_on_uuid ON public.bcf_comments USING btree (uuid);


--
-- Name: index_bcf_comments_on_uuid_and_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bcf_comments_on_uuid_and_issue_id ON public.bcf_comments USING btree (uuid, issue_id);


--
-- Name: index_bcf_comments_on_viewpoint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_comments_on_viewpoint_id ON public.bcf_comments USING btree (viewpoint_id);


--
-- Name: index_bcf_issues_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bcf_issues_on_uuid ON public.bcf_issues USING btree (uuid);


--
-- Name: index_bcf_issues_on_work_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bcf_issues_on_work_package_id ON public.bcf_issues USING btree (work_package_id);


--
-- Name: index_bcf_viewpoints_on_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_viewpoints_on_issue_id ON public.bcf_viewpoints USING btree (issue_id);


--
-- Name: index_bcf_viewpoints_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bcf_viewpoints_on_uuid ON public.bcf_viewpoints USING btree (uuid);


--
-- Name: index_bcf_viewpoints_on_uuid_and_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bcf_viewpoints_on_uuid_and_issue_id ON public.bcf_viewpoints USING btree (uuid, issue_id);


--
-- Name: index_budgets_on_project_id_and_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_budgets_on_project_id_and_updated_at ON public.budgets USING btree (project_id, updated_at);


--
-- Name: index_categories_on_assigned_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_assigned_to_id ON public.categories USING btree (assigned_to_id);


--
-- Name: index_changesets_on_committed_on; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_changesets_on_committed_on ON public.changesets USING btree (committed_on);


--
-- Name: index_changesets_on_repository_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_changesets_on_repository_id ON public.changesets USING btree (repository_id);


--
-- Name: index_changesets_on_repository_id_and_committed_on; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_changesets_on_repository_id_and_committed_on ON public.changesets USING btree (repository_id, committed_on);


--
-- Name: index_changesets_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_changesets_on_user_id ON public.changesets USING btree (user_id);


--
-- Name: index_comments_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_author_id ON public.comments USING btree (author_id);


--
-- Name: index_comments_on_commented_id_and_commented_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commented_id_and_commented_type ON public.comments USING btree (commented_id, commented_type);


--
-- Name: index_cost_entries_on_logged_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cost_entries_on_logged_by_id ON public.cost_entries USING btree (logged_by_id);


--
-- Name: index_custom_actions_projects_on_custom_action_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_projects_on_custom_action_id ON public.custom_actions_projects USING btree (custom_action_id);


--
-- Name: index_custom_actions_projects_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_projects_on_project_id ON public.custom_actions_projects USING btree (project_id);


--
-- Name: index_custom_actions_roles_on_custom_action_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_roles_on_custom_action_id ON public.custom_actions_roles USING btree (custom_action_id);


--
-- Name: index_custom_actions_roles_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_roles_on_role_id ON public.custom_actions_roles USING btree (role_id);


--
-- Name: index_custom_actions_statuses_on_custom_action_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_statuses_on_custom_action_id ON public.custom_actions_statuses USING btree (custom_action_id);


--
-- Name: index_custom_actions_statuses_on_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_statuses_on_status_id ON public.custom_actions_statuses USING btree (status_id);


--
-- Name: index_custom_actions_types_on_custom_action_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_types_on_custom_action_id ON public.custom_actions_types USING btree (custom_action_id);


--
-- Name: index_custom_actions_types_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_actions_types_on_type_id ON public.custom_actions_types USING btree (type_id);


--
-- Name: index_custom_fields_on_custom_field_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_fields_on_custom_field_section_id ON public.custom_fields USING btree (custom_field_section_id);


--
-- Name: index_custom_fields_on_id_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_fields_on_id_and_type ON public.custom_fields USING btree (id, type);


--
-- Name: index_custom_fields_projects_on_custom_field_id_and_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_custom_fields_projects_on_custom_field_id_and_project_id ON public.custom_fields_projects USING btree (custom_field_id, project_id);


--
-- Name: index_custom_options_on_custom_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_options_on_custom_field_id ON public.custom_options USING btree (custom_field_id);


--
-- Name: index_custom_options_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_options_on_value ON public.custom_options USING gin (value gin_trgm_ops);


--
-- Name: index_custom_values_on_custom_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_values_on_custom_field_id ON public.custom_values USING btree (custom_field_id);


--
-- Name: index_custom_values_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_values_on_value ON public.custom_values USING gin (value gin_trgm_ops);


--
-- Name: index_customizable_journals_on_custom_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customizable_journals_on_custom_field_id ON public.customizable_journals USING btree (custom_field_id);


--
-- Name: index_customizable_journals_on_journal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customizable_journals_on_journal_id ON public.customizable_journals USING btree (journal_id);


--
-- Name: index_deploy_status_checks_on_deploy_target_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_deploy_status_checks_on_deploy_target_id ON public.deploy_status_checks USING btree (deploy_target_id);


--
-- Name: index_deploy_status_checks_on_github_pull_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_deploy_status_checks_on_github_pull_request_id ON public.deploy_status_checks USING btree (github_pull_request_id);


--
-- Name: index_deploy_targets_on_host; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_deploy_targets_on_host ON public.deploy_targets USING btree (host);


--
-- Name: index_design_colors_on_variable; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_design_colors_on_variable ON public.design_colors USING btree (variable);


--
-- Name: index_documents_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_category_id ON public.documents USING btree (category_id);


--
-- Name: index_documents_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_created_at ON public.documents USING btree (created_at);


--
-- Name: index_emoji_reactions_on_reactable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emoji_reactions_on_reactable ON public.emoji_reactions USING btree (reactable_type, reactable_id);


--
-- Name: index_emoji_reactions_on_reaction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emoji_reactions_on_reaction ON public.emoji_reactions USING btree (reaction);


--
-- Name: index_emoji_reactions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emoji_reactions_on_user_id ON public.emoji_reactions USING btree (user_id);


--
-- Name: index_emoji_reactions_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_emoji_reactions_uniqueness ON public.emoji_reactions USING btree (user_id, reactable_type, reactable_id, reaction);


--
-- Name: index_enabled_modules_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enabled_modules_on_name ON public.enabled_modules USING btree (name);


--
-- Name: index_enumerations_on_color_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enumerations_on_color_id ON public.enumerations USING btree (color_id);


--
-- Name: index_enumerations_on_id_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enumerations_on_id_and_type ON public.enumerations USING btree (id, type);


--
-- Name: index_enumerations_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enumerations_on_project_id ON public.enumerations USING btree (project_id);


--
-- Name: index_favorites_on_favored; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_favored ON public.favorites USING btree (favored_type, favored_id);


--
-- Name: index_favorites_on_favored_type_and_favored_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_favored_type_and_favored_id ON public.favorites USING btree (favored_type, favored_id);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_favorites_on_user_id_and_favored_type_and_favored_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_favorites_on_user_id_and_favored_type_and_favored_id ON public.favorites USING btree (user_id, favored_type, favored_id);


--
-- Name: index_file_links_on_container_id_and_container_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_links_on_container_id_and_container_type ON public.file_links USING btree (container_id, container_type);


--
-- Name: index_file_links_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_links_on_creator_id ON public.file_links USING btree (creator_id);


--
-- Name: index_file_links_on_origin_id_and_storage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_links_on_origin_id_and_storage_id ON public.file_links USING btree (origin_id, storage_id);


--
-- Name: index_file_links_on_storage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_links_on_storage_id ON public.file_links USING btree (storage_id);


--
-- Name: index_forums_on_last_message_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forums_on_last_message_id ON public.forums USING btree (last_message_id);


--
-- Name: index_github_check_runs_on_github_pull_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_github_check_runs_on_github_pull_request_id ON public.github_check_runs USING btree (github_pull_request_id);


--
-- Name: index_github_pull_requests_on_github_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_github_pull_requests_on_github_user_id ON public.github_pull_requests USING btree (github_user_id);


--
-- Name: index_github_pull_requests_on_merged_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_github_pull_requests_on_merged_by_id ON public.github_pull_requests USING btree (merged_by_id);


--
-- Name: index_gitlab_issues_on_gitlab_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gitlab_issues_on_gitlab_user_id ON public.gitlab_issues USING btree (gitlab_user_id);


--
-- Name: index_gitlab_merge_requests_on_gitlab_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gitlab_merge_requests_on_gitlab_user_id ON public.gitlab_merge_requests USING btree (gitlab_user_id);


--
-- Name: index_gitlab_merge_requests_on_merged_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gitlab_merge_requests_on_merged_by_id ON public.gitlab_merge_requests USING btree (merged_by_id);


--
-- Name: index_gitlab_pipelines_on_gitlab_merge_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gitlab_pipelines_on_gitlab_merge_request_id ON public.gitlab_pipelines USING btree (gitlab_merge_request_id);


--
-- Name: index_good_job_executions_on_active_job_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_job_executions_on_active_job_id_and_created_at ON public.good_job_executions USING btree (active_job_id, created_at);


--
-- Name: index_good_job_jobs_for_candidate_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_job_jobs_for_candidate_lookup ON public.good_jobs USING btree (priority, created_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_job_settings_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_good_job_settings_on_key ON public.good_job_settings USING btree (key);


--
-- Name: index_good_jobs_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_jobs_on_finished_at ON public.good_jobs USING btree (finished_at) WHERE ((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL));


--
-- Name: index_good_jobs_jobs_on_priority_created_at_when_unfinished; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_jobs_on_priority_created_at_when_unfinished ON public.good_jobs USING btree (priority DESC NULLS LAST, created_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_active_job_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_active_job_id_and_created_at ON public.good_jobs USING btree (active_job_id, created_at);


--
-- Name: index_good_jobs_on_batch_callback_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_batch_callback_id ON public.good_jobs USING btree (batch_callback_id) WHERE (batch_callback_id IS NOT NULL);


--
-- Name: index_good_jobs_on_batch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_batch_id ON public.good_jobs USING btree (batch_id) WHERE (batch_id IS NOT NULL);


--
-- Name: index_good_jobs_on_concurrency_key_when_unfinished; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_concurrency_key_when_unfinished ON public.good_jobs USING btree (concurrency_key) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_cron_key_and_created_at_cond; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_cron_key_and_created_at_cond ON public.good_jobs USING btree (cron_key, created_at) WHERE (cron_key IS NOT NULL);


--
-- Name: index_good_jobs_on_cron_key_and_cron_at_cond; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_good_jobs_on_cron_key_and_cron_at_cond ON public.good_jobs USING btree (cron_key, cron_at) WHERE (cron_key IS NOT NULL);


--
-- Name: index_good_jobs_on_labels; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_labels ON public.good_jobs USING gin (labels) WHERE (labels IS NOT NULL);


--
-- Name: index_good_jobs_on_queue_name_and_scheduled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_queue_name_and_scheduled_at ON public.good_jobs USING btree (queue_name, scheduled_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_scheduled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_scheduled_at ON public.good_jobs USING btree (scheduled_at) WHERE (finished_at IS NULL);


--
-- Name: index_grid_widgets_on_grid_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_grid_widgets_on_grid_id ON public.grid_widgets USING btree (grid_id);


--
-- Name: index_grids_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_grids_on_project_id ON public.grids USING btree (project_id);


--
-- Name: index_grids_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_grids_on_user_id ON public.grids USING btree (user_id);


--
-- Name: index_group_users_on_user_id_and_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_group_users_on_user_id_and_group_id ON public.group_users USING btree (user_id, group_id);


--
-- Name: index_hierarchical_items_on_custom_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hierarchical_items_on_custom_field_id ON public.hierarchical_items USING btree (custom_field_id);


--
-- Name: index_ical_token_query_assignments_on_ical_token_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ical_token_query_assignments_on_ical_token_id ON public.ical_token_query_assignments USING btree (ical_token_id);


--
-- Name: index_ical_token_query_assignments_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ical_token_query_assignments_on_query_id ON public.ical_token_query_assignments USING btree (query_id);


--
-- Name: index_ifc_models_on_is_default; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ifc_models_on_is_default ON public.ifc_models USING btree (is_default);


--
-- Name: index_ifc_models_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ifc_models_on_project_id ON public.ifc_models USING btree (project_id);


--
-- Name: index_ifc_models_on_uploader_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ifc_models_on_uploader_id ON public.ifc_models USING btree (uploader_id);


--
-- Name: index_job_statuses_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_job_statuses_on_job_id ON public.job_statuses USING btree (job_id);


--
-- Name: index_job_statuses_on_reference_type_and_reference_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_job_statuses_on_reference_type_and_reference_id ON public.job_statuses USING btree (reference_type, reference_id);


--
-- Name: index_job_statuses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_statuses_on_user_id ON public.job_statuses USING btree (user_id);


--
-- Name: index_journals_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journals_on_created_at ON public.journals USING btree (created_at);


--
-- Name: index_journals_on_data_id_and_data_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_journals_on_data_id_and_data_type ON public.journals USING btree (data_id, data_type);


--
-- Name: index_journals_on_journable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journals_on_journable_id ON public.journals USING btree (journable_id);


--
-- Name: index_journals_on_journable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journals_on_journable_type ON public.journals USING btree (journable_type);


--
-- Name: index_journals_on_journable_type_and_journable_id_and_version; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_journals_on_journable_type_and_journable_id_and_version ON public.journals USING btree (journable_type, journable_id, version);


--
-- Name: index_journals_on_notes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journals_on_notes ON public.journals USING gin (notes gin_trgm_ops);


--
-- Name: index_journals_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journals_on_user_id ON public.journals USING btree (user_id);


--
-- Name: index_last_project_folders_on_project_storage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_last_project_folders_on_project_storage_id ON public.last_project_folders USING btree (project_storage_id);


--
-- Name: index_last_project_folders_on_project_storage_id_and_mode; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_last_project_folders_on_project_storage_id_and_mode ON public.last_project_folders USING btree (project_storage_id, mode);


--
-- Name: index_ldap_groups_memberships_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_memberships_on_group_id ON public.ldap_groups_memberships USING btree (group_id);


--
-- Name: index_ldap_groups_memberships_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_memberships_on_user_id ON public.ldap_groups_memberships USING btree (user_id);


--
-- Name: index_ldap_groups_memberships_on_user_id_and_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_ldap_groups_memberships_on_user_id_and_group_id ON public.ldap_groups_memberships USING btree (user_id, group_id);


--
-- Name: index_ldap_groups_synchronized_filters_on_ldap_auth_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_synchronized_filters_on_ldap_auth_source_id ON public.ldap_groups_synchronized_filters USING btree (ldap_auth_source_id);


--
-- Name: index_ldap_groups_synchronized_groups_on_filter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_synchronized_groups_on_filter_id ON public.ldap_groups_synchronized_groups USING btree (filter_id);


--
-- Name: index_ldap_groups_synchronized_groups_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_synchronized_groups_on_group_id ON public.ldap_groups_synchronized_groups USING btree (group_id);


--
-- Name: index_ldap_groups_synchronized_groups_on_ldap_auth_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ldap_groups_synchronized_groups_on_ldap_auth_source_id ON public.ldap_groups_synchronized_groups USING btree (ldap_auth_source_id);


--
-- Name: index_meeting_agenda_item_journals_on_presenter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_item_journals_on_presenter_id ON public.meeting_agenda_item_journals USING btree (presenter_id);


--
-- Name: index_meeting_agenda_items_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_author_id ON public.meeting_agenda_items USING btree (author_id);


--
-- Name: index_meeting_agenda_items_on_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_meeting_id ON public.meeting_agenda_items USING btree (meeting_id);


--
-- Name: index_meeting_agenda_items_on_meeting_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_meeting_section_id ON public.meeting_agenda_items USING btree (meeting_section_id);


--
-- Name: index_meeting_agenda_items_on_notes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_notes ON public.meeting_agenda_items USING gin (notes gin_trgm_ops);


--
-- Name: index_meeting_agenda_items_on_presenter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_presenter_id ON public.meeting_agenda_items USING btree (presenter_id);


--
-- Name: index_meeting_agenda_items_on_work_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agenda_items_on_work_package_id ON public.meeting_agenda_items USING btree (work_package_id);


--
-- Name: index_meeting_sections_on_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_sections_on_meeting_id ON public.meeting_sections USING btree (meeting_id);


--
-- Name: index_meetings_on_project_id_and_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meetings_on_project_id_and_updated_at ON public.meetings USING btree (project_id, updated_at);


--
-- Name: index_member_roles_on_inherited_from; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_member_roles_on_inherited_from ON public.member_roles USING btree (inherited_from);


--
-- Name: index_member_roles_on_member_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_member_roles_on_member_id ON public.member_roles USING btree (member_id);


--
-- Name: index_member_roles_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_member_roles_on_role_id ON public.member_roles USING btree (role_id);


--
-- Name: index_members_on_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_entity ON public.members USING btree (entity_type, entity_id);


--
-- Name: index_members_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_project_id ON public.members USING btree (project_id);


--
-- Name: index_members_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_user_id ON public.members USING btree (user_id);


--
-- Name: index_members_on_user_id_and_project_with_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_members_on_user_id_and_project_with_entity ON public.members USING btree (user_id, project_id, entity_type, entity_id) WHERE ((entity_type IS NOT NULL) AND (entity_id IS NOT NULL));


--
-- Name: index_members_on_user_id_and_project_without_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_members_on_user_id_and_project_without_entity ON public.members USING btree (user_id, project_id) WHERE ((entity_type IS NULL) AND (entity_id IS NULL));


--
-- Name: index_menu_items_on_navigatable_id_and_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_menu_items_on_navigatable_id_and_title ON public.menu_items USING btree (navigatable_id, title);


--
-- Name: index_menu_items_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_menu_items_on_parent_id ON public.menu_items USING btree (parent_id);


--
-- Name: index_messages_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_author_id ON public.messages USING btree (author_id);


--
-- Name: index_messages_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_created_at ON public.messages USING btree (created_at);


--
-- Name: index_messages_on_forum_id_and_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_forum_id_and_updated_at ON public.messages USING btree (forum_id, updated_at);


--
-- Name: index_messages_on_last_reply_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_last_reply_id ON public.messages USING btree (last_reply_id);


--
-- Name: index_news_journals_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_news_journals_on_project_id ON public.news_journals USING btree (project_id);


--
-- Name: index_news_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_news_on_author_id ON public.news USING btree (author_id);


--
-- Name: index_news_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_news_on_created_at ON public.news USING btree (created_at);


--
-- Name: index_news_on_project_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_news_on_project_id_and_created_at ON public.news USING btree (project_id, created_at);


--
-- Name: index_non_working_days_on_date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_non_working_days_on_date ON public.non_working_days USING btree (date);


--
-- Name: index_notification_settings_on_document_added; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_document_added ON public.notification_settings USING btree (document_added);


--
-- Name: index_notification_settings_on_forum_messages; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_forum_messages ON public.notification_settings USING btree (forum_messages);


--
-- Name: index_notification_settings_on_membership_added; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_membership_added ON public.notification_settings USING btree (membership_added);


--
-- Name: index_notification_settings_on_membership_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_membership_updated ON public.notification_settings USING btree (membership_updated);


--
-- Name: index_notification_settings_on_news_added; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_news_added ON public.notification_settings USING btree (news_added);


--
-- Name: index_notification_settings_on_news_commented; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_news_commented ON public.notification_settings USING btree (news_commented);


--
-- Name: index_notification_settings_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_project_id ON public.notification_settings USING btree (project_id);


--
-- Name: index_notification_settings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_user_id ON public.notification_settings USING btree (user_id);


--
-- Name: index_notification_settings_on_wiki_page_added; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_wiki_page_added ON public.notification_settings USING btree (wiki_page_added);


--
-- Name: index_notification_settings_on_wiki_page_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_wiki_page_updated ON public.notification_settings USING btree (wiki_page_updated);


--
-- Name: index_notification_settings_on_work_package_commented; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_work_package_commented ON public.notification_settings USING btree (work_package_commented);


--
-- Name: index_notification_settings_on_work_package_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_work_package_created ON public.notification_settings USING btree (work_package_created);


--
-- Name: index_notification_settings_on_work_package_prioritized; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_work_package_prioritized ON public.notification_settings USING btree (work_package_prioritized);


--
-- Name: index_notification_settings_on_work_package_processed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_work_package_processed ON public.notification_settings USING btree (work_package_processed);


--
-- Name: index_notification_settings_on_work_package_scheduled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_work_package_scheduled ON public.notification_settings USING btree (work_package_scheduled);


--
-- Name: index_notification_settings_unique_project; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_notification_settings_unique_project ON public.notification_settings USING btree (user_id, project_id) WHERE (project_id IS NOT NULL);


--
-- Name: index_notification_settings_unique_project_null; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_notification_settings_unique_project_null ON public.notification_settings USING btree (user_id) WHERE (project_id IS NULL);


--
-- Name: index_notifications_on_actor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_actor_id ON public.notifications USING btree (actor_id);


--
-- Name: index_notifications_on_journal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_journal_id ON public.notifications USING btree (journal_id);


--
-- Name: index_notifications_on_mail_alert_sent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_mail_alert_sent ON public.notifications USING btree (mail_alert_sent);


--
-- Name: index_notifications_on_mail_reminder_sent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_mail_reminder_sent ON public.notifications USING btree (mail_reminder_sent);


--
-- Name: index_notifications_on_read_ian; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_read_ian ON public.notifications USING btree (read_ian);


--
-- Name: index_notifications_on_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_recipient_id ON public.notifications USING btree (recipient_id);


--
-- Name: index_notifications_on_resource; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_resource ON public.notifications USING btree (resource_type, resource_id);


--
-- Name: index_oauth_access_grants_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_grants_on_application_id ON public.oauth_access_grants USING btree (application_id);


--
-- Name: index_oauth_access_grants_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_grants_on_resource_owner_id ON public.oauth_access_grants USING btree (resource_owner_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON public.oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_application_id ON public.oauth_access_tokens USING btree (application_id);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_integration; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_applications_on_integration ON public.oauth_applications USING btree (integration_type, integration_id);


--
-- Name: index_oauth_applications_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_applications_on_owner_id_and_owner_type ON public.oauth_applications USING btree (owner_id, owner_type);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON public.oauth_applications USING btree (uid);


--
-- Name: index_oauth_client_tokens_on_oauth_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_client_tokens_on_oauth_client_id ON public.oauth_client_tokens USING btree (oauth_client_id);


--
-- Name: index_oauth_client_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_client_tokens_on_user_id ON public.oauth_client_tokens USING btree (user_id);


--
-- Name: index_oauth_client_tokens_on_user_id_and_oauth_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_client_tokens_on_user_id_and_oauth_client_id ON public.oauth_client_tokens USING btree (user_id, oauth_client_id);


--
-- Name: index_oauth_clients_on_integration; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_clients_on_integration ON public.oauth_clients USING btree (integration_type, integration_id);


--
-- Name: index_oidc_user_session_links_on_oidc_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oidc_user_session_links_on_oidc_session ON public.oidc_user_session_links USING btree (oidc_session);


--
-- Name: index_oidc_user_session_links_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oidc_user_session_links_on_session_id ON public.oidc_user_session_links USING btree (session_id);


--
-- Name: index_ordered_work_packages_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ordered_work_packages_on_position ON public.ordered_work_packages USING btree ("position");


--
-- Name: index_ordered_work_packages_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ordered_work_packages_on_query_id ON public.ordered_work_packages USING btree (query_id);


--
-- Name: index_ordered_work_packages_on_work_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ordered_work_packages_on_work_package_id ON public.ordered_work_packages USING btree (work_package_id);


--
-- Name: index_paper_trail_audits_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_paper_trail_audits_on_item_type_and_item_id ON public.paper_trail_audits USING btree (item_type, item_id);


--
-- Name: index_project_cf_project_mappings_on_custom_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_cf_project_mappings_on_custom_field_id ON public.project_custom_field_project_mappings USING btree (custom_field_id);


--
-- Name: index_project_custom_field_project_mappings_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_custom_field_project_mappings_on_project_id ON public.project_custom_field_project_mappings USING btree (project_id);


--
-- Name: index_project_custom_field_project_mappings_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_project_custom_field_project_mappings_unique ON public.project_custom_field_project_mappings USING btree (project_id, custom_field_id);


--
-- Name: index_project_life_cycle_step_definitions_on_color_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_life_cycle_step_definitions_on_color_id ON public.project_life_cycle_step_definitions USING btree (color_id);


--
-- Name: index_project_life_cycle_steps_on_definition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_life_cycle_steps_on_definition_id ON public.project_life_cycle_steps USING btree (definition_id);


--
-- Name: index_project_life_cycle_steps_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_life_cycle_steps_on_project_id ON public.project_life_cycle_steps USING btree (project_id);


--
-- Name: index_project_queries_on_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_queries_on_public ON public.project_queries USING btree (public);


--
-- Name: index_project_queries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_queries_on_user_id ON public.project_queries USING btree (user_id);


--
-- Name: index_project_storages_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_storages_on_creator_id ON public.project_storages USING btree (creator_id);


--
-- Name: index_project_storages_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_storages_on_project_id ON public.project_storages USING btree (project_id);


--
-- Name: index_project_storages_on_project_id_and_storage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_project_storages_on_project_id_and_storage_id ON public.project_storages USING btree (project_id, storage_id);


--
-- Name: index_project_storages_on_storage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_storages_on_storage_id ON public.project_storages USING btree (storage_id);


--
-- Name: index_projects_on_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_active ON public.projects USING btree (active);


--
-- Name: index_projects_on_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_projects_on_identifier ON public.projects USING btree (identifier);


--
-- Name: index_projects_on_lft; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_lft ON public.projects USING btree (lft);


--
-- Name: index_projects_on_lft_and_rgt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_lft_and_rgt ON public.projects USING btree (lft, rgt);


--
-- Name: index_projects_on_rgt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_rgt ON public.projects USING btree (rgt);


--
-- Name: index_queries_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_queries_on_project_id ON public.queries USING btree (project_id);


--
-- Name: index_queries_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_queries_on_updated_at ON public.queries USING btree (updated_at);


--
-- Name: index_queries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_queries_on_user_id ON public.queries USING btree (user_id);


--
-- Name: index_recaptcha_entries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recaptcha_entries_on_user_id ON public.recaptcha_entries USING btree (user_id);


--
-- Name: index_relations_on_from_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relations_on_from_id ON public.relations USING btree (from_id);


--
-- Name: index_relations_on_from_id_and_to_id_and_relation_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_relations_on_from_id_and_to_id_and_relation_type ON public.relations USING btree (from_id, to_id, relation_type);


--
-- Name: index_relations_on_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relations_on_to_id ON public.relations USING btree (to_id);


--
-- Name: index_relations_on_to_id_and_from_id_and_relation_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_relations_on_to_id_and_from_id_and_relation_type ON public.relations USING btree (to_id, from_id, relation_type);


--
-- Name: index_remote_identities_on_oauth_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_remote_identities_on_oauth_client_id ON public.remote_identities USING btree (oauth_client_id);


--
-- Name: index_remote_identities_on_origin_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_remote_identities_on_origin_user_id ON public.remote_identities USING btree (origin_user_id);


--
-- Name: index_remote_identities_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_remote_identities_on_user_id ON public.remote_identities USING btree (user_id);


--
-- Name: index_remote_identities_on_user_id_and_oauth_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_remote_identities_on_user_id_and_oauth_client_id ON public.remote_identities USING btree (user_id, oauth_client_id);


--
-- Name: index_repositories_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_repositories_on_project_id ON public.repositories USING btree (project_id);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_session_id ON public.sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_updated_at ON public.sessions USING btree (updated_at);


--
-- Name: index_settings_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_settings_on_name ON public.settings USING btree (name);


--
-- Name: index_statuses_on_color_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statuses_on_color_id ON public.statuses USING btree (color_id);


--
-- Name: index_statuses_on_is_closed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statuses_on_is_closed ON public.statuses USING btree (is_closed);


--
-- Name: index_statuses_on_is_default; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statuses_on_is_default ON public.statuses USING btree (is_default);


--
-- Name: index_statuses_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statuses_on_position ON public.statuses USING btree ("position");


--
-- Name: index_storages_file_links_journals_on_file_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_storages_file_links_journals_on_file_link_id ON public.storages_file_links_journals USING btree (file_link_id);


--
-- Name: index_storages_file_links_journals_on_journal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_storages_file_links_journals_on_journal_id ON public.storages_file_links_journals USING btree (journal_id);


--
-- Name: index_storages_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_storages_on_creator_id ON public.storages USING btree (creator_id);


--
-- Name: index_storages_on_host; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_storages_on_host ON public.storages USING btree (host);


--
-- Name: index_storages_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_storages_on_name ON public.storages USING btree (name);


--
-- Name: index_teap_on_project_id_and_activity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teap_on_project_id_and_activity_id ON public.time_entry_activities_projects USING btree (project_id, activity_id);


--
-- Name: index_time_entries_on_activity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_activity_id ON public.time_entries USING btree (activity_id);


--
-- Name: index_time_entries_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_created_at ON public.time_entries USING btree (created_at);


--
-- Name: index_time_entries_on_logged_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_logged_by_id ON public.time_entries USING btree (logged_by_id);


--
-- Name: index_time_entries_on_ongoing; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_ongoing ON public.time_entries USING btree (ongoing);


--
-- Name: index_time_entries_on_project_id_and_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_project_id_and_updated_at ON public.time_entries USING btree (project_id, updated_at);


--
-- Name: index_time_entries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entries_on_user_id ON public.time_entries USING btree (user_id);


--
-- Name: index_time_entries_on_user_id_and_ongoing; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_time_entries_on_user_id_and_ongoing ON public.time_entries USING btree (user_id, ongoing) WHERE (ongoing = true);


--
-- Name: index_time_entry_activities_projects_on_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entry_activities_projects_on_active ON public.time_entry_activities_projects USING btree (active);


--
-- Name: index_time_entry_activities_projects_on_activity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entry_activities_projects_on_activity_id ON public.time_entry_activities_projects USING btree (activity_id);


--
-- Name: index_time_entry_activities_projects_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entry_activities_projects_on_project_id ON public.time_entry_activities_projects USING btree (project_id);


--
-- Name: index_time_entry_journals_on_logged_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entry_journals_on_logged_by_id ON public.time_entry_journals USING btree (logged_by_id);


--
-- Name: index_time_entry_journals_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_time_entry_journals_on_project_id ON public.time_entry_journals USING btree (project_id);


--
-- Name: index_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tokens_on_user_id ON public.tokens USING btree (user_id);


--
-- Name: index_two_factor_authentication_devices_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_two_factor_authentication_devices_on_user_id ON public.two_factor_authentication_devices USING btree (user_id);


--
-- Name: index_two_factor_authentication_devices_on_webauthn_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_two_factor_authentication_devices_on_webauthn_external_id ON public.two_factor_authentication_devices USING btree (webauthn_external_id);


--
-- Name: index_types_on_color_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_types_on_color_id ON public.types USING btree (color_id);


--
-- Name: index_user_passwords_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_passwords_on_user_id ON public.user_passwords USING btree (user_id);


--
-- Name: index_user_preferences_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_preferences_on_user_id ON public.user_preferences USING btree (user_id);


--
-- Name: index_user_prefs_settings_daily_reminders_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_prefs_settings_daily_reminders_enabled ON public.user_preferences USING gin ((((settings -> 'daily_reminders'::text) -> 'enabled'::text)));


--
-- Name: index_user_prefs_settings_daily_reminders_times; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_prefs_settings_daily_reminders_times ON public.user_preferences USING gin ((((settings -> 'daily_reminders'::text) -> 'times'::text)));


--
-- Name: index_user_prefs_settings_pause_reminders_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_prefs_settings_pause_reminders_enabled ON public.user_preferences USING btree (((((settings -> 'pause_reminders'::text) ->> 'enabled'::text))::boolean));


--
-- Name: index_user_prefs_settings_time_zone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_prefs_settings_time_zone ON public.user_preferences USING gin (((settings -> 'time_zone'::text)));


--
-- Name: index_user_prefs_settings_workdays; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_prefs_settings_workdays ON public.user_preferences USING gin (((settings -> 'workdays'::text)));


--
-- Name: index_users_on_id_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_id_and_type ON public.users USING btree (id, type);


--
-- Name: index_users_on_ldap_auth_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_ldap_auth_source_id ON public.users USING btree (ldap_auth_source_id);


--
-- Name: index_users_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_type ON public.users USING btree (type);


--
-- Name: index_users_on_type_and_login; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_type_and_login ON public.users USING btree (type, login);


--
-- Name: index_users_on_type_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_type_and_status ON public.users USING btree (type, status);


--
-- Name: index_version_settings_on_project_id_and_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_version_settings_on_project_id_and_version_id ON public.version_settings USING btree (project_id, version_id);


--
-- Name: index_versions_on_sharing; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_sharing ON public.versions USING btree (sharing);


--
-- Name: index_views_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_views_on_query_id ON public.views USING btree (query_id);


--
-- Name: index_watchers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_watchers_on_user_id ON public.watchers USING btree (user_id);


--
-- Name: index_watchers_on_watchable_id_and_watchable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_watchers_on_watchable_id_and_watchable_type ON public.watchers USING btree (watchable_id, watchable_type);


--
-- Name: index_webhooks_events_on_webhooks_webhook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_webhooks_events_on_webhooks_webhook_id ON public.webhooks_events USING btree (webhooks_webhook_id);


--
-- Name: index_webhooks_logs_on_webhooks_webhook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_webhooks_logs_on_webhooks_webhook_id ON public.webhooks_logs USING btree (webhooks_webhook_id);


--
-- Name: index_webhooks_projects_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_webhooks_projects_on_project_id ON public.webhooks_projects USING btree (project_id);


--
-- Name: index_webhooks_projects_on_webhooks_webhook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_webhooks_projects_on_webhooks_webhook_id ON public.webhooks_projects USING btree (webhooks_webhook_id);


--
-- Name: index_wiki_pages_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_pages_on_author_id ON public.wiki_pages USING btree (author_id);


--
-- Name: index_wiki_pages_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_pages_on_parent_id ON public.wiki_pages USING btree (parent_id);


--
-- Name: index_wiki_pages_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_pages_on_updated_at ON public.wiki_pages USING btree (updated_at);


--
-- Name: index_wiki_pages_on_wiki_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_pages_on_wiki_id ON public.wiki_pages USING btree (wiki_id);


--
-- Name: index_wiki_redirects_on_wiki_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_redirects_on_wiki_id ON public.wiki_redirects USING btree (wiki_id);


--
-- Name: index_work_package_journals_on_assigned_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_assigned_to_id ON public.work_package_journals USING btree (assigned_to_id);


--
-- Name: index_work_package_journals_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_author_id ON public.work_package_journals USING btree (author_id);


--
-- Name: index_work_package_journals_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_category_id ON public.work_package_journals USING btree (category_id);


--
-- Name: index_work_package_journals_on_due_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_due_date ON public.work_package_journals USING btree (due_date);


--
-- Name: index_work_package_journals_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_parent_id ON public.work_package_journals USING btree (parent_id);


--
-- Name: index_work_package_journals_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_project_id ON public.work_package_journals USING btree (project_id);


--
-- Name: index_work_package_journals_on_responsible_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_responsible_id ON public.work_package_journals USING btree (responsible_id);


--
-- Name: index_work_package_journals_on_schedule_manually; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_schedule_manually ON public.work_package_journals USING btree (schedule_manually);


--
-- Name: index_work_package_journals_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_start_date ON public.work_package_journals USING btree (start_date);


--
-- Name: index_work_package_journals_on_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_status_id ON public.work_package_journals USING btree (status_id);


--
-- Name: index_work_package_journals_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_type_id ON public.work_package_journals USING btree (type_id);


--
-- Name: index_work_package_journals_on_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_package_journals_on_version_id ON public.work_package_journals USING btree (version_id);


--
-- Name: index_work_packages_on_assigned_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_assigned_to_id ON public.work_packages USING btree (assigned_to_id);


--
-- Name: index_work_packages_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_author_id ON public.work_packages USING btree (author_id);


--
-- Name: index_work_packages_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_category_id ON public.work_packages USING btree (category_id);


--
-- Name: index_work_packages_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_created_at ON public.work_packages USING btree (created_at);


--
-- Name: index_work_packages_on_due_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_due_date ON public.work_packages USING btree (due_date);


--
-- Name: index_work_packages_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_parent_id ON public.work_packages USING btree (parent_id);


--
-- Name: index_work_packages_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_project_id ON public.work_packages USING btree (project_id);


--
-- Name: index_work_packages_on_project_id_and_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_project_id_and_updated_at ON public.work_packages USING btree (project_id, updated_at);


--
-- Name: index_work_packages_on_project_life_cycle_step_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_project_life_cycle_step_id ON public.work_packages USING btree (project_life_cycle_step_id);


--
-- Name: index_work_packages_on_responsible_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_responsible_id ON public.work_packages USING btree (responsible_id);


--
-- Name: index_work_packages_on_schedule_manually; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_schedule_manually ON public.work_packages USING btree (schedule_manually) WHERE schedule_manually;


--
-- Name: index_work_packages_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_start_date ON public.work_packages USING btree (start_date);


--
-- Name: index_work_packages_on_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_status_id ON public.work_packages USING btree (status_id);


--
-- Name: index_work_packages_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_type_id ON public.work_packages USING btree (type_id);


--
-- Name: index_work_packages_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_updated_at ON public.work_packages USING btree (updated_at);


--
-- Name: index_work_packages_on_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_version_id ON public.work_packages USING btree (version_id);


--
-- Name: index_workflows_on_new_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_workflows_on_new_status_id ON public.workflows USING btree (new_status_id);


--
-- Name: index_workflows_on_old_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_workflows_on_old_status_id ON public.workflows USING btree (old_status_id);


--
-- Name: index_workflows_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_workflows_on_role_id ON public.workflows USING btree (role_id);


--
-- Name: issue_categories_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issue_categories_project_id ON public.categories USING btree (project_id);


--
-- Name: item_anc_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX item_anc_desc_idx ON public.hierarchical_item_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: item_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_desc_idx ON public.hierarchical_item_hierarchies USING btree (descendant_id);


--
-- Name: messages_board_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_board_id ON public.messages USING btree (forum_id);


--
-- Name: messages_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_parent_id ON public.messages USING btree (parent_id);


--
-- Name: news_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX news_project_id ON public.news USING btree (project_id);


--
-- Name: projects_types_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projects_types_project_id ON public.projects_types USING btree (project_id);


--
-- Name: projects_types_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX projects_types_unique ON public.projects_types USING btree (project_id, type_id);


--
-- Name: time_entries_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX time_entries_issue_id ON public.time_entries USING btree (work_package_id);


--
-- Name: time_entries_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX time_entries_project_id ON public.time_entries USING btree (project_id);


--
-- Name: unique_index_gh_prs_wps_on_gh_pr_id_and_wp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_index_gh_prs_wps_on_gh_pr_id_and_wp_id ON public.github_pull_requests_work_packages USING btree (github_pull_request_id, work_package_id);


--
-- Name: unique_index_gl_issues_wps_on_gl_issue_id_and_wp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_index_gl_issues_wps_on_gl_issue_id_and_wp_id ON public.gitlab_issues_work_packages USING btree (gitlab_issue_id, work_package_id);


--
-- Name: unique_index_gl_mrs_wps_on_gl_mr_id_and_wp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_index_gl_mrs_wps_on_gl_mr_id_and_wp_id ON public.gitlab_merge_requests_work_packages USING btree (gitlab_merge_request_id, work_package_id);


--
-- Name: unique_inherited_role; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_inherited_role ON public.member_roles USING btree (member_id, role_id, inherited_from);


--
-- Name: unique_lastname_for_groups_and_placeholder_users; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_lastname_for_groups_and_placeholder_users ON public.users USING btree (lastname, type) WHERE (((type)::text = 'Group'::text) OR ((type)::text = 'PlaceholderUser'::text));


--
-- Name: versions_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX versions_project_id ON public.versions USING btree (project_id);


--
-- Name: watchers_user_id_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX watchers_user_id_type ON public.watchers USING btree (user_id, watchable_type);


--
-- Name: wiki_pages_wiki_id_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX wiki_pages_wiki_id_slug ON public.wiki_pages USING btree (wiki_id, slug);


--
-- Name: wiki_pages_wiki_id_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wiki_pages_wiki_id_title ON public.wiki_pages USING btree (wiki_id, title);


--
-- Name: wiki_redirects_wiki_id_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wiki_redirects_wiki_id_title ON public.wiki_redirects USING btree (wiki_id, title);


--
-- Name: wikis_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wikis_project_id ON public.wikis USING btree (project_id);


--
-- Name: wkfs_role_type_old_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wkfs_role_type_old_status ON public.workflows USING btree (role_id, type_id, old_status_id);


--
-- Name: work_package_anc_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX work_package_anc_desc_idx ON public.work_package_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: work_package_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX work_package_desc_idx ON public.work_package_hierarchies USING btree (descendant_id);


--
-- Name: work_package_journal_on_burndown_attributes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX work_package_journal_on_burndown_attributes ON public.work_package_journals USING btree (version_id, status_id, project_id, type_id);


--
-- Name: project_storages fk_rails_04546d7b88; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storages
    ADD CONSTRAINT fk_rails_04546d7b88 FOREIGN KEY (storage_id) REFERENCES public.storages(id) ON DELETE CASCADE;


--
-- Name: bcf_comments fk_rails_0571c4b386; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_comments
    ADD CONSTRAINT fk_rails_0571c4b386 FOREIGN KEY (reply_to) REFERENCES public.bcf_comments(id) ON DELETE SET NULL;


--
-- Name: notifications fk_rails_06a39bb8cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_06a39bb8cc FOREIGN KEY (actor_id) REFERENCES public.users(id);


--
-- Name: meeting_agenda_items fk_rails_06b94602d9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_items
    ADD CONSTRAINT fk_rails_06b94602d9 FOREIGN KEY (presenter_id) REFERENCES public.users(id);


--
-- Name: two_factor_authentication_devices fk_rails_0b09e132e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.two_factor_authentication_devices
    ADD CONSTRAINT fk_rails_0b09e132e7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: workflows fk_rails_0c5f149c21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT fk_rails_0c5f149c21 FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notification_settings fk_rails_0c95e91db7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT fk_rails_0c95e91db7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cost_entries fk_rails_0d35f09506; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_entries
    ADD CONSTRAINT fk_rails_0d35f09506 FOREIGN KEY (logged_by_id) REFERENCES public.users(id);


--
-- Name: custom_fields_projects fk_rails_12fb30588e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields_projects
    ADD CONSTRAINT fk_rails_12fb30588e FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: remote_identities fk_rails_19e47f842b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_identities
    ADD CONSTRAINT fk_rails_19e47f842b FOREIGN KEY (oauth_client_id) REFERENCES public.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: project_custom_field_project_mappings fk_rails_1a1f3f10e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_custom_field_project_mappings
    ADD CONSTRAINT fk_rails_1a1f3f10e9 FOREIGN KEY (custom_field_id) REFERENCES public.custom_fields(id);


--
-- Name: workflows fk_rails_2a8f410364; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT fk_rails_2a8f410364 FOREIGN KEY (type_id) REFERENCES public.types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: oauth_applications fk_rails_3d1f3b58d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT fk_rails_3d1f3b58d2 FOREIGN KEY (client_credentials_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: meeting_agenda_items fk_rails_3f56abf49c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_items
    ADD CONSTRAINT fk_rails_3f56abf49c FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: wiki_pages fk_rails_4189064f3f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_pages
    ADD CONSTRAINT fk_rails_4189064f3f FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: ldap_groups_synchronized_groups fk_rails_44dac1537e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_groups_synchronized_groups
    ADD CONSTRAINT fk_rails_44dac1537e FOREIGN KEY (filter_id) REFERENCES public.ldap_groups_synchronized_filters(id);


--
-- Name: types fk_rails_46ceaf0e5b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT fk_rails_46ceaf0e5b FOREIGN KEY (color_id) REFERENCES public.colors(id) ON DELETE SET NULL;


--
-- Name: notification_settings fk_rails_496a500fda; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT fk_rails_496a500fda FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: notifications fk_rails_4aea6afa11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_4aea6afa11 FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: project_life_cycle_step_definitions fk_rails_4b9851fb8b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_step_definitions
    ADD CONSTRAINT fk_rails_4b9851fb8b FOREIGN KEY (color_id) REFERENCES public.colors(id);


--
-- Name: bcf_issues fk_rails_4e35bc3056; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_issues
    ADD CONSTRAINT fk_rails_4e35bc3056 FOREIGN KEY (work_package_id) REFERENCES public.work_packages(id) ON DELETE CASCADE;


--
-- Name: ifc_models fk_rails_4f53d4601c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ifc_models
    ADD CONSTRAINT fk_rails_4f53d4601c FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: webhooks_logs fk_rails_551257cdac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_logs
    ADD CONSTRAINT fk_rails_551257cdac FOREIGN KEY (webhooks_webhook_id) REFERENCES public.webhooks_webhooks(id) ON DELETE CASCADE;


--
-- Name: bcf_comments fk_rails_556ef6e73e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_comments
    ADD CONSTRAINT fk_rails_556ef6e73e FOREIGN KEY (viewpoint_id) REFERENCES public.bcf_viewpoints(id) ON DELETE SET NULL;


--
-- Name: notifications fk_rails_595318131c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_595318131c FOREIGN KEY (journal_id) REFERENCES public.journals(id) ON DELETE CASCADE;


--
-- Name: time_entry_activities_projects fk_rails_5b669d4f34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_activities_projects
    ADD CONSTRAINT fk_rails_5b669d4f34 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: oidc_user_session_links fk_rails_5e6a849f92; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oidc_user_session_links
    ADD CONSTRAINT fk_rails_5e6a849f92 FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- Name: work_packages fk_rails_5edb6f06e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages
    ADD CONSTRAINT fk_rails_5edb6f06e6 FOREIGN KEY (status_id) REFERENCES public.statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: meeting_sections fk_rails_613c652e16; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_sections
    ADD CONSTRAINT fk_rails_613c652e16 FOREIGN KEY (meeting_id) REFERENCES public.meetings(id);


--
-- Name: file_links fk_rails_650ebb2e1a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_links
    ADD CONSTRAINT fk_rails_650ebb2e1a FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: oauth_client_tokens fk_rails_65a92bfbf4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_client_tokens
    ADD CONSTRAINT fk_rails_65a92bfbf4 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: workflows fk_rails_66af376b7e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT fk_rails_66af376b7e FOREIGN KEY (new_status_id) REFERENCES public.statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: storages fk_rails_6c69bacb8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT fk_rails_6c69bacb8d FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: oauth_client_tokens fk_rails_6e922d4135; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_client_tokens
    ADD CONSTRAINT fk_rails_6e922d4135 FOREIGN KEY (oauth_client_id) REFERENCES public.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: time_entries fk_rails_709864c72f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT fk_rails_709864c72f FOREIGN KEY (logged_by_id) REFERENCES public.users(id);


--
-- Name: oauth_access_tokens fk_rails_732cb83ab7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_732cb83ab7 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: last_project_folders fk_rails_73e1c678f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.last_project_folders
    ADD CONSTRAINT fk_rails_73e1c678f1 FOREIGN KEY (project_storage_id) REFERENCES public.project_storages(id) ON DELETE CASCADE;


--
-- Name: project_custom_field_project_mappings fk_rails_79aa0057e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_custom_field_project_mappings
    ADD CONSTRAINT fk_rails_79aa0057e4 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: bcf_comments fk_rails_7ac870008c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_comments
    ADD CONSTRAINT fk_rails_7ac870008c FOREIGN KEY (issue_id) REFERENCES public.bcf_issues(id) ON DELETE CASCADE;


--
-- Name: projects_types fk_rails_7c3935a107; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects_types
    ADD CONSTRAINT fk_rails_7c3935a107 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: remote_identities fk_rails_7f8585fc1a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_identities
    ADD CONSTRAINT fk_rails_7f8585fc1a FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: emoji_reactions fk_rails_80a9e7c3ce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emoji_reactions
    ADD CONSTRAINT fk_rails_80a9e7c3ce FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_life_cycle_steps fk_rails_81938d1823; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_steps
    ADD CONSTRAINT fk_rails_81938d1823 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: recaptcha_entries fk_rails_890a90efa9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recaptcha_entries
    ADD CONSTRAINT fk_rails_890a90efa9 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: meeting_agenda_items fk_rails_9089886cdd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_items
    ADD CONSTRAINT fk_rails_9089886cdd FOREIGN KEY (meeting_id) REFERENCES public.meetings(id);


--
-- Name: work_packages fk_rails_931ad309e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages
    ADD CONSTRAINT fk_rails_931ad309e8 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: project_storages fk_rails_96ab713fe3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storages
    ADD CONSTRAINT fk_rails_96ab713fe3 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: meeting_agenda_item_journals fk_rails_9b6296a185; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agenda_item_journals
    ADD CONSTRAINT fk_rails_9b6296a185 FOREIGN KEY (presenter_id) REFERENCES public.users(id);


--
-- Name: webhooks_events fk_rails_a166925c91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_events
    ADD CONSTRAINT fk_rails_a166925c91 FOREIGN KEY (webhooks_webhook_id) REFERENCES public.webhooks_webhooks(id);


--
-- Name: file_links fk_rails_a29c1fb981; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_links
    ADD CONSTRAINT fk_rails_a29c1fb981 FOREIGN KEY (storage_id) REFERENCES public.storages(id) ON DELETE CASCADE;


--
-- Name: project_life_cycle_steps fk_rails_abc065fdb1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_life_cycle_steps
    ADD CONSTRAINT fk_rails_abc065fdb1 FOREIGN KEY (definition_id) REFERENCES public.project_life_cycle_step_definitions(id);


--
-- Name: tokens fk_rails_ac8a5d0441; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT fk_rails_ac8a5d0441 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_storages fk_rails_acca00a591; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storages
    ADD CONSTRAINT fk_rails_acca00a591 FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: workflows fk_rails_b4628cffdf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT fk_rails_b4628cffdf FOREIGN KEY (old_status_id) REFERENCES public.statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: oauth_access_grants fk_rails_b4b53e07b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT fk_rails_b4b53e07b8 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: time_entry_activities_projects fk_rails_bc6c409022; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_activities_projects
    ADD CONSTRAINT fk_rails_bc6c409022 FOREIGN KEY (activity_id) REFERENCES public.enumerations(id);


--
-- Name: hierarchical_items fk_rails_c67cbe751d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hierarchical_items
    ADD CONSTRAINT fk_rails_c67cbe751d FOREIGN KEY (custom_field_id) REFERENCES public.custom_fields(id);


--
-- Name: oauth_applications fk_rails_cc886e315a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT fk_rails_cc886e315a FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: favorites fk_rails_d15744e438; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_d15744e438 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: webhooks_projects fk_rails_d7ea5de5b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_projects
    ADD CONSTRAINT fk_rails_d7ea5de5b8 FOREIGN KEY (webhooks_webhook_id) REFERENCES public.webhooks_webhooks(id);


--
-- Name: projects_types fk_rails_da213a0c8b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects_types
    ADD CONSTRAINT fk_rails_da213a0c8b FOREIGN KEY (type_id) REFERENCES public.types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: storages_file_links_journals fk_rails_e007095e78; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storages_file_links_journals
    ADD CONSTRAINT fk_rails_e007095e78 FOREIGN KEY (journal_id) REFERENCES public.journals(id);


--
-- Name: ical_token_query_assignments fk_rails_e0ecbb71e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ical_token_query_assignments
    ADD CONSTRAINT fk_rails_e0ecbb71e6 FOREIGN KEY (ical_token_id) REFERENCES public.tokens(id) ON DELETE CASCADE;


--
-- Name: custom_fields_projects fk_rails_e51cefe60d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_fields_projects
    ADD CONSTRAINT fk_rails_e51cefe60d FOREIGN KEY (custom_field_id) REFERENCES public.custom_fields(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: webhooks_projects fk_rails_e978b5e3d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks_projects
    ADD CONSTRAINT fk_rails_e978b5e3d7 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: ordered_work_packages fk_rails_e99c4d5dfe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ordered_work_packages
    ADD CONSTRAINT fk_rails_e99c4d5dfe FOREIGN KEY (query_id) REFERENCES public.queries(id) ON DELETE CASCADE;


--
-- Name: auth_providers fk_rails_e9bd348863; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_providers
    ADD CONSTRAINT fk_rails_e9bd348863 FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: views fk_rails_ef3c430897; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT fk_rails_ef3c430897 FOREIGN KEY (query_id) REFERENCES public.queries(id);


--
-- Name: work_packages fk_rails_f2a8977aa1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages
    ADD CONSTRAINT fk_rails_f2a8977aa1 FOREIGN KEY (type_id) REFERENCES public.types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ical_token_query_assignments fk_rails_f5e934437b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ical_token_query_assignments
    ADD CONSTRAINT fk_rails_f5e934437b FOREIGN KEY (query_id) REFERENCES public.queries(id) ON DELETE CASCADE;


--
-- Name: time_entry_journals fk_rails_f6e3d60ab5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_entry_journals
    ADD CONSTRAINT fk_rails_f6e3d60ab5 FOREIGN KEY (logged_by_id) REFERENCES public.users(id);


--
-- Name: bcf_viewpoints fk_rails_fa5c88e5be; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bcf_viewpoints
    ADD CONSTRAINT fk_rails_fa5c88e5be FOREIGN KEY (issue_id) REFERENCES public.bcf_issues(id) ON DELETE CASCADE;


--
-- Name: ordered_work_packages fk_rails_fe038e4e03; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ordered_work_packages
    ADD CONSTRAINT fk_rails_fe038e4e03 FOREIGN KEY (work_package_id) REFERENCES public.work_packages(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

