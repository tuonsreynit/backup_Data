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
    created_at timestamp(6) with time zone DEFAULT '2024-11-28 10:07:52.116764+00'::timestamp with time zone NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT '2024-11-28 10:07:52.116764+00'::timestamp with time zone NOT NULL
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
environment	production	2024-11-28 10:07:39.324216+00	2024-11-28 10:07:39.324219+00
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
1	6	Grids::Grid			455768	image/png	2a53ddc815206499a480d08e38272b8a	0	4	2024-11-28 10:08:23.086259+00	\N	demo_project_teaser.png	\N	\N	\N	2024-11-28 10:08:23.086259+00	0
2	7	Grids::Grid			442579	image/png	7b7d591a8dfdaf2900ceecdb9755f39f	0	4	2024-11-28 10:08:23.126109+00	\N	scrum_project_teaser.png	\N	\N	\N	2024-11-28 10:08:23.126109+00	0
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
1	1	Category 1 (to be changed in Project settings)	\N	2024-11-28 10:08:19.366499+00	2024-11-28 10:08:19.366499+00
2	2	Category 1 (to be changed in Project settings)	\N	2024-11-28 10:08:21.064498+00	2024-11-28 10:08:21.064498+00
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
1	Blue (dark)	#175A8E	2024-11-28 10:08:16.578392+00	2024-11-28 10:08:16.578392+00
2	Blue	#1A67A3	2024-11-28 10:08:16.582452+00	2024-11-28 10:08:16.582452+00
3	Blue (light)	#00B0F0	2024-11-28 10:08:16.583637+00	2024-11-28 10:08:16.583637+00
4	Green (light)	#35C53F	2024-11-28 10:08:16.584125+00	2024-11-28 10:08:16.584125+00
5	Green (dark)	#339933	2024-11-28 10:08:16.584574+00	2024-11-28 10:08:16.584574+00
6	Yellow	#FFFF00	2024-11-28 10:08:16.585059+00	2024-11-28 10:08:16.585059+00
7	Orange	#FFCC00	2024-11-28 10:08:16.585618+00	2024-11-28 10:08:16.585618+00
8	Red	#FF3300	2024-11-28 10:08:16.586124+00	2024-11-28 10:08:16.586124+00
9	Magenta	#E20074	2024-11-28 10:08:16.587134+00	2024-11-28 10:08:16.587134+00
10	White	#FFFFFF	2024-11-28 10:08:16.587727+00	2024-11-28 10:08:16.587727+00
11	Grey (light)	#F8F8F8	2024-11-28 10:08:16.588412+00	2024-11-28 10:08:16.588412+00
12	Grey	#EAEAEA	2024-11-28 10:08:16.589092+00	2024-11-28 10:08:16.589092+00
13	Grey (dark)	#878787	2024-11-28 10:08:16.58957+00	2024-11-28 10:08:16.58957+00
14	Black	#000000	2024-11-28 10:08:16.589956+00	2024-11-28 10:08:16.589956+00
15	gray-0	#F8F9FA	2024-11-28 10:08:16.59222+00	2024-11-28 10:08:16.59222+00
16	gray-1	#F1F3F5	2024-11-28 10:08:16.592805+00	2024-11-28 10:08:16.592805+00
17	gray-2	#E9ECEF	2024-11-28 10:08:16.593298+00	2024-11-28 10:08:16.593298+00
18	gray-3	#DEE2E6	2024-11-28 10:08:16.59384+00	2024-11-28 10:08:16.59384+00
19	gray-4	#CED4DA	2024-11-28 10:08:16.594258+00	2024-11-28 10:08:16.594258+00
20	gray-5	#ADB5BD	2024-11-28 10:08:16.594647+00	2024-11-28 10:08:16.594647+00
21	gray-6	#868E96	2024-11-28 10:08:16.595029+00	2024-11-28 10:08:16.595029+00
22	gray-7	#495057	2024-11-28 10:08:16.595409+00	2024-11-28 10:08:16.595409+00
23	gray-8	#343A40	2024-11-28 10:08:16.595788+00	2024-11-28 10:08:16.595788+00
24	gray-9	#212529	2024-11-28 10:08:16.596163+00	2024-11-28 10:08:16.596163+00
25	red-0	#FFF5F5	2024-11-28 10:08:16.596562+00	2024-11-28 10:08:16.596562+00
26	red-1	#FFE3E3	2024-11-28 10:08:16.597336+00	2024-11-28 10:08:16.597336+00
27	red-2	#FFC9C9	2024-11-28 10:08:16.597879+00	2024-11-28 10:08:16.597879+00
28	red-3	#FFA8A8	2024-11-28 10:08:16.59863+00	2024-11-28 10:08:16.59863+00
29	red-4	#FF8787	2024-11-28 10:08:16.599286+00	2024-11-28 10:08:16.599286+00
30	red-5	#FF6B6B	2024-11-28 10:08:16.599719+00	2024-11-28 10:08:16.599719+00
31	red-6	#FA5252	2024-11-28 10:08:16.600107+00	2024-11-28 10:08:16.600107+00
32	red-7	#F03E3E	2024-11-28 10:08:16.600488+00	2024-11-28 10:08:16.600488+00
33	red-8	#E03131	2024-11-28 10:08:16.600869+00	2024-11-28 10:08:16.600869+00
34	red-9	#C92A2A	2024-11-28 10:08:16.601275+00	2024-11-28 10:08:16.601275+00
35	pink-0	#FFF0F6	2024-11-28 10:08:16.601672+00	2024-11-28 10:08:16.601672+00
36	pink-1	#FFDEEB	2024-11-28 10:08:16.602052+00	2024-11-28 10:08:16.602052+00
37	pink-2	#FCC2D7	2024-11-28 10:08:16.603067+00	2024-11-28 10:08:16.603067+00
38	pink-3	#FAA2C1	2024-11-28 10:08:16.603563+00	2024-11-28 10:08:16.603563+00
39	pink-4	#F783AC	2024-11-28 10:08:16.603969+00	2024-11-28 10:08:16.603969+00
40	pink-5	#F06595	2024-11-28 10:08:16.604349+00	2024-11-28 10:08:16.604349+00
41	pink-6	#E64980	2024-11-28 10:08:16.604729+00	2024-11-28 10:08:16.604729+00
42	pink-7	#D6336C	2024-11-28 10:08:16.605131+00	2024-11-28 10:08:16.605131+00
43	pink-8	#C2255C	2024-11-28 10:08:16.605578+00	2024-11-28 10:08:16.605578+00
44	pink-9	#A61E4D	2024-11-28 10:08:16.605973+00	2024-11-28 10:08:16.605973+00
45	grape-0	#F8F0FC	2024-11-28 10:08:16.606362+00	2024-11-28 10:08:16.606362+00
46	grape-1	#F3D9FA	2024-11-28 10:08:16.606738+00	2024-11-28 10:08:16.606738+00
47	grape-2	#EEBEFA	2024-11-28 10:08:16.607454+00	2024-11-28 10:08:16.607454+00
48	grape-3	#E599F7	2024-11-28 10:08:16.608722+00	2024-11-28 10:08:16.608722+00
49	grape-4	#DA77F2	2024-11-28 10:08:16.609252+00	2024-11-28 10:08:16.609252+00
50	grape-5	#CC5DE8	2024-11-28 10:08:16.60967+00	2024-11-28 10:08:16.60967+00
51	grape-6	#BE4BDB	2024-11-28 10:08:16.610066+00	2024-11-28 10:08:16.610066+00
52	grape-7	#AE3EC9	2024-11-28 10:08:16.610442+00	2024-11-28 10:08:16.610442+00
53	grape-8	#9C36B5	2024-11-28 10:08:16.610817+00	2024-11-28 10:08:16.610817+00
54	grape-9	#862E9C	2024-11-28 10:08:16.611188+00	2024-11-28 10:08:16.611188+00
55	violet-0	#F3F0FF	2024-11-28 10:08:16.61204+00	2024-11-28 10:08:16.61204+00
56	violet-1	#E5DBFF	2024-11-28 10:08:16.612471+00	2024-11-28 10:08:16.612471+00
57	violet-2	#D0BFFF	2024-11-28 10:08:16.612855+00	2024-11-28 10:08:16.612855+00
58	violet-3	#B197FC	2024-11-28 10:08:16.613245+00	2024-11-28 10:08:16.613245+00
59	violet-4	#9775FA	2024-11-28 10:08:16.613775+00	2024-11-28 10:08:16.613775+00
60	violet-5	#845EF7	2024-11-28 10:08:16.614382+00	2024-11-28 10:08:16.614382+00
61	violet-6	#7950F2	2024-11-28 10:08:16.614952+00	2024-11-28 10:08:16.614952+00
62	violet-7	#7048E8	2024-11-28 10:08:16.615328+00	2024-11-28 10:08:16.615328+00
63	violet-8	#6741D9	2024-11-28 10:08:16.615704+00	2024-11-28 10:08:16.615704+00
64	violet-9	#5F3DC4	2024-11-28 10:08:16.616075+00	2024-11-28 10:08:16.616075+00
65	indigo-0	#EDF2FF	2024-11-28 10:08:16.616484+00	2024-11-28 10:08:16.616484+00
66	indigo-1	#DBE4FF	2024-11-28 10:08:16.617155+00	2024-11-28 10:08:16.617155+00
67	indigo-2	#BAC8FF	2024-11-28 10:08:16.617661+00	2024-11-28 10:08:16.617661+00
68	indigo-3	#91A7FF	2024-11-28 10:08:16.618082+00	2024-11-28 10:08:16.618082+00
69	indigo-4	#748FFC	2024-11-28 10:08:16.61846+00	2024-11-28 10:08:16.61846+00
70	indigo-5	#5C7CFA	2024-11-28 10:08:16.618873+00	2024-11-28 10:08:16.618873+00
71	indigo-6	#4C6EF5	2024-11-28 10:08:16.619762+00	2024-11-28 10:08:16.619762+00
72	indigo-7	#4263EB	2024-11-28 10:08:16.620421+00	2024-11-28 10:08:16.620421+00
73	indigo-8	#3B5BDB	2024-11-28 10:08:16.620983+00	2024-11-28 10:08:16.620983+00
74	indigo-9	#364FC7	2024-11-28 10:08:16.621725+00	2024-11-28 10:08:16.621725+00
75	blue-0	#E7F5FF	2024-11-28 10:08:16.622528+00	2024-11-28 10:08:16.622528+00
76	blue-1	#D0EBFF	2024-11-28 10:08:16.622975+00	2024-11-28 10:08:16.622975+00
77	blue-2	#A5D8FF	2024-11-28 10:08:16.623354+00	2024-11-28 10:08:16.623354+00
78	blue-3	#74C0FC	2024-11-28 10:08:16.623975+00	2024-11-28 10:08:16.623975+00
79	blue-4	#4DABF7	2024-11-28 10:08:16.624852+00	2024-11-28 10:08:16.624852+00
80	blue-5	#339AF0	2024-11-28 10:08:16.625724+00	2024-11-28 10:08:16.625724+00
81	blue-6	#228BE6	2024-11-28 10:08:16.62614+00	2024-11-28 10:08:16.62614+00
82	blue-7	#1C7ED6	2024-11-28 10:08:16.626561+00	2024-11-28 10:08:16.626561+00
83	blue-8	#1971C2	2024-11-28 10:08:16.626877+00	2024-11-28 10:08:16.626877+00
84	blue-9	#1864AB	2024-11-28 10:08:16.627194+00	2024-11-28 10:08:16.627194+00
85	cyan-0	#E3FAFC	2024-11-28 10:08:16.627552+00	2024-11-28 10:08:16.627552+00
86	cyan-1	#C5F6FA	2024-11-28 10:08:16.627866+00	2024-11-28 10:08:16.627866+00
87	cyan-2	#99E9F2	2024-11-28 10:08:16.628161+00	2024-11-28 10:08:16.628161+00
88	cyan-3	#66D9E8	2024-11-28 10:08:16.628451+00	2024-11-28 10:08:16.628451+00
89	cyan-4	#3BC9DB	2024-11-28 10:08:16.628736+00	2024-11-28 10:08:16.628736+00
90	cyan-5	#22B8CF	2024-11-28 10:08:16.629041+00	2024-11-28 10:08:16.629041+00
91	cyan-6	#15AABF	2024-11-28 10:08:16.629354+00	2024-11-28 10:08:16.629354+00
92	cyan-7	#1098AD	2024-11-28 10:08:16.629647+00	2024-11-28 10:08:16.629647+00
93	cyan-8	#0C8599	2024-11-28 10:08:16.630031+00	2024-11-28 10:08:16.630031+00
94	cyan-9	#0B7285	2024-11-28 10:08:16.630558+00	2024-11-28 10:08:16.630558+00
95	teal-0	#E6FCF5	2024-11-28 10:08:16.631412+00	2024-11-28 10:08:16.631412+00
96	teal-1	#C3FAE8	2024-11-28 10:08:16.63184+00	2024-11-28 10:08:16.63184+00
97	teal-2	#96F2D7	2024-11-28 10:08:16.63216+00	2024-11-28 10:08:16.63216+00
98	teal-3	#63E6BE	2024-11-28 10:08:16.632503+00	2024-11-28 10:08:16.632503+00
99	teal-4	#38D9A9	2024-11-28 10:08:16.632813+00	2024-11-28 10:08:16.632813+00
100	teal-5	#20C997	2024-11-28 10:08:16.633565+00	2024-11-28 10:08:16.633565+00
101	teal-6	#12B886	2024-11-28 10:08:16.634124+00	2024-11-28 10:08:16.634124+00
102	teal-7	#0CA678	2024-11-28 10:08:16.634467+00	2024-11-28 10:08:16.634467+00
103	teal-8	#099268	2024-11-28 10:08:16.634904+00	2024-11-28 10:08:16.634904+00
104	teal-9	#087F5B	2024-11-28 10:08:16.635474+00	2024-11-28 10:08:16.635474+00
105	green-0	#EBFBEE	2024-11-28 10:08:16.635959+00	2024-11-28 10:08:16.635959+00
106	green-1	#D3F9D8	2024-11-28 10:08:16.636293+00	2024-11-28 10:08:16.636293+00
107	green-2	#B2F2BB	2024-11-28 10:08:16.636597+00	2024-11-28 10:08:16.636597+00
108	green-3	#8CE99A	2024-11-28 10:08:16.637588+00	2024-11-28 10:08:16.637588+00
109	green-4	#69DB7C	2024-11-28 10:08:16.638707+00	2024-11-28 10:08:16.638707+00
110	green-5	#51CF66	2024-11-28 10:08:16.639196+00	2024-11-28 10:08:16.639196+00
111	green-6	#40C057	2024-11-28 10:08:16.63954+00	2024-11-28 10:08:16.63954+00
112	green-7	#37B24D	2024-11-28 10:08:16.63985+00	2024-11-28 10:08:16.63985+00
113	green-8	#2F9E44	2024-11-28 10:08:16.640138+00	2024-11-28 10:08:16.640138+00
114	green-9	#2B8A3E	2024-11-28 10:08:16.64043+00	2024-11-28 10:08:16.64043+00
115	lime-0	#F4FCE3	2024-11-28 10:08:16.640795+00	2024-11-28 10:08:16.640795+00
116	lime-1	#E9FAC8	2024-11-28 10:08:16.641112+00	2024-11-28 10:08:16.641112+00
117	lime-2	#D8F5A2	2024-11-28 10:08:16.641417+00	2024-11-28 10:08:16.641417+00
118	lime-3	#C0EB75	2024-11-28 10:08:16.64187+00	2024-11-28 10:08:16.64187+00
119	lime-4	#A9E34B	2024-11-28 10:08:16.642867+00	2024-11-28 10:08:16.642867+00
120	lime-5	#94D82D	2024-11-28 10:08:16.644204+00	2024-11-28 10:08:16.644204+00
121	lime-6	#82C91E	2024-11-28 10:08:16.644606+00	2024-11-28 10:08:16.644606+00
122	lime-7	#74B816	2024-11-28 10:08:16.644924+00	2024-11-28 10:08:16.644924+00
123	lime-8	#66A80F	2024-11-28 10:08:16.645273+00	2024-11-28 10:08:16.645273+00
124	lime-9	#5C940D	2024-11-28 10:08:16.64558+00	2024-11-28 10:08:16.64558+00
125	yellow-0	#FFF9DB	2024-11-28 10:08:16.646093+00	2024-11-28 10:08:16.646093+00
126	yellow-1	#FFF3BF	2024-11-28 10:08:16.646423+00	2024-11-28 10:08:16.646423+00
127	yellow-2	#FFEC99	2024-11-28 10:08:16.646709+00	2024-11-28 10:08:16.646709+00
128	yellow-3	#FFE066	2024-11-28 10:08:16.647014+00	2024-11-28 10:08:16.647014+00
129	yellow-4	#FFD43B	2024-11-28 10:08:16.64752+00	2024-11-28 10:08:16.64752+00
130	yellow-5	#FCC419	2024-11-28 10:08:16.648277+00	2024-11-28 10:08:16.648277+00
131	yellow-6	#FAB005	2024-11-28 10:08:16.648581+00	2024-11-28 10:08:16.648581+00
132	yellow-7	#F59F00	2024-11-28 10:08:16.648858+00	2024-11-28 10:08:16.648858+00
133	yellow-8	#F08C00	2024-11-28 10:08:16.649168+00	2024-11-28 10:08:16.649168+00
134	yellow-9	#E67700	2024-11-28 10:08:16.649572+00	2024-11-28 10:08:16.649572+00
135	orange-0	#FFF4E6	2024-11-28 10:08:16.650027+00	2024-11-28 10:08:16.650027+00
136	orange-1	#FFE8CC	2024-11-28 10:08:16.650457+00	2024-11-28 10:08:16.650457+00
137	orange-2	#FFD8A8	2024-11-28 10:08:16.650882+00	2024-11-28 10:08:16.650882+00
138	orange-3	#FFC078	2024-11-28 10:08:16.651229+00	2024-11-28 10:08:16.651229+00
139	orange-4	#FFA94D	2024-11-28 10:08:16.651528+00	2024-11-28 10:08:16.651528+00
140	orange-5	#FF922B	2024-11-28 10:08:16.651869+00	2024-11-28 10:08:16.651869+00
141	orange-6	#FD7E14	2024-11-28 10:08:16.652631+00	2024-11-28 10:08:16.652631+00
142	orange-7	#F76707	2024-11-28 10:08:16.653635+00	2024-11-28 10:08:16.653635+00
143	orange-8	#E8590C	2024-11-28 10:08:16.654427+00	2024-11-28 10:08:16.654427+00
144	orange-9	#D9480F	2024-11-28 10:08:16.655028+00	2024-11-28 10:08:16.655028+00
145	PM2 Orange	#F7983A	2024-12-11 09:57:00.553531+00	2024-12-11 09:57:00.553531+00
146	PM2 Purple	#682D91	2024-12-11 09:57:00.558305+00	2024-12-11 09:57:00.558305+00
147	PM2 Red	#F05823	2024-12-11 09:57:00.563843+00	2024-12-11 09:57:00.563843+00
148	PM2 Magenta	#EC038A	2024-12-11 09:57:00.564681+00	2024-12-11 09:57:00.564681+00
149	PM2 Green Yellow	#B1D13A	2024-12-11 09:57:00.565673+00	2024-12-11 09:57:00.565673+00
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
1	1	Project attributes	ProjectCustomFieldSection	2024-11-28 10:07:45.90269+00	2024-11-28 10:07:45.90269+00
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
14	3	calendar
15	3	board_view
16	3	work_package_tracking
17	3	gantt
18	3	news
19	3	costs
20	3	wiki
21	3	reporting_module
22	3	meetings
23	3	backlogs
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
1	Management	1	t	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.532361+00	2024-11-28 10:08:16.532361+00	\N
2	Specification	2	f	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.541572+00	2024-11-28 10:08:16.541572+00	\N
3	Development	3	f	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.550723+00	2024-11-28 10:08:16.550723+00	\N
4	Testing	4	f	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.557226+00	2024-11-28 10:08:16.557226+00	\N
5	Support	5	f	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.561297+00	2024-11-28 10:08:16.561297+00	\N
6	Other	6	f	TimeEntryActivity	t	\N	\N	2024-11-28 10:08:16.566138+00	2024-11-28 10:08:16.566138+00	\N
7	Low	1	f	IssuePriority	t	\N	\N	2024-11-28 10:08:17.82235+00	2024-11-28 10:08:17.82235+00	86
8	Normal	2	t	IssuePriority	t	\N	\N	2024-11-28 10:08:17.827603+00	2024-11-28 10:08:17.827603+00	78
9	High	3	f	IssuePriority	t	\N	\N	2024-11-28 10:08:17.832376+00	2024-11-28 10:08:17.832376+00	132
10	Immediate	4	f	IssuePriority	t	\N	\N	2024-11-28 10:08:17.837132+00	2024-11-28 10:08:17.837132+00	50
11	Documentation	1	f	DocumentCategory	t	\N	\N	2024-11-28 10:08:18.55588+00	2024-11-28 10:08:18.55588+00	\N
12	Specification	2	f	DocumentCategory	t	\N	\N	2024-11-28 10:08:18.561197+00	2024-11-28 10:08:18.561197+00	\N
13	Other	3	f	DocumentCategory	t	\N	\N	2024-11-28 10:08:18.563956+00	2024-11-28 10:08:18.563956+00	\N
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
2c02a02d-871d-48df-8bfe-7cde6b742e9f	2024-11-28 10:08:19.208474+00	2024-11-28 10:08:19.260563+00	6a5de249-cc6b-42c4-984a-9fb1524da851	Notifications::WorkflowJob	default	{"job_id": "6a5de249-cc6b-42c4-984a-9fb1524da851", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/1"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.171463573Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.201477+00	2024-11-28 10:08:19.259844+00	\N	\N
ff710e4b-edee-4661-8ccb-e6f59aa2719f	2024-11-28 10:08:19.326187+00	2024-11-28 10:08:19.347223+00	910015e2-65d2-4cf6-9c89-a4e99abe5745	Notifications::WorkflowJob	default	{"job_id": "910015e2-65d2-4cf6-9c89-a4e99abe5745", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/2"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.322889817Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.323888+00	2024-11-28 10:08:19.347016+00	\N	\N
434e6a5a-09e2-4de8-9126-bbfb78322d96	2024-11-28 10:08:19.506375+00	2024-11-28 10:08:19.519227+00	579e5b7a-05e5-4f4d-a113-9b8833029d02	Notifications::WorkflowJob	default	{"job_id": "579e5b7a-05e5-4f4d-a113-9b8833029d02", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/3"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.504291392Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.504598+00	2024-11-28 10:08:19.51907+00	\N	\N
13f16225-4c5a-4316-bcb6-b78dcdcb554f	2024-11-28 10:08:19.604237+00	2024-11-28 10:08:19.615766+00	ef554d33-db3b-4c96-9129-b668ae734776	Notifications::WorkflowJob	default	{"job_id": "ef554d33-db3b-4c96-9129-b668ae734776", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.602218318Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.602472+00	2024-11-28 10:08:19.615612+00	\N	\N
9d0d9ffe-2266-4410-a1ee-3c560b1697e1	2024-11-28 10:08:19.634801+00	2024-11-28 10:08:19.644356+00	99314b7f-4def-470e-8515-ccc00045b573	Notifications::WorkflowJob	default	{"job_id": "99314b7f-4def-470e-8515-ccc00045b573", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.632559910Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.632913+00	2024-11-28 10:08:19.644199+00	\N	\N
21c92741-cff1-4c85-8926-9aeea26f0313	2024-11-28 10:08:19.668061+00	2024-11-28 10:08:19.679656+00	9ae0c369-7b71-4f6e-b1b5-3beb81fcba79	Notifications::WorkflowJob	default	{"job_id": "9ae0c369-7b71-4f6e-b1b5-3beb81fcba79", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.666467153Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.666675+00	2024-11-28 10:08:19.679467+00	\N	\N
86a565ce-9383-40bf-8e57-4de4ee06bb60	2024-11-28 10:09:05.160788+00	2024-11-28 10:09:05.24342+00	aaf182c1-1352-48c5-8d2d-8751611186c2	WorkPackages::Progress::MigrateValuesJob	default	{"job_id": "aaf182c1-1352-48c5-8d2d-8751611186c2", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [{"current_mode": "field", "previous_mode": null, "_aj_ruby2_keywords": ["current_mode", "previous_mode"]}], "job_class": "WorkPackages::Progress::MigrateValuesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:07:51.916751975Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:07:51.95534+00	2024-11-28 10:09:05.242915+00	\N	\N
bfa80017-3392-4d2c-94a8-64de8fc3c390	2024-11-28 10:13:19.359091+00	2024-11-28 10:13:19.370983+00	a7641a84-5044-4e4e-8502-4518cde0de71	Notifications::WorkflowJob	default	{"job_id": "a7641a84-5044-4e4e-8502-4518cde0de71", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.344398700Z", "scheduled_at": "2024-11-28T10:13:19.344213210Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.344213+00	2024-11-28 10:13:19.370723+00	\N	\N
65df0601-b351-41ec-8ee0-5e14b48aaca7	2024-11-28 10:13:19.543488+00	2024-11-28 10:13:19.574489+00	a305feb0-f86b-4e6e-8ab3-2b8c2d4953e1	Journals::CompletedJob	default	{"job_id": "a305feb0-f86b-4e6e-8ab3-2b8c2d4953e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [3, {"value": "2024-11-28T10:08:19.493076000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.522559715Z", "scheduled_at": "2024-11-28T10:13:19.521964201Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.521964+00	2024-11-28 10:13:19.574179+00	\N	\N
139647ed-0f26-4c56-b1e1-989f306bde33	2024-11-28 10:14:05.236377+00	2024-11-28 10:14:05.264219+00	df788a12-0725-47b4-b728-8b63d724b965	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	default	{"job_id": "df788a12-0725-47b4-b728-8b63d724b965", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 1, "queue_name": "default", "enqueued_at": "2024-11-28T10:09:05.234905491Z", "scheduled_at": "2024-11-28T10:14:05.233999090Z", "provider_job_id": "df788a12-0725-47b4-b728-8b63d724b965", "exception_executions": {"[GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError]": 1}}	2024-11-28 10:14:05.233999+00	2024-11-28 10:14:05.264017+00	\N	\N
bdb7111e-6dc3-4150-8c4f-10e19d56940a	2024-11-28 10:15:00.065668+00	2024-11-28 10:15:00.129992+00	28e838db-0518-4c18-942a-d78d730c417a	Notifications::ScheduleDateAlertsNotificationsJob	default	{"job_id": "28e838db-0518-4c18-942a-d78d730c417a", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:00.054503982Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:00.055567+00	2024-11-28 10:15:00.12984+00	\N	\N
590c6f4b-407a-4351-a731-897554a8a96b	2024-11-28 10:08:19.699944+00	2024-11-28 10:08:19.71135+00	9a6b6818-a0b6-4b28-a428-92665805d136	Notifications::WorkflowJob	default	{"job_id": "9a6b6818-a0b6-4b28-a428-92665805d136", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.698379931Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.69864+00	2024-11-28 10:08:19.711176+00	\N	\N
dbb04b68-111f-4391-8875-40b9ef42090d	2024-11-28 10:08:19.732408+00	2024-11-28 10:08:19.74399+00	bddb2dd2-1ac0-45e0-a08e-63832bb744a4	Notifications::WorkflowJob	default	{"job_id": "bddb2dd2-1ac0-45e0-a08e-63832bb744a4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.730481496Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.730849+00	2024-11-28 10:08:19.74384+00	\N	\N
66d3a2b4-5812-48f9-af94-21dff9dadd8a	2024-11-28 10:08:19.757997+00	2024-11-28 10:08:19.766518+00	8fe5f71e-6aa8-40b3-a7a0-958ac6621bcf	Notifications::WorkflowJob	default	{"job_id": "8fe5f71e-6aa8-40b3-a7a0-958ac6621bcf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.756327920Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.756545+00	2024-11-28 10:08:19.766344+00	\N	\N
533e5973-4c66-4140-adb1-fb630be54976	2024-11-28 10:08:19.798572+00	2024-11-28 10:08:19.808085+00	c7258cac-0c13-4ae6-8195-6698f5c273ae	Notifications::WorkflowJob	default	{"job_id": "c7258cac-0c13-4ae6-8195-6698f5c273ae", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.796527424Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.796734+00	2024-11-28 10:08:19.807896+00	\N	\N
35a39dbc-0d7c-4060-a057-c69ed1950077	2024-11-28 10:08:19.829551+00	2024-11-28 10:08:19.8384+00	1ed30a2b-9f7c-4fa2-a55f-b9475a27a880	Notifications::WorkflowJob	default	{"job_id": "1ed30a2b-9f7c-4fa2-a55f-b9475a27a880", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.827581019Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.82779+00	2024-11-28 10:08:19.838181+00	\N	\N
ccbaa786-087a-4068-8bfd-cb18518f8558	2024-11-28 10:08:19.853821+00	2024-11-28 10:08:19.862157+00	53b39c32-7892-4ebc-80d4-9ad4627bd6e3	Notifications::WorkflowJob	default	{"job_id": "53b39c32-7892-4ebc-80d4-9ad4627bd6e3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.851814057Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.852206+00	2024-11-28 10:08:19.862006+00	\N	\N
0b7470b9-dfe5-4ff5-939f-79a45a6740c7	2024-11-28 10:09:05.213588+00	2024-11-28 10:09:05.256077+00	df788a12-0725-47b4-b728-8b63d724b965	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	default	{"job_id": "df788a12-0725-47b4-b728-8b63d724b965", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:07:52.045648946Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:07:52.045905+00	2024-11-28 10:09:05.255666+00	GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError: GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError	3
11e7b510-a8d6-42ad-a461-6dcde1c739a8	2024-11-28 10:13:19.261592+00	2024-11-28 10:13:19.323932+00	9336b705-5d15-4514-9ea3-552a1863836c	Notifications::WorkflowJob	default	{"job_id": "9336b705-5d15-4514-9ea3-552a1863836c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.255518477Z", "scheduled_at": "2024-11-28T10:13:19.254078748Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.254078+00	2024-11-28 10:13:19.32345+00	\N	\N
be78cb47-c4fc-4ae4-a6ee-21d3bbf0a534	2024-11-28 10:13:19.667333+00	2024-11-28 10:13:19.702495+00	77803450-e315-4fc3-9823-1525b08af5e7	Notifications::WorkflowJob	default	{"job_id": "77803450-e315-4fc3-9823-1525b08af5e7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.642654921Z", "scheduled_at": "2024-11-28T10:13:19.642401733Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.642401+00	2024-11-28 10:13:19.702198+00	\N	\N
8c70b671-42f0-4ad8-ab14-5da8b05c19df	2024-11-28 10:15:00.05125+00	2024-11-28 10:15:00.118733+00	5953e60d-2946-4ce6-94b7-6b9bdd25c4a2	Notifications::ScheduleReminderMailsJob	default	{"job_id": "5953e60d-2946-4ce6-94b7-6b9bdd25c4a2", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:00.031899164Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:00.034662+00	2024-11-28 10:15:00.118559+00	\N	\N
0a4356ea-546c-40ad-8349-86b66fdd9945	2024-11-28 10:15:07.146261+00	2024-11-28 10:15:07.340647+00	995cd400-1f7e-409e-a584-cd1358546187	Mails::MailerJob	mailers	{"job_id": "995cd400-1f7e-409e-a584-cd1358546187", "locale": "en", "priority": null, "timezone": "Etc/UTC", "arguments": ["UserMailer", "user_signed_up", "deliver_now", {"args": [{"_aj_globalid": "gid://open-project/Token::Invitation/2"}], "_aj_ruby2_keywords": ["args"]}], "job_class": "Mails::MailerJob", "executions": 0, "queue_name": "mailers", "enqueued_at": "2024-11-28T10:15:07.135309847Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:07.135799+00	2024-11-28 10:15:07.340463+00	\N	\N
23bf6e48-3b99-4bc5-a97c-a82217b5ba93	2024-11-28 10:08:19.88227+00	2024-11-28 10:08:19.891106+00	d72f48bf-4d19-4c7e-a9a2-37fc578495b7	Notifications::WorkflowJob	default	{"job_id": "d72f48bf-4d19-4c7e-a9a2-37fc578495b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.879953940Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.880153+00	2024-11-28 10:08:19.890938+00	\N	\N
041dc2a6-14f0-484d-aea1-1589382ef192	2024-11-28 10:08:19.908874+00	2024-11-28 10:08:19.91838+00	2b619adb-a578-4c33-af8a-9e8659d25db1	Notifications::WorkflowJob	default	{"job_id": "2b619adb-a578-4c33-af8a-9e8659d25db1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.907381771Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.907697+00	2024-11-28 10:08:19.918218+00	\N	\N
a57e2db2-9546-41ec-9b86-088260c5a0e2	2024-11-28 10:08:19.9292+00	2024-11-28 10:08:19.939629+00	ca3e5469-8998-4f9a-87b6-2f2022a8cbc4	Notifications::WorkflowJob	default	{"job_id": "ca3e5469-8998-4f9a-87b6-2f2022a8cbc4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.927646134Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.927852+00	2024-11-28 10:08:19.939382+00	\N	\N
8d2b76d2-f96d-4625-ac60-55e868abd169	2024-11-28 10:08:19.967857+00	2024-11-28 10:08:19.977161+00	9463443a-5858-4e24-a3c2-3f7d5b6469e1	Notifications::WorkflowJob	default	{"job_id": "9463443a-5858-4e24-a3c2-3f7d5b6469e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.966387736Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.966583+00	2024-11-28 10:08:19.976994+00	\N	\N
93908360-9539-452d-83a3-1dd2ccf38d53	2024-11-28 10:08:19.992299+00	2024-11-28 10:08:20.001445+00	309eba23-cd7b-415e-8349-98f5f67bf4b5	Notifications::WorkflowJob	default	{"job_id": "309eba23-cd7b-415e-8349-98f5f67bf4b5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.990798128Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.991005+00	2024-11-28 10:08:20.001282+00	\N	\N
43c422d0-11a9-4701-b54f-f3e3d06fc4ce	2024-11-28 10:08:20.035437+00	2024-11-28 10:08:20.047069+00	e1e6fd10-0a37-40fe-af8c-ab315b5492d4	Notifications::WorkflowJob	default	{"job_id": "e1e6fd10-0a37-40fe-af8c-ab315b5492d4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.033672474Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.03393+00	2024-11-28 10:08:20.046665+00	\N	\N
fe9c26c8-8d10-41c7-a041-e448737bacf3	2024-11-28 10:13:19.362427+00	2024-11-28 10:13:19.398685+00	34e215ca-038a-4c4f-807a-9d18374ba5aa	Journals::CompletedJob	default	{"job_id": "34e215ca-038a-4c4f-807a-9d18374ba5aa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [2, {"value": "2024-11-28T10:08:19.299321000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.351585972Z", "scheduled_at": "2024-11-28T10:13:19.350400584Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.3504+00	2024-11-28 10:13:19.397737+00	\N	\N
da263b1a-1af4-4abf-8973-a3e7d1c24008	2024-11-28 10:13:19.528684+00	2024-11-28 10:13:19.558571+00	1e73ff2b-1ccb-4b14-9601-6fdb5c89eca4	Notifications::WorkflowJob	default	{"job_id": "1e73ff2b-1ccb-4b14-9601-6fdb5c89eca4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.517510372Z", "scheduled_at": "2024-11-28T10:13:19.517326184Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.517326+00	2024-11-28 10:13:19.557618+00	\N	\N
8c0a52df-1699-4ed0-b035-103ab8dde9f5	2024-11-28 10:13:19.625111+00	2024-11-28 10:13:19.673663+00	4ccab370-2993-4f69-864c-17090eab9310	Journals::CompletedJob	default	{"job_id": "4ccab370-2993-4f69-864c-17090eab9310", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-11-28T10:08:19.556742000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.618501264Z", "scheduled_at": "2024-11-28T10:13:19.618270919Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.61827+00	2024-11-28 10:13:19.673134+00	\N	\N
1baf8d20-0cbb-404d-abd8-c36b655a428d	2024-11-28 10:15:07.107265+00	2024-11-28 10:15:07.14156+00	3e918815-9401-49ca-91ef-1f876e33399e	Mails::InvitationJob	default	{"job_id": "3e918815-9401-49ca-91ef-1f876e33399e", "locale": "en", "priority": 0, "timezone": "Etc/UTC", "arguments": [{"_aj_globalid": "gid://open-project/Token::Invitation/2"}], "job_class": "Mails::InvitationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:07.098727186Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:07.099083+00	2024-11-28 10:15:07.141416+00	\N	\N
b1aa10f6-ba80-4b1c-a845-f27d993614a6	2024-11-28 10:08:20.070218+00	2024-11-28 10:08:20.079046+00	532b536c-c661-4971-93ee-73c39aedda15	Notifications::WorkflowJob	default	{"job_id": "532b536c-c661-4971-93ee-73c39aedda15", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.068475208Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.068687+00	2024-11-28 10:08:20.078838+00	\N	\N
c8ed63f2-86b1-424b-999e-5a27deea840c	2024-11-28 10:08:20.092301+00	2024-11-28 10:08:20.101619+00	4add24bc-fe91-4d9a-a00e-4fb4775b45d3	Notifications::WorkflowJob	default	{"job_id": "4add24bc-fe91-4d9a-a00e-4fb4775b45d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.090692278Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.090888+00	2024-11-28 10:08:20.101453+00	\N	\N
81416cce-4040-451d-8059-c3bd58292b6d	2024-11-28 10:08:20.12353+00	2024-11-28 10:08:20.135357+00	3c7c537b-c03f-40b8-9057-839cd0be7925	Notifications::WorkflowJob	default	{"job_id": "3c7c537b-c03f-40b8-9057-839cd0be7925", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.121896348Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.12215+00	2024-11-28 10:08:20.135179+00	\N	\N
c4eb59d9-ed8d-45dd-9d98-66a9a75fa74b	2024-11-28 10:08:20.152709+00	2024-11-28 10:08:20.160528+00	58c2d5ff-cfc5-45ab-8c07-a9e2d272345e	Notifications::WorkflowJob	default	{"job_id": "58c2d5ff-cfc5-45ab-8c07-a9e2d272345e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.151301130Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.151498+00	2024-11-28 10:08:20.160376+00	\N	\N
d7abd3c1-16bc-485f-b6e8-02aab60279de	2024-11-28 10:08:20.170738+00	2024-11-28 10:08:20.179422+00	bedca8e5-e5c8-4382-b254-31e3c4b9b4d8	Notifications::WorkflowJob	default	{"job_id": "bedca8e5-e5c8-4382-b254-31e3c4b9b4d8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.169511244Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.169709+00	2024-11-28 10:08:20.179252+00	\N	\N
991c7566-da96-45af-84d5-25dbc299e4b5	2024-11-28 10:08:20.198904+00	2024-11-28 10:08:20.208296+00	e80412cf-3770-49d4-80cd-ce5cb6aa7266	Notifications::WorkflowJob	default	{"job_id": "e80412cf-3770-49d4-80cd-ce5cb6aa7266", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.197176082Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.197427+00	2024-11-28 10:08:20.208142+00	\N	\N
5f2efd91-8620-485a-996c-7ef8a70f0bfb	2024-11-28 10:13:19.617265+00	2024-11-28 10:13:19.641799+00	b120cf5d-58b8-43a2-8691-ec8ce62349b4	Notifications::WorkflowJob	default	{"job_id": "b120cf5d-58b8-43a2-8691-ec8ce62349b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.614073183Z", "scheduled_at": "2024-11-28T10:13:19.613795979Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.613795+00	2024-11-28 10:13:19.641148+00	\N	\N
e0e8bd11-8e85-48dc-abb8-bd801f680707	2024-11-28 10:13:19.693353+00	2024-11-28 10:13:19.821779+00	8a47d6bd-d452-43b3-93dd-46b18970f3b8	Journals::CompletedJob	default	{"job_id": "8a47d6bd-d452-43b3-93dd-46b18970f3b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-11-28T10:08:19.630954000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.647397075Z", "scheduled_at": "2024-11-28T10:13:19.647049879Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.647049+00	2024-11-28 10:13:19.821385+00	\N	\N
511bd668-beb8-4778-9917-d5b3baa3b817	2024-11-28 10:13:19.89198+00	2024-11-28 10:13:19.98034+00	1382dbf0-1392-48a8-8e19-a58615ed6c02	Notifications::WorkflowJob	default	{"job_id": "1382dbf0-1392-48a8-8e19-a58615ed6c02", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.764407705Z", "scheduled_at": "2024-11-28T10:13:19.764081189Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.764081+00	2024-11-28 10:13:19.980154+00	\N	\N
5e7170a4-17ee-49aa-b0a0-4fffeaf7851b	2024-11-28 10:15:46.008217+00	2024-11-28 10:15:46.109602+00	235c38b8-c5a0-4d19-ad9d-4354f736f84b	Mails::MailerJob	mailers	{"job_id": "235c38b8-c5a0-4d19-ad9d-4354f736f84b", "locale": "en", "priority": null, "timezone": "UTC", "arguments": ["UserMailer", "account_information", "deliver_now", {"args": [{"_aj_globalid": "gid://open-project/User/5"}, "1234567890n"], "_aj_ruby2_keywords": ["args"]}], "job_class": "Mails::MailerJob", "executions": 0, "queue_name": "mailers", "enqueued_at": "2024-11-28T10:15:46.000626568Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:46.000904+00	2024-11-28 10:15:46.109307+00	\N	\N
ac1623c9-f1e7-4bfd-b43f-3aba40efe212	2024-11-28 10:08:20.220359+00	2024-11-28 10:08:20.229684+00	f0eb4086-860e-4bda-a398-dd26acc1ae07	Notifications::WorkflowJob	default	{"job_id": "f0eb4086-860e-4bda-a398-dd26acc1ae07", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.219040546Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.219246+00	2024-11-28 10:08:20.229501+00	\N	\N
56656a10-1f26-4f55-9996-25c7c9485dfc	2024-11-28 10:08:20.247394+00	2024-11-28 10:08:20.257619+00	5239eff6-84c5-4806-95fc-dafd11b49fd1	Notifications::WorkflowJob	default	{"job_id": "5239eff6-84c5-4806-95fc-dafd11b49fd1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.245854155Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.246054+00	2024-11-28 10:08:20.257454+00	\N	\N
aaf8f67f-5984-41c8-9fe8-e6d04dc8b31e	2024-11-28 10:08:20.266992+00	2024-11-28 10:08:20.274812+00	a861da97-078a-4b6f-9896-56418da376f3	Notifications::WorkflowJob	default	{"job_id": "a861da97-078a-4b6f-9896-56418da376f3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.265807070Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.265999+00	2024-11-28 10:08:20.274663+00	\N	\N
21c9b32e-b254-4f4c-8202-9754e12e2eff	2024-11-28 10:08:20.29045+00	2024-11-28 10:08:20.298687+00	664b4f56-d3b8-40bd-96ff-901b2d280cf6	Notifications::WorkflowJob	default	{"job_id": "664b4f56-d3b8-40bd-96ff-901b2d280cf6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.288981879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.289204+00	2024-11-28 10:08:20.298534+00	\N	\N
439451bb-c799-4951-862d-ff12ec5b684f	2024-11-28 10:08:20.317532+00	2024-11-28 10:08:20.325831+00	0ad9dc82-4657-40b2-b890-589df3e0e4a2	Notifications::WorkflowJob	default	{"job_id": "0ad9dc82-4657-40b2-b890-589df3e0e4a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.315964919Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.316161+00	2024-11-28 10:08:20.325678+00	\N	\N
3adc44de-ff78-4855-bdf3-cb831b97237b	2024-11-28 10:08:20.339584+00	2024-11-28 10:08:20.347979+00	298a52b3-d772-4c06-bb96-fd0ad0fbb2e9	Notifications::WorkflowJob	default	{"job_id": "298a52b3-d772-4c06-bb96-fd0ad0fbb2e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.337968016Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.338165+00	2024-11-28 10:08:20.347803+00	\N	\N
1d65ca98-429a-47a6-97cf-7b0c885f3099	2024-11-28 10:13:19.715213+00	2024-11-28 10:13:19.819332+00	d0b6934a-235b-4ee6-8036-99c02091c76e	Notifications::WorkflowJob	default	{"job_id": "d0b6934a-235b-4ee6-8036-99c02091c76e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.676813149Z", "scheduled_at": "2024-11-28T10:13:19.676636585Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.676636+00	2024-11-28 10:13:19.819058+00	\N	\N
e752fba7-ee2c-4580-a82d-d93f22b83e36	2024-11-28 10:13:19.885542+00	2024-11-28 10:13:19.986981+00	a7fa572b-a26c-4dec-841d-0c59ff9c9741	Journals::CompletedJob	default	{"job_id": "a7fa572b-a26c-4dec-841d-0c59ff9c9741", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.717776000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.746030956Z", "scheduled_at": "2024-11-28T10:13:19.745818364Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.745818+00	2024-11-28 10:13:19.986474+00	\N	\N
8e0a310a-3f9c-4d80-8497-b83b6c4c085b	2024-11-28 10:13:20.015409+00	2024-11-28 10:13:20.091869+00	093dee5c-6b90-4f91-b46a-a23dd07427ac	Notifications::WorkflowJob	default	{"job_id": "093dee5c-6b90-4f91-b46a-a23dd07427ac", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.916626436Z", "scheduled_at": "2024-11-28T10:13:19.916303346Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.916303+00	2024-11-28 10:13:20.090649+00	\N	\N
8ff5a909-ce19-49a6-bdd4-2b6477191442	2024-11-28 10:13:20.071296+00	2024-11-28 10:13:20.144096+00	69370b45-ed71-495a-8aed-42de157b1960	Notifications::WorkflowJob	default	{"job_id": "69370b45-ed71-495a-8aed-42de157b1960", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.999556095Z", "scheduled_at": "2024-11-28T10:13:19.999379201Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.999379+00	2024-11-28 10:13:20.143878+00	\N	\N
3b85a433-de66-48e0-8e25-29d99b56c299	2024-11-28 10:08:20.372586+00	2024-11-28 10:08:20.382897+00	66502a80-b19c-4334-9520-c7fa5978cfab	Notifications::WorkflowJob	default	{"job_id": "66502a80-b19c-4334-9520-c7fa5978cfab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.370288372Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.37089+00	2024-11-28 10:08:20.382715+00	\N	\N
a0a158f0-9375-46d4-bd93-34f3d8a77c0b	2024-11-28 10:08:20.405467+00	2024-11-28 10:08:20.414303+00	d261f4f4-669a-42a9-88a5-e96aeb2d232e	Notifications::WorkflowJob	default	{"job_id": "d261f4f4-669a-42a9-88a5-e96aeb2d232e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.403510122Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.403705+00	2024-11-28 10:08:20.414069+00	\N	\N
531f4e1a-a24e-4917-ae4d-79fb1b934be1	2024-11-28 10:08:20.427054+00	2024-11-28 10:08:20.435306+00	721c1897-7345-4c1a-a972-88f049746980	Notifications::WorkflowJob	default	{"job_id": "721c1897-7345-4c1a-a972-88f049746980", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.425610082Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.425804+00	2024-11-28 10:08:20.435154+00	\N	\N
367e147c-efbc-42e9-960d-e371e460ad6c	2024-11-28 10:08:20.45594+00	2024-11-28 10:08:20.46334+00	5b4d4d2c-f3b5-4a6b-8b6d-d91a7307dc42	Notifications::WorkflowJob	default	{"job_id": "5b4d4d2c-f3b5-4a6b-8b6d-d91a7307dc42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.454338906Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.454555+00	2024-11-28 10:08:20.463167+00	\N	\N
fb2bc36c-b78e-431c-80ae-1de5910f1134	2024-11-28 10:08:20.472848+00	2024-11-28 10:08:20.481137+00	01907454-ce4f-4efa-a20c-2778b1f945b9	Notifications::WorkflowJob	default	{"job_id": "01907454-ce4f-4efa-a20c-2778b1f945b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.471458723Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.471662+00	2024-11-28 10:08:20.480913+00	\N	\N
6af2a5a2-d252-43cb-b7ec-7febb0a7ef28	2024-11-28 10:08:20.497022+00	2024-11-28 10:08:20.504079+00	5e57e3ac-8a10-44ae-a184-b50929dc9185	Notifications::WorkflowJob	default	{"job_id": "5e57e3ac-8a10-44ae-a184-b50929dc9185", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.495815483Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.49601+00	2024-11-28 10:08:20.503931+00	\N	\N
d8b67304-5c62-4960-8a27-079063e25902	2024-11-28 10:13:19.809157+00	2024-11-28 10:13:19.874762+00	504f3d7e-31b6-461c-a6a5-1428217eecc5	Journals::CompletedJob	default	{"job_id": "504f3d7e-31b6-461c-a6a5-1428217eecc5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-11-28T10:08:19.656300000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.682138955Z", "scheduled_at": "2024-11-28T10:13:19.681920322Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.68192+00	2024-11-28 10:13:19.874513+00	\N	\N
b03be777-eee0-44b9-b5c4-41d3e3cac4d3	2024-11-28 10:13:19.984606+00	2024-11-28 10:13:20.104108+00	329554e7-847d-406f-9ca0-0cdef96647b3	Journals::CompletedJob	default	{"job_id": "329554e7-847d-406f-9ca0-0cdef96647b3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.776038000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.810618732Z", "scheduled_at": "2024-11-28T10:13:19.810407123Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.810407+00	2024-11-28 10:13:20.103959+00	\N	\N
74545b57-e516-4222-8fe7-bda8b6282137	2024-11-28 10:13:20.047422+00	2024-11-28 10:13:20.151795+00	21295f61-c94b-419a-948e-d01ec8471c35	Journals::CompletedJob	default	{"job_id": "21295f61-c94b-419a-948e-d01ec8471c35", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.898109000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.920507424Z", "scheduled_at": "2024-11-28T10:13:19.920294562Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.920294+00	2024-11-28 10:13:20.15163+00	\N	\N
900d31cf-709e-41b8-8f94-259f6a8ff44e	2024-11-28 10:13:20.200658+00	2024-11-28 10:13:20.269047+00	64009d5d-6f84-4ab5-83a2-381f67117e51	Notifications::WorkflowJob	default	{"job_id": "64009d5d-6f84-4ab5-83a2-381f67117e51", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.132473781Z", "scheduled_at": "2024-11-28T10:13:20.132318207Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.132318+00	2024-11-28 10:13:20.268878+00	\N	\N
8856d9b9-e473-4953-9e8c-e58ceb431469	2024-11-28 10:13:20.246655+00	2024-11-28 10:13:20.308808+00	9b778e59-4a54-4832-854f-cecaca938a2e	Notifications::WorkflowJob	default	{"job_id": "9b778e59-4a54-4832-854f-cecaca938a2e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.206685877Z", "scheduled_at": "2024-11-28T10:13:20.206254553Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.206254+00	2024-11-28 10:13:20.308626+00	\N	\N
93cc5f7a-ebcc-4db8-b3e3-9f4d3b48189b	2024-11-28 10:08:20.515031+00	2024-11-28 10:08:20.523148+00	f68e5caa-6401-42d5-a0fd-d615a01e7cc6	Notifications::WorkflowJob	default	{"job_id": "f68e5caa-6401-42d5-a0fd-d615a01e7cc6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.512883030Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.513106+00	2024-11-28 10:08:20.522979+00	\N	\N
bb0f1744-4926-4512-810e-2c0d29030e06	2024-11-28 10:08:20.70434+00	2024-11-28 10:08:20.718646+00	d87c076c-c752-4a9c-89e3-e3db2d0dbe64	Notifications::WorkflowJob	default	{"job_id": "d87c076c-c752-4a9c-89e3-e3db2d0dbe64", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/17"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.702839496Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.703054+00	2024-11-28 10:08:20.71845+00	\N	\N
8c828085-457d-4730-8ebe-63647a7e154d	2024-11-28 10:08:20.999613+00	2024-11-28 10:08:21.011571+00	ec33bc49-d466-4463-9584-15abf957b86d	Notifications::WorkflowJob	default	{"job_id": "ec33bc49-d466-4463-9584-15abf957b86d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/18"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.997823456Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.998119+00	2024-11-28 10:08:21.011403+00	\N	\N
3a12274c-747e-4be5-937a-4caf8aeffdf9	2024-11-28 10:08:21.036484+00	2024-11-28 10:08:21.048544+00	4e4dcc16-5527-4152-9fcc-6dc797b8d9fd	Notifications::WorkflowJob	default	{"job_id": "4e4dcc16-5527-4152-9fcc-6dc797b8d9fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/19"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.035004861Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.035205+00	2024-11-28 10:08:21.048372+00	\N	\N
96f2f035-5d73-4230-aa9e-e1256b67cd07	2024-11-28 10:08:21.10959+00	2024-11-28 10:08:21.121413+00	6f0ce3f0-db18-4254-bb5e-cebce44b26b4	Notifications::WorkflowJob	default	{"job_id": "6f0ce3f0-db18-4254-bb5e-cebce44b26b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/20"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.107202955Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.107473+00	2024-11-28 10:08:21.12125+00	\N	\N
216445f0-4d24-4161-82a0-6301d71e2db9	2024-11-28 10:08:21.22191+00	2024-11-28 10:08:21.232702+00	3fce55f0-716b-4ccd-86f9-671e9096a044	Notifications::WorkflowJob	default	{"job_id": "3fce55f0-716b-4ccd-86f9-671e9096a044", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/21"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.220209844Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.220421+00	2024-11-28 10:08:21.232533+00	\N	\N
0350541f-6778-4971-80e6-fe40b3374ea3	2024-11-28 10:13:19.831187+00	2024-11-28 10:13:19.882107+00	608afb52-b229-4029-90da-83b7964befee	Notifications::WorkflowJob	default	{"job_id": "608afb52-b229-4029-90da-83b7964befee", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.707989136Z", "scheduled_at": "2024-11-28T10:13:19.707817952Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.707818+00	2024-11-28 10:13:19.881899+00	\N	\N
380b1d4a-cffb-4d0b-86ac-dc693278f8e2	2024-11-28 10:13:19.989888+00	2024-11-28 10:13:20.045211+00	2c5ee105-fa0d-499f-95b3-16c2d7accf2a	Notifications::WorkflowJob	default	{"job_id": "2c5ee105-fa0d-499f-95b3-16c2d7accf2a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.860451507Z", "scheduled_at": "2024-11-28T10:13:19.860175987Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.860175+00	2024-11-28 10:13:20.044827+00	\N	\N
20191442-79d9-4284-b4ac-6eaf4384a9f6	2024-11-28 10:13:20.059352+00	2024-11-28 10:13:20.126073+00	1f0dab6f-7b53-4efd-b8ee-110cd2d202e0	Notifications::WorkflowJob	default	{"job_id": "1f0dab6f-7b53-4efd-b8ee-110cd2d202e0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.937542340Z", "scheduled_at": "2024-11-28T10:13:19.937208360Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.937208+00	2024-11-28 10:13:20.125543+00	\N	\N
fb52bc02-6440-434b-92c7-742cc1c22932	2024-11-28 10:08:21.271736+00	2024-11-28 10:08:21.280249+00	d867ef11-5266-4e02-980a-668571c84670	Notifications::WorkflowJob	default	{"job_id": "d867ef11-5266-4e02-980a-668571c84670", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.270146926Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.270347+00	2024-11-28 10:08:21.280061+00	\N	\N
ef029651-6225-4c1c-b36b-64667689198b	2024-11-28 10:08:21.293306+00	2024-11-28 10:08:21.301525+00	75f4bd21-3b18-4a3b-a181-47518ffd766f	Notifications::WorkflowJob	default	{"job_id": "75f4bd21-3b18-4a3b-a181-47518ffd766f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.291476670Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.291705+00	2024-11-28 10:08:21.301361+00	\N	\N
7e3fc671-13cd-4553-9594-05f588e22956	2024-11-28 10:08:21.334578+00	2024-11-28 10:08:21.343253+00	a38ade04-6f19-48f5-971e-14c143bad3bd	Notifications::WorkflowJob	default	{"job_id": "a38ade04-6f19-48f5-971e-14c143bad3bd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.332857785Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.333079+00	2024-11-28 10:08:21.343096+00	\N	\N
693849da-2e20-4076-8164-a2f766bc3051	2024-11-28 10:08:21.356994+00	2024-11-28 10:08:21.370089+00	7f23fc75-3a9a-423e-b561-27b728263f73	Notifications::WorkflowJob	default	{"job_id": "7f23fc75-3a9a-423e-b561-27b728263f73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.355112767Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.355329+00	2024-11-28 10:08:21.369894+00	\N	\N
9ce8a349-2e9e-46f3-9144-c3e18fcac9e3	2024-11-28 10:08:21.395621+00	2024-11-28 10:08:21.404236+00	da63c6e0-9c5b-43c1-abc0-0ad4b63b50d5	Notifications::WorkflowJob	default	{"job_id": "da63c6e0-9c5b-43c1-abc0-0ad4b63b50d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.394301864Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.394513+00	2024-11-28 10:08:21.404079+00	\N	\N
f8f34fe7-f59a-49c0-a0a9-8c548a1fbcc9	2024-11-28 10:08:21.431999+00	2024-11-28 10:08:21.44113+00	640ff382-05d2-4324-bb25-af570980d230	Notifications::WorkflowJob	default	{"job_id": "640ff382-05d2-4324-bb25-af570980d230", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.430576798Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.430885+00	2024-11-28 10:08:21.440927+00	\N	\N
f6e46395-319e-4dfd-b236-d3d9a1df9ef4	2024-11-28 10:13:19.87282+00	2024-11-28 10:13:19.982964+00	3a300915-cb77-4436-b1f5-856659bece0e	Journals::CompletedJob	default	{"job_id": "3a300915-cb77-4436-b1f5-856659bece0e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:19.688230000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.713411443Z", "scheduled_at": "2024-11-28T10:13:19.713204122Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.713204+00	2024-11-28 10:13:19.982801+00	\N	\N
87a726c9-50ab-494c-a4fe-9cd6f0aa222f	2024-11-28 10:13:20.063762+00	2024-11-28 10:13:20.141319+00	5c658ae5-011c-411b-80ff-e9a7a8fdb077	Notifications::WorkflowJob	default	{"job_id": "5c658ae5-011c-411b-80ff-e9a7a8fdb077", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.975172223Z", "scheduled_at": "2024-11-28T10:13:19.974702015Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.974702+00	2024-11-28 10:13:20.141153+00	\N	\N
7f28b747-e402-4b06-bed7-a400582921f3	2024-11-28 10:13:20.067278+00	2024-11-28 10:13:20.198341+00	c6427247-355f-42a0-be09-3542ee125827	Journals::CompletedJob	default	{"job_id": "c6427247-355f-42a0-be09-3542ee125827", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.946665000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.980202131Z", "scheduled_at": "2024-11-28T10:13:19.979816202Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.979816+00	2024-11-28 10:13:20.198187+00	\N	\N
4fb37d6e-57dc-4d63-9fd6-a300a6406580	2024-11-28 10:08:21.452896+00	2024-11-28 10:08:21.463929+00	bb5c6d45-082f-48cd-9168-9bb808550197	Notifications::WorkflowJob	default	{"job_id": "bb5c6d45-082f-48cd-9168-9bb808550197", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.451274760Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.451493+00	2024-11-28 10:08:21.46371+00	\N	\N
ca232f3d-04eb-4f02-abf8-99444e4b3278	2024-11-28 10:08:21.487906+00	2024-11-28 10:08:21.496632+00	49c67e60-c9ce-4869-9046-3f0846e6cddf	Notifications::WorkflowJob	default	{"job_id": "49c67e60-c9ce-4869-9046-3f0846e6cddf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.486646659Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.486853+00	2024-11-28 10:08:21.496467+00	\N	\N
c7aa2fe8-bf0e-4327-bcd4-e2865bfac088	2024-11-28 10:08:21.519139+00	2024-11-28 10:08:21.527959+00	558a0e5d-69d9-40ee-8c61-41c36beaf7d9	Notifications::WorkflowJob	default	{"job_id": "558a0e5d-69d9-40ee-8c61-41c36beaf7d9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.517764405Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.517987+00	2024-11-28 10:08:21.527777+00	\N	\N
571b3aa1-0f97-4e60-8eb1-99fc8283e158	2024-11-28 10:08:21.540696+00	2024-11-28 10:08:21.549226+00	b8fd1ab6-07b4-487a-a4fb-7b51fa502a2d	Notifications::WorkflowJob	default	{"job_id": "b8fd1ab6-07b4-487a-a4fb-7b51fa502a2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.539351305Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.539581+00	2024-11-28 10:08:21.54906+00	\N	\N
54979356-7601-4c07-a9d4-04197b2b0901	2024-11-28 10:08:21.567623+00	2024-11-28 10:08:21.578694+00	d0722825-0a4b-42f0-b1d0-443e8c36d6fb	Notifications::WorkflowJob	default	{"job_id": "d0722825-0a4b-42f0-b1d0-443e8c36d6fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.566321620Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.566522+00	2024-11-28 10:08:21.578531+00	\N	\N
74d1ea6a-662e-4566-88c2-5d6916ac4690	2024-11-28 10:08:21.599193+00	2024-11-28 10:08:21.605931+00	d1d87eb1-25b8-4e7a-9852-bf16562f33de	Notifications::WorkflowJob	default	{"job_id": "d1d87eb1-25b8-4e7a-9852-bf16562f33de", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.597706010Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.59802+00	2024-11-28 10:08:21.605768+00	\N	\N
c785b589-7f26-475e-bd6d-d806a58dcd61	2024-11-28 10:13:19.880808+00	2024-11-28 10:13:19.959721+00	728ee2bb-032c-41ec-89b9-86c22619d68c	Notifications::WorkflowJob	default	{"job_id": "728ee2bb-032c-41ec-89b9-86c22619d68c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.742374512Z", "scheduled_at": "2024-11-28T10:13:19.742200453Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.7422+00	2024-11-28 10:13:19.957973+00	\N	\N
688c4b21-ab25-444c-b59b-20ee52099130	2024-11-28 10:13:20.045964+00	2024-11-28 10:13:20.149117+00	b5416020-b878-41e0-a896-8232eaee2d42	Journals::CompletedJob	default	{"job_id": "b5416020-b878-41e0-a896-8232eaee2d42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.926803000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.942547020Z", "scheduled_at": "2024-11-28T10:13:19.942104885Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.942104+00	2024-11-28 10:13:20.148963+00	\N	\N
edd4996a-49e9-46a2-ba71-5de9fbf28040	2024-11-28 10:13:20.144654+00	2024-11-28 10:13:20.214162+00	745dc5c9-c393-4f11-83b0-2262b1f9a252	Notifications::WorkflowJob	default	{"job_id": "745dc5c9-c393-4f11-83b0-2262b1f9a252", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.043926666Z", "scheduled_at": "2024-11-28T10:13:20.042541070Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.042541+00	2024-11-28 10:13:20.214018+00	\N	\N
1c923354-1e10-4ab7-b681-97430fd9af21	2024-11-28 10:08:21.622199+00	2024-11-28 10:08:21.629437+00	a8f91fa7-6c58-4d0d-919c-004900b82153	Notifications::WorkflowJob	default	{"job_id": "a8f91fa7-6c58-4d0d-919c-004900b82153", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.620937125Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.621151+00	2024-11-28 10:08:21.629231+00	\N	\N
a81e9189-f14f-496f-805b-71a367b6c37e	2024-11-28 10:08:21.639846+00	2024-11-28 10:08:21.647702+00	d120268d-24d6-4d02-87fc-88ec0cfb3097	Notifications::WorkflowJob	default	{"job_id": "d120268d-24d6-4d02-87fc-88ec0cfb3097", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.638325188Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.638524+00	2024-11-28 10:08:21.647542+00	\N	\N
d2b6a35a-a862-426f-92d2-2524e179cd1c	2024-11-28 10:08:21.667261+00	2024-11-28 10:08:21.674608+00	c8596f9e-81aa-4725-a0ae-72d4d8e79ac9	Notifications::WorkflowJob	default	{"job_id": "c8596f9e-81aa-4725-a0ae-72d4d8e79ac9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.665826375Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.666037+00	2024-11-28 10:08:21.674409+00	\N	\N
6a15641f-5538-4225-b515-949c13b84d16	2024-11-28 10:08:21.68471+00	2024-11-28 10:08:21.692059+00	d5b3aaa0-2a09-49d8-999c-a82254061dd9	Notifications::WorkflowJob	default	{"job_id": "d5b3aaa0-2a09-49d8-999c-a82254061dd9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.683282265Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.683477+00	2024-11-28 10:08:21.691899+00	\N	\N
8797cf8c-6f7b-4e9b-a63f-164fd8f567d3	2024-11-28 10:08:21.71173+00	2024-11-28 10:08:21.723438+00	1b0aa52b-3908-4f12-9b3e-324175b1eb40	Notifications::WorkflowJob	default	{"job_id": "1b0aa52b-3908-4f12-9b3e-324175b1eb40", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.710414837Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.710615+00	2024-11-28 10:08:21.723269+00	\N	\N
8070e1e8-4645-4ce1-84ad-baf174e2955b	2024-11-28 10:08:21.733136+00	2024-11-28 10:08:21.743413+00	d1a0bc3d-056f-4ffe-9bc8-c17bc4505e42	Notifications::WorkflowJob	default	{"job_id": "d1a0bc3d-056f-4ffe-9bc8-c17bc4505e42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.731884576Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.732079+00	2024-11-28 10:08:21.743249+00	\N	\N
3c31f420-9cda-405c-8ac3-b51552ba857c	2024-11-28 10:13:19.97037+00	2024-11-28 10:13:20.060471+00	1d0d03f8-aaeb-4231-934a-75df9b432e78	Journals::CompletedJob	default	{"job_id": "1d0d03f8-aaeb-4231-934a-75df9b432e78", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.755064000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.768608057Z", "scheduled_at": "2024-11-28T10:13:19.768394323Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.768394+00	2024-11-28 10:13:20.060321+00	\N	\N
e3dcce1e-ce64-422b-94d6-6f8c29fb18a9	2024-11-28 10:13:20.183123+00	2024-11-28 10:13:20.252962+00	893cc023-6ac9-40b6-8bdb-20e48173ca29	Notifications::WorkflowJob	default	{"job_id": "893cc023-6ac9-40b6-8bdb-20e48173ca29", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.099823290Z", "scheduled_at": "2024-11-28T10:13:20.099671493Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.099671+00	2024-11-28 10:13:20.252752+00	\N	\N
12141921-08b1-458c-aa80-ed6e1a9217a2	2024-11-28 10:13:20.155551+00	2024-11-28 10:13:20.285433+00	05509d2b-77e2-4a91-bcac-852bfeb21028	Journals::CompletedJob	default	{"job_id": "05509d2b-77e2-4a91-bcac-852bfeb21028", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:20.008764000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.051071296Z", "scheduled_at": "2024-11-28T10:13:20.049523062Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.049522+00	2024-11-28 10:13:20.285257+00	\N	\N
4f734451-b32b-4a69-bc7b-3f0ad2ae286a	2024-11-28 10:08:21.767753+00	2024-11-28 10:08:21.775906+00	b94be0f3-d5a6-4113-821b-a15f7c6ae89c	Notifications::WorkflowJob	default	{"job_id": "b94be0f3-d5a6-4113-821b-a15f7c6ae89c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.766092106Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.7663+00	2024-11-28 10:08:21.775673+00	\N	\N
32aa4c62-52c3-489c-baab-7b866d5a0246	2024-11-28 10:08:21.78773+00	2024-11-28 10:08:21.796879+00	e3230f1d-5b78-4358-9a8a-b85b941b6d35	Notifications::WorkflowJob	default	{"job_id": "e3230f1d-5b78-4358-9a8a-b85b941b6d35", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.786286306Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.786483+00	2024-11-28 10:08:21.796712+00	\N	\N
c73f4235-9bcb-42db-a8c1-c4aa4966a422	2024-11-28 10:08:21.823233+00	2024-11-28 10:08:21.834436+00	444d42ef-0274-406e-ada7-d40d4dbaeffd	Notifications::WorkflowJob	default	{"job_id": "444d42ef-0274-406e-ada7-d40d4dbaeffd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.820864808Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.821189+00	2024-11-28 10:08:21.834198+00	\N	\N
ee4c52da-1bcb-4cf0-8a92-c055297c4bb3	2024-11-28 10:08:21.859275+00	2024-11-28 10:08:21.870106+00	dba3b3ef-9817-44b0-92cf-ed9ee7fa0fb3	Notifications::WorkflowJob	default	{"job_id": "dba3b3ef-9817-44b0-92cf-ed9ee7fa0fb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.857205286Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.857525+00	2024-11-28 10:08:21.86983+00	\N	\N
0cab56e6-a9fa-4cf9-ad3c-c49cdddc7618	2024-11-28 10:08:21.885182+00	2024-11-28 10:08:21.89646+00	0b06b72a-ac8e-4ec1-8df3-5b0f6118f633	Notifications::WorkflowJob	default	{"job_id": "0b06b72a-ac8e-4ec1-8df3-5b0f6118f633", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.882985954Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.883268+00	2024-11-28 10:08:21.896247+00	\N	\N
1cba6853-e824-410e-9cf3-2be2c7cf4c66	2024-11-28 10:08:21.923873+00	2024-11-28 10:08:21.934327+00	68c092fa-a4a1-47c6-95c4-4b6facff00f2	Notifications::WorkflowJob	default	{"job_id": "68c092fa-a4a1-47c6-95c4-4b6facff00f2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.921805042Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.922098+00	2024-11-28 10:08:21.934105+00	\N	\N
27b67ec1-bcd8-4a33-849b-4403c5660734	2024-11-28 10:13:19.97265+00	2024-11-28 10:13:20.033698+00	f4a004b6-1aa2-4411-a4bb-b9b1feea22d3	Notifications::WorkflowJob	default	{"job_id": "f4a004b6-1aa2-4411-a4bb-b9b1feea22d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.805315548Z", "scheduled_at": "2024-11-28T10:13:19.805108647Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.805108+00	2024-11-28 10:13:20.033535+00	\N	\N
2e15dfe1-d6a6-4225-a641-7a43bcb87a8e	2024-11-28 10:13:20.128293+00	2024-11-28 10:13:20.222676+00	a2f73010-03ab-4f0c-9996-09825e914685	Journals::CompletedJob	default	{"job_id": "a2f73010-03ab-4f0c-9996-09825e914685", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:19.989370000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.004763066Z", "scheduled_at": "2024-11-28T10:13:20.003971492Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.003971+00	2024-11-28 10:13:20.222534+00	\N	\N
5121ea82-3d7a-47d7-95d6-659ca7c0305a	2024-11-28 10:13:20.225282+00	2024-11-28 10:13:20.287253+00	01cfb482-147b-4b07-8ec1-7ea060d408ca	Notifications::WorkflowJob	default	{"job_id": "01cfb482-147b-4b07-8ec1-7ea060d408ca", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.158975601Z", "scheduled_at": "2024-11-28T10:13:20.158675374Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.158675+00	2024-11-28 10:13:20.287104+00	\N	\N
63ed4901-196f-468f-bc56-6a27da804bb4	2024-11-28 10:08:21.950866+00	2024-11-28 10:08:21.961331+00	add51451-4feb-4c22-a3d1-9247968a4e59	Notifications::WorkflowJob	default	{"job_id": "add51451-4feb-4c22-a3d1-9247968a4e59", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.948909071Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.949224+00	2024-11-28 10:08:21.961091+00	\N	\N
dfb98692-3410-4510-a28d-27de4fccfb0f	2024-11-28 10:08:21.989454+00	2024-11-28 10:08:21.999789+00	f9855bf6-9d06-4f93-be3b-47902dabd68d	Notifications::WorkflowJob	default	{"job_id": "f9855bf6-9d06-4f93-be3b-47902dabd68d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.987522930Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.987812+00	2024-11-28 10:08:21.999553+00	\N	\N
4ea3e1dd-a27d-4bca-a36d-6a6ded0d6dca	2024-11-28 10:08:22.012942+00	2024-11-28 10:08:22.027277+00	bfdb727d-7f42-4084-af07-56a66f80b24d	Notifications::WorkflowJob	default	{"job_id": "bfdb727d-7f42-4084-af07-56a66f80b24d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.011083768Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.011376+00	2024-11-28 10:08:22.026984+00	\N	\N
9d65dd13-5b00-47e5-ba5b-883b534a1241	2024-11-28 10:08:22.060529+00	2024-11-28 10:08:22.068406+00	6f1d3e93-b460-44c8-b523-440fde0580d1	Notifications::WorkflowJob	default	{"job_id": "6f1d3e93-b460-44c8-b523-440fde0580d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.059051219Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.059254+00	2024-11-28 10:08:22.068263+00	\N	\N
99719750-d537-4f2a-bd39-ca9c22f2a42c	2024-11-28 10:08:22.079934+00	2024-11-28 10:08:22.087673+00	b58cfc5d-51ff-4c19-b7dd-b89471f5def5	Notifications::WorkflowJob	default	{"job_id": "b58cfc5d-51ff-4c19-b7dd-b89471f5def5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.078286239Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.078522+00	2024-11-28 10:08:22.087526+00	\N	\N
aaa16ea9-ce3e-4b4b-af01-ded6cce6e603	2024-11-28 10:08:22.117047+00	2024-11-28 10:08:22.133376+00	80acd075-1878-407d-96b6-e311e7966fef	Notifications::WorkflowJob	default	{"job_id": "80acd075-1878-407d-96b6-e311e7966fef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.114895454Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.115263+00	2024-11-28 10:08:22.133134+00	\N	\N
8f8d8ae8-998b-4c93-9c7d-7a44db735d49	2024-11-28 10:13:20.000171+00	2024-11-28 10:13:20.075059+00	91427481-2090-4663-9b8a-9832b8f75b34	Notifications::WorkflowJob	default	{"job_id": "91427481-2090-4663-9b8a-9832b8f75b34", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.836376187Z", "scheduled_at": "2024-11-28T10:13:19.836209322Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.836209+00	2024-11-28 10:13:20.074795+00	\N	\N
b7d160ea-36d5-4cd6-8e35-5b1ff4bda606	2024-11-28 10:13:20.16908+00	2024-11-28 10:13:20.239369+00	42a17e9d-9917-46fb-8e32-affd60fd0080	Notifications::WorkflowJob	default	{"job_id": "42a17e9d-9917-46fb-8e32-affd60fd0080", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.077159376Z", "scheduled_at": "2024-11-28T10:13:20.076996027Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.076996+00	2024-11-28 10:13:20.239288+00	\N	\N
45ca27c4-b564-4cf2-97b8-a9f8886e7b6b	2024-11-28 10:13:20.234624+00	2024-11-28 10:13:20.312337+00	3d2508ba-c2f8-4011-9fe8-4dcd7f3110a6	Journals::CompletedJob	default	{"job_id": "3d2508ba-c2f8-4011-9fe8-4dcd7f3110a6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.142161000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.162245615Z", "scheduled_at": "2024-11-28T10:13:20.162063702Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.162063+00	2024-11-28 10:13:20.312207+00	\N	\N
e69b1880-c235-4f0a-9cea-e3f1bb83aa75	2024-11-28 10:08:22.159834+00	2024-11-28 10:08:22.185977+00	68f9895e-37ea-4ea8-a5fc-7e31656e1c92	Notifications::WorkflowJob	default	{"job_id": "68f9895e-37ea-4ea8-a5fc-7e31656e1c92", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.156477879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.156765+00	2024-11-28 10:08:22.185715+00	\N	\N
99eecfde-004d-4c94-8f26-e991b6e9c4a0	2024-11-28 10:08:22.229319+00	2024-11-28 10:08:22.243362+00	eef5eb68-5602-4dad-b3b5-c7638bde782f	Notifications::WorkflowJob	default	{"job_id": "eef5eb68-5602-4dad-b3b5-c7638bde782f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.226454408Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.227335+00	2024-11-28 10:08:22.243195+00	\N	\N
16877f00-29b8-4884-831f-2145e8ba5d45	2024-11-28 10:08:22.260691+00	2024-11-28 10:08:22.273269+00	f4ff5437-39a8-4013-a29a-9561e9ad22fb	Notifications::WorkflowJob	default	{"job_id": "f4ff5437-39a8-4013-a29a-9561e9ad22fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.258575079Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.258775+00	2024-11-28 10:08:22.273078+00	\N	\N
33b06e30-30d8-4760-9051-be7d4aaa51fc	2024-11-28 10:08:22.310829+00	2024-11-28 10:08:22.324494+00	3f168c50-f856-45e7-b2c4-d1c67bfe3256	Notifications::WorkflowJob	default	{"job_id": "3f168c50-f856-45e7-b2c4-d1c67bfe3256", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.308742424Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.309478+00	2024-11-28 10:08:22.324318+00	\N	\N
9e50a1f5-f554-48ff-a70f-4456cbcde0b6	2024-11-28 10:08:22.350767+00	2024-11-28 10:08:22.363568+00	711aff1c-9d1e-43a6-ab1f-1c34094cf232	Notifications::WorkflowJob	default	{"job_id": "711aff1c-9d1e-43a6-ab1f-1c34094cf232", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.348979528Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.349183+00	2024-11-28 10:08:22.363387+00	\N	\N
9e0714f0-a8da-442f-8b6f-c1d509317492	2024-11-28 10:08:22.383144+00	2024-11-28 10:08:22.396663+00	2f270b2e-b8af-4cc0-a212-a482ce34129b	Notifications::WorkflowJob	default	{"job_id": "2f270b2e-b8af-4cc0-a212-a482ce34129b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.379322602Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.379513+00	2024-11-28 10:08:22.396513+00	\N	\N
d5dbf685-f9be-4090-927a-54d04d4f6b2d	2024-11-28 10:13:20.002124+00	2024-11-28 10:13:20.112068+00	aa00c5f9-fd2e-4bf9-b3ac-e8d7da6302a7	Journals::CompletedJob	default	{"job_id": "aa00c5f9-fd2e-4bf9-b3ac-e8d7da6302a7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.816175000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.841512867Z", "scheduled_at": "2024-11-28T10:13:19.841284255Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.841284+00	2024-11-28 10:13:20.111895+00	\N	\N
41edc0e9-a275-4dd3-888b-ab653a66b94b	2024-11-28 10:13:20.238467+00	2024-11-28 10:13:20.315948+00	b3e51e63-b059-4952-9885-9657749ff740	Notifications::WorkflowJob	default	{"job_id": "b3e51e63-b059-4952-9885-9657749ff740", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.177665932Z", "scheduled_at": "2024-11-28T10:13:20.176783897Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.176783+00	2024-11-28 10:13:20.315778+00	\N	\N
d2bc0d71-0303-4bac-bc01-0d52081aa1de	2024-11-28 10:13:20.207556+00	2024-11-28 10:13:20.331429+00	fda85dbf-df8a-49e8-b7b8-44e7b44ffeb0	Journals::CompletedJob	default	{"job_id": "fda85dbf-df8a-49e8-b7b8-44e7b44ffeb0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.107544000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.137924021Z", "scheduled_at": "2024-11-28T10:13:20.137723613Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.137723+00	2024-11-28 10:13:20.331312+00	\N	\N
d7a47510-d752-4f0b-8fa4-24690b9bcf58	2024-11-28 10:13:20.313597+00	2024-11-28 10:13:20.375482+00	a81d423a-6403-4993-82ff-4248149c2562	Notifications::WorkflowJob	default	{"job_id": "a81d423a-6403-4993-82ff-4248149c2562", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.255716377Z", "scheduled_at": "2024-11-28T10:13:20.255504657Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.255504+00	2024-11-28 10:13:20.374575+00	\N	\N
c3925738-f417-4604-bbe2-843226832d0a	2024-11-28 10:13:20.429581+00	2024-11-28 10:13:20.548943+00	2024b345-b983-4da9-9095-a45014feef50	Journals::CompletedJob	default	{"job_id": "2024b345-b983-4da9-9095-a45014feef50", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.357162000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.387236884Z", "scheduled_at": "2024-11-28T10:13:20.386680905Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.38668+00	2024-11-28 10:13:20.548814+00	\N	\N
c8a72ff3-2624-45ab-b974-04aad412c1ef	2024-11-28 10:08:22.429316+00	2024-11-28 10:08:22.453255+00	e0740287-6223-4cfd-bc85-69eca59eabc0	Notifications::WorkflowJob	default	{"job_id": "e0740287-6223-4cfd-bc85-69eca59eabc0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.425600865Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.42603+00	2024-11-28 10:08:22.452896+00	\N	\N
1e66e0e9-97ad-4648-9f9d-6147e0a511b9	2024-11-28 10:08:22.484351+00	2024-11-28 10:08:22.499477+00	f5bfd5ce-1160-4d37-80e1-54b2a6b3c246	Notifications::WorkflowJob	default	{"job_id": "f5bfd5ce-1160-4d37-80e1-54b2a6b3c246", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.481790460Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.481982+00	2024-11-28 10:08:22.499316+00	\N	\N
530a006c-c9ac-4fa0-b713-36be1ab576fc	2024-11-28 10:08:22.538132+00	2024-11-28 10:08:22.5512+00	b3c6f575-2771-469d-98bf-d1b6125d17bb	Notifications::WorkflowJob	default	{"job_id": "b3c6f575-2771-469d-98bf-d1b6125d17bb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.536184016Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.536384+00	2024-11-28 10:08:22.551015+00	\N	\N
74585cf0-db0a-4e92-bb6e-c3e2c8fdf9cd	2024-11-28 10:08:22.570503+00	2024-11-28 10:08:22.583303+00	d73be670-2839-41b0-aa9b-bada981c58b8	Notifications::WorkflowJob	default	{"job_id": "d73be670-2839-41b0-aa9b-bada981c58b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.568313072Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.568515+00	2024-11-28 10:08:22.582822+00	\N	\N
14824d8d-1553-488b-8ba0-665d8b31c45e	2024-11-28 10:08:22.61717+00	2024-11-28 10:08:22.628778+00	da6d9652-21ab-4a9f-8239-614629a29ac7	Notifications::WorkflowJob	default	{"job_id": "da6d9652-21ab-4a9f-8239-614629a29ac7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.614064098Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.614273+00	2024-11-28 10:08:22.628611+00	\N	\N
ce60a065-527e-4efc-a783-3e15ce5692ed	2024-11-28 10:08:22.64604+00	2024-11-28 10:08:22.658086+00	3e68f122-3ea8-4434-930e-4e3a6f800c65	Notifications::WorkflowJob	default	{"job_id": "3e68f122-3ea8-4434-930e-4e3a6f800c65", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.644093830Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.644673+00	2024-11-28 10:08:22.657515+00	\N	\N
cdfebd44-f52b-4d07-b3ca-e4553aec1450	2024-11-28 10:13:20.003442+00	2024-11-28 10:13:20.100915+00	c202e31a-3958-4dd3-9a77-b0040627da28	Journals::CompletedJob	default	{"job_id": "c202e31a-3958-4dd3-9a77-b0040627da28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.850731000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.864429147Z", "scheduled_at": "2024-11-28T10:13:19.864171330Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.864171+00	2024-11-28 10:13:20.100777+00	\N	\N
d7d2a56b-1b0e-4415-9d3a-cbb82e1428d9	2024-11-28 10:13:20.192142+00	2024-11-28 10:13:20.273539+00	a4913a70-f79d-40db-ab09-305e380b0c11	Journals::CompletedJob	default	{"job_id": "a4913a70-f79d-40db-ab09-305e380b0c11", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.089449000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.104307055Z", "scheduled_at": "2024-11-28T10:13:20.104114091Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.104114+00	2024-11-28 10:13:20.273374+00	\N	\N
995c7d77-3576-45ed-98b7-d97cdd3926a2	2024-11-28 10:13:20.243462+00	2024-11-28 10:13:20.319017+00	3b50773a-9f6a-4684-8ed3-0a317b3772a6	Journals::CompletedJob	default	{"job_id": "3b50773a-9f6a-4684-8ed3-0a317b3772a6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.168695000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.182053777Z", "scheduled_at": "2024-11-28T10:13:20.181499470Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.181499+00	2024-11-28 10:13:20.318858+00	\N	\N
494c8594-2635-4aab-ad85-c37cb5f879f5	2024-11-28 10:13:20.322351+00	2024-11-28 10:13:20.421302+00	e338eb54-8abd-46ae-970d-aaeb4c9deb38	Journals::CompletedJob	default	{"job_id": "e338eb54-8abd-46ae-970d-aaeb4c9deb38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-11-28T10:08:20.237479000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.259548473Z", "scheduled_at": "2024-11-28T10:13:20.259372621Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.259372+00	2024-11-28 10:13:20.421113+00	\N	\N
20c0637c-29b4-4f4d-8a4e-daa2b0b18612	2024-11-28 10:08:22.691588+00	2024-11-28 10:08:22.703793+00	990999a4-26c5-4750-b904-163163ff5d9f	Notifications::WorkflowJob	default	{"job_id": "990999a4-26c5-4750-b904-163163ff5d9f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.688819231Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.68984+00	2024-11-28 10:08:22.703638+00	\N	\N
aa9e1fc1-12d1-408f-abe2-23429b795e75	2024-11-28 10:08:22.721205+00	2024-11-28 10:08:22.734336+00	f7c4d01f-9458-43c3-b1a9-35a48014ef76	Notifications::WorkflowJob	default	{"job_id": "f7c4d01f-9458-43c3-b1a9-35a48014ef76", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.719058036Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.719255+00	2024-11-28 10:08:22.734152+00	\N	\N
b2468b12-2897-484b-a070-61860046ee87	2024-11-28 10:08:22.765838+00	2024-11-28 10:08:22.779142+00	89dbef8e-ffb2-4813-9f97-8e2072387ff4	Notifications::WorkflowJob	default	{"job_id": "89dbef8e-ffb2-4813-9f97-8e2072387ff4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.763166000Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.76415+00	2024-11-28 10:08:22.778975+00	\N	\N
af8c1c64-ec70-4a6c-9319-74eaf82a8dbf	2024-11-28 10:08:22.795735+00	2024-11-28 10:08:22.807439+00	c97c2b3c-5c47-47b6-a2cf-6502d0dcfd3f	Notifications::WorkflowJob	default	{"job_id": "c97c2b3c-5c47-47b6-a2cf-6502d0dcfd3f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.793781398Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.793979+00	2024-11-28 10:08:22.807275+00	\N	\N
42c91296-bd62-4bcb-9c6d-e27b8e2a1bbe	2024-11-28 10:08:22.836134+00	2024-11-28 10:08:22.84921+00	445b5a17-3d50-4890-a311-b87a3faf9e61	Notifications::WorkflowJob	default	{"job_id": "445b5a17-3d50-4890-a311-b87a3faf9e61", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.834146825Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.83435+00	2024-11-28 10:08:22.849037+00	\N	\N
f483d992-13ec-4455-ad6a-455eaadf466a	2024-11-28 10:08:22.863657+00	2024-11-28 10:08:22.873003+00	588237e8-ed9f-413f-b0f1-266c3191f2a3	Notifications::WorkflowJob	default	{"job_id": "588237e8-ed9f-413f-b0f1-266c3191f2a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.860987005Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.86119+00	2024-11-28 10:08:22.872722+00	\N	\N
817dbe09-5756-492b-9a78-ef43025451e9	2024-11-28 10:13:20.005094+00	2024-11-28 10:13:20.086151+00	9870d739-9f00-4062-81f1-65d5a3ac6c98	Notifications::WorkflowJob	default	{"job_id": "9870d739-9f00-4062-81f1-65d5a3ac6c98", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.888939076Z", "scheduled_at": "2024-11-28T10:13:19.888753446Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.888753+00	2024-11-28 10:13:20.085874+00	\N	\N
4cbec796-2074-4051-ba61-495dd0ab95dd	2024-11-28 10:13:20.179166+00	2024-11-28 10:13:20.276124+00	0d52208f-8f96-48af-850c-d50f928f2103	Journals::CompletedJob	default	{"job_id": "0d52208f-8f96-48af-850c-d50f928f2103", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.056157000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.082407305Z", "scheduled_at": "2024-11-28T10:13:20.081710399Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.08171+00	2024-11-28 10:13:20.275884+00	\N	\N
04fa5bd6-ef75-4fe8-98d2-5d2dfdba100f	2024-11-28 10:13:20.289838+00	2024-11-28 10:13:20.356343+00	37887cb2-6295-47f1-9bcc-86d77e1e43bd	Notifications::WorkflowJob	default	{"job_id": "37887cb2-6295-47f1-9bcc-86d77e1e43bd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.227555474Z", "scheduled_at": "2024-11-28T10:13:20.227415720Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.227415+00	2024-11-28 10:13:20.35618+00	\N	\N
99f0d600-ac3f-48fe-bd14-5ccffa316ab4	2024-11-28 10:13:20.340621+00	2024-11-28 10:13:20.405822+00	3c2bea55-2650-4a55-bb6d-251e71a1ce26	Notifications::WorkflowJob	default	{"job_id": "3c2bea55-2650-4a55-bb6d-251e71a1ce26", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.273205621Z", "scheduled_at": "2024-11-28T10:13:20.273036852Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.273036+00	2024-11-28 10:13:20.405622+00	\N	\N
c7eb2740-ed36-49aa-8ffc-65ac2e067b85	2024-11-28 10:13:20.366192+00	2024-11-28 10:13:20.465044+00	5a92a02c-824a-476d-9834-17d9140814a0	Journals::CompletedJob	default	{"job_id": "5a92a02c-824a-476d-9834-17d9140814a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-11-28T10:08:20.280292000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.300547697Z", "scheduled_at": "2024-11-28T10:13:20.300371475Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.300371+00	2024-11-28 10:13:20.464748+00	\N	\N
16696b09-bb66-4741-be24-32805a5bbab8	2024-11-28 10:08:22.900472+00	2024-11-28 10:08:22.908674+00	542e7688-683f-4dc0-8ff0-2e6f87866c65	Notifications::WorkflowJob	default	{"job_id": "542e7688-683f-4dc0-8ff0-2e6f87866c65", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.899131840Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.899336+00	2024-11-28 10:08:22.908494+00	\N	\N
d0ff1ea3-d651-4380-85da-787d73036548	2024-11-28 10:08:22.918888+00	2024-11-28 10:08:22.92716+00	bb7ab98f-31c9-4ae8-b20c-fba0c5b3a619	Notifications::WorkflowJob	default	{"job_id": "bb7ab98f-31c9-4ae8-b20c-fba0c5b3a619", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.917452672Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.917646+00	2024-11-28 10:08:22.926996+00	\N	\N
f6bd2866-1ab2-4ed0-b680-645f9a93d12e	2024-11-28 10:08:22.946832+00	2024-11-28 10:08:22.956376+00	0f2b4a02-05d5-424f-b113-ec877e198d31	Notifications::WorkflowJob	default	{"job_id": "0f2b4a02-05d5-424f-b113-ec877e198d31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.945192892Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.945431+00	2024-11-28 10:08:22.956177+00	\N	\N
0d1f601d-7598-4ee3-a32c-212aa6232911	2024-11-28 10:08:22.967027+00	2024-11-28 10:08:22.975155+00	f878aaa9-54ed-4bb8-8f04-c1ddfd1d1b54	Notifications::WorkflowJob	default	{"job_id": "f878aaa9-54ed-4bb8-8f04-c1ddfd1d1b54", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.965524010Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.965717+00	2024-11-28 10:08:22.974997+00	\N	\N
9495ff54-e493-4336-b83f-55e890f7f9d3	2024-11-28 10:08:23.095666+00	2024-11-28 10:08:23.104411+00	c58cf412-23b3-4d9c-bca8-e370f9648234	Notifications::WorkflowJob	default	{"job_id": "c58cf412-23b3-4d9c-bca8-e370f9648234", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/45"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.094278903Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:23.094489+00	2024-11-28 10:08:23.104251+00	\N	\N
2be33ac8-d7db-47a2-bd06-4f48bee0d750	2024-11-28 10:08:23.134608+00	2024-11-28 10:08:23.143416+00	ea1ca0a6-0126-4310-8cb8-168c5fe4080a	Notifications::WorkflowJob	default	{"job_id": "ea1ca0a6-0126-4310-8cb8-168c5fe4080a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/46"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.132385455Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:23.133023+00	2024-11-28 10:08:23.143222+00	\N	\N
80ba6513-b27c-4740-b0e2-b2b2e1a71f01	2024-11-28 10:13:20.006886+00	2024-11-28 10:13:20.163459+00	fb725e59-cd2e-459a-a017-6ec8166207cb	Journals::CompletedJob	default	{"job_id": "fb725e59-cd2e-459a-a017-6ec8166207cb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.867761000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.892901189Z", "scheduled_at": "2024-11-28T10:13:19.892688417Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.892688+00	2024-11-28 10:13:20.163286+00	\N	\N
89cde90d-184e-41f2-a541-f9c3f7555ec6	2024-11-28 10:13:20.257129+00	2024-11-28 10:13:20.352351+00	f7b88bd7-707e-4c3f-9c54-f31330d0633c	Journals::CompletedJob	default	{"job_id": "f7b88bd7-707e-4c3f-9c54-f31330d0633c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.185332000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.210047926Z", "scheduled_at": "2024-11-28T10:13:20.209873447Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.209873+00	2024-11-28 10:13:20.352102+00	\N	\N
c36c8b4d-3449-4d91-be2b-a9f56fb3b772	2024-11-28 10:13:20.299927+00	2024-11-28 10:13:20.457868+00	bf75c872-1ff6-4d2d-8869-459fc7dea370	Journals::CompletedJob	default	{"job_id": "bf75c872-1ff6-4d2d-8869-459fc7dea370", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-11-28T10:08:20.216647000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.232564251Z", "scheduled_at": "2024-11-28T10:13:20.232292628Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.232292+00	2024-11-28 10:13:20.457647+00	\N	\N
99abd44b-e0a4-4c95-9f75-e408f831d6b8	2024-11-28 10:13:20.355297+00	2024-11-28 10:13:20.479006+00	8b3474ee-5546-46ea-acbb-15597deba007	Journals::CompletedJob	default	{"job_id": "8b3474ee-5546-46ea-acbb-15597deba007", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-11-28T10:08:20.264772000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.276373612Z", "scheduled_at": "2024-11-28T10:13:20.276207068Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.276207+00	2024-11-28 10:13:20.478806+00	\N	\N
5e91046b-21b2-4310-8159-03c1d950b69e	2024-11-28 10:13:20.371025+00	2024-11-28 10:13:20.451435+00	5a07bd80-739a-4c4d-a22c-949541c250fd	Notifications::WorkflowJob	default	{"job_id": "5a07bd80-739a-4c4d-a22c-949541c250fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.324173528Z", "scheduled_at": "2024-11-28T10:13:20.324024977Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.324025+00	2024-11-28 10:13:20.451272+00	\N	\N
8ceffaea-7c68-44cf-8383-c84c3e2bcc18	2024-11-28 10:13:20.552591+00	2024-11-28 10:13:20.643864+00	df8cacba-875b-46b8-91b1-ddc1401b0dda	Journals::CompletedJob	default	{"job_id": "df8cacba-875b-46b8-91b1-ddc1401b0dda", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-11-28T10:08:20.470694000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.483173152Z", "scheduled_at": "2024-11-28T10:13:20.483013921Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.483013+00	2024-11-28 10:13:20.64371+00	\N	\N
1fe4545f-c52c-4316-b661-fa17af45ac82	2024-11-28 10:13:21.315248+00	2024-11-28 10:13:21.337024+00	b423f538-c9f1-4495-97d9-f25d20a07193	Journals::CompletedJob	default	{"job_id": "b423f538-c9f1-4495-97d9-f25d20a07193", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-11-28T10:08:21.248994000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.282697213Z", "scheduled_at": "2024-11-28T10:13:21.282552039Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.282552+00	2024-11-28 10:13:21.33676+00	\N	\N
a60b3d8e-621d-4fd8-b81a-6b8a6b33fa2f	2024-11-28 10:13:21.373729+00	2024-11-28 10:13:21.386355+00	31abe499-95f6-45be-aebf-eb2b49ff41f8	Notifications::WorkflowJob	default	{"job_id": "31abe499-95f6-45be-aebf-eb2b49ff41f8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.366711858Z", "scheduled_at": "2024-11-28T10:13:21.366438342Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.366438+00	2024-11-28 10:13:21.386184+00	\N	\N
a66014f2-af20-4aa7-a06a-49de182991d6	2024-11-28 10:13:21.411723+00	2024-11-28 10:13:21.420897+00	ce56c8fa-70f8-4c1f-965a-5eca8795b897	Journals::CompletedJob	default	{"job_id": "ce56c8fa-70f8-4c1f-965a-5eca8795b897", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-11-28T10:08:21.381472000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.406287946Z", "scheduled_at": "2024-11-28T10:13:21.405874896Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.405874+00	2024-11-28 10:13:21.420734+00	\N	\N
49e30483-b320-4518-85eb-076d81dbb433	2024-11-28 10:13:21.442237+00	2024-11-28 10:13:21.452262+00	02836437-2217-4040-a560-902ad697669a	Notifications::WorkflowJob	default	{"job_id": "02836437-2217-4040-a560-902ad697669a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.439305619Z", "scheduled_at": "2024-11-28T10:13:21.439161307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.439161+00	2024-11-28 10:13:21.452031+00	\N	\N
c74999b6-9486-4dcf-a66d-6e4789edcdbf	2024-11-28 10:13:20.377269+00	2024-11-28 10:13:20.498525+00	bb748dd7-6323-445a-810f-77befab73631	Journals::CompletedJob	default	{"job_id": "bb748dd7-6323-445a-810f-77befab73631", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.304410000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.328297625Z", "scheduled_at": "2024-11-28T10:13:20.328116083Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.328115+00	2024-11-28 10:13:20.498382+00	\N	\N
9644ea5a-f7df-48fc-8c0c-b6db0fd48ebe	2024-11-28 10:13:20.575493+00	2024-11-28 10:13:20.664341+00	5cda9e15-8499-47e8-b2e9-f5c670d0f00c	Journals::CompletedJob	default	{"job_id": "5cda9e15-8499-47e8-b2e9-f5c670d0f00c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-11-28T10:08:20.512069000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.525305346Z", "scheduled_at": "2024-11-28T10:13:20.525071384Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.525071+00	2024-11-28 10:13:20.664131+00	\N	\N
9e96f255-a85c-4ffc-8b78-fabb40ca4d74	2024-11-28 10:13:20.721009+00	2024-11-28 10:13:20.726528+00	f7821da6-eaef-4255-b9b4-bdeaad2049e1	Notifications::WorkflowJob	default	{"job_id": "f7821da6-eaef-4255-b9b4-bdeaad2049e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.716614115Z", "scheduled_at": "2024-11-28T10:13:20.716483448Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.716483+00	2024-11-28 10:13:20.726388+00	\N	\N
8763e827-4243-4cbe-9e76-1c0b8ac28d14	2024-11-28 10:13:21.012619+00	2024-11-28 10:13:21.019126+00	c256f1f7-930f-4cd3-ae79-a850c247d877	Notifications::WorkflowJob	default	{"job_id": "c256f1f7-930f-4cd3-ae79-a850c247d877", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.009638565Z", "scheduled_at": "2024-11-28T10:13:21.009385657Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.009385+00	2024-11-28 10:13:21.018967+00	\N	\N
96c81079-e270-45e3-ad1e-12eaa3c9ad83	2024-11-28 10:13:21.050958+00	2024-11-28 10:13:21.063921+00	498f5af1-d7d6-4e04-abd1-d236cd0cd3af	Notifications::WorkflowJob	default	{"job_id": "498f5af1-d7d6-4e04-abd1-d236cd0cd3af", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.046399186Z", "scheduled_at": "2024-11-28T10:13:21.046225167Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.046225+00	2024-11-28 10:13:21.063571+00	\N	\N
3affe9e9-7cd4-4083-a8df-252bd205a2f4	2024-11-28 10:13:21.130283+00	2024-11-28 10:13:21.141787+00	87088ada-7020-41e8-b3bd-b878927d564e	Journals::CompletedJob	default	{"job_id": "87088ada-7020-41e8-b3bd-b878927d564e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [20, {"value": "2024-11-28T10:08:21.098847000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.125466630Z", "scheduled_at": "2024-11-28T10:13:21.123251558Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.123251+00	2024-11-28 10:13:21.141631+00	\N	\N
ceec2d37-bac8-40dd-816e-7cf1cf45936b	2024-11-28 10:13:20.396007+00	2024-11-28 10:13:20.506433+00	aad09fb0-b1e0-4fb5-8e5b-bc658013198c	Notifications::WorkflowJob	default	{"job_id": "aad09fb0-b1e0-4fb5-8e5b-bc658013198c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.346284829Z", "scheduled_at": "2024-11-28T10:13:20.346136478Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.346136+00	2024-11-28 10:13:20.506311+00	\N	\N
3b43d222-3062-462c-b3e7-3df1adba56f9	2024-11-28 10:13:20.403422+00	2024-11-28 10:13:20.513055+00	456f7e1e-ed02-4b44-b88d-b80f9cd60590	Journals::CompletedJob	default	{"job_id": "456f7e1e-ed02-4b44-b88d-b80f9cd60590", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.336628000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.351010612Z", "scheduled_at": "2024-11-28T10:13:20.350158854Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.350158+00	2024-11-28 10:13:20.512765+00	\N	\N
0dd203f9-c783-4928-ad75-c8818e1d9ab4	2024-11-28 10:13:20.414224+00	2024-11-28 10:13:20.509861+00	4df8db19-dc2f-4f02-bf2e-66ed62017724	Notifications::WorkflowJob	default	{"job_id": "4df8db19-dc2f-4f02-bf2e-66ed62017724", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.380549067Z", "scheduled_at": "2024-11-28T10:13:20.380397892Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.380397+00	2024-11-28 10:13:20.50976+00	\N	\N
eaed65dc-d4a4-4550-bdf8-49073fa68685	2024-11-28 10:13:20.360049+00	2024-11-28 10:13:20.439239+00	38877eb5-0c03-4103-b0a6-c3fb32aa08bf	Notifications::WorkflowJob	default	{"job_id": "38877eb5-0c03-4103-b0a6-c3fb32aa08bf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.296724509Z", "scheduled_at": "2024-11-28T10:13:20.296574326Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.296574+00	2024-11-28 10:13:20.439005+00	\N	\N
09a8cc0a-b9ad-40b3-bfa8-eab701e4d2a6	2024-11-28 10:13:20.545637+00	2024-11-28 10:13:20.607073+00	2366a0c4-2153-42fb-8276-866172ae0826	Notifications::WorkflowJob	default	{"job_id": "2366a0c4-2153-42fb-8276-866172ae0826", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.479060035Z", "scheduled_at": "2024-11-28T10:13:20.478924549Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.478924+00	2024-11-28 10:13:20.606945+00	\N	\N
44022f1d-4a67-4777-bc7c-79c5c7abfb49	2024-11-28 10:13:20.46677+00	2024-11-28 10:13:20.540954+00	789181b5-352b-49e9-8ee8-7823eec26802	Notifications::WorkflowJob	default	{"job_id": "789181b5-352b-49e9-8ee8-7823eec26802", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.412439672Z", "scheduled_at": "2024-11-28T10:13:20.412300289Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.4123+00	2024-11-28 10:13:20.540693+00	\N	\N
811ce041-7cc1-48cb-b2da-cd842e3bee18	2024-11-28 10:13:20.47715+00	2024-11-28 10:13:20.553915+00	9b9f0cfd-0a9d-4241-8704-5d84e01e378a	Journals::CompletedJob	default	{"job_id": "9b9f0cfd-0a9d-4241-8704-5d84e01e378a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.391412000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.416685550Z", "scheduled_at": "2024-11-28T10:13:20.416523454Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.416523+00	2024-11-28 10:13:20.553818+00	\N	\N
31229787-78be-4ab4-aa3d-b630336e722a	2024-11-28 10:13:20.499092+00	2024-11-28 10:13:20.558717+00	ee8f0810-d6b9-4ff1-bbea-9137b21209cd	Notifications::WorkflowJob	default	{"job_id": "ee8f0810-d6b9-4ff1-bbea-9137b21209cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.433638560Z", "scheduled_at": "2024-11-28T10:13:20.433502413Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.433502+00	2024-11-28 10:13:20.558592+00	\N	\N
bb5df133-173f-4879-b19f-08730fd4c8ed	2024-11-28 10:13:20.501941+00	2024-11-28 10:13:20.567545+00	d91768af-199c-4fef-9e91-04c5d0336c0a	Journals::CompletedJob	default	{"job_id": "d91768af-199c-4fef-9e91-04c5d0336c0a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.424529000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.437191550Z", "scheduled_at": "2024-11-28T10:13:20.437023643Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.437023+00	2024-11-28 10:13:20.567462+00	\N	\N
7b77975e-01db-4b54-8857-b2481e568692	2024-11-28 10:13:20.526127+00	2024-11-28 10:13:20.581416+00	970bdd4c-463b-4e75-b47b-41e49393bddb	Notifications::WorkflowJob	default	{"job_id": "970bdd4c-463b-4e75-b47b-41e49393bddb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.461830693Z", "scheduled_at": "2024-11-28T10:13:20.461696239Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.461696+00	2024-11-28 10:13:20.581262+00	\N	\N
82f8f990-fecc-4791-aaf2-c742cb9282a2	2024-11-28 10:13:20.53511+00	2024-11-28 10:13:20.64806+00	3da03879-81ff-49cf-b58c-c63fe5c3946b	Journals::CompletedJob	default	{"job_id": "3da03879-81ff-49cf-b58c-c63fe5c3946b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.440651000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.465657057Z", "scheduled_at": "2024-11-28T10:13:20.465496234Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.465496+00	2024-11-28 10:13:20.647903+00	\N	\N
28692bcc-d6a2-472d-bbd8-8207cf20f5bb	2024-11-28 10:13:21.057534+00	2024-11-28 10:13:21.067738+00	1d529880-a44d-4aa2-830b-5091b7152838	Journals::CompletedJob	default	{"job_id": "1d529880-a44d-4aa2-830b-5091b7152838", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [19, {"value": "2024-11-28T10:08:21.022826000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.051929398Z", "scheduled_at": "2024-11-28T10:13:21.051497693Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.051497+00	2024-11-28 10:13:21.0675+00	\N	\N
f5eb5ee2-e664-4264-9f7a-a0e57ad9ae93	2024-11-28 10:13:21.126823+00	2024-11-28 10:13:21.139371+00	a104d491-18d7-4c99-9fb6-ee7064c183bb	Notifications::WorkflowJob	default	{"job_id": "a104d491-18d7-4c99-9fb6-ee7064c183bb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.119720170Z", "scheduled_at": "2024-11-28T10:13:21.119568374Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.119568+00	2024-11-28 10:13:21.139078+00	\N	\N
ddec38fc-b981-4023-b6a5-bd8210547b8f	2024-11-28 10:13:21.239355+00	2024-11-28 10:13:21.313992+00	86d10a59-a21e-416a-9f49-63ab4c3f4e36	Journals::CompletedJob	default	{"job_id": "86d10a59-a21e-416a-9f49-63ab4c3f4e36", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [21, {"value": "2024-11-28T10:08:21.211834000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.236139833Z", "scheduled_at": "2024-11-28T10:13:21.235872468Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.235872+00	2024-11-28 10:13:21.313809+00	\N	\N
c610ee36-c3cf-4844-99da-3adbddf390c1	2024-11-28 10:13:21.352987+00	2024-11-28 10:13:21.369866+00	aea2c70d-4415-4562-adf6-daea998a643e	Notifications::WorkflowJob	default	{"job_id": "aea2c70d-4415-4562-adf6-daea998a643e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.341544808Z", "scheduled_at": "2024-11-28T10:13:21.341414613Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.341414+00	2024-11-28 10:13:21.369577+00	\N	\N
e58fd1b7-7f76-4acc-8c44-fed49bfe91a2	2024-11-28 10:13:21.655134+00	2024-11-28 10:13:21.662262+00	1b48c43a-fe41-405c-8dac-24503e1d9616	Journals::CompletedJob	default	{"job_id": "1b48c43a-fe41-405c-8dac-24503e1d9616", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.637480000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.649442830Z", "scheduled_at": "2024-11-28T10:13:21.649299079Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.649299+00	2024-11-28 10:13:21.661993+00	\N	\N
b702a185-b805-4d67-b8b4-0408415b5810	2024-11-28 10:13:20.556793+00	2024-11-28 10:13:20.618083+00	e77285a0-23ab-4a05-aafa-e0255c192371	Notifications::WorkflowJob	default	{"job_id": "e77285a0-23ab-4a05-aafa-e0255c192371", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.502719619Z", "scheduled_at": "2024-11-28T10:13:20.502590014Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.502589+00	2024-11-28 10:13:20.617904+00	\N	\N
3d8f1ba2-c096-48ec-866c-32f97232c9dc	2024-11-28 10:13:21.314437+00	2024-11-28 10:13:21.334343+00	df67d719-45c7-42da-b8d7-273e243ffe9a	Notifications::WorkflowJob	default	{"job_id": "df67d719-45c7-42da-b8d7-273e243ffe9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.278567104Z", "scheduled_at": "2024-11-28T10:13:21.278442058Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.278441+00	2024-11-28 10:13:21.334133+00	\N	\N
e99c02cd-1986-46de-9982-9b5b9c9c878b	2024-11-28 10:13:21.3564+00	2024-11-28 10:13:21.371058+00	849ab5b4-05a8-4680-ac4b-91b3e2b4aae0	Journals::CompletedJob	default	{"job_id": "849ab5b4-05a8-4680-ac4b-91b3e2b4aae0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-11-28T10:08:21.311905000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.345366133Z", "scheduled_at": "2024-11-28T10:13:21.345214808Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.345214+00	2024-11-28 10:13:21.370864+00	\N	\N
1cf4898e-7574-40e4-b315-10926d139cba	2024-11-28 10:13:21.652468+00	2024-11-28 10:13:21.660336+00	9abe8d8e-fd6b-4b10-904d-f336508161b9	Notifications::WorkflowJob	default	{"job_id": "9abe8d8e-fd6b-4b10-904d-f336508161b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.645895040Z", "scheduled_at": "2024-11-28T10:13:21.645744576Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.645744+00	2024-11-28 10:13:21.660178+00	\N	\N
50f52fda-c09a-4e4d-93af-f93ab291fea7	2024-11-28 10:13:21.688116+00	2024-11-28 10:13:21.705747+00	f8a43ede-10df-4037-82c4-8317dac7b188	Journals::CompletedJob	default	{"job_id": "f8a43ede-10df-4037-82c4-8317dac7b188", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.652757000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.676574630Z", "scheduled_at": "2024-11-28T10:13:21.676424707Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.676424+00	2024-11-28 10:13:21.705606+00	\N	\N
a4a15d21-1c6c-4837-b570-a5dce6dd15d0	2024-11-28 10:13:21.724576+00	2024-11-28 10:13:21.732783+00	589462aa-3ab1-4ced-8eec-27a8d2c83913	Notifications::WorkflowJob	default	{"job_id": "589462aa-3ab1-4ced-8eec-27a8d2c83913", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.721656223Z", "scheduled_at": "2024-11-28T10:13:21.721535014Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.721534+00	2024-11-28 10:13:21.732587+00	\N	\N
f862aa99-b068-4364-bc11-3c5156b856d0	2024-11-28 10:13:20.56075+00	2024-11-28 10:13:20.634203+00	78e257fb-3fb4-459d-a720-bca04fcad254	Journals::CompletedJob	default	{"job_id": "78e257fb-3fb4-459d-a720-bca04fcad254", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-11-28T10:08:20.487360000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.506188720Z", "scheduled_at": "2024-11-28T10:13:20.506017005Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.506016+00	2024-11-28 10:13:20.634078+00	\N	\N
944724ea-d0c5-4979-9c53-1153453c22f2	2024-11-28 10:13:21.843282+00	2024-11-28 10:13:21.863406+00	0cdd75e5-926c-45cd-8dee-922d322de6ad	Notifications::WorkflowJob	default	{"job_id": "0cdd75e5-926c-45cd-8dee-922d322de6ad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.831715666Z", "scheduled_at": "2024-11-28T10:13:21.831537189Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.831537+00	2024-11-28 10:13:21.863219+00	\N	\N
3cc0eb87-bef2-4892-a5ea-cd4d43222660	2024-11-28 10:13:22.441524+00	2024-11-28 10:13:22.457459+00	30d5f589-25e4-4a8a-a0e5-4bc6d6f39e5d	Journals::CompletedJob	default	{"job_id": "30d5f589-25e4-4a8a-a0e5-4bc6d6f39e5d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.377686000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.399589180Z", "scheduled_at": "2024-11-28T10:13:22.399051815Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.399051+00	2024-11-28 10:13:22.457262+00	\N	\N
0ccf7bd3-e597-47e9-9f24-dcbab1c255c4	2024-11-28 10:13:20.566684+00	2024-11-28 10:13:20.63078+00	e13037a9-1cff-4c38-bffb-b4c685c56856	Notifications::WorkflowJob	default	{"job_id": "e13037a9-1cff-4c38-bffb-b4c685c56856", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.521292177Z", "scheduled_at": "2024-11-28T10:13:20.521153987Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.521154+00	2024-11-28 10:13:20.630641+00	\N	\N
64ca5ef6-014f-41f6-bc33-014604d17f29	2024-11-28 10:13:21.316632+00	2024-11-28 10:13:21.335829+00	63d2d749-e074-42f6-a914-1b2e8c41338d	Notifications::WorkflowJob	default	{"job_id": "63d2d749-e074-42f6-a914-1b2e8c41338d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.299665812Z", "scheduled_at": "2024-11-28T10:13:21.299545114Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.299545+00	2024-11-28 10:13:21.335665+00	\N	\N
bc1eb012-4169-49f4-ac83-7c533cdb1d58	2024-11-28 10:13:21.823057+00	2024-11-28 10:13:21.860976+00	cf409ba2-42b6-4f0e-8006-b950de0699b0	Journals::CompletedJob	default	{"job_id": "cf409ba2-42b6-4f0e-8006-b950de0699b0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-11-28T10:08:21.784843000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.799129698Z", "scheduled_at": "2024-11-28T10:13:21.798855510Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.798855+00	2024-11-28 10:13:21.86084+00	\N	\N
39c7a281-251f-4d30-ad7e-aa6131c2e5f3	2024-11-28 10:13:22.46616+00	2024-11-28 10:13:22.476721+00	cd6ecc21-0cae-4b36-a3d3-b55cc24497b1	Journals::CompletedJob	default	{"job_id": "cd6ecc21-0cae-4b36-a3d3-b55cc24497b1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.404644000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.460291207Z", "scheduled_at": "2024-11-28T10:13:22.458835467Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.458835+00	2024-11-28 10:13:22.476555+00	\N	\N
ebe60fce-21d0-43bf-bbd2-af346c6db699	2024-11-28 10:13:22.496926+00	2024-11-28 10:13:22.501356+00	ccc6a0fd-5325-418b-973c-ed4707fb8140	Notifications::WorkflowJob	default	{"job_id": "ccc6a0fd-5325-418b-973c-ed4707fb8140", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.494207256Z", "scheduled_at": "2024-11-28T10:13:22.494071800Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.494071+00	2024-11-28 10:13:22.50121+00	\N	\N
beba7f31-e704-4797-bb9b-19797958406f	2024-11-28 10:13:22.556772+00	2024-11-28 10:13:22.562835+00	c08db6ad-4684-4c43-8f1c-2d06de3db6ef	Journals::CompletedJob	default	{"job_id": "c08db6ad-4684-4c43-8f1c-2d06de3db6ef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-11-28T10:08:22.512770000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.554406273Z", "scheduled_at": "2024-11-28T10:13:22.554260307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.55426+00	2024-11-28 10:13:22.562681+00	\N	\N
0a1824cf-3f68-4d4d-b8ba-9ff881333cbb	2024-11-28 10:13:21.234583+00	2024-11-28 10:13:21.304555+00	3970824f-e0d0-4605-84be-52c1e335f286	Notifications::WorkflowJob	default	{"job_id": "3970824f-e0d0-4605-84be-52c1e335f286", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.230409673Z", "scheduled_at": "2024-11-28T10:13:21.230087124Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.230087+00	2024-11-28 10:13:21.304256+00	\N	\N
84d8ce73-86a1-4f1c-a8fb-4d9309ebd8f5	2024-11-28 10:13:21.328537+00	2024-11-28 10:13:21.358423+00	232ba707-7e19-4a14-b876-c5e32cf2e28e	Journals::CompletedJob	default	{"job_id": "232ba707-7e19-4a14-b876-c5e32cf2e28e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-11-28T10:08:21.290285000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.303775653Z", "scheduled_at": "2024-11-28T10:13:21.303626261Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.303626+00	2024-11-28 10:13:21.358221+00	\N	\N
10bbde12-b7af-46fb-a6c2-2de4f3e4dade	2024-11-28 10:13:21.382178+00	2024-11-28 10:13:21.395097+00	b68ccdaa-948b-4408-80e7-f3637d810e84	Journals::CompletedJob	default	{"job_id": "b68ccdaa-948b-4408-80e7-f3637d810e84", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-11-28T10:08:21.353881000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.372236631Z", "scheduled_at": "2024-11-28T10:13:21.372085475Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.372085+00	2024-11-28 10:13:21.39489+00	\N	\N
d0797d67-0bdf-478c-a2c3-dbe2bc57c253	2024-11-28 10:13:21.405558+00	2024-11-28 10:13:21.417732+00	f421d582-4029-4847-b6db-8138919e0d8f	Notifications::WorkflowJob	default	{"job_id": "f421d582-4029-4847-b6db-8138919e0d8f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.402801793Z", "scheduled_at": "2024-11-28T10:13:21.402675464Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.402675+00	2024-11-28 10:13:21.417504+00	\N	\N
1ec6a292-24a2-4283-bc7d-b31a6a0ee17f	2024-11-28 10:13:21.447726+00	2024-11-28 10:13:21.456797+00	235058da-6132-46c8-b8e2-af328a32380d	Journals::CompletedJob	default	{"job_id": "235058da-6132-46c8-b8e2-af328a32380d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.411680000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.442860742Z", "scheduled_at": "2024-11-28T10:13:21.442645435Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.442645+00	2024-11-28 10:13:21.456635+00	\N	\N
83a8f616-6042-4c0c-b8bd-e69e1dcd379f	2024-11-28 10:13:21.471796+00	2024-11-28 10:13:21.479906+00	876dc787-917b-46bb-bc31-c9dd97db28a0	Journals::CompletedJob	default	{"job_id": "876dc787-917b-46bb-bc31-c9dd97db28a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.450280000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.466439584Z", "scheduled_at": "2024-11-28T10:13:21.466116184Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.466116+00	2024-11-28 10:13:21.47966+00	\N	\N
e996a1aa-b619-4f42-925e-d000760a9a81	2024-11-28 10:13:21.464529+00	2024-11-28 10:13:21.473851+00	e145a9ac-7762-4d12-a288-e286b271a8d5	Notifications::WorkflowJob	default	{"job_id": "e145a9ac-7762-4d12-a288-e286b271a8d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.461177448Z", "scheduled_at": "2024-11-28T10:13:21.461008569Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.461008+00	2024-11-28 10:13:21.473661+00	\N	\N
9ccad127-b798-4211-af7e-d72321185f90	2024-11-28 10:13:21.5027+00	2024-11-28 10:13:21.514818+00	caaed92d-e02f-403a-8371-868537b940a2	Journals::CompletedJob	default	{"job_id": "caaed92d-e02f-403a-8371-868537b940a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.472098000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.498677896Z", "scheduled_at": "2024-11-28T10:13:21.498495361Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.498495+00	2024-11-28 10:13:21.51465+00	\N	\N
5d711368-0cd3-4d37-8614-3897adf218ac	2024-11-28 10:13:21.530292+00	2024-11-28 10:13:21.53633+00	63734437-43e4-4ed3-b81c-6f7f8c0e123b	Notifications::WorkflowJob	default	{"job_id": "63734437-43e4-4ed3-b81c-6f7f8c0e123b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.526375054Z", "scheduled_at": "2024-11-28T10:13:21.526216635Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.526216+00	2024-11-28 10:13:21.536176+00	\N	\N
757b29ed-fe54-44ff-a26f-f0fdc4ed1395	2024-11-28 10:13:21.556033+00	2024-11-28 10:13:21.565791+00	e865de07-4587-4003-9c63-984a7dfed157	Journals::CompletedJob	default	{"job_id": "e865de07-4587-4003-9c63-984a7dfed157", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.538041000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.550785335Z", "scheduled_at": "2024-11-28T10:13:21.550646523Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.550646+00	2024-11-28 10:13:21.565618+00	\N	\N
a26edd15-ccb8-4a70-9a56-7ddb7c57b077	2024-11-28 10:13:21.580891+00	2024-11-28 10:13:21.589983+00	14a56a4d-a71e-45a7-be66-9bdebf7e4877	Notifications::WorkflowJob	default	{"job_id": "14a56a4d-a71e-45a7-be66-9bdebf7e4877", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.577070616Z", "scheduled_at": "2024-11-28T10:13:21.576920102Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.57692+00	2024-11-28 10:13:21.589789+00	\N	\N
d64254b3-7dd2-4454-bbf6-a63c35b130ea	2024-11-28 10:13:21.606869+00	2024-11-28 10:13:21.614245+00	2870689b-2a4f-4f5d-a9a1-a3bbd6a386fb	Notifications::WorkflowJob	default	{"job_id": "2870689b-2a4f-4f5d-a9a1-a3bbd6a386fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.604430097Z", "scheduled_at": "2024-11-28T10:13:21.604310100Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.60431+00	2024-11-28 10:13:21.613986+00	\N	\N
1acd52c5-bc6c-479b-92c7-54c6d30cd8ca	2024-11-28 10:13:21.498558+00	2024-11-28 10:13:21.507354+00	78e2fefb-cca4-4eae-a8b4-da93a1331a07	Notifications::WorkflowJob	default	{"job_id": "78e2fefb-cca4-4eae-a8b4-da93a1331a07", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.494878582Z", "scheduled_at": "2024-11-28T10:13:21.494415237Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.494415+00	2024-11-28 10:13:21.507199+00	\N	\N
9e1bb17a-0960-47e0-9138-ce0b0efb7a59	2024-11-28 10:13:21.534358+00	2024-11-28 10:13:21.541564+00	f9e3814e-b039-4a5b-8e33-2a2f19491a04	Journals::CompletedJob	default	{"job_id": "f9e3814e-b039-4a5b-8e33-2a2f19491a04", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.503683000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.531040473Z", "scheduled_at": "2024-11-28T10:13:21.530569884Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.53057+00	2024-11-28 10:13:21.541374+00	\N	\N
55239a58-e37a-4061-8c40-e126bc07850b	2024-11-28 10:13:21.552171+00	2024-11-28 10:13:21.563634+00	82598bda-c247-423a-b4c4-d049377a722d	Notifications::WorkflowJob	default	{"job_id": "82598bda-c247-423a-b4c4-d049377a722d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.547542332Z", "scheduled_at": "2024-11-28T10:13:21.547275368Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.547275+00	2024-11-28 10:13:21.563361+00	\N	\N
3f97752c-d890-4183-b4fc-63dbb2cf9f64	2024-11-28 10:13:21.585539+00	2024-11-28 10:13:21.600463+00	88406fcd-14f1-4d6e-80a4-5f87ba9543dd	Journals::CompletedJob	default	{"job_id": "88406fcd-14f1-4d6e-80a4-5f87ba9543dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.554755000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.580940384Z", "scheduled_at": "2024-11-28T10:13:21.580743963Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.580744+00	2024-11-28 10:13:21.600306+00	\N	\N
a3784298-889d-4fa0-968b-4dd5a25cd526	2024-11-28 10:13:21.610861+00	2024-11-28 10:13:21.619751+00	12833fce-9646-4403-ac30-ff25d9f28892	Journals::CompletedJob	default	{"job_id": "12833fce-9646-4403-ac30-ff25d9f28892", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.585544000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.607919135Z", "scheduled_at": "2024-11-28T10:13:21.607770093Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.60777+00	2024-11-28 10:13:21.619582+00	\N	\N
417e382a-a3dc-47bf-9c05-8a8818407bba	2024-11-28 10:13:21.631483+00	2024-11-28 10:13:21.640112+00	a5f55191-8eaf-43c1-843c-9a91a35520fc	Notifications::WorkflowJob	default	{"job_id": "a5f55191-8eaf-43c1-843c-9a91a35520fc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.627833928Z", "scheduled_at": "2024-11-28T10:13:21.627714853Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.627714+00	2024-11-28 10:13:21.63989+00	\N	\N
a3b9f17a-fe10-4a5f-b13d-131bed4ea579	2024-11-28 10:13:21.635547+00	2024-11-28 10:13:21.64363+00	109d8d2a-5d94-4795-9096-c8128de0002c	Journals::CompletedJob	default	{"job_id": "109d8d2a-5d94-4795-9096-c8128de0002c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.612705000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.631418015Z", "scheduled_at": "2024-11-28T10:13:21.631272440Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.631272+00	2024-11-28 10:13:21.643011+00	\N	\N
0dd6358f-fde6-4f42-86bb-766dbe8bc0d3	2024-11-28 10:13:21.698051+00	2024-11-28 10:13:21.713158+00	b3f609ba-e586-4632-b783-f9704eab7362	Notifications::WorkflowJob	default	{"job_id": "b3f609ba-e586-4632-b783-f9704eab7362", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.690449608Z", "scheduled_at": "2024-11-28T10:13:21.690317909Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.690317+00	2024-11-28 10:13:21.712942+00	\N	\N
491d4da0-04a7-4077-9e3e-93b4993ed656	2024-11-28 10:13:21.729327+00	2024-11-28 10:13:21.740553+00	89c78fb4-35cb-4bd4-b89e-48ef257f945b	Journals::CompletedJob	default	{"job_id": "89c78fb4-35cb-4bd4-b89e-48ef257f945b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.696851000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.725168444Z", "scheduled_at": "2024-11-28T10:13:21.725020985Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.72502+00	2024-11-28 10:13:21.740367+00	\N	\N
191afc92-ae53-4721-b5cb-25462976eb0d	2024-11-28 10:13:21.804368+00	2024-11-28 10:13:21.844511+00	d39659fa-03f1-4676-88f5-96bbb0c3ab9a	Notifications::WorkflowJob	default	{"job_id": "d39659fa-03f1-4676-88f5-96bbb0c3ab9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.794523170Z", "scheduled_at": "2024-11-28T10:13:21.794393525Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.794393+00	2024-11-28 10:13:21.844279+00	\N	\N
c082e12a-1a9e-40ad-b66d-2da916a09be9	2024-11-28 10:13:21.872727+00	2024-11-28 10:13:21.88414+00	32800bca-6b46-442b-aa2f-85f13a00937f	Notifications::WorkflowJob	default	{"job_id": "32800bca-6b46-442b-aa2f-85f13a00937f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.867746680Z", "scheduled_at": "2024-11-28T10:13:21.867575156Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.867574+00	2024-11-28 10:13:21.883913+00	\N	\N
15538e40-16b5-4dea-806d-1da95d3a47f5	2024-11-28 10:13:21.901601+00	2024-11-28 10:13:21.911894+00	24baa311-d0e2-4f93-8f38-7ae1a0e5393e	Journals::CompletedJob	default	{"job_id": "24baa311-d0e2-4f93-8f38-7ae1a0e5393e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.881815000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.899198327Z", "scheduled_at": "2024-11-28T10:13:21.898984804Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.898984+00	2024-11-28 10:13:21.911709+00	\N	\N
8aa6175e-9b96-4b9b-a86b-738a0c9f815b	2024-11-28 10:13:21.685034+00	2024-11-28 10:13:21.692917+00	9b3e3eed-a6e3-453c-a504-3facf9d41194	Notifications::WorkflowJob	default	{"job_id": "9b3e3eed-a6e3-453c-a504-3facf9d41194", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.672769796Z", "scheduled_at": "2024-11-28T10:13:21.672641975Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.672641+00	2024-11-28 10:13:21.692667+00	\N	\N
57c3ff7a-8721-43e4-9ff7-b0895e7b2488	2024-11-28 10:13:21.792931+00	2024-11-28 10:13:21.836031+00	cf3a32ca-8766-4cbc-a64f-b4628a7f5395	Journals::CompletedJob	default	{"job_id": "cf3a32ca-8766-4cbc-a64f-b4628a7f5395", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-11-28T10:08:21.749861000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.777829319Z", "scheduled_at": "2024-11-28T10:13:21.777674496Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.777674+00	2024-11-28 10:13:21.835792+00	\N	\N
99fb9a04-e41e-4e34-86e2-8fdfdcf10437	2024-11-28 10:13:21.879421+00	2024-11-28 10:13:21.88794+00	f6422cef-1e10-48de-8511-aefdfff8989a	Journals::CompletedJob	default	{"job_id": "f6422cef-1e10-48de-8511-aefdfff8989a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.843530000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.873018935Z", "scheduled_at": "2024-11-28T10:13:21.872535472Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.872535+00	2024-11-28 10:13:21.887774+00	\N	\N
8aa736e3-c3d0-4880-af77-b90eea2319b0	2024-11-28 10:13:21.897357+00	2024-11-28 10:13:21.903099+00	8274d3f5-e178-4415-ab00-94a2af01a694	Notifications::WorkflowJob	default	{"job_id": "8274d3f5-e178-4415-ab00-94a2af01a694", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.894247719Z", "scheduled_at": "2024-11-28T10:13:21.894068971Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.894068+00	2024-11-28 10:13:21.902928+00	\N	\N
8e6877b5-3e98-47e7-8e0f-1002cd8da184	2024-11-28 10:13:21.939638+00	2024-11-28 10:13:21.951716+00	41a92d3f-9d42-44c8-b423-584dcf850453	Journals::CompletedJob	default	{"job_id": "41a92d3f-9d42-44c8-b423-584dcf850453", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.904313000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.937348773Z", "scheduled_at": "2024-11-28T10:13:21.937130721Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.93713+00	2024-11-28 10:13:21.9515+00	\N	\N
60d30193-1af6-4df4-959c-591fcc29bdc7	2024-11-28 10:13:21.961121+00	2024-11-28 10:13:21.966102+00	e6caef14-eb1a-43e8-a59e-e24a346a0ee5	Notifications::WorkflowJob	default	{"job_id": "e6caef14-eb1a-43e8-a59e-e24a346a0ee5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.958972702Z", "scheduled_at": "2024-11-28T10:13:21.958799264Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.958799+00	2024-11-28 10:13:21.965925+00	\N	\N
7f141323-b148-4f6f-bc6b-d1948fe3e0b9	2024-11-28 10:13:21.701185+00	2024-11-28 10:13:21.716734+00	b231c7ba-b965-4d08-9e10-6ab34618313c	Journals::CompletedJob	default	{"job_id": "b231c7ba-b965-4d08-9e10-6ab34618313c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.682360000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.694001074Z", "scheduled_at": "2024-11-28T10:13:21.693857132Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.693856+00	2024-11-28 10:13:21.716495+00	\N	\N
6504de0a-8382-4121-b832-715a9819dfa9	2024-11-28 10:13:21.758481+00	2024-11-28 10:13:21.783217+00	74e90f55-8677-4811-835c-75c0453327f1	Journals::CompletedJob	default	{"job_id": "74e90f55-8677-4811-835c-75c0453327f1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-11-28T10:08:21.730609000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.745992424Z", "scheduled_at": "2024-11-28T10:13:21.745837992Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.745838+00	2024-11-28 10:13:21.783046+00	\N	\N
e0145830-96c8-4c32-b347-68dd82ba64f8	2024-11-28 10:13:21.848955+00	2024-11-28 10:13:21.867577+00	8c752737-15eb-4921-a4fe-2aea2c5abb31	Journals::CompletedJob	default	{"job_id": "8c752737-15eb-4921-a4fe-2aea2c5abb31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-11-28T10:08:21.803135000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.837750701Z", "scheduled_at": "2024-11-28T10:13:21.837527901Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.837527+00	2024-11-28 10:13:21.867436+00	\N	\N
54a913d9-00c6-45c6-92bd-40967a0aa4ba	2024-11-28 10:13:22.094623+00	2024-11-28 10:13:22.104559+00	e9f080ab-eea5-48ca-8a43-655bcaf70be2	Journals::CompletedJob	default	{"job_id": "e9f080ab-eea5-48ca-8a43-655bcaf70be2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-11-28T10:08:22.077108000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.089526072Z", "scheduled_at": "2024-11-28T10:13:22.089366822Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.089366+00	2024-11-28 10:13:22.104435+00	\N	\N
922c3dbb-9551-403b-8c2d-e5a8d69911f1	2024-11-28 10:13:22.127502+00	2024-11-28 10:13:22.131969+00	59687b49-dc31-4236-986a-2346ca268cdd	Notifications::WorkflowJob	default	{"job_id": "59687b49-dc31-4236-986a-2346ca268cdd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.125601049Z", "scheduled_at": "2024-11-28T10:13:22.125414266Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.125414+00	2024-11-28 10:13:22.131841+00	\N	\N
baa4146f-36d1-460d-ac0c-6e258dc9060e	2024-11-28 10:13:22.140329+00	2024-11-28 10:13:22.14474+00	2b76361f-da93-4c60-859f-1e0d95fc905d	Journals::CompletedJob	default	{"job_id": "2b76361f-da93-4c60-859f-1e0d95fc905d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-11-28T10:08:22.093397000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.138814488Z", "scheduled_at": "2024-11-28T10:13:22.138283005Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.138283+00	2024-11-28 10:13:22.144601+00	\N	\N
a6a8c243-5173-4d58-907e-4bf347f7b2e2	2024-11-28 10:13:22.18384+00	2024-11-28 10:13:22.188857+00	283fbc60-91ae-496b-91a6-9223e0c9b1b1	Notifications::WorkflowJob	default	{"job_id": "283fbc60-91ae-496b-91a6-9223e0c9b1b1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.181919127Z", "scheduled_at": "2024-11-28T10:13:22.181741802Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.181741+00	2024-11-28 10:13:22.188625+00	\N	\N
08870555-2937-4a32-b9f0-4cac0d437785	2024-11-28 10:13:22.252405+00	2024-11-28 10:13:22.259817+00	c25a6301-e982-4c9c-b96c-9d2ea2c4e1db	Journals::CompletedJob	default	{"job_id": "c25a6301-e982-4c9c-b96c-9d2ea2c4e1db", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-11-28T10:08:22.200989000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.246403236Z", "scheduled_at": "2024-11-28T10:13:22.246250037Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.246249+00	2024-11-28 10:13:22.259639+00	\N	\N
f4fe5d7a-7ce2-4b66-b986-44e0a05c2e28	2024-11-28 10:13:22.274028+00	2024-11-28 10:13:22.284046+00	cddb7e0c-1c0b-4065-bde8-2299957fc097	Notifications::WorkflowJob	default	{"job_id": "cddb7e0c-1c0b-4065-bde8-2299957fc097", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.270584074Z", "scheduled_at": "2024-11-28T10:13:22.270459589Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.270459+00	2024-11-28 10:13:22.283771+00	\N	\N
cebc973d-ed3d-4fb1-807f-2bfcc2581044	2024-11-28 10:13:22.332914+00	2024-11-28 10:13:22.340575+00	0d3d95c2-bf35-4075-9866-94e58ac7e780	Journals::CompletedJob	default	{"job_id": "0d3d95c2-bf35-4075-9866-94e58ac7e780", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-11-28T10:08:22.285489000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.327810358Z", "scheduled_at": "2024-11-28T10:13:22.327662098Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.327661+00	2024-11-28 10:13:22.340395+00	\N	\N
3d2b37d0-24d0-4e41-9b06-59673cff351c	2024-11-28 10:13:21.743034+00	2024-11-28 10:13:21.766347+00	31673ca4-3e8b-4e66-acbf-6313d399ac39	Notifications::WorkflowJob	default	{"job_id": "31673ca4-3e8b-4e66-acbf-6313d399ac39", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.740928313Z", "scheduled_at": "2024-11-28T10:13:21.740789571Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.740789+00	2024-11-28 10:13:21.766024+00	\N	\N
ee512aea-abd2-434c-a939-e16ca2505fea	2024-11-28 10:13:21.784841+00	2024-11-28 10:13:21.832071+00	bc4e5223-3fcb-4fa7-ba08-bf3f68936adc	Notifications::WorkflowJob	default	{"job_id": "bc4e5223-3fcb-4fa7-ba08-bf3f68936adc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.774181871Z", "scheduled_at": "2024-11-28T10:13:21.774046004Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.774045+00	2024-11-28 10:13:21.830904+00	\N	\N
b8e5c8c4-6fa3-4f8b-9a80-6500c95a8387	2024-11-28 10:13:21.935055+00	2024-11-28 10:13:21.941143+00	8d8e3cf4-a1ca-4a96-a58c-02b370fce129	Notifications::WorkflowJob	default	{"job_id": "8d8e3cf4-a1ca-4a96-a58c-02b370fce129", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.932064273Z", "scheduled_at": "2024-11-28T10:13:21.931887109Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.931887+00	2024-11-28 10:13:21.940951+00	\N	\N
db7927d3-fd04-41f6-acb3-7b02fa8e4206	2024-11-28 10:13:21.967336+00	2024-11-28 10:13:21.978117+00	c0b2f486-e922-4406-832d-9d896d5f1595	Journals::CompletedJob	default	{"job_id": "c0b2f486-e922-4406-832d-9d896d5f1595", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-11-28T10:08:21.947508000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.963697133Z", "scheduled_at": "2024-11-28T10:13:21.963488629Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.963488+00	2024-11-28 10:13:21.97783+00	\N	\N
2afbf8f1-4576-44b7-9d87-fc32eb185d00	2024-11-28 10:13:22.000093+00	2024-11-28 10:13:22.006982+00	20c3d50e-6c1c-4e58-82b2-348220aee5dc	Notifications::WorkflowJob	default	{"job_id": "20c3d50e-6c1c-4e58-82b2-348220aee5dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.997151321Z", "scheduled_at": "2024-11-28T10:13:21.996955311Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.996955+00	2024-11-28 10:13:22.006884+00	\N	\N
2a246b70-f535-4d9e-b919-93bb79287902	2024-11-28 10:13:22.034293+00	2024-11-28 10:13:22.044113+00	94164e90-f48a-4f19-ae63-1a96f596987e	Journals::CompletedJob	default	{"job_id": "94164e90-f48a-4f19-ae63-1a96f596987e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-11-28T10:08:22.010073000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.031191966Z", "scheduled_at": "2024-11-28T10:13:22.030904504Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.030904+00	2024-11-28 10:13:22.043899+00	\N	\N
483b7dea-3fe0-4495-8f14-ccf8186d7c60	2024-11-28 10:13:22.069987+00	2024-11-28 10:13:22.078739+00	d05809f5-7e41-4130-9c0e-d6a1a4c1231a	Notifications::WorkflowJob	default	{"job_id": "d05809f5-7e41-4130-9c0e-d6a1a4c1231a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.066893077Z", "scheduled_at": "2024-11-28T10:13:22.066773561Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.066773+00	2024-11-28 10:13:22.07851+00	\N	\N
2abacfb1-2d55-494c-aa9f-33ae88a2f4b2	2024-11-28 10:13:22.090923+00	2024-11-28 10:13:22.099145+00	053d9d1d-7ff3-42e2-9d05-2a1f8f73a4d5	Notifications::WorkflowJob	default	{"job_id": "053d9d1d-7ff3-42e2-9d05-2a1f8f73a4d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.085999813Z", "scheduled_at": "2024-11-28T10:13:22.085867243Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.085867+00	2024-11-28 10:13:22.098975+00	\N	\N
444a0820-6cf5-4b23-9035-9fdb4c62b1b2	2024-11-28 10:13:22.005451+00	2024-11-28 10:13:22.014963+00	caa61aa7-a2ef-4a02-941b-ae9e2139a112	Journals::CompletedJob	default	{"job_id": "caa61aa7-a2ef-4a02-941b-ae9e2139a112", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-11-28T10:08:21.971685000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.002158315Z", "scheduled_at": "2024-11-28T10:13:22.001939181Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.001939+00	2024-11-28 10:13:22.014761+00	\N	\N
0f04662e-1862-4177-83f9-eb1cb09a894a	2024-11-28 10:13:22.026324+00	2024-11-28 10:13:22.030757+00	b2e27425-1658-444a-9709-39ae5d4acd2d	Notifications::WorkflowJob	default	{"job_id": "b2e27425-1658-444a-9709-39ae5d4acd2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.024109052Z", "scheduled_at": "2024-11-28T10:13:22.023877465Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.023877+00	2024-11-28 10:13:22.030553+00	\N	\N
58e506cf-a5e0-4c54-9304-bc97390c20c0	2024-11-28 10:13:22.074217+00	2024-11-28 10:13:22.083928+00	e16e43d8-d456-49b7-9705-91a26d4c4b11	Journals::CompletedJob	default	{"job_id": "e16e43d8-d456-49b7-9705-91a26d4c4b11", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-11-28T10:08:22.039579000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.070267899Z", "scheduled_at": "2024-11-28T10:13:22.070125540Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.070125+00	2024-11-28 10:13:22.083733+00	\N	\N
41034b29-d7aa-4aa7-8469-8bc580dda1d5	2024-11-28 10:13:22.445019+00	2024-11-28 10:13:22.45659+00	a93f4ccc-b237-472a-8575-4cf68148edf7	Notifications::WorkflowJob	default	{"job_id": "a93f4ccc-b237-472a-8575-4cf68148edf7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.394386596Z", "scheduled_at": "2024-11-28T10:13:22.394258474Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.394258+00	2024-11-28 10:13:22.456422+00	\N	\N
b1685be4-6876-4e1c-aaaa-b8df1f983293	2024-11-28 10:13:22.980692+00	2024-11-28 10:13:22.991076+00	084c4d35-3f0d-45d6-9cb8-0f347201c9a0	Journals::CompletedJob	default	{"job_id": "084c4d35-3f0d-45d6-9cb8-0f347201c9a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-11-28T10:08:22.964534000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.976937029Z", "scheduled_at": "2024-11-28T10:13:22.976796554Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.976796+00	2024-11-28 10:13:22.990898+00	\N	\N
5acf3a27-cdab-4984-9c06-e975e69fc631	2024-11-28 10:13:23.105846+00	2024-11-28 10:13:23.113692+00	1c050739-2a43-4159-84f5-9b1c610dbb10	Notifications::WorkflowJob	default	{"job_id": "1c050739-2a43-4159-84f5-9b1c610dbb10", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.102820942Z", "scheduled_at": "2024-11-28T10:13:23.102696307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:23.102696+00	2024-11-28 10:13:23.113512+00	\N	\N
1f4fea19-c578-4e26-a731-13e562c39121	2024-11-28 10:13:22.195871+00	2024-11-28 10:13:22.207478+00	1e04e968-b1d1-4d0a-afce-2ea25647005e	Journals::CompletedJob	default	{"job_id": "1e04e968-b1d1-4d0a-afce-2ea25647005e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-11-28T10:08:22.153864000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.191557566Z", "scheduled_at": "2024-11-28T10:13:22.191306442Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.191306+00	2024-11-28 10:13:22.207167+00	\N	\N
52e559f2-2641-4d2e-bd94-fbcf8ca22cc5	2024-11-28 10:13:22.244367+00	2024-11-28 10:13:22.255459+00	0b4eb3d3-2a54-42eb-9152-17fac3b9c66d	Notifications::WorkflowJob	default	{"job_id": "0b4eb3d3-2a54-42eb-9152-17fac3b9c66d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.240028358Z", "scheduled_at": "2024-11-28T10:13:22.239893493Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.239893+00	2024-11-28 10:13:22.255183+00	\N	\N
d1f1a71d-9d4a-4630-bba0-1a0d5e3aa909	2024-11-28 10:13:22.280993+00	2024-11-28 10:13:22.298159+00	36e11c35-7d7a-4efe-9426-9db80de57bd0	Journals::CompletedJob	default	{"job_id": "36e11c35-7d7a-4efe-9426-9db80de57bd0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-11-28T10:08:22.257541000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.276485546Z", "scheduled_at": "2024-11-28T10:13:22.276341735Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.276341+00	2024-11-28 10:13:22.297823+00	\N	\N
74d91065-d37a-41fa-afc8-13d60de9deac	2024-11-28 10:13:22.325512+00	2024-11-28 10:13:22.335895+00	01a6e046-b51f-4956-963f-c8e7b4362d2f	Notifications::WorkflowJob	default	{"job_id": "01a6e046-b51f-4956-963f-c8e7b4362d2f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.321344659Z", "scheduled_at": "2024-11-28T10:13:22.321217068Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.321217+00	2024-11-28 10:13:22.335576+00	\N	\N
0777e969-780d-41c1-bf5b-452f7800b874	2024-11-28 10:13:22.373722+00	2024-11-28 10:13:22.450655+00	cd74b31f-cf08-43c1-8f9b-cc3c8bd24b80	Journals::CompletedJob	default	{"job_id": "cd74b31f-cf08-43c1-8f9b-cc3c8bd24b80", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.333671000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.367222084Z", "scheduled_at": "2024-11-28T10:13:22.367069667Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.367069+00	2024-11-28 10:13:22.450513+00	\N	\N
92996ad2-6c22-4bbf-93e1-c5c4724ee1b8	2024-11-28 10:13:22.363457+00	2024-11-28 10:13:22.371984+00	c4ac695e-9503-4d50-8366-ffef9ffea36a	Notifications::WorkflowJob	default	{"job_id": "c4ac695e-9503-4d50-8366-ffef9ffea36a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.360398449Z", "scheduled_at": "2024-11-28T10:13:22.359915878Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.359915+00	2024-11-28 10:13:22.371741+00	\N	\N
c810a166-a4ef-4579-a59b-dcbf38659000	2024-11-28 10:13:22.453192+00	2024-11-28 10:13:22.465504+00	e5df4be5-61d7-46c9-b94f-df8129ac0392	Notifications::WorkflowJob	default	{"job_id": "e5df4be5-61d7-46c9-b94f-df8129ac0392", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.448168196Z", "scheduled_at": "2024-11-28T10:13:22.447926540Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.447926+00	2024-11-28 10:13:22.465342+00	\N	\N
76674418-5e28-4e96-8005-45cfc55bc3f9	2024-11-28 10:13:22.505178+00	2024-11-28 10:13:22.510971+00	385fd604-b08b-4438-9135-d780990240c2	Journals::CompletedJob	default	{"job_id": "385fd604-b08b-4438-9135-d780990240c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-11-28T10:08:22.480602000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.503860954Z", "scheduled_at": "2024-11-28T10:13:22.502554938Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.502554+00	2024-11-28 10:13:22.510433+00	\N	\N
53ae2ac9-6002-4af2-81e6-8e1e3ba329f4	2024-11-28 10:13:22.549505+00	2024-11-28 10:13:22.553947+00	0897d36f-7cb0-41f9-977f-5be2b9e2768b	Notifications::WorkflowJob	default	{"job_id": "0897d36f-7cb0-41f9-977f-5be2b9e2768b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.546846750Z", "scheduled_at": "2024-11-28T10:13:22.546711204Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.546711+00	2024-11-28 10:13:22.553789+00	\N	\N
a307a4fc-af07-4b2e-800a-7184e46476e3	2024-11-28 10:13:22.589564+00	2024-11-28 10:13:22.597815+00	b1a7a3cb-d7d9-43e5-b785-2d8708d21354	Journals::CompletedJob	default	{"job_id": "b1a7a3cb-d7d9-43e5-b785-2d8708d21354", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-11-28T10:08:22.566251000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.586983144Z", "scheduled_at": "2024-11-28T10:13:22.586813794Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.586813+00	2024-11-28 10:13:22.597638+00	\N	\N
6bdb35a8-8202-498a-b272-cfe30b479bbe	2024-11-28 10:13:22.629019+00	2024-11-28 10:13:22.634175+00	10d4f9b2-1c37-4368-b5f6-f607cc7a029b	Notifications::WorkflowJob	default	{"job_id": "10d4f9b2-1c37-4368-b5f6-f607cc7a029b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.626248495Z", "scheduled_at": "2024-11-28T10:13:22.625726338Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.625726+00	2024-11-28 10:13:22.634018+00	\N	\N
eefc2c55-c5af-46ea-9cd6-074dc9afc709	2024-11-28 10:13:22.582867+00	2024-11-28 10:13:22.586574+00	8f415b59-0602-4f4b-a9ab-c579dd61a295	Notifications::WorkflowJob	default	{"job_id": "8f415b59-0602-4f4b-a9ab-c579dd61a295", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.580329311Z", "scheduled_at": "2024-11-28T10:13:22.580195058Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.580195+00	2024-11-28 10:13:22.586413+00	\N	\N
aece82c7-036d-4c32-b60b-728fd37a90f0	2024-11-28 10:13:22.635689+00	2024-11-28 10:13:22.640812+00	ae271d50-fd37-4ced-ab9f-288c029be092	Journals::CompletedJob	default	{"job_id": "ae271d50-fd37-4ced-ab9f-288c029be092", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-11-28T10:08:22.598123000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.632535165Z", "scheduled_at": "2024-11-28T10:13:22.632381716Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.632381+00	2024-11-28 10:13:22.640663+00	\N	\N
ba11addd-62fa-4991-9d85-38e39f9d270a	2024-11-28 10:13:22.656834+00	2024-11-28 10:13:22.66053+00	5169fb9f-ffbd-4c43-abde-dbfb34b07634	Notifications::WorkflowJob	default	{"job_id": "5169fb9f-ffbd-4c43-abde-dbfb34b07634", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.655170996Z", "scheduled_at": "2024-11-28T10:13:22.655043966Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.655043+00	2024-11-28 10:13:22.660345+00	\N	\N
4ffdc94a-76a7-4ddf-b3cc-b343ebf4f30e	2024-11-28 10:13:22.710235+00	2024-11-28 10:13:22.717596+00	f580385a-e883-416a-9e8b-77110d5bf4bc	Journals::CompletedJob	default	{"job_id": "f580385a-e883-416a-9e8b-77110d5bf4bc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-11-28T10:08:22.673149000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.707061184Z", "scheduled_at": "2024-11-28T10:13:22.706234153Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.706234+00	2024-11-28 10:13:22.717366+00	\N	\N
ab510597-9ec2-4485-b45d-54d6ff658595	2024-11-28 10:13:22.732984+00	2024-11-28 10:13:22.736853+00	a966413a-2fe4-48b3-bef8-05253680fac8	Notifications::WorkflowJob	default	{"job_id": "a966413a-2fe4-48b3-bef8-05253680fac8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.731179554Z", "scheduled_at": "2024-11-28T10:13:22.731025653Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.731025+00	2024-11-28 10:13:22.736635+00	\N	\N
afcd0d9d-6b21-4bbc-b379-7c3d47b31e4f	2024-11-28 10:13:22.784604+00	2024-11-28 10:13:22.790204+00	66bcf7a2-2fd8-4981-ac3c-c6df7fe67456	Journals::CompletedJob	default	{"job_id": "66bcf7a2-2fd8-4981-ac3c-c6df7fe67456", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-11-28T10:08:22.746200000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.782214327Z", "scheduled_at": "2024-11-28T10:13:22.782060356Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.78206+00	2024-11-28 10:13:22.790075+00	\N	\N
4783337a-0f48-432e-bbb3-0d9c1f2d7681	2024-11-28 10:13:22.663312+00	2024-11-28 10:13:22.670697+00	dc2dfe42-a1a3-4b1f-86c3-02097d816499	Journals::CompletedJob	default	{"job_id": "dc2dfe42-a1a3-4b1f-86c3-02097d816499", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-11-28T10:08:22.642994000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.661187155Z", "scheduled_at": "2024-11-28T10:13:22.660315659Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.660315+00	2024-11-28 10:13:22.670531+00	\N	\N
780572fd-2335-4c4f-a2fe-de13d96b1adb	2024-11-28 10:13:22.703555+00	2024-11-28 10:13:22.709011+00	06cb6d4c-a230-460a-b7f0-6001c5a5660e	Notifications::WorkflowJob	default	{"job_id": "06cb6d4c-a230-460a-b7f0-6001c5a5660e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.701916701Z", "scheduled_at": "2024-11-28T10:13:22.701254541Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.701254+00	2024-11-28 10:13:22.708793+00	\N	\N
fcb742e2-cb63-442d-9d60-fe52b530db10	2024-11-28 10:13:22.740478+00	2024-11-28 10:13:22.750731+00	bf66b7df-5ad1-41ee-a1de-2d494480fa73	Journals::CompletedJob	default	{"job_id": "bf66b7df-5ad1-41ee-a1de-2d494480fa73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-11-28T10:08:22.718327000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.737098740Z", "scheduled_at": "2024-11-28T10:13:22.736929480Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.736929+00	2024-11-28 10:13:22.750509+00	\N	\N
d209376c-f6dc-44b2-a6f9-c9b92a60ca21	2024-11-28 10:13:22.778729+00	2024-11-28 10:13:22.783656+00	3e060bc6-cff8-4700-b9ec-135314beb919	Notifications::WorkflowJob	default	{"job_id": "3e060bc6-cff8-4700-b9ec-135314beb919", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.776741965Z", "scheduled_at": "2024-11-28T10:13:22.775635455Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.775635+00	2024-11-28 10:13:22.783511+00	\N	\N
f8d55582-5768-4333-9923-222d2caea1a1	2024-11-28 10:13:22.813488+00	2024-11-28 10:13:22.821543+00	cb22cdab-a8c6-4811-af35-70e4a5231d17	Journals::CompletedJob	default	{"job_id": "cb22cdab-a8c6-4811-af35-70e4a5231d17", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-11-28T10:08:22.792691000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.810424743Z", "scheduled_at": "2024-11-28T10:13:22.809922024Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.809921+00	2024-11-28 10:13:22.821376+00	\N	\N
b59ebef9-af77-4826-90c0-6642ebba509e	2024-11-28 10:13:22.849273+00	2024-11-28 10:13:22.854203+00	c8bfea28-d84a-4621-a035-162f173e6999	Notifications::WorkflowJob	default	{"job_id": "c8bfea28-d84a-4621-a035-162f173e6999", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.847194993Z", "scheduled_at": "2024-11-28T10:13:22.847068835Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.847069+00	2024-11-28 10:13:22.854044+00	\N	\N
5a6dfdc2-e6ff-41fe-ad3c-0d4a86929540	2024-11-28 10:13:22.806879+00	2024-11-28 10:13:22.811857+00	e4b0cb0f-907c-4f8f-94ac-b47f674b37f8	Notifications::WorkflowJob	default	{"job_id": "e4b0cb0f-907c-4f8f-94ac-b47f674b37f8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.805384767Z", "scheduled_at": "2024-11-28T10:13:22.804955857Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.804955+00	2024-11-28 10:13:22.81167+00	\N	\N
52500736-e38e-4dd3-9b2c-3e5672e152c6	2024-11-28 10:13:22.854615+00	2024-11-28 10:13:22.860881+00	a6f08055-5ef2-4d8b-9eea-b105689818b5	Journals::CompletedJob	default	{"job_id": "a6f08055-5ef2-4d8b-9eea-b105689818b5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-11-28T10:08:22.818407000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.851392739Z", "scheduled_at": "2024-11-28T10:13:22.851238388Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.851238+00	2024-11-28 10:13:22.860737+00	\N	\N
68d57fac-6d89-4342-9f6b-81645efa1c54	2024-11-28 10:13:22.872866+00	2024-11-28 10:13:22.878065+00	45b9c960-7896-44c7-8ce0-e51e664639fd	Notifications::WorkflowJob	default	{"job_id": "45b9c960-7896-44c7-8ce0-e51e664639fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.870532979Z", "scheduled_at": "2024-11-28T10:13:22.870412441Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.870412+00	2024-11-28 10:13:22.877888+00	\N	\N
f61852a2-d9a8-4ffb-8bb0-9341e021424d	2024-11-28 10:13:22.914026+00	2024-11-28 10:13:22.920943+00	93adb768-e228-4f4b-8677-165a8c17dc88	Journals::CompletedJob	default	{"job_id": "93adb768-e228-4f4b-8677-165a8c17dc88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-11-28T10:08:22.885644000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.910590846Z", "scheduled_at": "2024-11-28T10:13:22.910446704Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.910446+00	2024-11-28 10:13:22.920749+00	\N	\N
266e8a0e-ca16-4907-a5e6-9351f35d61aa	2024-11-28 10:13:22.927319+00	2024-11-28 10:13:22.931199+00	b54a19de-5bb9-48da-ae99-e0b2eb7cd704	Notifications::WorkflowJob	default	{"job_id": "b54a19de-5bb9-48da-ae99-e0b2eb7cd704", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.925464129Z", "scheduled_at": "2024-11-28T10:13:22.925297024Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.925297+00	2024-11-28 10:13:22.931049+00	\N	\N
a8b5a267-a88e-4bb1-8818-172ba49558dc	2024-11-28 10:13:22.962621+00	2024-11-28 10:13:22.971011+00	559f0657-5d39-458d-827d-c308a8b86b83	Journals::CompletedJob	default	{"job_id": "559f0657-5d39-458d-827d-c308a8b86b83", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-11-28T10:08:22.933187000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.958561644Z", "scheduled_at": "2024-11-28T10:13:22.958384470Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.958384+00	2024-11-28 10:13:22.970839+00	\N	\N
96de7542-acb7-4407-ba1a-99ee0c0dbf9a	2024-11-28 10:13:22.880028+00	2024-11-28 10:13:22.890289+00	53cf632f-842f-4142-85f2-3ff37807d20f	Journals::CompletedJob	default	{"job_id": "53cf632f-842f-4142-85f2-3ff37807d20f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-11-28T10:08:22.859774000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.876793009Z", "scheduled_at": "2024-11-28T10:13:22.876509704Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.876509+00	2024-11-28 10:13:22.890131+00	\N	\N
bb1536a1-d82c-47ae-af57-80a2f02295e0	2024-11-28 10:13:22.909407+00	2024-11-28 10:13:22.917401+00	926158a2-5b83-407a-abf7-5642092392f0	Notifications::WorkflowJob	default	{"job_id": "926158a2-5b83-407a-abf7-5642092392f0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.906573691Z", "scheduled_at": "2024-11-28T10:13:22.906431993Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.906431+00	2024-11-28 10:13:22.917266+00	\N	\N
ed4f9a9e-03b7-4ce1-ae39-a4cec930aff7	2024-11-28 10:13:22.932228+00	2024-11-28 10:13:22.940753+00	6f96efce-89d1-4307-8608-552d0d3e424d	Journals::CompletedJob	default	{"job_id": "6f96efce-89d1-4307-8608-552d0d3e424d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-11-28T10:08:22.916636000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.928876602Z", "scheduled_at": "2024-11-28T10:13:22.928733612Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.928733+00	2024-11-28 10:13:22.940582+00	\N	\N
6f42308b-1036-46f1-8a32-47552c0682d2	2024-11-28 10:13:22.957391+00	2024-11-28 10:13:22.967059+00	8f6b0879-5dd3-4225-aa52-29ef8dff7030	Notifications::WorkflowJob	default	{"job_id": "8f6b0879-5dd3-4225-aa52-29ef8dff7030", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.954450471Z", "scheduled_at": "2024-11-28T10:13:22.954294326Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.954294+00	2024-11-28 10:13:22.966851+00	\N	\N
c589ed5c-cf1c-426e-8236-255d20e86721	2024-11-28 10:13:22.976871+00	2024-11-28 10:13:22.984095+00	4a8af9e7-371c-4f10-bfa8-ab548408f9fa	Notifications::WorkflowJob	default	{"job_id": "4a8af9e7-371c-4f10-bfa8-ab548408f9fa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.973335039Z", "scheduled_at": "2024-11-28T10:13:22.972885700Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.972885+00	2024-11-28 10:13:22.983936+00	\N	\N
7f0c2cab-cb1a-4b88-91ad-6b423ec8e7b3	2024-11-28 10:13:23.144109+00	2024-11-28 10:13:23.149578+00	c7e70ff4-608b-479e-8447-4f56127cb007	Notifications::WorkflowJob	default	{"job_id": "c7e70ff4-608b-479e-8447-4f56127cb007", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.140861120Z", "scheduled_at": "2024-11-28T10:13:23.140659098Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:23.140659+00	2024-11-28 10:13:23.149425+00	\N	\N
7c52720a-4356-4277-b4b5-6b70b10b12dd	2024-11-28 10:13:27.099926+00	2024-11-28 10:13:27.192601+00	ea221efe-238b-448c-9e62-ef838f6dbef7	Notifications::WorkflowJob	default	{"job_id": "ea221efe-238b-448c-9e62-ef838f6dbef7", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/47"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:13:27.047755060Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:27.061613+00	2024-11-28 10:13:27.192422+00	\N	\N
ea3a7c5b-996f-4ae3-bf35-855717598ed1	2024-11-29 02:03:05.589738+00	2024-11-29 02:03:05.633775+00	312c2f5a-c961-4be9-bf04-ec248fe7c7b1	Notifications::WorkflowJob	default	{"job_id": "312c2f5a-c961-4be9-bf04-ec248fe7c7b1", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:13:27.174342986Z", "scheduled_at": "2024-11-28T10:18:27.169188350Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:18:27.169188+00	2024-11-29 02:03:05.633076+00	\N	\N
\.


--
-- Data for Name: good_job_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.good_job_processes (id, created_at, updated_at, state) FROM stdin;
918bbed3-43df-46dc-9719-dac0b6596670	2024-12-11 09:57:41.76076+00	2024-12-11 09:59:11.977738+00	{"id": "918bbed3-43df-46dc-9719-dac0b6596670", "pid": 135, "hostname": "348fe5da32a5", "proctitle": "/app/vendor/bundle/ruby/3.3.0/bin/good_job", "schedulers": [{"name": "GoodJob::Scheduler(queues=* max_threads=20)", "queues": "*", "max_cache": 10000, "max_threads": 20, "active_cache": 0, "execution_at": null, "active_threads": 0, "check_queue_at": "2024-12-11T09:59:11.705Z", "available_cache": 10000, "available_threads": 20, "empty_executions_count": 10, "total_executions_count": 0, "errored_executions_count": 0, "succeeded_executions_count": 0}], "cron_enabled": true, "preserve_job_records": true, "total_executions_count": 0, "database_connection_pool": {"size": 17, "active": 1}, "retry_on_unhandled_error": false, "total_empty_executions_count": 10, "total_errored_executions_count": 0, "total_succeeded_executions_count": 0}
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
df788a12-0725-47b4-b728-8b63d724b965	default	10	{"job_id": "df788a12-0725-47b4-b728-8b63d724b965", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [], "job_class": "WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob", "executions": 1, "queue_name": "default", "enqueued_at": "2024-11-28T10:09:05.234905491Z", "scheduled_at": "2024-11-28T10:14:05.233999090Z", "provider_job_id": "df788a12-0725-47b4-b728-8b63d724b965", "exception_executions": {"[GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError]": 1}}	2024-11-28 10:14:05.233999+00	2024-11-28 10:14:05.236377+00	2024-11-28 10:14:05.264017+00	\N	2024-11-28 10:07:52.045905+00	2024-11-28 10:14:05.265525+00	df788a12-0725-47b4-b728-8b63d724b965	WorkPackagesProgressJob	\N	\N	\N	\N	\N	t	2	WorkPackages::Progress::MigrateRemoveTotalsFromChildlessWorkPackagesJob	\N	\N
28e838db-0518-4c18-942a-d78d730c417a	default	0	{"job_id": "28e838db-0518-4c18-942a-d78d730c417a", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleDateAlertsNotificationsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:00.054503982Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:00.055567+00	2024-11-28 10:15:00.065668+00	2024-11-28 10:15:00.12984+00	\N	2024-11-28 10:15:00.055567+00	2024-11-28 10:15:00.131059+00	28e838db-0518-4c18-942a-d78d730c417a	Notifications::ScheduleDateAlertsNotificationsJob	Notifications::ScheduleDateAlertsNotificationsJob	\N	2024-11-28 10:15:00+00	\N	\N	t	1	Notifications::ScheduleDateAlertsNotificationsJob	\N	\N
6a5de249-cc6b-42c4-984a-9fb1524da851	default	5	{"job_id": "6a5de249-cc6b-42c4-984a-9fb1524da851", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/1"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.171463573Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.201477+00	2024-11-28 10:08:19.208474+00	2024-11-28 10:08:19.259844+00	\N	2024-11-28 10:08:19.201477+00	2024-11-28 10:08:19.263564+00	6a5de249-cc6b-42c4-984a-9fb1524da851	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
aaf182c1-1352-48c5-8d2d-8751611186c2	default	10	{"job_id": "aaf182c1-1352-48c5-8d2d-8751611186c2", "locale": "en", "priority": 10, "timezone": "UTC", "arguments": [{"current_mode": "field", "previous_mode": null, "_aj_ruby2_keywords": ["current_mode", "previous_mode"]}], "job_class": "WorkPackages::Progress::MigrateValuesJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:07:51.916751975Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:07:51.95534+00	2024-11-28 10:09:05.160788+00	2024-11-28 10:09:05.242915+00	\N	2024-11-28 10:07:51.95534+00	2024-11-28 10:09:05.261133+00	aaf182c1-1352-48c5-8d2d-8751611186c2	WorkPackagesProgressJob	\N	\N	\N	\N	\N	t	1	WorkPackages::Progress::MigrateValuesJob	\N	\N
5953e60d-2946-4ce6-94b7-6b9bdd25c4a2	default	0	{"job_id": "5953e60d-2946-4ce6-94b7-6b9bdd25c4a2", "locale": "en", "priority": null, "timezone": "UTC", "arguments": [], "job_class": "Notifications::ScheduleReminderMailsJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:00.031899164Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:00.034662+00	2024-11-28 10:15:00.05125+00	2024-11-28 10:15:00.118559+00	\N	2024-11-28 10:15:00.034662+00	2024-11-28 10:15:00.120039+00	5953e60d-2946-4ce6-94b7-6b9bdd25c4a2	Notifications::ScheduleReminderMailsJob	Notifications::ScheduleReminderMailsJob	\N	2024-11-28 10:15:00+00	\N	\N	t	1	Notifications::ScheduleReminderMailsJob	\N	\N
910015e2-65d2-4cf6-9c89-a4e99abe5745	default	5	{"job_id": "910015e2-65d2-4cf6-9c89-a4e99abe5745", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/2"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.322889817Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.323888+00	2024-11-28 10:08:19.326187+00	2024-11-28 10:08:19.347016+00	\N	2024-11-28 10:08:19.323888+00	2024-11-28 10:08:19.348246+00	910015e2-65d2-4cf6-9c89-a4e99abe5745	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9336b705-5d15-4514-9ea3-552a1863836c	default	5	{"job_id": "9336b705-5d15-4514-9ea3-552a1863836c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.255518477Z", "scheduled_at": "2024-11-28T10:13:19.254078748Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.254078+00	2024-11-28 10:13:19.261592+00	2024-11-28 10:13:19.32345+00	\N	2024-11-28 10:08:19.257136+00	2024-11-28 10:13:19.331369+00	9336b705-5d15-4514-9ea3-552a1863836c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ea221efe-238b-448c-9e62-ef838f6dbef7	default	5	{"job_id": "ea221efe-238b-448c-9e62-ef838f6dbef7", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/47"}, true], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:13:27.047755060Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:27.061613+00	2024-11-28 10:13:27.099926+00	2024-11-28 10:13:27.192422+00	\N	2024-11-28 10:13:27.061613+00	2024-11-28 10:13:27.193646+00	ea221efe-238b-448c-9e62-ef838f6dbef7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a7641a84-5044-4e4e-8502-4518cde0de71	default	5	{"job_id": "a7641a84-5044-4e4e-8502-4518cde0de71", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.344398700Z", "scheduled_at": "2024-11-28T10:13:19.344213210Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.344213+00	2024-11-28 10:13:19.359091+00	2024-11-28 10:13:19.370723+00	\N	2024-11-28 10:08:19.344722+00	2024-11-28 10:13:19.373864+00	a7641a84-5044-4e4e-8502-4518cde0de71	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
34e215ca-038a-4c4f-807a-9d18374ba5aa	default	5	{"job_id": "34e215ca-038a-4c4f-807a-9d18374ba5aa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [2, {"value": "2024-11-28T10:08:19.299321000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.351585972Z", "scheduled_at": "2024-11-28T10:13:19.350400584Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.3504+00	2024-11-28 10:13:19.362427+00	2024-11-28 10:13:19.397737+00	\N	2024-11-28 10:08:19.352033+00	2024-11-28 10:13:19.400039+00	34e215ca-038a-4c4f-807a-9d18374ba5aa	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
77803450-e315-4fc3-9823-1525b08af5e7	default	5	{"job_id": "77803450-e315-4fc3-9823-1525b08af5e7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.642654921Z", "scheduled_at": "2024-11-28T10:13:19.642401733Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.642401+00	2024-11-28 10:13:19.667333+00	2024-11-28 10:13:19.702198+00	\N	2024-11-28 10:08:19.642862+00	2024-11-28 10:13:19.707094+00	77803450-e315-4fc3-9823-1525b08af5e7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
579e5b7a-05e5-4f4d-a113-9b8833029d02	default	5	{"job_id": "579e5b7a-05e5-4f4d-a113-9b8833029d02", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/3"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.504291392Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.504598+00	2024-11-28 10:08:19.506375+00	2024-11-28 10:08:19.51907+00	\N	2024-11-28 10:08:19.504598+00	2024-11-28 10:08:19.520031+00	579e5b7a-05e5-4f4d-a113-9b8833029d02	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b120cf5d-58b8-43a2-8691-ec8ce62349b4	default	5	{"job_id": "b120cf5d-58b8-43a2-8691-ec8ce62349b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.614073183Z", "scheduled_at": "2024-11-28T10:13:19.613795979Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.613795+00	2024-11-28 10:13:19.617265+00	2024-11-28 10:13:19.641148+00	\N	2024-11-28 10:08:19.614293+00	2024-11-28 10:13:19.66224+00	b120cf5d-58b8-43a2-8691-ec8ce62349b4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1e73ff2b-1ccb-4b14-9601-6fdb5c89eca4	default	5	{"job_id": "1e73ff2b-1ccb-4b14-9601-6fdb5c89eca4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.517510372Z", "scheduled_at": "2024-11-28T10:13:19.517326184Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.517326+00	2024-11-28 10:13:19.528684+00	2024-11-28 10:13:19.557618+00	\N	2024-11-28 10:08:19.517724+00	2024-11-28 10:13:19.56505+00	1e73ff2b-1ccb-4b14-9601-6fdb5c89eca4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3e918815-9401-49ca-91ef-1f876e33399e	default	0	{"job_id": "3e918815-9401-49ca-91ef-1f876e33399e", "locale": "en", "priority": 0, "timezone": "Etc/UTC", "arguments": [{"_aj_globalid": "gid://open-project/Token::Invitation/2"}], "job_class": "Mails::InvitationJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:15:07.098727186Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:07.099083+00	2024-11-28 10:15:07.107265+00	2024-11-28 10:15:07.141416+00	\N	2024-11-28 10:15:07.099083+00	2024-11-28 10:15:07.14264+00	3e918815-9401-49ca-91ef-1f876e33399e	\N	\N	\N	\N	\N	\N	t	1	Mails::InvitationJob	\N	\N
ef554d33-db3b-4c96-9129-b668ae734776	default	5	{"job_id": "ef554d33-db3b-4c96-9129-b668ae734776", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.602218318Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.602472+00	2024-11-28 10:08:19.604237+00	2024-11-28 10:08:19.615612+00	\N	2024-11-28 10:08:19.602472+00	2024-11-28 10:08:19.616449+00	ef554d33-db3b-4c96-9129-b668ae734776	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a305feb0-f86b-4e6e-8ab3-2b8c2d4953e1	default	5	{"job_id": "a305feb0-f86b-4e6e-8ab3-2b8c2d4953e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [3, {"value": "2024-11-28T10:08:19.493076000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.522559715Z", "scheduled_at": "2024-11-28T10:13:19.521964201Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.521964+00	2024-11-28 10:13:19.543488+00	2024-11-28 10:13:19.574179+00	\N	2024-11-28 10:08:19.522969+00	2024-11-28 10:13:19.579023+00	a305feb0-f86b-4e6e-8ab3-2b8c2d4953e1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
235c38b8-c5a0-4d19-ad9d-4354f736f84b	mailers	0	{"job_id": "235c38b8-c5a0-4d19-ad9d-4354f736f84b", "locale": "en", "priority": null, "timezone": "UTC", "arguments": ["UserMailer", "account_information", "deliver_now", {"args": [{"_aj_globalid": "gid://open-project/User/5"}, "1234567890n"], "_aj_ruby2_keywords": ["args"]}], "job_class": "Mails::MailerJob", "executions": 0, "queue_name": "mailers", "enqueued_at": "2024-11-28T10:15:46.000626568Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:46.000904+00	2024-11-28 10:15:46.008217+00	2024-11-28 10:15:46.109307+00	\N	2024-11-28 10:15:46.000904+00	2024-11-28 10:15:46.111558+00	235c38b8-c5a0-4d19-ad9d-4354f736f84b	\N	\N	\N	\N	\N	\N	t	1	Mails::MailerJob	\N	\N
312c2f5a-c961-4be9-bf04-ec248fe7c7b1	default	5	{"job_id": "312c2f5a-c961-4be9-bf04-ec248fe7c7b1", "locale": "en", "priority": 5, "timezone": "Etc/UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:13:27.174342986Z", "scheduled_at": "2024-11-28T10:18:27.169188350Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:18:27.169188+00	2024-11-29 02:03:05.589738+00	2024-11-29 02:03:05.633076+00	\N	2024-11-28 10:13:27.179652+00	2024-11-29 02:03:05.640228+00	312c2f5a-c961-4be9-bf04-ec248fe7c7b1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4ccab370-2993-4f69-864c-17090eab9310	default	5	{"job_id": "4ccab370-2993-4f69-864c-17090eab9310", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-11-28T10:08:19.556742000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.618501264Z", "scheduled_at": "2024-11-28T10:13:19.618270919Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.61827+00	2024-11-28 10:13:19.625111+00	2024-11-28 10:13:19.673134+00	\N	2024-11-28 10:08:19.618725+00	2024-11-28 10:13:19.687043+00	4ccab370-2993-4f69-864c-17090eab9310	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
99314b7f-4def-470e-8515-ccc00045b573	default	5	{"job_id": "99314b7f-4def-470e-8515-ccc00045b573", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/4"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.632559910Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.632913+00	2024-11-28 10:08:19.634801+00	2024-11-28 10:08:19.644199+00	\N	2024-11-28 10:08:19.632913+00	2024-11-28 10:08:19.645155+00	99314b7f-4def-470e-8515-ccc00045b573	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
995cd400-1f7e-409e-a584-cd1358546187	mailers	0	{"job_id": "995cd400-1f7e-409e-a584-cd1358546187", "locale": "en", "priority": null, "timezone": "Etc/UTC", "arguments": ["UserMailer", "user_signed_up", "deliver_now", {"args": [{"_aj_globalid": "gid://open-project/Token::Invitation/2"}], "_aj_ruby2_keywords": ["args"]}], "job_class": "Mails::MailerJob", "executions": 0, "queue_name": "mailers", "enqueued_at": "2024-11-28T10:15:07.135309847Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:15:07.135799+00	2024-11-28 10:15:07.146261+00	2024-11-28 10:15:07.340463+00	\N	2024-11-28 10:15:07.135799+00	2024-11-28 10:15:07.341681+00	995cd400-1f7e-409e-a584-cd1358546187	\N	\N	\N	\N	\N	\N	t	1	Mails::MailerJob	\N	\N
504f3d7e-31b6-461c-a6a5-1428217eecc5	default	5	{"job_id": "504f3d7e-31b6-461c-a6a5-1428217eecc5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-11-28T10:08:19.656300000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.682138955Z", "scheduled_at": "2024-11-28T10:13:19.681920322Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.68192+00	2024-11-28 10:13:19.809157+00	2024-11-28 10:13:19.874513+00	\N	2024-11-28 10:08:19.682314+00	2024-11-28 10:13:19.898901+00	504f3d7e-31b6-461c-a6a5-1428217eecc5	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
9ae0c369-7b71-4f6e-b1b5-3beb81fcba79	default	5	{"job_id": "9ae0c369-7b71-4f6e-b1b5-3beb81fcba79", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.666467153Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.666675+00	2024-11-28 10:08:19.668061+00	2024-11-28 10:08:19.679467+00	\N	2024-11-28 10:08:19.666675+00	2024-11-28 10:08:19.680513+00	9ae0c369-7b71-4f6e-b1b5-3beb81fcba79	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3a300915-cb77-4436-b1f5-856659bece0e	default	5	{"job_id": "3a300915-cb77-4436-b1f5-856659bece0e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:19.688230000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.713411443Z", "scheduled_at": "2024-11-28T10:13:19.713204122Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.713204+00	2024-11-28 10:13:19.87282+00	2024-11-28 10:13:19.982801+00	\N	2024-11-28 10:08:19.713583+00	2024-11-28 10:13:19.996672+00	3a300915-cb77-4436-b1f5-856659bece0e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d0b6934a-235b-4ee6-8036-99c02091c76e	default	5	{"job_id": "d0b6934a-235b-4ee6-8036-99c02091c76e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.676813149Z", "scheduled_at": "2024-11-28T10:13:19.676636585Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.676636+00	2024-11-28 10:13:19.715213+00	2024-11-28 10:13:19.819058+00	\N	2024-11-28 10:08:19.677516+00	2024-11-28 10:13:19.837464+00	d0b6934a-235b-4ee6-8036-99c02091c76e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9a6b6818-a0b6-4b28-a428-92665805d136	default	5	{"job_id": "9a6b6818-a0b6-4b28-a428-92665805d136", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.698379931Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.69864+00	2024-11-28 10:08:19.699944+00	2024-11-28 10:08:19.711176+00	\N	2024-11-28 10:08:19.69864+00	2024-11-28 10:08:19.712102+00	9a6b6818-a0b6-4b28-a428-92665805d136	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8a47d6bd-d452-43b3-93dd-46b18970f3b8	default	5	{"job_id": "8a47d6bd-d452-43b3-93dd-46b18970f3b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [4, {"value": "2024-11-28T10:08:19.630954000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.647397075Z", "scheduled_at": "2024-11-28T10:13:19.647049879Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.647049+00	2024-11-28 10:13:19.693353+00	2024-11-28 10:13:19.821385+00	\N	2024-11-28 10:08:19.64759+00	2024-11-28 10:13:19.840428+00	8a47d6bd-d452-43b3-93dd-46b18970f3b8	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
608afb52-b229-4029-90da-83b7964befee	default	5	{"job_id": "608afb52-b229-4029-90da-83b7964befee", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.707989136Z", "scheduled_at": "2024-11-28T10:13:19.707817952Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.707818+00	2024-11-28 10:13:19.831187+00	2024-11-28 10:13:19.881899+00	\N	2024-11-28 10:08:19.708186+00	2024-11-28 10:13:19.903118+00	608afb52-b229-4029-90da-83b7964befee	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a7fa572b-a26c-4dec-841d-0c59ff9c9741	default	5	{"job_id": "a7fa572b-a26c-4dec-841d-0c59ff9c9741", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.717776000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.746030956Z", "scheduled_at": "2024-11-28T10:13:19.745818364Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.745818+00	2024-11-28 10:13:19.885542+00	2024-11-28 10:13:19.986474+00	\N	2024-11-28 10:08:19.746201+00	2024-11-28 10:13:19.998977+00	a7fa572b-a26c-4dec-841d-0c59ff9c9741	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
bddb2dd2-1ac0-45e0-a08e-63832bb744a4	default	5	{"job_id": "bddb2dd2-1ac0-45e0-a08e-63832bb744a4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.730481496Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.730849+00	2024-11-28 10:08:19.732408+00	2024-11-28 10:08:19.74384+00	\N	2024-11-28 10:08:19.730849+00	2024-11-28 10:08:19.744681+00	bddb2dd2-1ac0-45e0-a08e-63832bb744a4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
728ee2bb-032c-41ec-89b9-86c22619d68c	default	5	{"job_id": "728ee2bb-032c-41ec-89b9-86c22619d68c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.742374512Z", "scheduled_at": "2024-11-28T10:13:19.742200453Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.7422+00	2024-11-28 10:13:19.880808+00	2024-11-28 10:13:19.957973+00	\N	2024-11-28 10:08:19.742572+00	2024-11-28 10:13:19.987601+00	728ee2bb-032c-41ec-89b9-86c22619d68c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8fe5f71e-6aa8-40b3-a7a0-958ac6621bcf	default	5	{"job_id": "8fe5f71e-6aa8-40b3-a7a0-958ac6621bcf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.756327920Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.756545+00	2024-11-28 10:08:19.757997+00	2024-11-28 10:08:19.766344+00	\N	2024-11-28 10:08:19.756545+00	2024-11-28 10:08:19.767267+00	8fe5f71e-6aa8-40b3-a7a0-958ac6621bcf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1382dbf0-1392-48a8-8e19-a58615ed6c02	default	5	{"job_id": "1382dbf0-1392-48a8-8e19-a58615ed6c02", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.764407705Z", "scheduled_at": "2024-11-28T10:13:19.764081189Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.764081+00	2024-11-28 10:13:19.89198+00	2024-11-28 10:13:19.980154+00	\N	2024-11-28 10:08:19.764707+00	2024-11-28 10:13:19.99571+00	1382dbf0-1392-48a8-8e19-a58615ed6c02	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1d0d03f8-aaeb-4231-934a-75df9b432e78	default	5	{"job_id": "1d0d03f8-aaeb-4231-934a-75df9b432e78", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.755064000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.768608057Z", "scheduled_at": "2024-11-28T10:13:19.768394323Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.768394+00	2024-11-28 10:13:19.97037+00	2024-11-28 10:13:20.060321+00	\N	2024-11-28 10:08:19.768779+00	2024-11-28 10:13:20.083124+00	1d0d03f8-aaeb-4231-934a-75df9b432e78	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c7258cac-0c13-4ae6-8195-6698f5c273ae	default	5	{"job_id": "c7258cac-0c13-4ae6-8195-6698f5c273ae", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/7"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.796527424Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.796734+00	2024-11-28 10:08:19.798572+00	2024-11-28 10:08:19.807896+00	\N	2024-11-28 10:08:19.796734+00	2024-11-28 10:08:19.80883+00	c7258cac-0c13-4ae6-8195-6698f5c273ae	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
91427481-2090-4663-9b8a-9832b8f75b34	default	5	{"job_id": "91427481-2090-4663-9b8a-9832b8f75b34", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.836376187Z", "scheduled_at": "2024-11-28T10:13:19.836209322Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.836209+00	2024-11-28 10:13:20.000171+00	2024-11-28 10:13:20.074795+00	\N	2024-11-28 10:08:19.83658+00	2024-11-28 10:13:20.099468+00	91427481-2090-4663-9b8a-9832b8f75b34	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1ed30a2b-9f7c-4fa2-a55f-b9475a27a880	default	5	{"job_id": "1ed30a2b-9f7c-4fa2-a55f-b9475a27a880", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.827581019Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.82779+00	2024-11-28 10:08:19.829551+00	2024-11-28 10:08:19.838181+00	\N	2024-11-28 10:08:19.82779+00	2024-11-28 10:08:19.839819+00	1ed30a2b-9f7c-4fa2-a55f-b9475a27a880	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
329554e7-847d-406f-9ca0-0cdef96647b3	default	5	{"job_id": "329554e7-847d-406f-9ca0-0cdef96647b3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [7, {"value": "2024-11-28T10:08:19.776038000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.810618732Z", "scheduled_at": "2024-11-28T10:13:19.810407123Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.810407+00	2024-11-28 10:13:19.984606+00	2024-11-28 10:13:20.103959+00	\N	2024-11-28 10:08:19.810789+00	2024-11-28 10:13:20.13122+00	329554e7-847d-406f-9ca0-0cdef96647b3	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
53b39c32-7892-4ebc-80d4-9ad4627bd6e3	default	5	{"job_id": "53b39c32-7892-4ebc-80d4-9ad4627bd6e3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.851814057Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.852206+00	2024-11-28 10:08:19.853821+00	2024-11-28 10:08:19.862006+00	\N	2024-11-28 10:08:19.852206+00	2024-11-28 10:08:19.862837+00	53b39c32-7892-4ebc-80d4-9ad4627bd6e3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f4a004b6-1aa2-4411-a4bb-b9b1feea22d3	default	5	{"job_id": "f4a004b6-1aa2-4411-a4bb-b9b1feea22d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.805315548Z", "scheduled_at": "2024-11-28T10:13:19.805108647Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.805108+00	2024-11-28 10:13:19.97265+00	2024-11-28 10:13:20.033535+00	\N	2024-11-28 10:08:19.805542+00	2024-11-28 10:13:20.058875+00	f4a004b6-1aa2-4411-a4bb-b9b1feea22d3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2c5ee105-fa0d-499f-95b3-16c2d7accf2a	default	5	{"job_id": "2c5ee105-fa0d-499f-95b3-16c2d7accf2a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.860451507Z", "scheduled_at": "2024-11-28T10:13:19.860175987Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.860175+00	2024-11-28 10:13:19.989888+00	2024-11-28 10:13:20.044827+00	\N	2024-11-28 10:08:19.860667+00	2024-11-28 10:13:20.072679+00	2c5ee105-fa0d-499f-95b3-16c2d7accf2a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
aa00c5f9-fd2e-4bf9-b3ac-e8d7da6302a7	default	5	{"job_id": "aa00c5f9-fd2e-4bf9-b3ac-e8d7da6302a7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.816175000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.841512867Z", "scheduled_at": "2024-11-28T10:13:19.841284255Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.841284+00	2024-11-28 10:13:20.002124+00	2024-11-28 10:13:20.111895+00	\N	2024-11-28 10:08:19.841698+00	2024-11-28 10:13:20.139499+00	aa00c5f9-fd2e-4bf9-b3ac-e8d7da6302a7	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
fb725e59-cd2e-459a-a017-6ec8166207cb	default	5	{"job_id": "fb725e59-cd2e-459a-a017-6ec8166207cb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.867761000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.892901189Z", "scheduled_at": "2024-11-28T10:13:19.892688417Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.892688+00	2024-11-28 10:13:20.006886+00	2024-11-28 10:13:20.163286+00	\N	2024-11-28 10:08:19.893253+00	2024-11-28 10:13:20.184193+00	fb725e59-cd2e-459a-a017-6ec8166207cb	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d72f48bf-4d19-4c7e-a9a2-37fc578495b7	default	5	{"job_id": "d72f48bf-4d19-4c7e-a9a2-37fc578495b7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/8"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.879953940Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.880153+00	2024-11-28 10:08:19.88227+00	2024-11-28 10:08:19.890938+00	\N	2024-11-28 10:08:19.880153+00	2024-11-28 10:08:19.891733+00	d72f48bf-4d19-4c7e-a9a2-37fc578495b7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2b619adb-a578-4c33-af8a-9e8659d25db1	default	5	{"job_id": "2b619adb-a578-4c33-af8a-9e8659d25db1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.907381771Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.907697+00	2024-11-28 10:08:19.908874+00	2024-11-28 10:08:19.918218+00	\N	2024-11-28 10:08:19.907697+00	2024-11-28 10:08:19.919169+00	2b619adb-a578-4c33-af8a-9e8659d25db1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9870d739-9f00-4062-81f1-65d5a3ac6c98	default	5	{"job_id": "9870d739-9f00-4062-81f1-65d5a3ac6c98", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.888939076Z", "scheduled_at": "2024-11-28T10:13:19.888753446Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.888753+00	2024-11-28 10:13:20.005094+00	2024-11-28 10:13:20.085874+00	\N	2024-11-28 10:08:19.889186+00	2024-11-28 10:13:20.109806+00	9870d739-9f00-4062-81f1-65d5a3ac6c98	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
093dee5c-6b90-4f91-b46a-a23dd07427ac	default	5	{"job_id": "093dee5c-6b90-4f91-b46a-a23dd07427ac", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.916626436Z", "scheduled_at": "2024-11-28T10:13:19.916303346Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.916303+00	2024-11-28 10:13:20.015409+00	2024-11-28 10:13:20.090649+00	\N	2024-11-28 10:08:19.916827+00	2024-11-28 10:13:20.113771+00	093dee5c-6b90-4f91-b46a-a23dd07427ac	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c202e31a-3958-4dd3-9a77-b0040627da28	default	5	{"job_id": "c202e31a-3958-4dd3-9a77-b0040627da28", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [8, {"value": "2024-11-28T10:08:19.850731000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.864429147Z", "scheduled_at": "2024-11-28T10:13:19.864171330Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.864171+00	2024-11-28 10:13:20.003442+00	2024-11-28 10:13:20.100777+00	\N	2024-11-28 10:08:19.864709+00	2024-11-28 10:13:20.123167+00	c202e31a-3958-4dd3-9a77-b0040627da28	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
21295f61-c94b-419a-948e-d01ec8471c35	default	5	{"job_id": "21295f61-c94b-419a-948e-d01ec8471c35", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.898109000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.920507424Z", "scheduled_at": "2024-11-28T10:13:19.920294562Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.920294+00	2024-11-28 10:13:20.047422+00	2024-11-28 10:13:20.15163+00	\N	2024-11-28 10:08:19.920674+00	2024-11-28 10:13:20.174144+00	21295f61-c94b-419a-948e-d01ec8471c35	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
ca3e5469-8998-4f9a-87b6-2f2022a8cbc4	default	5	{"job_id": "ca3e5469-8998-4f9a-87b6-2f2022a8cbc4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.927646134Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.927852+00	2024-11-28 10:08:19.9292+00	2024-11-28 10:08:19.939382+00	\N	2024-11-28 10:08:19.927852+00	2024-11-28 10:08:19.940657+00	ca3e5469-8998-4f9a-87b6-2f2022a8cbc4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c6427247-355f-42a0-be09-3542ee125827	default	5	{"job_id": "c6427247-355f-42a0-be09-3542ee125827", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.946665000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.980202131Z", "scheduled_at": "2024-11-28T10:13:19.979816202Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.979816+00	2024-11-28 10:13:20.067278+00	2024-11-28 10:13:20.198187+00	\N	2024-11-28 10:08:19.980441+00	2024-11-28 10:13:20.222267+00	c6427247-355f-42a0-be09-3542ee125827	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
9463443a-5858-4e24-a3c2-3f7d5b6469e1	default	5	{"job_id": "9463443a-5858-4e24-a3c2-3f7d5b6469e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/9"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.966387736Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.966583+00	2024-11-28 10:08:19.967857+00	2024-11-28 10:08:19.976994+00	\N	2024-11-28 10:08:19.966583+00	2024-11-28 10:08:19.978244+00	9463443a-5858-4e24-a3c2-3f7d5b6469e1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1f0dab6f-7b53-4efd-b8ee-110cd2d202e0	default	5	{"job_id": "1f0dab6f-7b53-4efd-b8ee-110cd2d202e0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.937542340Z", "scheduled_at": "2024-11-28T10:13:19.937208360Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.937208+00	2024-11-28 10:13:20.059352+00	2024-11-28 10:13:20.125543+00	\N	2024-11-28 10:08:19.937882+00	2024-11-28 10:13:20.152307+00	1f0dab6f-7b53-4efd-b8ee-110cd2d202e0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5c658ae5-011c-411b-80ff-e9a7a8fdb077	default	5	{"job_id": "5c658ae5-011c-411b-80ff-e9a7a8fdb077", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.975172223Z", "scheduled_at": "2024-11-28T10:13:19.974702015Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.974702+00	2024-11-28 10:13:20.063762+00	2024-11-28 10:13:20.141153+00	\N	2024-11-28 10:08:19.975384+00	2024-11-28 10:13:20.161868+00	5c658ae5-011c-411b-80ff-e9a7a8fdb077	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
69370b45-ed71-495a-8aed-42de157b1960	default	5	{"job_id": "69370b45-ed71-495a-8aed-42de157b1960", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.999556095Z", "scheduled_at": "2024-11-28T10:13:19.999379201Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.999379+00	2024-11-28 10:13:20.071296+00	2024-11-28 10:13:20.143878+00	\N	2024-11-28 10:08:19.999894+00	2024-11-28 10:13:20.166147+00	69370b45-ed71-495a-8aed-42de157b1960	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b5416020-b878-41e0-a896-8232eaee2d42	default	5	{"job_id": "b5416020-b878-41e0-a896-8232eaee2d42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [9, {"value": "2024-11-28T10:08:19.926803000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.942547020Z", "scheduled_at": "2024-11-28T10:13:19.942104885Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:19.942104+00	2024-11-28 10:13:20.045964+00	2024-11-28 10:13:20.148963+00	\N	2024-11-28 10:08:19.942768+00	2024-11-28 10:13:20.170132+00	b5416020-b878-41e0-a896-8232eaee2d42	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
309eba23-cd7b-415e-8349-98f5f67bf4b5	default	5	{"job_id": "309eba23-cd7b-415e-8349-98f5f67bf4b5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:19.990798128Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:19.991005+00	2024-11-28 10:08:19.992299+00	2024-11-28 10:08:20.001282+00	\N	2024-11-28 10:08:19.991005+00	2024-11-28 10:08:20.002443+00	309eba23-cd7b-415e-8349-98f5f67bf4b5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
05509d2b-77e2-4a91-bcac-852bfeb21028	default	5	{"job_id": "05509d2b-77e2-4a91-bcac-852bfeb21028", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:20.008764000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.051071296Z", "scheduled_at": "2024-11-28T10:13:20.049523062Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.049522+00	2024-11-28 10:13:20.155551+00	2024-11-28 10:13:20.285257+00	\N	2024-11-28 10:08:20.051346+00	2024-11-28 10:13:20.306053+00	05509d2b-77e2-4a91-bcac-852bfeb21028	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
42a17e9d-9917-46fb-8e32-affd60fd0080	default	5	{"job_id": "42a17e9d-9917-46fb-8e32-affd60fd0080", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.077159376Z", "scheduled_at": "2024-11-28T10:13:20.076996027Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.076996+00	2024-11-28 10:13:20.16908+00	2024-11-28 10:13:20.239288+00	\N	2024-11-28 10:08:20.077366+00	2024-11-28 10:13:20.263899+00	42a17e9d-9917-46fb-8e32-affd60fd0080	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e1e6fd10-0a37-40fe-af8c-ab315b5492d4	default	5	{"job_id": "e1e6fd10-0a37-40fe-af8c-ab315b5492d4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/6"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.033672474Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.03393+00	2024-11-28 10:08:20.035437+00	2024-11-28 10:08:20.046665+00	\N	2024-11-28 10:08:20.03393+00	2024-11-28 10:08:20.048315+00	e1e6fd10-0a37-40fe-af8c-ab315b5492d4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
532b536c-c661-4971-93ee-73c39aedda15	default	5	{"job_id": "532b536c-c661-4971-93ee-73c39aedda15", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.068475208Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.068687+00	2024-11-28 10:08:20.070218+00	2024-11-28 10:08:20.078838+00	\N	2024-11-28 10:08:20.068687+00	2024-11-28 10:08:20.079879+00	532b536c-c661-4971-93ee-73c39aedda15	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
745dc5c9-c393-4f11-83b0-2262b1f9a252	default	5	{"job_id": "745dc5c9-c393-4f11-83b0-2262b1f9a252", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.043926666Z", "scheduled_at": "2024-11-28T10:13:20.042541070Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.042541+00	2024-11-28 10:13:20.144654+00	2024-11-28 10:13:20.214018+00	\N	2024-11-28 10:08:20.044139+00	2024-11-28 10:13:20.23698+00	745dc5c9-c393-4f11-83b0-2262b1f9a252	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a2f73010-03ab-4f0c-9996-09825e914685	default	5	{"job_id": "a2f73010-03ab-4f0c-9996-09825e914685", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [6, {"value": "2024-11-28T10:08:19.989370000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.004763066Z", "scheduled_at": "2024-11-28T10:13:20.003971492Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.003971+00	2024-11-28 10:13:20.128293+00	2024-11-28 10:13:20.222534+00	\N	2024-11-28 10:08:20.004946+00	2024-11-28 10:13:20.248723+00	a2f73010-03ab-4f0c-9996-09825e914685	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0d52208f-8f96-48af-850c-d50f928f2103	default	5	{"job_id": "0d52208f-8f96-48af-850c-d50f928f2103", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.056157000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.082407305Z", "scheduled_at": "2024-11-28T10:13:20.081710399Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.08171+00	2024-11-28 10:13:20.179166+00	2024-11-28 10:13:20.275884+00	\N	2024-11-28 10:08:20.082609+00	2024-11-28 10:13:20.298072+00	0d52208f-8f96-48af-850c-d50f928f2103	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
a4913a70-f79d-40db-ab09-305e380b0c11	default	5	{"job_id": "a4913a70-f79d-40db-ab09-305e380b0c11", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.089449000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.104307055Z", "scheduled_at": "2024-11-28T10:13:20.104114091Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.104114+00	2024-11-28 10:13:20.192142+00	2024-11-28 10:13:20.273374+00	\N	2024-11-28 10:08:20.10448+00	2024-11-28 10:13:20.295984+00	a4913a70-f79d-40db-ab09-305e380b0c11	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
4add24bc-fe91-4d9a-a00e-4fb4775b45d3	default	5	{"job_id": "4add24bc-fe91-4d9a-a00e-4fb4775b45d3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.090692278Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.090888+00	2024-11-28 10:08:20.092301+00	2024-11-28 10:08:20.101453+00	\N	2024-11-28 10:08:20.090888+00	2024-11-28 10:08:20.102306+00	4add24bc-fe91-4d9a-a00e-4fb4775b45d3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3c7c537b-c03f-40b8-9057-839cd0be7925	default	5	{"job_id": "3c7c537b-c03f-40b8-9057-839cd0be7925", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/10"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.121896348Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.12215+00	2024-11-28 10:08:20.12353+00	2024-11-28 10:08:20.135179+00	\N	2024-11-28 10:08:20.12215+00	2024-11-28 10:08:20.136067+00	3c7c537b-c03f-40b8-9057-839cd0be7925	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
893cc023-6ac9-40b6-8bdb-20e48173ca29	default	5	{"job_id": "893cc023-6ac9-40b6-8bdb-20e48173ca29", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.099823290Z", "scheduled_at": "2024-11-28T10:13:20.099671493Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.099671+00	2024-11-28 10:13:20.183123+00	2024-11-28 10:13:20.252752+00	\N	2024-11-28 10:08:20.10002+00	2024-11-28 10:13:20.274205+00	893cc023-6ac9-40b6-8bdb-20e48173ca29	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
64009d5d-6f84-4ab5-83a2-381f67117e51	default	5	{"job_id": "64009d5d-6f84-4ab5-83a2-381f67117e51", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.132473781Z", "scheduled_at": "2024-11-28T10:13:20.132318207Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.132318+00	2024-11-28 10:13:20.200658+00	2024-11-28 10:13:20.268878+00	\N	2024-11-28 10:08:20.132672+00	2024-11-28 10:13:20.288273+00	64009d5d-6f84-4ab5-83a2-381f67117e51	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
fda85dbf-df8a-49e8-b7b8-44e7b44ffeb0	default	5	{"job_id": "fda85dbf-df8a-49e8-b7b8-44e7b44ffeb0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [10, {"value": "2024-11-28T10:08:20.107544000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.137924021Z", "scheduled_at": "2024-11-28T10:13:20.137723613Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.137723+00	2024-11-28 10:13:20.207556+00	2024-11-28 10:13:20.331312+00	\N	2024-11-28 10:08:20.1381+00	2024-11-28 10:13:20.353493+00	fda85dbf-df8a-49e8-b7b8-44e7b44ffeb0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
58c2d5ff-cfc5-45ab-8c07-a9e2d272345e	default	5	{"job_id": "58c2d5ff-cfc5-45ab-8c07-a9e2d272345e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.151301130Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.151498+00	2024-11-28 10:08:20.152709+00	2024-11-28 10:08:20.160376+00	\N	2024-11-28 10:08:20.151498+00	2024-11-28 10:08:20.161143+00	58c2d5ff-cfc5-45ab-8c07-a9e2d272345e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b3e51e63-b059-4952-9885-9657749ff740	default	5	{"job_id": "b3e51e63-b059-4952-9885-9657749ff740", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.177665932Z", "scheduled_at": "2024-11-28T10:13:20.176783897Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.176783+00	2024-11-28 10:13:20.238467+00	2024-11-28 10:13:20.315778+00	\N	2024-11-28 10:08:20.177878+00	2024-11-28 10:13:20.337032+00	b3e51e63-b059-4952-9885-9657749ff740	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bedca8e5-e5c8-4382-b254-31e3c4b9b4d8	default	5	{"job_id": "bedca8e5-e5c8-4382-b254-31e3c4b9b4d8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.169511244Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.169709+00	2024-11-28 10:08:20.170738+00	2024-11-28 10:08:20.179252+00	\N	2024-11-28 10:08:20.169709+00	2024-11-28 10:08:20.180149+00	bedca8e5-e5c8-4382-b254-31e3c4b9b4d8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e80412cf-3770-49d4-80cd-ce5cb6aa7266	default	5	{"job_id": "e80412cf-3770-49d4-80cd-ce5cb6aa7266", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/11"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.197176082Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.197427+00	2024-11-28 10:08:20.198904+00	2024-11-28 10:08:20.208142+00	\N	2024-11-28 10:08:20.197427+00	2024-11-28 10:08:20.208921+00	e80412cf-3770-49d4-80cd-ce5cb6aa7266	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
01cfb482-147b-4b07-8ec1-7ea060d408ca	default	5	{"job_id": "01cfb482-147b-4b07-8ec1-7ea060d408ca", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.158975601Z", "scheduled_at": "2024-11-28T10:13:20.158675374Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.158675+00	2024-11-28 10:13:20.225282+00	2024-11-28 10:13:20.287104+00	\N	2024-11-28 10:08:20.159176+00	2024-11-28 10:13:20.31073+00	01cfb482-147b-4b07-8ec1-7ea060d408ca	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9b778e59-4a54-4832-854f-cecaca938a2e	default	5	{"job_id": "9b778e59-4a54-4832-854f-cecaca938a2e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.206685877Z", "scheduled_at": "2024-11-28T10:13:20.206254553Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.206254+00	2024-11-28 10:13:20.246655+00	2024-11-28 10:13:20.308626+00	\N	2024-11-28 10:08:20.206946+00	2024-11-28 10:13:20.329113+00	9b778e59-4a54-4832-854f-cecaca938a2e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3d2508ba-c2f8-4011-9fe8-4dcd7f3110a6	default	5	{"job_id": "3d2508ba-c2f8-4011-9fe8-4dcd7f3110a6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.142161000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.162245615Z", "scheduled_at": "2024-11-28T10:13:20.162063702Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.162063+00	2024-11-28 10:13:20.234624+00	2024-11-28 10:13:20.312207+00	\N	2024-11-28 10:08:20.162408+00	2024-11-28 10:13:20.332901+00	3d2508ba-c2f8-4011-9fe8-4dcd7f3110a6	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3b50773a-9f6a-4684-8ed3-0a317b3772a6	default	5	{"job_id": "3b50773a-9f6a-4684-8ed3-0a317b3772a6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.168695000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.182053777Z", "scheduled_at": "2024-11-28T10:13:20.181499470Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.181499+00	2024-11-28 10:13:20.243462+00	2024-11-28 10:13:20.318858+00	\N	2024-11-28 10:08:20.182234+00	2024-11-28 10:13:20.344704+00	3b50773a-9f6a-4684-8ed3-0a317b3772a6	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e338eb54-8abd-46ae-970d-aaeb4c9deb38	default	5	{"job_id": "e338eb54-8abd-46ae-970d-aaeb4c9deb38", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-11-28T10:08:20.237479000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.259548473Z", "scheduled_at": "2024-11-28T10:13:20.259372621Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.259372+00	2024-11-28 10:13:20.322351+00	2024-11-28 10:13:20.421113+00	\N	2024-11-28 10:08:20.259712+00	2024-11-28 10:13:20.456252+00	e338eb54-8abd-46ae-970d-aaeb4c9deb38	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
bf75c872-1ff6-4d2d-8869-459fc7dea370	default	5	{"job_id": "bf75c872-1ff6-4d2d-8869-459fc7dea370", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [5, {"value": "2024-11-28T10:08:20.216647000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.232564251Z", "scheduled_at": "2024-11-28T10:13:20.232292628Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.232292+00	2024-11-28 10:13:20.299927+00	2024-11-28 10:13:20.457647+00	\N	2024-11-28 10:08:20.232738+00	2024-11-28 10:13:20.493926+00	bf75c872-1ff6-4d2d-8869-459fc7dea370	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f0eb4086-860e-4bda-a398-dd26acc1ae07	default	5	{"job_id": "f0eb4086-860e-4bda-a398-dd26acc1ae07", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/5"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.219040546Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.219246+00	2024-11-28 10:08:20.220359+00	2024-11-28 10:08:20.229501+00	\N	2024-11-28 10:08:20.219246+00	2024-11-28 10:08:20.23041+00	f0eb4086-860e-4bda-a398-dd26acc1ae07	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5239eff6-84c5-4806-95fc-dafd11b49fd1	default	5	{"job_id": "5239eff6-84c5-4806-95fc-dafd11b49fd1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.245854155Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.246054+00	2024-11-28 10:08:20.247394+00	2024-11-28 10:08:20.257454+00	\N	2024-11-28 10:08:20.246054+00	2024-11-28 10:08:20.258224+00	5239eff6-84c5-4806-95fc-dafd11b49fd1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f7b88bd7-707e-4c3f-9c54-f31330d0633c	default	5	{"job_id": "f7b88bd7-707e-4c3f-9c54-f31330d0633c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [11, {"value": "2024-11-28T10:08:20.185332000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.210047926Z", "scheduled_at": "2024-11-28T10:13:20.209873447Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.209873+00	2024-11-28 10:13:20.257129+00	2024-11-28 10:13:20.352102+00	\N	2024-11-28 10:08:20.210209+00	2024-11-28 10:13:20.373538+00	f7b88bd7-707e-4c3f-9c54-f31330d0633c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
37887cb2-6295-47f1-9bcc-86d77e1e43bd	default	5	{"job_id": "37887cb2-6295-47f1-9bcc-86d77e1e43bd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.227555474Z", "scheduled_at": "2024-11-28T10:13:20.227415720Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.227415+00	2024-11-28 10:13:20.289838+00	2024-11-28 10:13:20.35618+00	\N	2024-11-28 10:08:20.227749+00	2024-11-28 10:13:20.380651+00	37887cb2-6295-47f1-9bcc-86d77e1e43bd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a81d423a-6403-4993-82ff-4248149c2562	default	5	{"job_id": "a81d423a-6403-4993-82ff-4248149c2562", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.255716377Z", "scheduled_at": "2024-11-28T10:13:20.255504657Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.255504+00	2024-11-28 10:13:20.313597+00	2024-11-28 10:13:20.374575+00	\N	2024-11-28 10:08:20.25595+00	2024-11-28 10:13:20.399428+00	a81d423a-6403-4993-82ff-4248149c2562	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5a92a02c-824a-476d-9834-17d9140814a0	default	5	{"job_id": "5a92a02c-824a-476d-9834-17d9140814a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-11-28T10:08:20.280292000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.300547697Z", "scheduled_at": "2024-11-28T10:13:20.300371475Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.300371+00	2024-11-28 10:13:20.366192+00	2024-11-28 10:13:20.464748+00	\N	2024-11-28 10:08:20.300714+00	2024-11-28 10:13:20.500031+00	5a92a02c-824a-476d-9834-17d9140814a0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
a861da97-078a-4b6f-9896-56418da376f3	default	5	{"job_id": "a861da97-078a-4b6f-9896-56418da376f3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/12"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.265807070Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.265999+00	2024-11-28 10:08:20.266992+00	2024-11-28 10:08:20.274663+00	\N	2024-11-28 10:08:20.265999+00	2024-11-28 10:08:20.275387+00	a861da97-078a-4b6f-9896-56418da376f3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
664b4f56-d3b8-40bd-96ff-901b2d280cf6	default	5	{"job_id": "664b4f56-d3b8-40bd-96ff-901b2d280cf6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.288981879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.289204+00	2024-11-28 10:08:20.29045+00	2024-11-28 10:08:20.298534+00	\N	2024-11-28 10:08:20.289204+00	2024-11-28 10:08:20.299351+00	664b4f56-d3b8-40bd-96ff-901b2d280cf6	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3c2bea55-2650-4a55-bb6d-251e71a1ce26	default	5	{"job_id": "3c2bea55-2650-4a55-bb6d-251e71a1ce26", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.273205621Z", "scheduled_at": "2024-11-28T10:13:20.273036852Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.273036+00	2024-11-28 10:13:20.340621+00	2024-11-28 10:13:20.405622+00	\N	2024-11-28 10:08:20.273424+00	2024-11-28 10:13:20.440816+00	3c2bea55-2650-4a55-bb6d-251e71a1ce26	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
38877eb5-0c03-4103-b0a6-c3fb32aa08bf	default	5	{"job_id": "38877eb5-0c03-4103-b0a6-c3fb32aa08bf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.296724509Z", "scheduled_at": "2024-11-28T10:13:20.296574326Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.296574+00	2024-11-28 10:13:20.360049+00	2024-11-28 10:13:20.439005+00	\N	2024-11-28 10:08:20.296951+00	2024-11-28 10:13:20.469631+00	38877eb5-0c03-4103-b0a6-c3fb32aa08bf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5a07bd80-739a-4c4d-a22c-949541c250fd	default	5	{"job_id": "5a07bd80-739a-4c4d-a22c-949541c250fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.324173528Z", "scheduled_at": "2024-11-28T10:13:20.324024977Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.324025+00	2024-11-28 10:13:20.371025+00	2024-11-28 10:13:20.451272+00	\N	2024-11-28 10:08:20.32437+00	2024-11-28 10:13:20.485457+00	5a07bd80-739a-4c4d-a22c-949541c250fd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8b3474ee-5546-46ea-acbb-15597deba007	default	5	{"job_id": "8b3474ee-5546-46ea-acbb-15597deba007", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [12, {"value": "2024-11-28T10:08:20.264772000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.276373612Z", "scheduled_at": "2024-11-28T10:13:20.276207068Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.276207+00	2024-11-28 10:13:20.355297+00	2024-11-28 10:13:20.478806+00	\N	2024-11-28 10:08:20.276528+00	2024-11-28 10:13:20.510884+00	8b3474ee-5546-46ea-acbb-15597deba007	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
0ad9dc82-4657-40b2-b890-589df3e0e4a2	default	5	{"job_id": "0ad9dc82-4657-40b2-b890-589df3e0e4a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.315964919Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.316161+00	2024-11-28 10:08:20.317532+00	2024-11-28 10:08:20.325678+00	\N	2024-11-28 10:08:20.316161+00	2024-11-28 10:08:20.326501+00	0ad9dc82-4657-40b2-b890-589df3e0e4a2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
456f7e1e-ed02-4b44-b88d-b80f9cd60590	default	5	{"job_id": "456f7e1e-ed02-4b44-b88d-b80f9cd60590", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.336628000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.351010612Z", "scheduled_at": "2024-11-28T10:13:20.350158854Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.350158+00	2024-11-28 10:13:20.403422+00	2024-11-28 10:13:20.512765+00	\N	2024-11-28 10:08:20.351191+00	2024-11-28 10:13:20.533807+00	456f7e1e-ed02-4b44-b88d-b80f9cd60590	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2024b345-b983-4da9-9095-a45014feef50	default	5	{"job_id": "2024b345-b983-4da9-9095-a45014feef50", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.357162000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.387236884Z", "scheduled_at": "2024-11-28T10:13:20.386680905Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.38668+00	2024-11-28 10:13:20.429581+00	2024-11-28 10:13:20.548814+00	\N	2024-11-28 10:08:20.387413+00	2024-11-28 10:13:20.565172+00	2024b345-b983-4da9-9095-a45014feef50	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
298a52b3-d772-4c06-bb96-fd0ad0fbb2e9	default	5	{"job_id": "298a52b3-d772-4c06-bb96-fd0ad0fbb2e9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.337968016Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.338165+00	2024-11-28 10:08:20.339584+00	2024-11-28 10:08:20.347803+00	\N	2024-11-28 10:08:20.338165+00	2024-11-28 10:08:20.348873+00	298a52b3-d772-4c06-bb96-fd0ad0fbb2e9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
66502a80-b19c-4334-9520-c7fa5978cfab	default	5	{"job_id": "66502a80-b19c-4334-9520-c7fa5978cfab", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/14"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.370288372Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.37089+00	2024-11-28 10:08:20.372586+00	2024-11-28 10:08:20.382715+00	\N	2024-11-28 10:08:20.37089+00	2024-11-28 10:08:20.383592+00	66502a80-b19c-4334-9520-c7fa5978cfab	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bb748dd7-6323-445a-810f-77befab73631	default	5	{"job_id": "bb748dd7-6323-445a-810f-77befab73631", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [14, {"value": "2024-11-28T10:08:20.304410000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.328297625Z", "scheduled_at": "2024-11-28T10:13:20.328116083Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.328115+00	2024-11-28 10:13:20.377269+00	2024-11-28 10:13:20.498382+00	\N	2024-11-28 10:08:20.328464+00	2024-11-28 10:13:20.51808+00	bb748dd7-6323-445a-810f-77befab73631	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
aad09fb0-b1e0-4fb5-8e5b-bc658013198c	default	5	{"job_id": "aad09fb0-b1e0-4fb5-8e5b-bc658013198c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.346284829Z", "scheduled_at": "2024-11-28T10:13:20.346136478Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.346136+00	2024-11-28 10:13:20.396007+00	2024-11-28 10:13:20.506311+00	\N	2024-11-28 10:08:20.346484+00	2024-11-28 10:13:20.523921+00	aad09fb0-b1e0-4fb5-8e5b-bc658013198c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4df8db19-dc2f-4f02-bf2e-66ed62017724	default	5	{"job_id": "4df8db19-dc2f-4f02-bf2e-66ed62017724", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.380549067Z", "scheduled_at": "2024-11-28T10:13:20.380397892Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.380397+00	2024-11-28 10:13:20.414224+00	2024-11-28 10:13:20.50976+00	\N	2024-11-28 10:08:20.380771+00	2024-11-28 10:13:20.529216+00	4df8db19-dc2f-4f02-bf2e-66ed62017724	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ee8f0810-d6b9-4ff1-bbea-9137b21209cd	default	5	{"job_id": "ee8f0810-d6b9-4ff1-bbea-9137b21209cd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.433638560Z", "scheduled_at": "2024-11-28T10:13:20.433502413Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.433502+00	2024-11-28 10:13:20.499092+00	2024-11-28 10:13:20.558592+00	\N	2024-11-28 10:08:20.433835+00	2024-11-28 10:13:20.572911+00	ee8f0810-d6b9-4ff1-bbea-9137b21209cd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d261f4f4-669a-42a9-88a5-e96aeb2d232e	default	5	{"job_id": "d261f4f4-669a-42a9-88a5-e96aeb2d232e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.403510122Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.403705+00	2024-11-28 10:08:20.405467+00	2024-11-28 10:08:20.414069+00	\N	2024-11-28 10:08:20.403705+00	2024-11-28 10:08:20.415451+00	d261f4f4-669a-42a9-88a5-e96aeb2d232e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
721c1897-7345-4c1a-a972-88f049746980	default	5	{"job_id": "721c1897-7345-4c1a-a972-88f049746980", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.425610082Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.425804+00	2024-11-28 10:08:20.427054+00	2024-11-28 10:08:20.435154+00	\N	2024-11-28 10:08:20.425804+00	2024-11-28 10:08:20.435994+00	721c1897-7345-4c1a-a972-88f049746980	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
789181b5-352b-49e9-8ee8-7823eec26802	default	5	{"job_id": "789181b5-352b-49e9-8ee8-7823eec26802", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.412439672Z", "scheduled_at": "2024-11-28T10:13:20.412300289Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.4123+00	2024-11-28 10:13:20.46677+00	2024-11-28 10:13:20.540693+00	\N	2024-11-28 10:08:20.412636+00	2024-11-28 10:13:20.559099+00	789181b5-352b-49e9-8ee8-7823eec26802	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9b9f0cfd-0a9d-4241-8704-5d84e01e378a	default	5	{"job_id": "9b9f0cfd-0a9d-4241-8704-5d84e01e378a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.391412000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.416685550Z", "scheduled_at": "2024-11-28T10:13:20.416523454Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.416523+00	2024-11-28 10:13:20.47715+00	2024-11-28 10:13:20.553818+00	\N	2024-11-28 10:08:20.416843+00	2024-11-28 10:13:20.569273+00	9b9f0cfd-0a9d-4241-8704-5d84e01e378a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d91768af-199c-4fef-9e91-04c5d0336c0a	default	5	{"job_id": "d91768af-199c-4fef-9e91-04c5d0336c0a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.424529000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.437191550Z", "scheduled_at": "2024-11-28T10:13:20.437023643Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.437023+00	2024-11-28 10:13:20.501941+00	2024-11-28 10:13:20.567462+00	\N	2024-11-28 10:08:20.437361+00	2024-11-28 10:13:20.58874+00	d91768af-199c-4fef-9e91-04c5d0336c0a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
5b4d4d2c-f3b5-4a6b-8b6d-d91a7307dc42	default	5	{"job_id": "5b4d4d2c-f3b5-4a6b-8b6d-d91a7307dc42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/15"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.454338906Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.454555+00	2024-11-28 10:08:20.45594+00	2024-11-28 10:08:20.463167+00	\N	2024-11-28 10:08:20.454555+00	2024-11-28 10:08:20.464211+00	5b4d4d2c-f3b5-4a6b-8b6d-d91a7307dc42	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3da03879-81ff-49cf-b58c-c63fe5c3946b	default	5	{"job_id": "3da03879-81ff-49cf-b58c-c63fe5c3946b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [15, {"value": "2024-11-28T10:08:20.440651000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.465657057Z", "scheduled_at": "2024-11-28T10:13:20.465496234Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.465496+00	2024-11-28 10:13:20.53511+00	2024-11-28 10:13:20.647903+00	\N	2024-11-28 10:08:20.465811+00	2024-11-28 10:13:20.658827+00	3da03879-81ff-49cf-b58c-c63fe5c3946b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
01907454-ce4f-4efa-a20c-2778b1f945b9	default	5	{"job_id": "01907454-ce4f-4efa-a20c-2778b1f945b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/13"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.471458723Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.471662+00	2024-11-28 10:08:20.472848+00	2024-11-28 10:08:20.480913+00	\N	2024-11-28 10:08:20.471662+00	2024-11-28 10:08:20.482116+00	01907454-ce4f-4efa-a20c-2778b1f945b9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
5e57e3ac-8a10-44ae-a184-b50929dc9185	default	5	{"job_id": "5e57e3ac-8a10-44ae-a184-b50929dc9185", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.495815483Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.49601+00	2024-11-28 10:08:20.497022+00	2024-11-28 10:08:20.503931+00	\N	2024-11-28 10:08:20.49601+00	2024-11-28 10:08:20.504704+00	5e57e3ac-8a10-44ae-a184-b50929dc9185	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
970bdd4c-463b-4e75-b47b-41e49393bddb	default	5	{"job_id": "970bdd4c-463b-4e75-b47b-41e49393bddb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.461830693Z", "scheduled_at": "2024-11-28T10:13:20.461696239Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.461696+00	2024-11-28 10:13:20.526127+00	2024-11-28 10:13:20.581262+00	\N	2024-11-28 10:08:20.462019+00	2024-11-28 10:13:20.608362+00	970bdd4c-463b-4e75-b47b-41e49393bddb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2366a0c4-2153-42fb-8276-866172ae0826	default	5	{"job_id": "2366a0c4-2153-42fb-8276-866172ae0826", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.479060035Z", "scheduled_at": "2024-11-28T10:13:20.478924549Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.478924+00	2024-11-28 10:13:20.545637+00	2024-11-28 10:13:20.606945+00	\N	2024-11-28 10:08:20.47925+00	2024-11-28 10:13:20.624362+00	2366a0c4-2153-42fb-8276-866172ae0826	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e77285a0-23ab-4a05-aafa-e0255c192371	default	5	{"job_id": "e77285a0-23ab-4a05-aafa-e0255c192371", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.502719619Z", "scheduled_at": "2024-11-28T10:13:20.502590014Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.502589+00	2024-11-28 10:13:20.556793+00	2024-11-28 10:13:20.617904+00	\N	2024-11-28 10:08:20.502902+00	2024-11-28 10:13:20.637685+00	e77285a0-23ab-4a05-aafa-e0255c192371	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
df8cacba-875b-46b8-91b1-ddc1401b0dda	default	5	{"job_id": "df8cacba-875b-46b8-91b1-ddc1401b0dda", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [13, {"value": "2024-11-28T10:08:20.470694000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.483173152Z", "scheduled_at": "2024-11-28T10:13:20.483013921Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.483013+00	2024-11-28 10:13:20.552591+00	2024-11-28 10:13:20.64371+00	\N	2024-11-28 10:08:20.483338+00	2024-11-28 10:13:20.655639+00	df8cacba-875b-46b8-91b1-ddc1401b0dda	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f68e5caa-6401-42d5-a0fd-d615a01e7cc6	default	5	{"job_id": "f68e5caa-6401-42d5-a0fd-d615a01e7cc6", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/16"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.512883030Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.513106+00	2024-11-28 10:08:20.515031+00	2024-11-28 10:08:20.522979+00	\N	2024-11-28 10:08:20.513106+00	2024-11-28 10:08:20.523891+00	f68e5caa-6401-42d5-a0fd-d615a01e7cc6	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e13037a9-1cff-4c38-bffb-b4c685c56856	default	5	{"job_id": "e13037a9-1cff-4c38-bffb-b4c685c56856", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.521292177Z", "scheduled_at": "2024-11-28T10:13:20.521153987Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.521154+00	2024-11-28 10:13:20.566684+00	2024-11-28 10:13:20.630641+00	\N	2024-11-28 10:08:20.521485+00	2024-11-28 10:13:20.648407+00	e13037a9-1cff-4c38-bffb-b4c685c56856	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d87c076c-c752-4a9c-89e3-e3db2d0dbe64	default	5	{"job_id": "d87c076c-c752-4a9c-89e3-e3db2d0dbe64", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/17"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.702839496Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.703054+00	2024-11-28 10:08:20.70434+00	2024-11-28 10:08:20.71845+00	\N	2024-11-28 10:08:20.703054+00	2024-11-28 10:08:20.719505+00	d87c076c-c752-4a9c-89e3-e3db2d0dbe64	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
78e257fb-3fb4-459d-a720-bca04fcad254	default	5	{"job_id": "78e257fb-3fb4-459d-a720-bca04fcad254", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-11-28T10:08:20.487360000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.506188720Z", "scheduled_at": "2024-11-28T10:13:20.506017005Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.506016+00	2024-11-28 10:13:20.56075+00	2024-11-28 10:13:20.634078+00	\N	2024-11-28 10:08:20.506354+00	2024-11-28 10:13:20.650807+00	78e257fb-3fb4-459d-a720-bca04fcad254	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
5cda9e15-8499-47e8-b2e9-f5c670d0f00c	default	5	{"job_id": "5cda9e15-8499-47e8-b2e9-f5c670d0f00c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [16, {"value": "2024-11-28T10:08:20.512069000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.525305346Z", "scheduled_at": "2024-11-28T10:13:20.525071384Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.525071+00	2024-11-28 10:13:20.575493+00	2024-11-28 10:13:20.664131+00	\N	2024-11-28 10:08:20.525636+00	2024-11-28 10:13:20.667597+00	5cda9e15-8499-47e8-b2e9-f5c670d0f00c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f7821da6-eaef-4255-b9b4-bdeaad2049e1	default	5	{"job_id": "f7821da6-eaef-4255-b9b4-bdeaad2049e1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.716614115Z", "scheduled_at": "2024-11-28T10:13:20.716483448Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:20.716483+00	2024-11-28 10:13:20.721009+00	2024-11-28 10:13:20.726388+00	\N	2024-11-28 10:08:20.716816+00	2024-11-28 10:13:20.727192+00	f7821da6-eaef-4255-b9b4-bdeaad2049e1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ec33bc49-d466-4463-9584-15abf957b86d	default	5	{"job_id": "ec33bc49-d466-4463-9584-15abf957b86d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/18"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:20.997823456Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:20.998119+00	2024-11-28 10:08:20.999613+00	2024-11-28 10:08:21.011403+00	\N	2024-11-28 10:08:20.998119+00	2024-11-28 10:08:21.012472+00	ec33bc49-d466-4463-9584-15abf957b86d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
498f5af1-d7d6-4e04-abd1-d236cd0cd3af	default	5	{"job_id": "498f5af1-d7d6-4e04-abd1-d236cd0cd3af", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.046399186Z", "scheduled_at": "2024-11-28T10:13:21.046225167Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.046225+00	2024-11-28 10:13:21.050958+00	2024-11-28 10:13:21.063571+00	\N	2024-11-28 10:08:21.046644+00	2024-11-28 10:13:21.066351+00	498f5af1-d7d6-4e04-abd1-d236cd0cd3af	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c256f1f7-930f-4cd3-ae79-a850c247d877	default	5	{"job_id": "c256f1f7-930f-4cd3-ae79-a850c247d877", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.009638565Z", "scheduled_at": "2024-11-28T10:13:21.009385657Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.009385+00	2024-11-28 10:13:21.012619+00	2024-11-28 10:13:21.018967+00	\N	2024-11-28 10:08:21.00984+00	2024-11-28 10:13:21.020206+00	c256f1f7-930f-4cd3-ae79-a850c247d877	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
4e4dcc16-5527-4152-9fcc-6dc797b8d9fd	default	5	{"job_id": "4e4dcc16-5527-4152-9fcc-6dc797b8d9fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/19"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.035004861Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.035205+00	2024-11-28 10:08:21.036484+00	2024-11-28 10:08:21.048372+00	\N	2024-11-28 10:08:21.035205+00	2024-11-28 10:08:21.049263+00	4e4dcc16-5527-4152-9fcc-6dc797b8d9fd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a104d491-18d7-4c99-9fb6-ee7064c183bb	default	5	{"job_id": "a104d491-18d7-4c99-9fb6-ee7064c183bb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.119720170Z", "scheduled_at": "2024-11-28T10:13:21.119568374Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.119568+00	2024-11-28 10:13:21.126823+00	2024-11-28 10:13:21.139078+00	\N	2024-11-28 10:08:21.119935+00	2024-11-28 10:13:21.142512+00	a104d491-18d7-4c99-9fb6-ee7064c183bb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
87088ada-7020-41e8-b3bd-b878927d564e	default	5	{"job_id": "87088ada-7020-41e8-b3bd-b878927d564e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [20, {"value": "2024-11-28T10:08:21.098847000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.125466630Z", "scheduled_at": "2024-11-28T10:13:21.123251558Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.123251+00	2024-11-28 10:13:21.130283+00	2024-11-28 10:13:21.141631+00	\N	2024-11-28 10:08:21.126068+00	2024-11-28 10:13:21.143769+00	87088ada-7020-41e8-b3bd-b878927d564e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
6f0ce3f0-db18-4254-bb5e-cebce44b26b4	default	5	{"job_id": "6f0ce3f0-db18-4254-bb5e-cebce44b26b4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/20"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.107202955Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.107473+00	2024-11-28 10:08:21.10959+00	2024-11-28 10:08:21.12125+00	\N	2024-11-28 10:08:21.107473+00	2024-11-28 10:08:21.122169+00	6f0ce3f0-db18-4254-bb5e-cebce44b26b4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1d529880-a44d-4aa2-830b-5091b7152838	default	5	{"job_id": "1d529880-a44d-4aa2-830b-5091b7152838", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [19, {"value": "2024-11-28T10:08:21.022826000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.051929398Z", "scheduled_at": "2024-11-28T10:13:21.051497693Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.051497+00	2024-11-28 10:13:21.057534+00	2024-11-28 10:13:21.0675+00	\N	2024-11-28 10:08:21.052234+00	2024-11-28 10:13:21.069075+00	1d529880-a44d-4aa2-830b-5091b7152838	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3fce55f0-716b-4ccd-86f9-671e9096a044	default	5	{"job_id": "3fce55f0-716b-4ccd-86f9-671e9096a044", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/21"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.220209844Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.220421+00	2024-11-28 10:08:21.22191+00	2024-11-28 10:08:21.232533+00	\N	2024-11-28 10:08:21.220421+00	2024-11-28 10:08:21.233688+00	3fce55f0-716b-4ccd-86f9-671e9096a044	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3970824f-e0d0-4605-84be-52c1e335f286	default	5	{"job_id": "3970824f-e0d0-4605-84be-52c1e335f286", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.230409673Z", "scheduled_at": "2024-11-28T10:13:21.230087124Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.230087+00	2024-11-28 10:13:21.234583+00	2024-11-28 10:13:21.304256+00	\N	2024-11-28 10:08:21.23061+00	2024-11-28 10:13:21.309556+00	3970824f-e0d0-4605-84be-52c1e335f286	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d867ef11-5266-4e02-980a-668571c84670	default	5	{"job_id": "d867ef11-5266-4e02-980a-668571c84670", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.270146926Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.270347+00	2024-11-28 10:08:21.271736+00	2024-11-28 10:08:21.280061+00	\N	2024-11-28 10:08:21.270347+00	2024-11-28 10:08:21.281366+00	d867ef11-5266-4e02-980a-668571c84670	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
86d10a59-a21e-416a-9f49-63ab4c3f4e36	default	5	{"job_id": "86d10a59-a21e-416a-9f49-63ab4c3f4e36", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [21, {"value": "2024-11-28T10:08:21.211834000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.236139833Z", "scheduled_at": "2024-11-28T10:13:21.235872468Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.235872+00	2024-11-28 10:13:21.239355+00	2024-11-28 10:13:21.313809+00	\N	2024-11-28 10:08:21.236327+00	2024-11-28 10:13:21.320807+00	86d10a59-a21e-416a-9f49-63ab4c3f4e36	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
df67d719-45c7-42da-b8d7-273e243ffe9a	default	5	{"job_id": "df67d719-45c7-42da-b8d7-273e243ffe9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.278567104Z", "scheduled_at": "2024-11-28T10:13:21.278442058Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.278441+00	2024-11-28 10:13:21.314437+00	2024-11-28 10:13:21.334133+00	\N	2024-11-28 10:08:21.278769+00	2024-11-28 10:13:21.338989+00	df67d719-45c7-42da-b8d7-273e243ffe9a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b423f538-c9f1-4495-97d9-f25d20a07193	default	5	{"job_id": "b423f538-c9f1-4495-97d9-f25d20a07193", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-11-28T10:08:21.248994000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.282697213Z", "scheduled_at": "2024-11-28T10:13:21.282552039Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.282552+00	2024-11-28 10:13:21.315248+00	2024-11-28 10:13:21.33676+00	\N	2024-11-28 10:08:21.282853+00	2024-11-28 10:13:21.340081+00	b423f538-c9f1-4495-97d9-f25d20a07193	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
75f4bd21-3b18-4a3b-a181-47518ffd766f	default	5	{"job_id": "75f4bd21-3b18-4a3b-a181-47518ffd766f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/22"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.291476670Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.291705+00	2024-11-28 10:08:21.293306+00	2024-11-28 10:08:21.301361+00	\N	2024-11-28 10:08:21.291705+00	2024-11-28 10:08:21.302242+00	75f4bd21-3b18-4a3b-a181-47518ffd766f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
31abe499-95f6-45be-aebf-eb2b49ff41f8	default	5	{"job_id": "31abe499-95f6-45be-aebf-eb2b49ff41f8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.366711858Z", "scheduled_at": "2024-11-28T10:13:21.366438342Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.366438+00	2024-11-28 10:13:21.373729+00	2024-11-28 10:13:21.386184+00	\N	2024-11-28 10:08:21.367152+00	2024-11-28 10:13:21.38764+00	31abe499-95f6-45be-aebf-eb2b49ff41f8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
aea2c70d-4415-4562-adf6-daea998a643e	default	5	{"job_id": "aea2c70d-4415-4562-adf6-daea998a643e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.341544808Z", "scheduled_at": "2024-11-28T10:13:21.341414613Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.341414+00	2024-11-28 10:13:21.352987+00	2024-11-28 10:13:21.369577+00	\N	2024-11-28 10:08:21.341748+00	2024-11-28 10:13:21.372425+00	aea2c70d-4415-4562-adf6-daea998a643e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a38ade04-6f19-48f5-971e-14c143bad3bd	default	5	{"job_id": "a38ade04-6f19-48f5-971e-14c143bad3bd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.332857785Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.333079+00	2024-11-28 10:08:21.334578+00	2024-11-28 10:08:21.343096+00	\N	2024-11-28 10:08:21.333079+00	2024-11-28 10:08:21.344007+00	a38ade04-6f19-48f5-971e-14c143bad3bd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
63d2d749-e074-42f6-a914-1b2e8c41338d	default	5	{"job_id": "63d2d749-e074-42f6-a914-1b2e8c41338d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.299665812Z", "scheduled_at": "2024-11-28T10:13:21.299545114Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.299545+00	2024-11-28 10:13:21.316632+00	2024-11-28 10:13:21.335665+00	\N	2024-11-28 10:08:21.299864+00	2024-11-28 10:13:21.339759+00	63d2d749-e074-42f6-a914-1b2e8c41338d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
7f23fc75-3a9a-423e-b561-27b728263f73	default	5	{"job_id": "7f23fc75-3a9a-423e-b561-27b728263f73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/23"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.355112767Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.355329+00	2024-11-28 10:08:21.356994+00	2024-11-28 10:08:21.369894+00	\N	2024-11-28 10:08:21.355329+00	2024-11-28 10:08:21.370973+00	7f23fc75-3a9a-423e-b561-27b728263f73	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
232ba707-7e19-4a14-b876-c5e32cf2e28e	default	5	{"job_id": "232ba707-7e19-4a14-b876-c5e32cf2e28e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [22, {"value": "2024-11-28T10:08:21.290285000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.303775653Z", "scheduled_at": "2024-11-28T10:13:21.303626261Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.303626+00	2024-11-28 10:13:21.328537+00	2024-11-28 10:13:21.358221+00	\N	2024-11-28 10:08:21.303943+00	2024-11-28 10:13:21.360944+00	232ba707-7e19-4a14-b876-c5e32cf2e28e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
849ab5b4-05a8-4680-ac4b-91b3e2b4aae0	default	5	{"job_id": "849ab5b4-05a8-4680-ac4b-91b3e2b4aae0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-11-28T10:08:21.311905000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.345366133Z", "scheduled_at": "2024-11-28T10:13:21.345214808Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.345214+00	2024-11-28 10:13:21.3564+00	2024-11-28 10:13:21.370864+00	\N	2024-11-28 10:08:21.345538+00	2024-11-28 10:13:21.375506+00	849ab5b4-05a8-4680-ac4b-91b3e2b4aae0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f421d582-4029-4847-b6db-8138919e0d8f	default	5	{"job_id": "f421d582-4029-4847-b6db-8138919e0d8f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.402801793Z", "scheduled_at": "2024-11-28T10:13:21.402675464Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.402675+00	2024-11-28 10:13:21.405558+00	2024-11-28 10:13:21.417504+00	\N	2024-11-28 10:08:21.402995+00	2024-11-28 10:13:21.42007+00	f421d582-4029-4847-b6db-8138919e0d8f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b68ccdaa-948b-4408-80e7-f3637d810e84	default	5	{"job_id": "b68ccdaa-948b-4408-80e7-f3637d810e84", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [23, {"value": "2024-11-28T10:08:21.353881000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.372236631Z", "scheduled_at": "2024-11-28T10:13:21.372085475Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.372085+00	2024-11-28 10:13:21.382178+00	2024-11-28 10:13:21.39489+00	\N	2024-11-28 10:08:21.372415+00	2024-11-28 10:13:21.39603+00	b68ccdaa-948b-4408-80e7-f3637d810e84	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
da63c6e0-9c5b-43c1-abc0-0ad4b63b50d5	default	5	{"job_id": "da63c6e0-9c5b-43c1-abc0-0ad4b63b50d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.394301864Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.394513+00	2024-11-28 10:08:21.395621+00	2024-11-28 10:08:21.404079+00	\N	2024-11-28 10:08:21.394513+00	2024-11-28 10:08:21.404848+00	da63c6e0-9c5b-43c1-abc0-0ad4b63b50d5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
02836437-2217-4040-a560-902ad697669a	default	5	{"job_id": "02836437-2217-4040-a560-902ad697669a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.439305619Z", "scheduled_at": "2024-11-28T10:13:21.439161307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.439161+00	2024-11-28 10:13:21.442237+00	2024-11-28 10:13:21.452031+00	\N	2024-11-28 10:08:21.439534+00	2024-11-28 10:13:21.453342+00	02836437-2217-4040-a560-902ad697669a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
235058da-6132-46c8-b8e2-af328a32380d	default	5	{"job_id": "235058da-6132-46c8-b8e2-af328a32380d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.411680000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.442860742Z", "scheduled_at": "2024-11-28T10:13:21.442645435Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.442645+00	2024-11-28 10:13:21.447726+00	2024-11-28 10:13:21.456635+00	\N	2024-11-28 10:08:21.443018+00	2024-11-28 10:13:21.458644+00	235058da-6132-46c8-b8e2-af328a32380d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
640ff382-05d2-4324-bb25-af570980d230	default	5	{"job_id": "640ff382-05d2-4324-bb25-af570980d230", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.430576798Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.430885+00	2024-11-28 10:08:21.431999+00	2024-11-28 10:08:21.440927+00	\N	2024-11-28 10:08:21.430885+00	2024-11-28 10:08:21.441816+00	640ff382-05d2-4324-bb25-af570980d230	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ce56c8fa-70f8-4c1f-965a-5eca8795b897	default	5	{"job_id": "ce56c8fa-70f8-4c1f-965a-5eca8795b897", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-11-28T10:08:21.381472000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.406287946Z", "scheduled_at": "2024-11-28T10:13:21.405874896Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.405874+00	2024-11-28 10:13:21.411723+00	2024-11-28 10:13:21.420734+00	\N	2024-11-28 10:08:21.407103+00	2024-11-28 10:13:21.421804+00	ce56c8fa-70f8-4c1f-965a-5eca8795b897	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
63734437-43e4-4ed3-b81c-6f7f8c0e123b	default	5	{"job_id": "63734437-43e4-4ed3-b81c-6f7f8c0e123b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.526375054Z", "scheduled_at": "2024-11-28T10:13:21.526216635Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.526216+00	2024-11-28 10:13:21.530292+00	2024-11-28 10:13:21.536176+00	\N	2024-11-28 10:08:21.526604+00	2024-11-28 10:13:21.537531+00	63734437-43e4-4ed3-b81c-6f7f8c0e123b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bb5c6d45-082f-48cd-9168-9bb808550197	default	5	{"job_id": "bb5c6d45-082f-48cd-9168-9bb808550197", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.451274760Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.451493+00	2024-11-28 10:08:21.452896+00	2024-11-28 10:08:21.46371+00	\N	2024-11-28 10:08:21.451493+00	2024-11-28 10:08:21.465045+00	bb5c6d45-082f-48cd-9168-9bb808550197	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
78e2fefb-cca4-4eae-a8b4-da93a1331a07	default	5	{"job_id": "78e2fefb-cca4-4eae-a8b4-da93a1331a07", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.494878582Z", "scheduled_at": "2024-11-28T10:13:21.494415237Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.494415+00	2024-11-28 10:13:21.498558+00	2024-11-28 10:13:21.507199+00	\N	2024-11-28 10:08:21.495168+00	2024-11-28 10:13:21.509229+00	78e2fefb-cca4-4eae-a8b4-da93a1331a07	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e145a9ac-7762-4d12-a288-e286b271a8d5	default	5	{"job_id": "e145a9ac-7762-4d12-a288-e286b271a8d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.461177448Z", "scheduled_at": "2024-11-28T10:13:21.461008569Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.461008+00	2024-11-28 10:13:21.464529+00	2024-11-28 10:13:21.473661+00	\N	2024-11-28 10:08:21.461423+00	2024-11-28 10:13:21.4752+00	e145a9ac-7762-4d12-a288-e286b271a8d5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
49c67e60-c9ce-4869-9046-3f0846e6cddf	default	5	{"job_id": "49c67e60-c9ce-4869-9046-3f0846e6cddf", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/25"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.486646659Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.486853+00	2024-11-28 10:08:21.487906+00	2024-11-28 10:08:21.496467+00	\N	2024-11-28 10:08:21.486853+00	2024-11-28 10:08:21.497376+00	49c67e60-c9ce-4869-9046-3f0846e6cddf	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
876dc787-917b-46bb-bc31-c9dd97db28a0	default	5	{"job_id": "876dc787-917b-46bb-bc31-c9dd97db28a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.450280000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.466439584Z", "scheduled_at": "2024-11-28T10:13:21.466116184Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.466116+00	2024-11-28 10:13:21.471796+00	2024-11-28 10:13:21.47966+00	\N	2024-11-28 10:08:21.466978+00	2024-11-28 10:13:21.481166+00	876dc787-917b-46bb-bc31-c9dd97db28a0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
caaed92d-e02f-403a-8371-868537b940a2	default	5	{"job_id": "caaed92d-e02f-403a-8371-868537b940a2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [25, {"value": "2024-11-28T10:08:21.472098000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.498677896Z", "scheduled_at": "2024-11-28T10:13:21.498495361Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.498495+00	2024-11-28 10:13:21.5027+00	2024-11-28 10:13:21.51465+00	\N	2024-11-28 10:08:21.498906+00	2024-11-28 10:13:21.516281+00	caaed92d-e02f-403a-8371-868537b940a2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
558a0e5d-69d9-40ee-8c61-41c36beaf7d9	default	5	{"job_id": "558a0e5d-69d9-40ee-8c61-41c36beaf7d9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.517764405Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.517987+00	2024-11-28 10:08:21.519139+00	2024-11-28 10:08:21.527777+00	\N	2024-11-28 10:08:21.517987+00	2024-11-28 10:08:21.52864+00	558a0e5d-69d9-40ee-8c61-41c36beaf7d9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
88406fcd-14f1-4d6e-80a4-5f87ba9543dd	default	5	{"job_id": "88406fcd-14f1-4d6e-80a4-5f87ba9543dd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.554755000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.580940384Z", "scheduled_at": "2024-11-28T10:13:21.580743963Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.580744+00	2024-11-28 10:13:21.585539+00	2024-11-28 10:13:21.600306+00	\N	2024-11-28 10:08:21.581195+00	2024-11-28 10:13:21.601431+00	88406fcd-14f1-4d6e-80a4-5f87ba9543dd	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f9e3814e-b039-4a5b-8e33-2a2f19491a04	default	5	{"job_id": "f9e3814e-b039-4a5b-8e33-2a2f19491a04", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.503683000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.531040473Z", "scheduled_at": "2024-11-28T10:13:21.530569884Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.53057+00	2024-11-28 10:13:21.534358+00	2024-11-28 10:13:21.541374+00	\N	2024-11-28 10:08:21.531334+00	2024-11-28 10:13:21.542697+00	f9e3814e-b039-4a5b-8e33-2a2f19491a04	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b8fd1ab6-07b4-487a-a4fb-7b51fa502a2d	default	5	{"job_id": "b8fd1ab6-07b4-487a-a4fb-7b51fa502a2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.539351305Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.539581+00	2024-11-28 10:08:21.540696+00	2024-11-28 10:08:21.54906+00	\N	2024-11-28 10:08:21.539581+00	2024-11-28 10:08:21.549836+00	b8fd1ab6-07b4-487a-a4fb-7b51fa502a2d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
82598bda-c247-423a-b4c4-d049377a722d	default	5	{"job_id": "82598bda-c247-423a-b4c4-d049377a722d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.547542332Z", "scheduled_at": "2024-11-28T10:13:21.547275368Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.547275+00	2024-11-28 10:13:21.552171+00	2024-11-28 10:13:21.563361+00	\N	2024-11-28 10:08:21.547743+00	2024-11-28 10:13:21.565084+00	82598bda-c247-423a-b4c4-d049377a722d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d0722825-0a4b-42f0-b1d0-443e8c36d6fb	default	5	{"job_id": "d0722825-0a4b-42f0-b1d0-443e8c36d6fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/26"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.566321620Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.566522+00	2024-11-28 10:08:21.567623+00	2024-11-28 10:08:21.578531+00	\N	2024-11-28 10:08:21.566522+00	2024-11-28 10:08:21.579419+00	d0722825-0a4b-42f0-b1d0-443e8c36d6fb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e865de07-4587-4003-9c63-984a7dfed157	default	5	{"job_id": "e865de07-4587-4003-9c63-984a7dfed157", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [26, {"value": "2024-11-28T10:08:21.538041000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.550785335Z", "scheduled_at": "2024-11-28T10:13:21.550646523Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.550646+00	2024-11-28 10:13:21.556033+00	2024-11-28 10:13:21.565618+00	\N	2024-11-28 10:08:21.550963+00	2024-11-28 10:13:21.566945+00	e865de07-4587-4003-9c63-984a7dfed157	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
14a56a4d-a71e-45a7-be66-9bdebf7e4877	default	5	{"job_id": "14a56a4d-a71e-45a7-be66-9bdebf7e4877", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.577070616Z", "scheduled_at": "2024-11-28T10:13:21.576920102Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.57692+00	2024-11-28 10:13:21.580891+00	2024-11-28 10:13:21.589789+00	\N	2024-11-28 10:08:21.577274+00	2024-11-28 10:13:21.592289+00	14a56a4d-a71e-45a7-be66-9bdebf7e4877	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a5f55191-8eaf-43c1-843c-9a91a35520fc	default	5	{"job_id": "a5f55191-8eaf-43c1-843c-9a91a35520fc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.627833928Z", "scheduled_at": "2024-11-28T10:13:21.627714853Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.627714+00	2024-11-28 10:13:21.631483+00	2024-11-28 10:13:21.63989+00	\N	2024-11-28 10:08:21.628022+00	2024-11-28 10:13:21.642173+00	a5f55191-8eaf-43c1-843c-9a91a35520fc	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
109d8d2a-5d94-4795-9096-c8128de0002c	default	5	{"job_id": "109d8d2a-5d94-4795-9096-c8128de0002c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.612705000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.631418015Z", "scheduled_at": "2024-11-28T10:13:21.631272440Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.631272+00	2024-11-28 10:13:21.635547+00	2024-11-28 10:13:21.643011+00	\N	2024-11-28 10:08:21.631583+00	2024-11-28 10:13:21.645218+00	109d8d2a-5d94-4795-9096-c8128de0002c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d1d87eb1-25b8-4e7a-9852-bf16562f33de	default	5	{"job_id": "d1d87eb1-25b8-4e7a-9852-bf16562f33de", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.597706010Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.59802+00	2024-11-28 10:08:21.599193+00	2024-11-28 10:08:21.605768+00	\N	2024-11-28 10:08:21.59802+00	2024-11-28 10:08:21.60665+00	d1d87eb1-25b8-4e7a-9852-bf16562f33de	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2870689b-2a4f-4f5d-a9a1-a3bbd6a386fb	default	5	{"job_id": "2870689b-2a4f-4f5d-a9a1-a3bbd6a386fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.604430097Z", "scheduled_at": "2024-11-28T10:13:21.604310100Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.60431+00	2024-11-28 10:13:21.606869+00	2024-11-28 10:13:21.613986+00	\N	2024-11-28 10:08:21.604619+00	2024-11-28 10:13:21.615542+00	2870689b-2a4f-4f5d-a9a1-a3bbd6a386fb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
12833fce-9646-4403-ac30-ff25d9f28892	default	5	{"job_id": "12833fce-9646-4403-ac30-ff25d9f28892", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.585544000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.607919135Z", "scheduled_at": "2024-11-28T10:13:21.607770093Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.60777+00	2024-11-28 10:13:21.610861+00	2024-11-28 10:13:21.619582+00	\N	2024-11-28 10:08:21.608092+00	2024-11-28 10:13:21.621278+00	12833fce-9646-4403-ac30-ff25d9f28892	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
a8f91fa7-6c58-4d0d-919c-004900b82153	default	5	{"job_id": "a8f91fa7-6c58-4d0d-919c-004900b82153", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.620937125Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.621151+00	2024-11-28 10:08:21.622199+00	2024-11-28 10:08:21.629231+00	\N	2024-11-28 10:08:21.621151+00	2024-11-28 10:08:21.630329+00	a8f91fa7-6c58-4d0d-919c-004900b82153	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d120268d-24d6-4d02-87fc-88ec0cfb3097	default	5	{"job_id": "d120268d-24d6-4d02-87fc-88ec0cfb3097", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.638325188Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.638524+00	2024-11-28 10:08:21.639846+00	2024-11-28 10:08:21.647542+00	\N	2024-11-28 10:08:21.638524+00	2024-11-28 10:08:21.648349+00	d120268d-24d6-4d02-87fc-88ec0cfb3097	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b3f609ba-e586-4632-b783-f9704eab7362	default	5	{"job_id": "b3f609ba-e586-4632-b783-f9704eab7362", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.690449608Z", "scheduled_at": "2024-11-28T10:13:21.690317909Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.690317+00	2024-11-28 10:13:21.698051+00	2024-11-28 10:13:21.712942+00	\N	2024-11-28 10:08:21.690655+00	2024-11-28 10:13:21.717436+00	b3f609ba-e586-4632-b783-f9704eab7362	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9b3e3eed-a6e3-453c-a504-3facf9d41194	default	5	{"job_id": "9b3e3eed-a6e3-453c-a504-3facf9d41194", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.672769796Z", "scheduled_at": "2024-11-28T10:13:21.672641975Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.672641+00	2024-11-28 10:13:21.685034+00	2024-11-28 10:13:21.692667+00	\N	2024-11-28 10:08:21.672992+00	2024-11-28 10:13:21.696788+00	9b3e3eed-a6e3-453c-a504-3facf9d41194	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c8596f9e-81aa-4725-a0ae-72d4d8e79ac9	default	5	{"job_id": "c8596f9e-81aa-4725-a0ae-72d4d8e79ac9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/28"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.665826375Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.666037+00	2024-11-28 10:08:21.667261+00	2024-11-28 10:08:21.674409+00	\N	2024-11-28 10:08:21.666037+00	2024-11-28 10:08:21.675345+00	c8596f9e-81aa-4725-a0ae-72d4d8e79ac9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
9abe8d8e-fd6b-4b10-904d-f336508161b9	default	5	{"job_id": "9abe8d8e-fd6b-4b10-904d-f336508161b9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.645895040Z", "scheduled_at": "2024-11-28T10:13:21.645744576Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.645744+00	2024-11-28 10:13:21.652468+00	2024-11-28 10:13:21.660178+00	\N	2024-11-28 10:08:21.646124+00	2024-11-28 10:13:21.661501+00	9abe8d8e-fd6b-4b10-904d-f336508161b9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1b48c43a-fe41-405c-8dac-24503e1d9616	default	5	{"job_id": "1b48c43a-fe41-405c-8dac-24503e1d9616", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.637480000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.649442830Z", "scheduled_at": "2024-11-28T10:13:21.649299079Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.649299+00	2024-11-28 10:13:21.655134+00	2024-11-28 10:13:21.661993+00	\N	2024-11-28 10:08:21.649605+00	2024-11-28 10:13:21.663158+00	1b48c43a-fe41-405c-8dac-24503e1d9616	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d5b3aaa0-2a09-49d8-999c-a82254061dd9	default	5	{"job_id": "d5b3aaa0-2a09-49d8-999c-a82254061dd9", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.683282265Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.683477+00	2024-11-28 10:08:21.68471+00	2024-11-28 10:08:21.691899+00	\N	2024-11-28 10:08:21.683477+00	2024-11-28 10:08:21.692722+00	d5b3aaa0-2a09-49d8-999c-a82254061dd9	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f8a43ede-10df-4037-82c4-8317dac7b188	default	5	{"job_id": "f8a43ede-10df-4037-82c4-8317dac7b188", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [28, {"value": "2024-11-28T10:08:21.652757000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.676574630Z", "scheduled_at": "2024-11-28T10:13:21.676424707Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.676424+00	2024-11-28 10:13:21.688116+00	2024-11-28 10:13:21.705606+00	\N	2024-11-28 10:08:21.67674+00	2024-11-28 10:13:21.708796+00	f8a43ede-10df-4037-82c4-8317dac7b188	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
589462aa-3ab1-4ced-8eec-27a8d2c83913	default	5	{"job_id": "589462aa-3ab1-4ced-8eec-27a8d2c83913", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.721656223Z", "scheduled_at": "2024-11-28T10:13:21.721535014Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.721534+00	2024-11-28 10:13:21.724576+00	2024-11-28 10:13:21.732587+00	\N	2024-11-28 10:08:21.721846+00	2024-11-28 10:13:21.733863+00	589462aa-3ab1-4ced-8eec-27a8d2c83913	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b231c7ba-b965-4d08-9e10-6ab34618313c	default	5	{"job_id": "b231c7ba-b965-4d08-9e10-6ab34618313c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.682360000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.694001074Z", "scheduled_at": "2024-11-28T10:13:21.693857132Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.693856+00	2024-11-28 10:13:21.701185+00	2024-11-28 10:13:21.716495+00	\N	2024-11-28 10:08:21.694159+00	2024-11-28 10:13:21.718743+00	b231c7ba-b965-4d08-9e10-6ab34618313c	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
1b0aa52b-3908-4f12-9b3e-324175b1eb40	default	5	{"job_id": "1b0aa52b-3908-4f12-9b3e-324175b1eb40", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/27"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.710414837Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.710615+00	2024-11-28 10:08:21.71173+00	2024-11-28 10:08:21.723269+00	\N	2024-11-28 10:08:21.710615+00	2024-11-28 10:08:21.724075+00	1b0aa52b-3908-4f12-9b3e-324175b1eb40	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
31673ca4-3e8b-4e66-acbf-6313d399ac39	default	5	{"job_id": "31673ca4-3e8b-4e66-acbf-6313d399ac39", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.740928313Z", "scheduled_at": "2024-11-28T10:13:21.740789571Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.740789+00	2024-11-28 10:13:21.743034+00	2024-11-28 10:13:21.766024+00	\N	2024-11-28 10:08:21.741185+00	2024-11-28 10:13:21.767995+00	31673ca4-3e8b-4e66-acbf-6313d399ac39	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d1a0bc3d-056f-4ffe-9bc8-c17bc4505e42	default	5	{"job_id": "d1a0bc3d-056f-4ffe-9bc8-c17bc4505e42", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/24"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.731884576Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.732079+00	2024-11-28 10:08:21.733136+00	2024-11-28 10:08:21.743249+00	\N	2024-11-28 10:08:21.732079+00	2024-11-28 10:08:21.744392+00	d1a0bc3d-056f-4ffe-9bc8-c17bc4505e42	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
89c78fb4-35cb-4bd4-b89e-48ef257f945b	default	5	{"job_id": "89c78fb4-35cb-4bd4-b89e-48ef257f945b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [27, {"value": "2024-11-28T10:08:21.696851000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.725168444Z", "scheduled_at": "2024-11-28T10:13:21.725020985Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.72502+00	2024-11-28 10:13:21.729327+00	2024-11-28 10:13:21.740367+00	\N	2024-11-28 10:08:21.725327+00	2024-11-28 10:13:21.742156+00	89c78fb4-35cb-4bd4-b89e-48ef257f945b	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
74e90f55-8677-4811-835c-75c0453327f1	default	5	{"job_id": "74e90f55-8677-4811-835c-75c0453327f1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [24, {"value": "2024-11-28T10:08:21.730609000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.745992424Z", "scheduled_at": "2024-11-28T10:13:21.745837992Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.745838+00	2024-11-28 10:13:21.758481+00	2024-11-28 10:13:21.783046+00	\N	2024-11-28 10:08:21.746167+00	2024-11-28 10:13:21.797993+00	74e90f55-8677-4811-835c-75c0453327f1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
cf409ba2-42b6-4f0e-8006-b950de0699b0	default	5	{"job_id": "cf409ba2-42b6-4f0e-8006-b950de0699b0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-11-28T10:08:21.784843000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.799129698Z", "scheduled_at": "2024-11-28T10:13:21.798855510Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.798855+00	2024-11-28 10:13:21.823057+00	2024-11-28 10:13:21.86084+00	\N	2024-11-28 10:08:21.799298+00	2024-11-28 10:13:21.864197+00	cf409ba2-42b6-4f0e-8006-b950de0699b0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b94be0f3-d5a6-4113-821b-a15f7c6ae89c	default	5	{"job_id": "b94be0f3-d5a6-4113-821b-a15f7c6ae89c", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.766092106Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.7663+00	2024-11-28 10:08:21.767753+00	2024-11-28 10:08:21.775673+00	\N	2024-11-28 10:08:21.7663+00	2024-11-28 10:08:21.776599+00	b94be0f3-d5a6-4113-821b-a15f7c6ae89c	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0cdd75e5-926c-45cd-8dee-922d322de6ad	default	5	{"job_id": "0cdd75e5-926c-45cd-8dee-922d322de6ad", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.831715666Z", "scheduled_at": "2024-11-28T10:13:21.831537189Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.831537+00	2024-11-28 10:13:21.843282+00	2024-11-28 10:13:21.863219+00	\N	2024-11-28 10:08:21.83201+00	2024-11-28 10:13:21.866797+00	0cdd75e5-926c-45cd-8dee-922d322de6ad	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e3230f1d-5b78-4358-9a8a-b85b941b6d35	default	5	{"job_id": "e3230f1d-5b78-4358-9a8a-b85b941b6d35", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/29"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.786286306Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.786483+00	2024-11-28 10:08:21.78773+00	2024-11-28 10:08:21.796712+00	\N	2024-11-28 10:08:21.786483+00	2024-11-28 10:08:21.797728+00	e3230f1d-5b78-4358-9a8a-b85b941b6d35	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bc4e5223-3fcb-4fa7-ba08-bf3f68936adc	default	5	{"job_id": "bc4e5223-3fcb-4fa7-ba08-bf3f68936adc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.774181871Z", "scheduled_at": "2024-11-28T10:13:21.774046004Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.774045+00	2024-11-28 10:13:21.784841+00	2024-11-28 10:13:21.830904+00	\N	2024-11-28 10:08:21.774379+00	2024-11-28 10:13:21.839231+00	bc4e5223-3fcb-4fa7-ba08-bf3f68936adc	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cf3a32ca-8766-4cbc-a64f-b4628a7f5395	default	5	{"job_id": "cf3a32ca-8766-4cbc-a64f-b4628a7f5395", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [29, {"value": "2024-11-28T10:08:21.749861000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.777829319Z", "scheduled_at": "2024-11-28T10:13:21.777674496Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.777674+00	2024-11-28 10:13:21.792931+00	2024-11-28 10:13:21.835792+00	\N	2024-11-28 10:08:21.777992+00	2024-11-28 10:13:21.845333+00	cf3a32ca-8766-4cbc-a64f-b4628a7f5395	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d39659fa-03f1-4676-88f5-96bbb0c3ab9a	default	5	{"job_id": "d39659fa-03f1-4676-88f5-96bbb0c3ab9a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.794523170Z", "scheduled_at": "2024-11-28T10:13:21.794393525Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.794393+00	2024-11-28 10:13:21.804368+00	2024-11-28 10:13:21.844279+00	\N	2024-11-28 10:08:21.794725+00	2024-11-28 10:13:21.852944+00	d39659fa-03f1-4676-88f5-96bbb0c3ab9a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
444d42ef-0274-406e-ada7-d40d4dbaeffd	default	5	{"job_id": "444d42ef-0274-406e-ada7-d40d4dbaeffd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.820864808Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.821189+00	2024-11-28 10:08:21.823233+00	2024-11-28 10:08:21.834198+00	\N	2024-11-28 10:08:21.821189+00	2024-11-28 10:08:21.835644+00	444d42ef-0274-406e-ada7-d40d4dbaeffd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8274d3f5-e178-4415-ab00-94a2af01a694	default	5	{"job_id": "8274d3f5-e178-4415-ab00-94a2af01a694", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.894247719Z", "scheduled_at": "2024-11-28T10:13:21.894068971Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.894068+00	2024-11-28 10:13:21.897357+00	2024-11-28 10:13:21.902928+00	\N	2024-11-28 10:08:21.894537+00	2024-11-28 10:13:21.90718+00	8274d3f5-e178-4415-ab00-94a2af01a694	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8c752737-15eb-4921-a4fe-2aea2c5abb31	default	5	{"job_id": "8c752737-15eb-4921-a4fe-2aea2c5abb31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-11-28T10:08:21.803135000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.837750701Z", "scheduled_at": "2024-11-28T10:13:21.837527901Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.837527+00	2024-11-28 10:13:21.848955+00	2024-11-28 10:13:21.867436+00	\N	2024-11-28 10:08:21.838011+00	2024-11-28 10:13:21.870295+00	8c752737-15eb-4921-a4fe-2aea2c5abb31	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
dba3b3ef-9817-44b0-92cf-ed9ee7fa0fb3	default	5	{"job_id": "dba3b3ef-9817-44b0-92cf-ed9ee7fa0fb3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.857205286Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.857525+00	2024-11-28 10:08:21.859275+00	2024-11-28 10:08:21.86983+00	\N	2024-11-28 10:08:21.857525+00	2024-11-28 10:08:21.871133+00	dba3b3ef-9817-44b0-92cf-ed9ee7fa0fb3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f6422cef-1e10-48de-8511-aefdfff8989a	default	5	{"job_id": "f6422cef-1e10-48de-8511-aefdfff8989a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.843530000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.873018935Z", "scheduled_at": "2024-11-28T10:13:21.872535472Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.872535+00	2024-11-28 10:13:21.879421+00	2024-11-28 10:13:21.887774+00	\N	2024-11-28 10:08:21.873321+00	2024-11-28 10:13:21.889505+00	f6422cef-1e10-48de-8511-aefdfff8989a	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
32800bca-6b46-442b-aa2f-85f13a00937f	default	5	{"job_id": "32800bca-6b46-442b-aa2f-85f13a00937f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.867746680Z", "scheduled_at": "2024-11-28T10:13:21.867575156Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.867574+00	2024-11-28 10:13:21.872727+00	2024-11-28 10:13:21.883913+00	\N	2024-11-28 10:08:21.868035+00	2024-11-28 10:13:21.886157+00	32800bca-6b46-442b-aa2f-85f13a00937f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0b06b72a-ac8e-4ec1-8df3-5b0f6118f633	default	5	{"job_id": "0b06b72a-ac8e-4ec1-8df3-5b0f6118f633", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.882985954Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.883268+00	2024-11-28 10:08:21.885182+00	2024-11-28 10:08:21.896247+00	\N	2024-11-28 10:08:21.883268+00	2024-11-28 10:08:21.897502+00	0b06b72a-ac8e-4ec1-8df3-5b0f6118f633	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
24baa311-d0e2-4f93-8f38-7ae1a0e5393e	default	5	{"job_id": "24baa311-d0e2-4f93-8f38-7ae1a0e5393e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.881815000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.899198327Z", "scheduled_at": "2024-11-28T10:13:21.898984804Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.898984+00	2024-11-28 10:13:21.901601+00	2024-11-28 10:13:21.911709+00	\N	2024-11-28 10:08:21.899448+00	2024-11-28 10:13:21.913144+00	24baa311-d0e2-4f93-8f38-7ae1a0e5393e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
8d8e3cf4-a1ca-4a96-a58c-02b370fce129	default	5	{"job_id": "8d8e3cf4-a1ca-4a96-a58c-02b370fce129", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.932064273Z", "scheduled_at": "2024-11-28T10:13:21.931887109Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.931887+00	2024-11-28 10:13:21.935055+00	2024-11-28 10:13:21.940951+00	\N	2024-11-28 10:08:21.932354+00	2024-11-28 10:13:21.942186+00	8d8e3cf4-a1ca-4a96-a58c-02b370fce129	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
68c092fa-a4a1-47c6-95c4-4b6facff00f2	default	5	{"job_id": "68c092fa-a4a1-47c6-95c4-4b6facff00f2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/31"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.921805042Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.922098+00	2024-11-28 10:08:21.923873+00	2024-11-28 10:08:21.934105+00	\N	2024-11-28 10:08:21.922098+00	2024-11-28 10:08:21.935268+00	68c092fa-a4a1-47c6-95c4-4b6facff00f2	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c0b2f486-e922-4406-832d-9d896d5f1595	default	5	{"job_id": "c0b2f486-e922-4406-832d-9d896d5f1595", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [30, {"value": "2024-11-28T10:08:21.947508000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.963697133Z", "scheduled_at": "2024-11-28T10:13:21.963488629Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.963488+00	2024-11-28 10:13:21.967336+00	2024-11-28 10:13:21.97783+00	\N	2024-11-28 10:08:21.963946+00	2024-11-28 10:13:21.979415+00	c0b2f486-e922-4406-832d-9d896d5f1595	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
41a92d3f-9d42-44c8-b423-584dcf850453	default	5	{"job_id": "41a92d3f-9d42-44c8-b423-584dcf850453", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [31, {"value": "2024-11-28T10:08:21.904313000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.937348773Z", "scheduled_at": "2024-11-28T10:13:21.937130721Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.93713+00	2024-11-28 10:13:21.939638+00	2024-11-28 10:13:21.9515+00	\N	2024-11-28 10:08:21.937802+00	2024-11-28 10:13:21.953076+00	41a92d3f-9d42-44c8-b423-584dcf850453	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
add51451-4feb-4c22-a3d1-9247968a4e59	default	5	{"job_id": "add51451-4feb-4c22-a3d1-9247968a4e59", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/30"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.948909071Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.949224+00	2024-11-28 10:08:21.950866+00	2024-11-28 10:08:21.961091+00	\N	2024-11-28 10:08:21.949224+00	2024-11-28 10:08:21.962269+00	add51451-4feb-4c22-a3d1-9247968a4e59	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e6caef14-eb1a-43e8-a59e-e24a346a0ee5	default	5	{"job_id": "e6caef14-eb1a-43e8-a59e-e24a346a0ee5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.958972702Z", "scheduled_at": "2024-11-28T10:13:21.958799264Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.958799+00	2024-11-28 10:13:21.961121+00	2024-11-28 10:13:21.965925+00	\N	2024-11-28 10:08:21.959261+00	2024-11-28 10:13:21.968729+00	e6caef14-eb1a-43e8-a59e-e24a346a0ee5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f9855bf6-9d06-4f93-be3b-47902dabd68d	default	5	{"job_id": "f9855bf6-9d06-4f93-be3b-47902dabd68d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.987522930Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:21.987812+00	2024-11-28 10:08:21.989454+00	2024-11-28 10:08:21.999553+00	\N	2024-11-28 10:08:21.987812+00	2024-11-28 10:08:22.000677+00	f9855bf6-9d06-4f93-be3b-47902dabd68d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
20c3d50e-6c1c-4e58-82b2-348220aee5dc	default	5	{"job_id": "20c3d50e-6c1c-4e58-82b2-348220aee5dc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:21.997151321Z", "scheduled_at": "2024-11-28T10:13:21.996955311Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:21.996955+00	2024-11-28 10:13:22.000093+00	2024-11-28 10:13:22.006884+00	\N	2024-11-28 10:08:21.997666+00	2024-11-28 10:13:22.007947+00	20c3d50e-6c1c-4e58-82b2-348220aee5dc	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bfdb727d-7f42-4084-af07-56a66f80b24d	default	5	{"job_id": "bfdb727d-7f42-4084-af07-56a66f80b24d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/32"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.011083768Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.011376+00	2024-11-28 10:08:22.012942+00	2024-11-28 10:08:22.026984+00	\N	2024-11-28 10:08:22.011376+00	2024-11-28 10:08:22.028555+00	bfdb727d-7f42-4084-af07-56a66f80b24d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b2e27425-1658-444a-9709-39ae5d4acd2d	default	5	{"job_id": "b2e27425-1658-444a-9709-39ae5d4acd2d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.024109052Z", "scheduled_at": "2024-11-28T10:13:22.023877465Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.023877+00	2024-11-28 10:13:22.026324+00	2024-11-28 10:13:22.030553+00	\N	2024-11-28 10:08:22.02449+00	2024-11-28 10:13:22.032668+00	b2e27425-1658-444a-9709-39ae5d4acd2d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
caa61aa7-a2ef-4a02-941b-ae9e2139a112	default	5	{"job_id": "caa61aa7-a2ef-4a02-941b-ae9e2139a112", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-11-28T10:08:21.971685000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.002158315Z", "scheduled_at": "2024-11-28T10:13:22.001939181Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.001939+00	2024-11-28 10:13:22.005451+00	2024-11-28 10:13:22.014761+00	\N	2024-11-28 10:08:22.002416+00	2024-11-28 10:13:22.015975+00	caa61aa7-a2ef-4a02-941b-ae9e2139a112	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
6f1d3e93-b460-44c8-b523-440fde0580d1	default	5	{"job_id": "6f1d3e93-b460-44c8-b523-440fde0580d1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.059051219Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.059254+00	2024-11-28 10:08:22.060529+00	2024-11-28 10:08:22.068263+00	\N	2024-11-28 10:08:22.059254+00	2024-11-28 10:08:22.069078+00	6f1d3e93-b460-44c8-b523-440fde0580d1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
d05809f5-7e41-4130-9c0e-d6a1a4c1231a	default	5	{"job_id": "d05809f5-7e41-4130-9c0e-d6a1a4c1231a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.066893077Z", "scheduled_at": "2024-11-28T10:13:22.066773561Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.066773+00	2024-11-28 10:13:22.069987+00	2024-11-28 10:13:22.07851+00	\N	2024-11-28 10:08:22.067085+00	2024-11-28 10:13:22.079798+00	d05809f5-7e41-4130-9c0e-d6a1a4c1231a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
94164e90-f48a-4f19-ae63-1a96f596987e	default	5	{"job_id": "94164e90-f48a-4f19-ae63-1a96f596987e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [32, {"value": "2024-11-28T10:08:22.010073000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.031191966Z", "scheduled_at": "2024-11-28T10:13:22.030904504Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.030904+00	2024-11-28 10:13:22.034293+00	2024-11-28 10:13:22.043899+00	\N	2024-11-28 10:08:22.031568+00	2024-11-28 10:13:22.045432+00	94164e90-f48a-4f19-ae63-1a96f596987e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
053d9d1d-7ff3-42e2-9d05-2a1f8f73a4d5	default	5	{"job_id": "053d9d1d-7ff3-42e2-9d05-2a1f8f73a4d5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.085999813Z", "scheduled_at": "2024-11-28T10:13:22.085867243Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.085867+00	2024-11-28 10:13:22.090923+00	2024-11-28 10:13:22.098975+00	\N	2024-11-28 10:08:22.086235+00	2024-11-28 10:13:22.100548+00	053d9d1d-7ff3-42e2-9d05-2a1f8f73a4d5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e16e43d8-d456-49b7-9705-91a26d4c4b11	default	5	{"job_id": "e16e43d8-d456-49b7-9705-91a26d4c4b11", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-11-28T10:08:22.039579000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.070267899Z", "scheduled_at": "2024-11-28T10:13:22.070125540Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.070125+00	2024-11-28 10:13:22.074217+00	2024-11-28 10:13:22.083733+00	\N	2024-11-28 10:08:22.07043+00	2024-11-28 10:13:22.085866+00	e16e43d8-d456-49b7-9705-91a26d4c4b11	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
b58cfc5d-51ff-4c19-b7dd-b89471f5def5	default	5	{"job_id": "b58cfc5d-51ff-4c19-b7dd-b89471f5def5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/33"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.078286239Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.078522+00	2024-11-28 10:08:22.079934+00	2024-11-28 10:08:22.087526+00	\N	2024-11-28 10:08:22.078522+00	2024-11-28 10:08:22.08836+00	b58cfc5d-51ff-4c19-b7dd-b89471f5def5	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
2b76361f-da93-4c60-859f-1e0d95fc905d	default	5	{"job_id": "2b76361f-da93-4c60-859f-1e0d95fc905d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-11-28T10:08:22.093397000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.138814488Z", "scheduled_at": "2024-11-28T10:13:22.138283005Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.138283+00	2024-11-28 10:13:22.140329+00	2024-11-28 10:13:22.144601+00	\N	2024-11-28 10:08:22.139082+00	2024-11-28 10:13:22.145522+00	2b76361f-da93-4c60-859f-1e0d95fc905d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
80acd075-1878-407d-96b6-e311e7966fef	default	5	{"job_id": "80acd075-1878-407d-96b6-e311e7966fef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.114895454Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.115263+00	2024-11-28 10:08:22.117047+00	2024-11-28 10:08:22.133134+00	\N	2024-11-28 10:08:22.115263+00	2024-11-28 10:08:22.136543+00	80acd075-1878-407d-96b6-e311e7966fef	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e9f080ab-eea5-48ca-8a43-655bcaf70be2	default	5	{"job_id": "e9f080ab-eea5-48ca-8a43-655bcaf70be2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [33, {"value": "2024-11-28T10:08:22.077108000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.089526072Z", "scheduled_at": "2024-11-28T10:13:22.089366822Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.089366+00	2024-11-28 10:13:22.094623+00	2024-11-28 10:13:22.104435+00	\N	2024-11-28 10:08:22.0897+00	2024-11-28 10:13:22.105216+00	e9f080ab-eea5-48ca-8a43-655bcaf70be2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
59687b49-dc31-4236-986a-2346ca268cdd	default	5	{"job_id": "59687b49-dc31-4236-986a-2346ca268cdd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.125601049Z", "scheduled_at": "2024-11-28T10:13:22.125414266Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.125414+00	2024-11-28 10:13:22.127502+00	2024-11-28 10:13:22.131841+00	\N	2024-11-28 10:08:22.125911+00	2024-11-28 10:13:22.132676+00	59687b49-dc31-4236-986a-2346ca268cdd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cddb7e0c-1c0b-4065-bde8-2299957fc097	default	5	{"job_id": "cddb7e0c-1c0b-4065-bde8-2299957fc097", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.270584074Z", "scheduled_at": "2024-11-28T10:13:22.270459589Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.270459+00	2024-11-28 10:13:22.274028+00	2024-11-28 10:13:22.283771+00	\N	2024-11-28 10:08:22.270782+00	2024-11-28 10:13:22.286923+00	cddb7e0c-1c0b-4065-bde8-2299957fc097	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
68f9895e-37ea-4ea8-a5fc-7e31656e1c92	default	5	{"job_id": "68f9895e-37ea-4ea8-a5fc-7e31656e1c92", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/34"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.156477879Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.156765+00	2024-11-28 10:08:22.159834+00	2024-11-28 10:08:22.185715+00	\N	2024-11-28 10:08:22.156765+00	2024-11-28 10:08:22.187193+00	68f9895e-37ea-4ea8-a5fc-7e31656e1c92	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
283fbc60-91ae-496b-91a6-9223e0c9b1b1	default	5	{"job_id": "283fbc60-91ae-496b-91a6-9223e0c9b1b1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.181919127Z", "scheduled_at": "2024-11-28T10:13:22.181741802Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.181741+00	2024-11-28 10:13:22.18384+00	2024-11-28 10:13:22.188625+00	\N	2024-11-28 10:08:22.182219+00	2024-11-28 10:13:22.18998+00	283fbc60-91ae-496b-91a6-9223e0c9b1b1	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0b4eb3d3-2a54-42eb-9152-17fac3b9c66d	default	5	{"job_id": "0b4eb3d3-2a54-42eb-9152-17fac3b9c66d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.240028358Z", "scheduled_at": "2024-11-28T10:13:22.239893493Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.239893+00	2024-11-28 10:13:22.244367+00	2024-11-28 10:13:22.255183+00	\N	2024-11-28 10:08:22.240842+00	2024-11-28 10:13:22.257455+00	0b4eb3d3-2a54-42eb-9152-17fac3b9c66d	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
eef5eb68-5602-4dad-b3b5-c7638bde782f	default	5	{"job_id": "eef5eb68-5602-4dad-b3b5-c7638bde782f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.226454408Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.227335+00	2024-11-28 10:08:22.229319+00	2024-11-28 10:08:22.243195+00	\N	2024-11-28 10:08:22.227335+00	2024-11-28 10:08:22.244039+00	eef5eb68-5602-4dad-b3b5-c7638bde782f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1e04e968-b1d1-4d0a-afce-2ea25647005e	default	5	{"job_id": "1e04e968-b1d1-4d0a-afce-2ea25647005e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [34, {"value": "2024-11-28T10:08:22.153864000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.191557566Z", "scheduled_at": "2024-11-28T10:13:22.191306442Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.191306+00	2024-11-28 10:13:22.195871+00	2024-11-28 10:13:22.207167+00	\N	2024-11-28 10:08:22.191845+00	2024-11-28 10:13:22.208953+00	1e04e968-b1d1-4d0a-afce-2ea25647005e	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c25a6301-e982-4c9c-b96c-9d2ea2c4e1db	default	5	{"job_id": "c25a6301-e982-4c9c-b96c-9d2ea2c4e1db", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-11-28T10:08:22.200989000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.246403236Z", "scheduled_at": "2024-11-28T10:13:22.246250037Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.246249+00	2024-11-28 10:13:22.252405+00	2024-11-28 10:13:22.259639+00	\N	2024-11-28 10:08:22.24657+00	2024-11-28 10:13:22.260908+00	c25a6301-e982-4c9c-b96c-9d2ea2c4e1db	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f4ff5437-39a8-4013-a29a-9561e9ad22fb	default	5	{"job_id": "f4ff5437-39a8-4013-a29a-9561e9ad22fb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/35"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.258575079Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.258775+00	2024-11-28 10:08:22.260691+00	2024-11-28 10:08:22.273078+00	\N	2024-11-28 10:08:22.258775+00	2024-11-28 10:08:22.274512+00	f4ff5437-39a8-4013-a29a-9561e9ad22fb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
36e11c35-7d7a-4efe-9426-9db80de57bd0	default	5	{"job_id": "36e11c35-7d7a-4efe-9426-9db80de57bd0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [35, {"value": "2024-11-28T10:08:22.257541000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.276485546Z", "scheduled_at": "2024-11-28T10:13:22.276341735Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.276341+00	2024-11-28 10:13:22.280993+00	2024-11-28 10:13:22.297823+00	\N	2024-11-28 10:08:22.277033+00	2024-11-28 10:13:22.300107+00	36e11c35-7d7a-4efe-9426-9db80de57bd0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3f168c50-f856-45e7-b2c4-d1c67bfe3256	default	5	{"job_id": "3f168c50-f856-45e7-b2c4-d1c67bfe3256", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.308742424Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.309478+00	2024-11-28 10:08:22.310829+00	2024-11-28 10:08:22.324318+00	\N	2024-11-28 10:08:22.309478+00	2024-11-28 10:08:22.326232+00	3f168c50-f856-45e7-b2c4-d1c67bfe3256	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0d3d95c2-bf35-4075-9866-94e58ac7e780	default	5	{"job_id": "0d3d95c2-bf35-4075-9866-94e58ac7e780", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-11-28T10:08:22.285489000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.327810358Z", "scheduled_at": "2024-11-28T10:13:22.327662098Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.327661+00	2024-11-28 10:13:22.332914+00	2024-11-28 10:13:22.340395+00	\N	2024-11-28 10:08:22.327974+00	2024-11-28 10:13:22.341639+00	0d3d95c2-bf35-4075-9866-94e58ac7e780	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
01a6e046-b51f-4956-963f-c8e7b4362d2f	default	5	{"job_id": "01a6e046-b51f-4956-963f-c8e7b4362d2f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.321344659Z", "scheduled_at": "2024-11-28T10:13:22.321217068Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.321217+00	2024-11-28 10:13:22.325512+00	2024-11-28 10:13:22.335576+00	\N	2024-11-28 10:08:22.321885+00	2024-11-28 10:13:22.337897+00	01a6e046-b51f-4956-963f-c8e7b4362d2f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
711aff1c-9d1e-43a6-ab1f-1c34094cf232	default	5	{"job_id": "711aff1c-9d1e-43a6-ab1f-1c34094cf232", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.348979528Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.349183+00	2024-11-28 10:08:22.350767+00	2024-11-28 10:08:22.363387+00	\N	2024-11-28 10:08:22.349183+00	2024-11-28 10:08:22.364868+00	711aff1c-9d1e-43a6-ab1f-1c34094cf232	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cd74b31f-cf08-43c1-8f9b-cc3c8bd24b80	default	5	{"job_id": "cd74b31f-cf08-43c1-8f9b-cc3c8bd24b80", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.333671000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.367222084Z", "scheduled_at": "2024-11-28T10:13:22.367069667Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.367069+00	2024-11-28 10:13:22.373722+00	2024-11-28 10:13:22.450513+00	\N	2024-11-28 10:08:22.367757+00	2024-11-28 10:13:22.454613+00	cd74b31f-cf08-43c1-8f9b-cc3c8bd24b80	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c4ac695e-9503-4d50-8366-ffef9ffea36a	default	5	{"job_id": "c4ac695e-9503-4d50-8366-ffef9ffea36a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.360398449Z", "scheduled_at": "2024-11-28T10:13:22.359915878Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.359915+00	2024-11-28 10:13:22.363457+00	2024-11-28 10:13:22.371741+00	\N	2024-11-28 10:08:22.361017+00	2024-11-28 10:13:22.437199+00	c4ac695e-9503-4d50-8366-ffef9ffea36a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cd6ecc21-0cae-4b36-a3d3-b55cc24497b1	default	5	{"job_id": "cd6ecc21-0cae-4b36-a3d3-b55cc24497b1", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.404644000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.460291207Z", "scheduled_at": "2024-11-28T10:13:22.458835467Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.458835+00	2024-11-28 10:13:22.46616+00	2024-11-28 10:13:22.476555+00	\N	2024-11-28 10:08:22.460647+00	2024-11-28 10:13:22.477833+00	cd6ecc21-0cae-4b36-a3d3-b55cc24497b1	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
2f270b2e-b8af-4cc0-a212-a482ce34129b	default	5	{"job_id": "2f270b2e-b8af-4cc0-a212-a482ce34129b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.379322602Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.379513+00	2024-11-28 10:08:22.383144+00	2024-11-28 10:08:22.396513+00	\N	2024-11-28 10:08:22.379513+00	2024-11-28 10:08:22.397823+00	2f270b2e-b8af-4cc0-a212-a482ce34129b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a93f4ccc-b237-472a-8575-4cf68148edf7	default	5	{"job_id": "a93f4ccc-b237-472a-8575-4cf68148edf7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.394386596Z", "scheduled_at": "2024-11-28T10:13:22.394258474Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.394258+00	2024-11-28 10:13:22.445019+00	2024-11-28 10:13:22.456422+00	\N	2024-11-28 10:08:22.394583+00	2024-11-28 10:13:22.459953+00	a93f4ccc-b237-472a-8575-4cf68148edf7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e0740287-6223-4cfd-bc85-69eca59eabc0	default	5	{"job_id": "e0740287-6223-4cfd-bc85-69eca59eabc0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/37"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.425600865Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.42603+00	2024-11-28 10:08:22.429316+00	2024-11-28 10:08:22.452896+00	\N	2024-11-28 10:08:22.42603+00	2024-11-28 10:08:22.455678+00	e0740287-6223-4cfd-bc85-69eca59eabc0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
30d5f589-25e4-4a8a-a0e5-4bc6d6f39e5d	default	5	{"job_id": "30d5f589-25e4-4a8a-a0e5-4bc6d6f39e5d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [37, {"value": "2024-11-28T10:08:22.377686000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.399589180Z", "scheduled_at": "2024-11-28T10:13:22.399051815Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.399051+00	2024-11-28 10:13:22.441524+00	2024-11-28 10:13:22.457262+00	\N	2024-11-28 10:08:22.400059+00	2024-11-28 10:13:22.46168+00	30d5f589-25e4-4a8a-a0e5-4bc6d6f39e5d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
e5df4be5-61d7-46c9-b94f-df8129ac0392	default	5	{"job_id": "e5df4be5-61d7-46c9-b94f-df8129ac0392", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.448168196Z", "scheduled_at": "2024-11-28T10:13:22.447926540Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.447926+00	2024-11-28 10:13:22.453192+00	2024-11-28 10:13:22.465342+00	\N	2024-11-28 10:08:22.449339+00	2024-11-28 10:13:22.469722+00	e5df4be5-61d7-46c9-b94f-df8129ac0392	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f5bfd5ce-1160-4d37-80e1-54b2a6b3c246	default	5	{"job_id": "f5bfd5ce-1160-4d37-80e1-54b2a6b3c246", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/36"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.481790460Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.481982+00	2024-11-28 10:08:22.484351+00	2024-11-28 10:08:22.499316+00	\N	2024-11-28 10:08:22.481982+00	2024-11-28 10:08:22.501196+00	f5bfd5ce-1160-4d37-80e1-54b2a6b3c246	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ccc6a0fd-5325-418b-973c-ed4707fb8140	default	5	{"job_id": "ccc6a0fd-5325-418b-973c-ed4707fb8140", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.494207256Z", "scheduled_at": "2024-11-28T10:13:22.494071800Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.494071+00	2024-11-28 10:13:22.496926+00	2024-11-28 10:13:22.50121+00	\N	2024-11-28 10:08:22.495148+00	2024-11-28 10:13:22.501951+00	ccc6a0fd-5325-418b-973c-ed4707fb8140	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b3c6f575-2771-469d-98bf-d1b6125d17bb	default	5	{"job_id": "b3c6f575-2771-469d-98bf-d1b6125d17bb", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.536184016Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.536384+00	2024-11-28 10:08:22.538132+00	2024-11-28 10:08:22.551015+00	\N	2024-11-28 10:08:22.536384+00	2024-11-28 10:08:22.552045+00	b3c6f575-2771-469d-98bf-d1b6125d17bb	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0897d36f-7cb0-41f9-977f-5be2b9e2768b	default	5	{"job_id": "0897d36f-7cb0-41f9-977f-5be2b9e2768b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.546846750Z", "scheduled_at": "2024-11-28T10:13:22.546711204Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.546711+00	2024-11-28 10:13:22.549505+00	2024-11-28 10:13:22.553789+00	\N	2024-11-28 10:08:22.54705+00	2024-11-28 10:13:22.5554+00	0897d36f-7cb0-41f9-977f-5be2b9e2768b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
385fd604-b08b-4438-9135-d780990240c2	default	5	{"job_id": "385fd604-b08b-4438-9135-d780990240c2", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [36, {"value": "2024-11-28T10:08:22.480602000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.503860954Z", "scheduled_at": "2024-11-28T10:13:22.502554938Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.502554+00	2024-11-28 10:13:22.505178+00	2024-11-28 10:13:22.510433+00	\N	2024-11-28 10:08:22.504078+00	2024-11-28 10:13:22.511851+00	385fd604-b08b-4438-9135-d780990240c2	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
d73be670-2839-41b0-aa9b-bada981c58b8	default	5	{"job_id": "d73be670-2839-41b0-aa9b-bada981c58b8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/38"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.568313072Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.568515+00	2024-11-28 10:08:22.570503+00	2024-11-28 10:08:22.582822+00	\N	2024-11-28 10:08:22.568515+00	2024-11-28 10:08:22.584137+00	d73be670-2839-41b0-aa9b-bada981c58b8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8f415b59-0602-4f4b-a9ab-c579dd61a295	default	5	{"job_id": "8f415b59-0602-4f4b-a9ab-c579dd61a295", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.580329311Z", "scheduled_at": "2024-11-28T10:13:22.580195058Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.580195+00	2024-11-28 10:13:22.582867+00	2024-11-28 10:13:22.586413+00	\N	2024-11-28 10:08:22.580533+00	2024-11-28 10:13:22.587824+00	8f415b59-0602-4f4b-a9ab-c579dd61a295	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c08db6ad-4684-4c43-8f1c-2d06de3db6ef	default	5	{"job_id": "c08db6ad-4684-4c43-8f1c-2d06de3db6ef", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-11-28T10:08:22.512770000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.554406273Z", "scheduled_at": "2024-11-28T10:13:22.554260307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.55426+00	2024-11-28 10:13:22.556772+00	2024-11-28 10:13:22.562681+00	\N	2024-11-28 10:08:22.554569+00	2024-11-28 10:13:22.56366+00	c08db6ad-4684-4c43-8f1c-2d06de3db6ef	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
5169fb9f-ffbd-4c43-abde-dbfb34b07634	default	5	{"job_id": "5169fb9f-ffbd-4c43-abde-dbfb34b07634", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.655170996Z", "scheduled_at": "2024-11-28T10:13:22.655043966Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.655043+00	2024-11-28 10:13:22.656834+00	2024-11-28 10:13:22.660345+00	\N	2024-11-28 10:08:22.655733+00	2024-11-28 10:13:22.662485+00	5169fb9f-ffbd-4c43-abde-dbfb34b07634	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b1a7a3cb-d7d9-43e5-b785-2d8708d21354	default	5	{"job_id": "b1a7a3cb-d7d9-43e5-b785-2d8708d21354", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [38, {"value": "2024-11-28T10:08:22.566251000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.586983144Z", "scheduled_at": "2024-11-28T10:13:22.586813794Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.586813+00	2024-11-28 10:13:22.589564+00	2024-11-28 10:13:22.597638+00	\N	2024-11-28 10:08:22.587168+00	2024-11-28 10:13:22.598768+00	b1a7a3cb-d7d9-43e5-b785-2d8708d21354	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
da6d9652-21ab-4a9f-8239-614629a29ac7	default	5	{"job_id": "da6d9652-21ab-4a9f-8239-614629a29ac7", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.614064098Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.614273+00	2024-11-28 10:08:22.61717+00	2024-11-28 10:08:22.628611+00	\N	2024-11-28 10:08:22.614273+00	2024-11-28 10:08:22.629934+00	da6d9652-21ab-4a9f-8239-614629a29ac7	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
10d4f9b2-1c37-4368-b5f6-f607cc7a029b	default	5	{"job_id": "10d4f9b2-1c37-4368-b5f6-f607cc7a029b", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.626248495Z", "scheduled_at": "2024-11-28T10:13:22.625726338Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.625726+00	2024-11-28 10:13:22.629019+00	2024-11-28 10:13:22.634018+00	\N	2024-11-28 10:08:22.626451+00	2024-11-28 10:13:22.634872+00	10d4f9b2-1c37-4368-b5f6-f607cc7a029b	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
3e68f122-3ea8-4434-930e-4e3a6f800c65	default	5	{"job_id": "3e68f122-3ea8-4434-930e-4e3a6f800c65", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/39"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.644093830Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.644673+00	2024-11-28 10:08:22.64604+00	2024-11-28 10:08:22.657515+00	\N	2024-11-28 10:08:22.644673+00	2024-11-28 10:08:22.659272+00	3e68f122-3ea8-4434-930e-4e3a6f800c65	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ae271d50-fd37-4ced-ab9f-288c029be092	default	5	{"job_id": "ae271d50-fd37-4ced-ab9f-288c029be092", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-11-28T10:08:22.598123000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.632535165Z", "scheduled_at": "2024-11-28T10:13:22.632381716Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.632381+00	2024-11-28 10:13:22.635689+00	2024-11-28 10:13:22.640663+00	\N	2024-11-28 10:08:22.632707+00	2024-11-28 10:13:22.64156+00	ae271d50-fd37-4ced-ab9f-288c029be092	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
dc2dfe42-a1a3-4b1f-86c3-02097d816499	default	5	{"job_id": "dc2dfe42-a1a3-4b1f-86c3-02097d816499", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [39, {"value": "2024-11-28T10:08:22.642994000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.661187155Z", "scheduled_at": "2024-11-28T10:13:22.660315659Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.660315+00	2024-11-28 10:13:22.663312+00	2024-11-28 10:13:22.670531+00	\N	2024-11-28 10:08:22.661388+00	2024-11-28 10:13:22.67154+00	dc2dfe42-a1a3-4b1f-86c3-02097d816499	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
a966413a-2fe4-48b3-bef8-05253680fac8	default	5	{"job_id": "a966413a-2fe4-48b3-bef8-05253680fac8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.731179554Z", "scheduled_at": "2024-11-28T10:13:22.731025653Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.731025+00	2024-11-28 10:13:22.732984+00	2024-11-28 10:13:22.736635+00	\N	2024-11-28 10:08:22.731395+00	2024-11-28 10:13:22.739229+00	a966413a-2fe4-48b3-bef8-05253680fac8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
990999a4-26c5-4750-b904-163163ff5d9f	default	5	{"job_id": "990999a4-26c5-4750-b904-163163ff5d9f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.688819231Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.68984+00	2024-11-28 10:08:22.691588+00	2024-11-28 10:08:22.703638+00	\N	2024-11-28 10:08:22.68984+00	2024-11-28 10:08:22.70504+00	990999a4-26c5-4750-b904-163163ff5d9f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
06cb6d4c-a230-460a-b7f0-6001c5a5660e	default	5	{"job_id": "06cb6d4c-a230-460a-b7f0-6001c5a5660e", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.701916701Z", "scheduled_at": "2024-11-28T10:13:22.701254541Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.701254+00	2024-11-28 10:13:22.703555+00	2024-11-28 10:13:22.708793+00	\N	2024-11-28 10:08:22.702117+00	2024-11-28 10:13:22.711881+00	06cb6d4c-a230-460a-b7f0-6001c5a5660e	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f7c4d01f-9458-43c3-b1a9-35a48014ef76	default	5	{"job_id": "f7c4d01f-9458-43c3-b1a9-35a48014ef76", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/40"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.719058036Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.719255+00	2024-11-28 10:08:22.721205+00	2024-11-28 10:08:22.734152+00	\N	2024-11-28 10:08:22.719255+00	2024-11-28 10:08:22.735176+00	f7c4d01f-9458-43c3-b1a9-35a48014ef76	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
f580385a-e883-416a-9e8b-77110d5bf4bc	default	5	{"job_id": "f580385a-e883-416a-9e8b-77110d5bf4bc", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-11-28T10:08:22.673149000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.707061184Z", "scheduled_at": "2024-11-28T10:13:22.706234153Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.706234+00	2024-11-28 10:13:22.710235+00	2024-11-28 10:13:22.717366+00	\N	2024-11-28 10:08:22.708615+00	2024-11-28 10:13:22.718848+00	f580385a-e883-416a-9e8b-77110d5bf4bc	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
bf66b7df-5ad1-41ee-a1de-2d494480fa73	default	5	{"job_id": "bf66b7df-5ad1-41ee-a1de-2d494480fa73", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [40, {"value": "2024-11-28T10:08:22.718327000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.737098740Z", "scheduled_at": "2024-11-28T10:13:22.736929480Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.736929+00	2024-11-28 10:13:22.740478+00	2024-11-28 10:13:22.750509+00	\N	2024-11-28 10:08:22.737291+00	2024-11-28 10:13:22.751976+00	bf66b7df-5ad1-41ee-a1de-2d494480fa73	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
3e060bc6-cff8-4700-b9ec-135314beb919	default	5	{"job_id": "3e060bc6-cff8-4700-b9ec-135314beb919", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.776741965Z", "scheduled_at": "2024-11-28T10:13:22.775635455Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.775635+00	2024-11-28 10:13:22.778729+00	2024-11-28 10:13:22.783511+00	\N	2024-11-28 10:08:22.776959+00	2024-11-28 10:13:22.785892+00	3e060bc6-cff8-4700-b9ec-135314beb919	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
89dbef8e-ffb2-4813-9f97-8e2072387ff4	default	5	{"job_id": "89dbef8e-ffb2-4813-9f97-8e2072387ff4", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.763166000Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.76415+00	2024-11-28 10:08:22.765838+00	2024-11-28 10:08:22.778975+00	\N	2024-11-28 10:08:22.76415+00	2024-11-28 10:08:22.779837+00	89dbef8e-ffb2-4813-9f97-8e2072387ff4	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
e4b0cb0f-907c-4f8f-94ac-b47f674b37f8	default	5	{"job_id": "e4b0cb0f-907c-4f8f-94ac-b47f674b37f8", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.805384767Z", "scheduled_at": "2024-11-28T10:13:22.804955857Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.804955+00	2024-11-28 10:13:22.806879+00	2024-11-28 10:13:22.81167+00	\N	2024-11-28 10:08:22.805591+00	2024-11-28 10:13:22.81267+00	e4b0cb0f-907c-4f8f-94ac-b47f674b37f8	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
66bcf7a2-2fd8-4981-ac3c-c6df7fe67456	default	5	{"job_id": "66bcf7a2-2fd8-4981-ac3c-c6df7fe67456", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-11-28T10:08:22.746200000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.782214327Z", "scheduled_at": "2024-11-28T10:13:22.782060356Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.78206+00	2024-11-28 10:13:22.784604+00	2024-11-28 10:13:22.790075+00	\N	2024-11-28 10:08:22.782382+00	2024-11-28 10:13:22.790825+00	66bcf7a2-2fd8-4981-ac3c-c6df7fe67456	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c97c2b3c-5c47-47b6-a2cf-6502d0dcfd3f	default	5	{"job_id": "c97c2b3c-5c47-47b6-a2cf-6502d0dcfd3f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/41"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.793781398Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.793979+00	2024-11-28 10:08:22.795735+00	2024-11-28 10:08:22.807275+00	\N	2024-11-28 10:08:22.793979+00	2024-11-28 10:08:22.808522+00	c97c2b3c-5c47-47b6-a2cf-6502d0dcfd3f	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
a6f08055-5ef2-4d8b-9eea-b105689818b5	default	5	{"job_id": "a6f08055-5ef2-4d8b-9eea-b105689818b5", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-11-28T10:08:22.818407000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.851392739Z", "scheduled_at": "2024-11-28T10:13:22.851238388Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.851238+00	2024-11-28 10:13:22.854615+00	2024-11-28 10:13:22.860737+00	\N	2024-11-28 10:08:22.851612+00	2024-11-28 10:13:22.861752+00	a6f08055-5ef2-4d8b-9eea-b105689818b5	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c8bfea28-d84a-4621-a035-162f173e6999	default	5	{"job_id": "c8bfea28-d84a-4621-a035-162f173e6999", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.847194993Z", "scheduled_at": "2024-11-28T10:13:22.847068835Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.847069+00	2024-11-28 10:13:22.849273+00	2024-11-28 10:13:22.854044+00	\N	2024-11-28 10:08:22.847393+00	2024-11-28 10:13:22.855803+00	c8bfea28-d84a-4621-a035-162f173e6999	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
445b5a17-3d50-4890-a311-b87a3faf9e61	default	5	{"job_id": "445b5a17-3d50-4890-a311-b87a3faf9e61", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.834146825Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.83435+00	2024-11-28 10:08:22.836134+00	2024-11-28 10:08:22.849037+00	\N	2024-11-28 10:08:22.83435+00	2024-11-28 10:08:22.850053+00	445b5a17-3d50-4890-a311-b87a3faf9e61	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
cb22cdab-a8c6-4811-af35-70e4a5231d17	default	5	{"job_id": "cb22cdab-a8c6-4811-af35-70e4a5231d17", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [41, {"value": "2024-11-28T10:08:22.792691000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.810424743Z", "scheduled_at": "2024-11-28T10:13:22.809922024Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.809921+00	2024-11-28 10:13:22.813488+00	2024-11-28 10:13:22.821376+00	\N	2024-11-28 10:08:22.810599+00	2024-11-28 10:13:22.822291+00	cb22cdab-a8c6-4811-af35-70e4a5231d17	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
926158a2-5b83-407a-abf7-5642092392f0	default	5	{"job_id": "926158a2-5b83-407a-abf7-5642092392f0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.906573691Z", "scheduled_at": "2024-11-28T10:13:22.906431993Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.906431+00	2024-11-28 10:13:22.909407+00	2024-11-28 10:13:22.917266+00	\N	2024-11-28 10:08:22.90678+00	2024-11-28 10:13:22.918473+00	926158a2-5b83-407a-abf7-5642092392f0	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
45b9c960-7896-44c7-8ce0-e51e664639fd	default	5	{"job_id": "45b9c960-7896-44c7-8ce0-e51e664639fd", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.870532979Z", "scheduled_at": "2024-11-28T10:13:22.870412441Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.870412+00	2024-11-28 10:13:22.872866+00	2024-11-28 10:13:22.877888+00	\N	2024-11-28 10:08:22.870725+00	2024-11-28 10:13:22.878959+00	45b9c960-7896-44c7-8ce0-e51e664639fd	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
588237e8-ed9f-413f-b0f1-266c3191f2a3	default	5	{"job_id": "588237e8-ed9f-413f-b0f1-266c3191f2a3", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/42"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.860987005Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.86119+00	2024-11-28 10:08:22.863657+00	2024-11-28 10:08:22.872722+00	\N	2024-11-28 10:08:22.86119+00	2024-11-28 10:08:22.87434+00	588237e8-ed9f-413f-b0f1-266c3191f2a3	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
93adb768-e228-4f4b-8677-165a8c17dc88	default	5	{"job_id": "93adb768-e228-4f4b-8677-165a8c17dc88", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-11-28T10:08:22.885644000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.910590846Z", "scheduled_at": "2024-11-28T10:13:22.910446704Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.910446+00	2024-11-28 10:13:22.914026+00	2024-11-28 10:13:22.920749+00	\N	2024-11-28 10:08:22.910753+00	2024-11-28 10:13:22.922377+00	93adb768-e228-4f4b-8677-165a8c17dc88	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
53cf632f-842f-4142-85f2-3ff37807d20f	default	5	{"job_id": "53cf632f-842f-4142-85f2-3ff37807d20f", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [42, {"value": "2024-11-28T10:08:22.859774000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.876793009Z", "scheduled_at": "2024-11-28T10:13:22.876509704Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.876509+00	2024-11-28 10:13:22.880028+00	2024-11-28 10:13:22.890131+00	\N	2024-11-28 10:08:22.877165+00	2024-11-28 10:13:22.89118+00	53cf632f-842f-4142-85f2-3ff37807d20f	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
542e7688-683f-4dc0-8ff0-2e6f87866c65	default	5	{"job_id": "542e7688-683f-4dc0-8ff0-2e6f87866c65", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.899131840Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.899336+00	2024-11-28 10:08:22.900472+00	2024-11-28 10:08:22.908494+00	\N	2024-11-28 10:08:22.899336+00	2024-11-28 10:08:22.909451+00	542e7688-683f-4dc0-8ff0-2e6f87866c65	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
bb7ab98f-31c9-4ae8-b20c-fba0c5b3a619	default	5	{"job_id": "bb7ab98f-31c9-4ae8-b20c-fba0c5b3a619", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/43"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.917452672Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.917646+00	2024-11-28 10:08:22.918888+00	2024-11-28 10:08:22.926996+00	\N	2024-11-28 10:08:22.917646+00	2024-11-28 10:08:22.927807+00	bb7ab98f-31c9-4ae8-b20c-fba0c5b3a619	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
b54a19de-5bb9-48da-ae99-e0b2eb7cd704	default	5	{"job_id": "b54a19de-5bb9-48da-ae99-e0b2eb7cd704", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.925464129Z", "scheduled_at": "2024-11-28T10:13:22.925297024Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.925297+00	2024-11-28 10:13:22.927319+00	2024-11-28 10:13:22.931049+00	\N	2024-11-28 10:08:22.925682+00	2024-11-28 10:13:22.933437+00	b54a19de-5bb9-48da-ae99-e0b2eb7cd704	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
0f2b4a02-05d5-424f-b113-ec877e198d31	default	5	{"job_id": "0f2b4a02-05d5-424f-b113-ec877e198d31", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.945192892Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.945431+00	2024-11-28 10:08:22.946832+00	2024-11-28 10:08:22.956177+00	\N	2024-11-28 10:08:22.945431+00	2024-11-28 10:08:22.957161+00	0f2b4a02-05d5-424f-b113-ec877e198d31	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
6f96efce-89d1-4307-8608-552d0d3e424d	default	5	{"job_id": "6f96efce-89d1-4307-8608-552d0d3e424d", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [43, {"value": "2024-11-28T10:08:22.916636000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.928876602Z", "scheduled_at": "2024-11-28T10:13:22.928733612Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.928733+00	2024-11-28 10:13:22.932228+00	2024-11-28 10:13:22.940582+00	\N	2024-11-28 10:08:22.929066+00	2024-11-28 10:13:22.941662+00	6f96efce-89d1-4307-8608-552d0d3e424d	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
f878aaa9-54ed-4bb8-8f04-c1ddfd1d1b54	default	5	{"job_id": "f878aaa9-54ed-4bb8-8f04-c1ddfd1d1b54", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/44"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.965524010Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:22.965717+00	2024-11-28 10:08:22.967027+00	2024-11-28 10:08:22.974997+00	\N	2024-11-28 10:08:22.965717+00	2024-11-28 10:08:22.975816+00	f878aaa9-54ed-4bb8-8f04-c1ddfd1d1b54	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
8f6b0879-5dd3-4225-aa52-29ef8dff7030	default	5	{"job_id": "8f6b0879-5dd3-4225-aa52-29ef8dff7030", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.954450471Z", "scheduled_at": "2024-11-28T10:13:22.954294326Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.954294+00	2024-11-28 10:13:22.957391+00	2024-11-28 10:13:22.966851+00	\N	2024-11-28 10:08:22.954663+00	2024-11-28 10:13:22.968717+00	8f6b0879-5dd3-4225-aa52-29ef8dff7030	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
559f0657-5d39-458d-827d-c308a8b86b83	default	5	{"job_id": "559f0657-5d39-458d-827d-c308a8b86b83", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-11-28T10:08:22.933187000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.958561644Z", "scheduled_at": "2024-11-28T10:13:22.958384470Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.958384+00	2024-11-28 10:13:22.962621+00	2024-11-28 10:13:22.970839+00	\N	2024-11-28 10:08:22.958778+00	2024-11-28 10:13:22.972662+00	559f0657-5d39-458d-827d-c308a8b86b83	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
4a8af9e7-371c-4f10-bfa8-ab548408f9fa	default	5	{"job_id": "4a8af9e7-371c-4f10-bfa8-ab548408f9fa", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.973335039Z", "scheduled_at": "2024-11-28T10:13:22.972885700Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.972885+00	2024-11-28 10:13:22.976871+00	2024-11-28 10:13:22.983936+00	\N	2024-11-28 10:08:22.973553+00	2024-11-28 10:13:22.985027+00	4a8af9e7-371c-4f10-bfa8-ab548408f9fa	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
084c4d35-3f0d-45d6-9cb8-0f347201c9a0	default	5	{"job_id": "084c4d35-3f0d-45d6-9cb8-0f347201c9a0", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [44, {"value": "2024-11-28T10:08:22.964534000Z", "time_zone": "Etc/UTC", "_aj_serialized": "ActiveJob::Serializers::TimeWithZoneSerializer"}, false], "job_class": "Journals::CompletedJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:22.976937029Z", "scheduled_at": "2024-11-28T10:13:22.976796554Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:22.976796+00	2024-11-28 10:13:22.980692+00	2024-11-28 10:13:22.990898+00	\N	2024-11-28 10:08:22.977128+00	2024-11-28 10:13:22.992046+00	084c4d35-3f0d-45d6-9cb8-0f347201c9a0	\N	\N	\N	\N	\N	\N	t	1	Journals::CompletedJob	\N	\N
c58cf412-23b3-4d9c-bca8-e370f9648234	default	5	{"job_id": "c58cf412-23b3-4d9c-bca8-e370f9648234", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/45"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.094278903Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:23.094489+00	2024-11-28 10:08:23.095666+00	2024-11-28 10:08:23.104251+00	\N	2024-11-28 10:08:23.094489+00	2024-11-28 10:08:23.105441+00	c58cf412-23b3-4d9c-bca8-e370f9648234	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
1c050739-2a43-4159-84f5-9b1c610dbb10	default	5	{"job_id": "1c050739-2a43-4159-84f5-9b1c610dbb10", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.102820942Z", "scheduled_at": "2024-11-28T10:13:23.102696307Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:23.102696+00	2024-11-28 10:13:23.105846+00	2024-11-28 10:13:23.113512+00	\N	2024-11-28 10:08:23.10301+00	2024-11-28 10:13:23.114696+00	1c050739-2a43-4159-84f5-9b1c610dbb10	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
ea1ca0a6-0126-4310-8cb8-168c5fe4080a	default	5	{"job_id": "ea1ca0a6-0126-4310-8cb8-168c5fe4080a", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "create_notifications", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}, {"_aj_globalid": "gid://open-project/Journal/46"}, false], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.132385455Z", "scheduled_at": null, "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:08:23.133023+00	2024-11-28 10:08:23.134608+00	2024-11-28 10:08:23.143222+00	\N	2024-11-28 10:08:23.133023+00	2024-11-28 10:08:23.144633+00	ea1ca0a6-0126-4310-8cb8-168c5fe4080a	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
c7e70ff4-608b-479e-8447-4f56127cb007	default	5	{"job_id": "c7e70ff4-608b-479e-8447-4f56127cb007", "locale": "en", "priority": 5, "timezone": "UTC", "arguments": [{"value": "send_mails", "_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"}], "job_class": "Notifications::WorkflowJob", "executions": 0, "queue_name": "default", "enqueued_at": "2024-11-28T10:08:23.140861120Z", "scheduled_at": "2024-11-28T10:13:23.140659098Z", "provider_job_id": null, "exception_executions": {}}	2024-11-28 10:13:23.140659+00	2024-11-28 10:13:23.144109+00	2024-11-28 10:13:23.149425+00	\N	2024-11-28 10:08:23.141199+00	2024-11-28 10:13:23.150567+00	c7e70ff4-608b-479e-8447-4f56127cb007	\N	\N	\N	\N	\N	\N	t	1	Notifications::WorkflowJob	\N	\N
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
33	1	3	1	2	project_description	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project description\n	8
34	1	2	2	3	project_status	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project status\n	8
35	3	4	1	3	work_packages_overview	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages overview\n	8
36	2	3	2	3	members	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Members\n	8
37	1	2	1	2	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: 27\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  manual_sort: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: ow\n    values: []\n	9
38	1	2	2	3	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '28'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  manualSort: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: ow\n    values: []\n	9
\.


--
-- Data for Name: grids; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.grids (id, row_count, column_count, type, user_id, created_at, updated_at, project_id, name, options) FROM stdin;
1	1	4	Boards::Grid	\N	2024-11-28 10:08:20.586886+00	2024-11-28 10:08:20.586886+00	1	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n:filters:\n- :type:\n    :operator: "="\n    :values:\n    - '1'\n
2	1	4	Boards::Grid	\N	2024-11-28 10:08:20.626529+00	2024-11-28 10:08:20.626529+00	1	Basic board	---\nhighlightingMode: priority\n
3	1	2	Boards::Grid	\N	2024-11-28 10:08:20.6576+00	2024-11-28 10:08:20.6576+00	1	Work breakdown structure	---\ntype: action\nattribute: subtasks\n
4	1	4	Boards::Grid	\N	2024-11-28 10:08:23.003686+00	2024-11-28 10:08:23.003686+00	2	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n
5	1	4	Boards::Grid	\N	2024-11-28 10:08:23.037451+00	2024-11-28 10:08:23.037451+00	2	Task board	---\nhighlightingMode: priority\n
6	6	2	Grids::Overview	\N	2024-11-28 10:08:23.056631+00	2024-11-28 10:08:23.056631+00	1	\N	\N
7	6	2	Grids::Overview	\N	2024-11-28 10:08:23.118531+00	2024-11-28 10:08:23.118531+00	2	\N	\N
8	3	2	Grids::Overview	\N	2024-11-28 10:13:28.064343+00	2024-11-28 10:13:28.064343+00	3	\N	\N
9	1	2	Boards::Grid	\N	2024-11-28 10:13:51.894366+00	2024-11-28 10:13:55.884514+00	3	sprint1	---\n:type: free\n
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
1	Project	1	3		2024-11-28 10:08:19.070962+00	1	2024-11-28 10:08:19.070962+00	Journal::ProjectJournal	1	{}	["2024-11-28 10:08:19.070962+00",)
2	News	1	3		2024-11-28 10:08:19.299321+00	1	2024-11-28 10:08:19.299321+00	Journal::NewsJournal	1	{}	["2024-11-28 10:08:19.299321+00",)
3	WikiPage	1	3		2024-11-28 10:08:19.493076+00	1	2024-11-28 10:08:19.493076+00	Journal::WikiPageJournal	1	{}	["2024-11-28 10:08:19.493076+00",)
4	WorkPackage	1	3		2024-11-28 10:08:19.556742+00	1	2024-11-28 10:08:19.630954+00	Journal::WorkPackageJournal	2	{}	["2024-11-28 10:08:19.556742+00",)
7	WorkPackage	4	3		2024-11-28 10:08:19.717776+00	1	2024-11-28 10:08:19.776038+00	Journal::WorkPackageJournal	7	{}	["2024-11-28 10:08:19.717776+00",)
8	WorkPackage	5	3		2024-11-28 10:08:19.816175+00	1	2024-11-28 10:08:19.867761+00	Journal::WorkPackageJournal	10	{}	["2024-11-28 10:08:19.816175+00",)
9	WorkPackage	6	3		2024-11-28 10:08:19.898109+00	1	2024-11-28 10:08:19.946665+00	Journal::WorkPackageJournal	13	{}	["2024-11-28 10:08:19.898109+00",)
6	WorkPackage	3	3		2024-11-28 10:08:19.68823+00	1	2024-11-28 10:08:20.008764+00	Journal::WorkPackageJournal	15	{}	["2024-11-28 10:08:19.68823+00",)
10	WorkPackage	7	3		2024-11-28 10:08:20.056157+00	1	2024-11-28 10:08:20.107544+00	Journal::WorkPackageJournal	18	{}	["2024-11-28 10:08:20.056157+00",)
11	WorkPackage	8	3		2024-11-28 10:08:20.142161+00	1	2024-11-28 10:08:20.185332+00	Journal::WorkPackageJournal	21	{}	["2024-11-28 10:08:20.142161+00",)
5	WorkPackage	2	3		2024-11-28 10:08:19.6563+00	1	2024-11-28 10:08:20.216647+00	Journal::WorkPackageJournal	22	{}	["2024-11-28 10:08:19.6563+00",)
12	WorkPackage	9	3		2024-11-28 10:08:20.237479+00	1	2024-11-28 10:08:20.264772+00	Journal::WorkPackageJournal	24	{}	["2024-11-28 10:08:20.237479+00",)
14	WorkPackage	11	3		2024-11-28 10:08:20.30441+00	1	2024-11-28 10:08:20.357162+00	Journal::WorkPackageJournal	28	{}	["2024-11-28 10:08:20.30441+00",)
15	WorkPackage	12	3		2024-11-28 10:08:20.391412+00	1	2024-11-28 10:08:20.440651+00	Journal::WorkPackageJournal	31	{}	["2024-11-28 10:08:20.391412+00",)
13	WorkPackage	10	3		2024-11-28 10:08:20.280292+00	1	2024-11-28 10:08:20.470694+00	Journal::WorkPackageJournal	32	{}	["2024-11-28 10:08:20.280292+00",)
16	WorkPackage	13	3		2024-11-28 10:08:20.48736+00	1	2024-11-28 10:08:20.512069+00	Journal::WorkPackageJournal	34	{}	["2024-11-28 10:08:20.48736+00",)
17	Meeting	1	3		2024-11-28 10:08:20.685501+00	1	2024-11-28 10:08:20.685501+00	Journal::MeetingJournal	1	{}	["2024-11-28 10:08:20.685501+00",)
18	Project	2	3		2024-11-28 10:08:20.95891+00	1	2024-11-28 10:08:20.95891+00	Journal::ProjectJournal	2	{}	["2024-11-28 10:08:20.95891+00",)
19	News	2	3		2024-11-28 10:08:21.022826+00	1	2024-11-28 10:08:21.022826+00	Journal::NewsJournal	2	{}	["2024-11-28 10:08:21.022826+00",)
20	WikiPage	2	3		2024-11-28 10:08:21.098847+00	1	2024-11-28 10:08:21.098847+00	Journal::WikiPageJournal	2	{}	["2024-11-28 10:08:21.098847+00",)
21	WikiPage	3	3		2024-11-28 10:08:21.211834+00	1	2024-11-28 10:08:21.211834+00	Journal::WikiPageJournal	3	{}	["2024-11-28 10:08:21.211834+00",)
22	WorkPackage	14	3		2024-11-28 10:08:21.248994+00	1	2024-11-28 10:08:21.290285+00	Journal::WorkPackageJournal	36	{}	["2024-11-28 10:08:21.248994+00",)
23	WorkPackage	15	3		2024-11-28 10:08:21.311905+00	1	2024-11-28 10:08:21.353881+00	Journal::WorkPackageJournal	38	{}	["2024-11-28 10:08:21.311905+00",)
25	WorkPackage	17	3		2024-11-28 10:08:21.41168+00	1	2024-11-28 10:08:21.472098+00	Journal::WorkPackageJournal	42	{}	["2024-11-28 10:08:21.41168+00",)
26	WorkPackage	18	3		2024-11-28 10:08:21.503683+00	1	2024-11-28 10:08:21.554755+00	Journal::WorkPackageJournal	45	{}	["2024-11-28 10:08:21.503683+00",)
28	WorkPackage	20	3		2024-11-28 10:08:21.612705+00	1	2024-11-28 10:08:21.652757+00	Journal::WorkPackageJournal	49	{}	["2024-11-28 10:08:21.612705+00",)
27	WorkPackage	19	3		2024-11-28 10:08:21.585544+00	1	2024-11-28 10:08:21.696851+00	Journal::WorkPackageJournal	51	{}	["2024-11-28 10:08:21.585544+00",)
24	WorkPackage	16	3		2024-11-28 10:08:21.381472+00	1	2024-11-28 10:08:21.730609+00	Journal::WorkPackageJournal	52	{}	["2024-11-28 10:08:21.381472+00",)
29	WorkPackage	21	3		2024-11-28 10:08:21.749861+00	1	2024-11-28 10:08:21.784843+00	Journal::WorkPackageJournal	54	{}	["2024-11-28 10:08:21.749861+00",)
31	WorkPackage	23	3		2024-11-28 10:08:21.84353+00	1	2024-11-28 10:08:21.904313+00	Journal::WorkPackageJournal	58	{}	["2024-11-28 10:08:21.84353+00",)
30	WorkPackage	22	3		2024-11-28 10:08:21.803135+00	1	2024-11-28 10:08:21.947508+00	Journal::WorkPackageJournal	59	{}	["2024-11-28 10:08:21.803135+00",)
32	WorkPackage	24	3		2024-11-28 10:08:21.971685+00	1	2024-11-28 10:08:22.010073+00	Journal::WorkPackageJournal	61	{}	["2024-11-28 10:08:21.971685+00",)
33	WorkPackage	25	3		2024-11-28 10:08:22.039579+00	1	2024-11-28 10:08:22.077108+00	Journal::WorkPackageJournal	63	{}	["2024-11-28 10:08:22.039579+00",)
34	WorkPackage	26	3		2024-11-28 10:08:22.093397+00	1	2024-11-28 10:08:22.153864+00	Journal::WorkPackageJournal	65	{}	["2024-11-28 10:08:22.093397+00",)
35	WorkPackage	27	3		2024-11-28 10:08:22.200989+00	1	2024-11-28 10:08:22.257541+00	Journal::WorkPackageJournal	67	{}	["2024-11-28 10:08:22.200989+00",)
37	WorkPackage	29	3		2024-11-28 10:08:22.333671+00	1	2024-11-28 10:08:22.404644+00	Journal::WorkPackageJournal	71	{}	["2024-11-28 10:08:22.333671+00",)
36	WorkPackage	28	3		2024-11-28 10:08:22.285489+00	1	2024-11-28 10:08:22.480602+00	Journal::WorkPackageJournal	72	{}	["2024-11-28 10:08:22.285489+00",)
38	WorkPackage	30	3		2024-11-28 10:08:22.51277+00	1	2024-11-28 10:08:22.566251+00	Journal::WorkPackageJournal	74	{}	["2024-11-28 10:08:22.51277+00",)
39	WorkPackage	31	3		2024-11-28 10:08:22.598123+00	1	2024-11-28 10:08:22.642994+00	Journal::WorkPackageJournal	76	{}	["2024-11-28 10:08:22.598123+00",)
40	WorkPackage	32	3		2024-11-28 10:08:22.673149+00	1	2024-11-28 10:08:22.718327+00	Journal::WorkPackageJournal	78	{}	["2024-11-28 10:08:22.673149+00",)
41	WorkPackage	33	3		2024-11-28 10:08:22.7462+00	1	2024-11-28 10:08:22.792691+00	Journal::WorkPackageJournal	80	{}	["2024-11-28 10:08:22.7462+00",)
42	WorkPackage	34	3		2024-11-28 10:08:22.818407+00	1	2024-11-28 10:08:22.859774+00	Journal::WorkPackageJournal	82	{}	["2024-11-28 10:08:22.818407+00",)
43	WorkPackage	35	3		2024-11-28 10:08:22.885644+00	1	2024-11-28 10:08:22.916636+00	Journal::WorkPackageJournal	84	{}	["2024-11-28 10:08:22.885644+00",)
44	WorkPackage	36	3		2024-11-28 10:08:22.933187+00	1	2024-11-28 10:08:22.964534+00	Journal::WorkPackageJournal	86	{}	["2024-11-28 10:08:22.933187+00",)
45	Attachment	1	3		2024-11-28 10:08:23.086259+00	1	2024-11-28 10:08:23.086259+00	Journal::AttachmentJournal	1	{}	["2024-11-28 10:08:23.086259+00",)
46	Attachment	2	3		2024-11-28 10:08:23.126109+00	1	2024-11-28 10:08:23.126109+00	Journal::AttachmentJournal	2	{}	["2024-11-28 10:08:23.126109+00",)
47	Project	3	4		2024-11-28 10:13:27.01768+00	1	2024-11-28 10:13:27.01768+00	Journal::ProjectJournal	3	{}	["2024-11-28 10:13:27.01768+00",)
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
1	1	4	Good news	What went well this week?	1	5	2024-11-29 10:00:00	2024-11-29 10:05:00	2024-11-28 10:08:20.744477	2024-11-28 10:08:20.929228	\N	0	0	4	1
2	1	4	Updates from development team	News and focused topics for the upcoming week.	2	5	2024-11-29 10:05:00	2024-11-29 10:10:00	2024-11-28 10:08:20.765685	2024-11-28 10:08:20.929228	\N	0	0	4	1
3	1	4	Updates from product team	News and focused topics for the upcoming week.	3	5	2024-11-29 10:10:00	2024-11-29 10:15:00	2024-11-28 10:08:20.778312	2024-11-28 10:08:20.929228	\N	0	0	4	1
4	1	4	Updates from marketing team	News and focused topics for the upcoming week.	4	5	2024-11-29 10:15:00	2024-11-29 10:20:00	2024-11-28 10:08:20.835939	2024-11-28 10:08:20.929228	\N	0	0	4	1
5	1	4	\N	**Today's topic**: Organizing the open-source conference.	5	5	2024-11-29 10:20:00	2024-11-29 10:25:00	2024-11-28 10:08:20.850708	2024-11-28 10:08:20.929228	2	1	0	4	1
6	1	4	Updates from sales team	News and focused topics for the upcoming week.	6	5	2024-11-29 10:25:00	2024-11-29 10:30:00	2024-11-28 10:08:20.866884	2024-11-28 10:08:20.929228	\N	0	0	4	1
7	1	4	Review of quarterly goals	Assessing the status and progress of the defined quarterly goals.	7	5	2024-11-29 10:30:00	2024-11-29 10:35:00	2024-11-28 10:08:20.883519	2024-11-28 10:08:20.929228	\N	0	0	4	1
8	1	4	Core values feedback	Highlight employees who have lived the core values this week.	8	5	2024-11-29 10:35:00	2024-11-29 10:40:00	2024-11-28 10:08:20.898926	2024-11-28 10:08:20.929228	\N	0	0	4	1
9	1	4	General topics	Solving or discussing topics together.	9	20	2024-11-29 10:40:00	2024-11-29 11:00:00	2024-11-28 10:08:20.916025	2024-11-28 10:08:20.929228	\N	0	0	4	1
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
1	Weekly	4	1	\N	2024-11-29 10:00:00+00	1	0
\.


--
-- Data for Name: meeting_participants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_participants (id, user_id, meeting_id, email, name, invited, attended, created_at, updated_at) FROM stdin;
1	4	1	\N	\N	t	\N	2024-11-28 10:08:20.687286+00	2024-11-28 10:08:20.687286+00
\.


--
-- Data for Name: meeting_sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meeting_sections (id, "position", title, meeting_id, created_at, updated_at) FROM stdin;
1	1		1	2024-11-28 10:08:20.737241+00	2024-11-28 10:08:20.737241+00
\.


--
-- Data for Name: meetings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meetings (id, title, author_id, project_id, location, start_time, duration, created_at, updated_at, state, type, lock_version) FROM stdin;
1	Weekly	4	1	\N	2024-11-29 10:00:00+00	1	2024-11-28 10:08:20.685501+00	2024-11-28 10:08:20.685501+00	0	StructuredMeeting	0
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
1	4	1	2024-11-28 10:08:19.28987+00	2024-11-28 10:08:19.294016+00	\N	\N
2	4	2	2024-11-28 10:08:21.020499+00	2024-11-28 10:08:21.022174+00	\N	\N
\.


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu_items (id, name, title, parent_id, options, navigatable_id, type) FROM stdin;
1	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	1	MenuItems::WikiMenuItem
2	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	2	MenuItems::WikiMenuItem
3	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	3	MenuItems::WikiMenuItem
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
1	1	Welcome to your demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	The actual news	4	2024-11-28 10:08:19.299321+00	0	2024-11-28 10:08:19.299321+00
2	2	Welcome to your Scrum demo project	We are glad you joined.\nIn this module you can communicate project news to your team members.\n	This is the news content.	4	2024-11-28 10:08:21.022826+00	0	2024-11-28 10:08:21.022826+00
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
1	\N	4	t	t	2024-11-28 10:08:18.624097+00	2024-11-28 10:08:18.624097+00	f	f	f	f	f	f	f	f	f	f	f	f	f	1	1	\N	t	t	t
2	\N	5	t	t	2024-11-28 10:15:07.090792+00	2024-11-28 10:15:07.090792+00	f	f	f	f	f	f	f	f	f	f	f	f	f	1	1	\N	t	t	t
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
1	OpenProject Mobile App	DgJZ7Rat23xHZbcq_nxPg5RUuxljonLCN7V7N7GoBAA	c6d3dd480576b717b50e0f046c45994b1e17d3b314d25287581d68434b452b82	User	1	\N	openprojectapp://oauth-callback		f	2024-11-28 10:08:18.885516+00	2024-11-28 10:08:18.885516+00	\N	\N	f	t
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
3	Hello		f	1	hello	t	f	\N	
\.


--
-- Data for Name: project_life_cycle_step_definitions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_life_cycle_step_definitions (id, type, name, "position", color_id, created_at, updated_at) FROM stdin;
1	Project::StageDefinition	Initiating	1	145	2024-12-11 09:57:00.59641+00	2024-12-11 09:57:00.59641+00
2	Project::GateDefinition	Ready for Planning	2	146	2024-12-11 09:57:00.609027+00	2024-12-11 09:57:00.609027+00
3	Project::StageDefinition	Planning	3	147	2024-12-11 09:57:00.615429+00	2024-12-11 09:57:00.615429+00
4	Project::GateDefinition	Ready for Executing	4	146	2024-12-11 09:57:00.62544+00	2024-12-11 09:57:00.62544+00
5	Project::StageDefinition	Executing	5	148	2024-12-11 09:57:00.629442+00	2024-12-11 09:57:00.629442+00
6	Project::GateDefinition	Ready for Closing	6	146	2024-12-11 09:57:00.633409+00	2024-12-11 09:57:00.633409+00
7	Project::StageDefinition	Closing	7	149	2024-12-11 09:57:00.636484+00	2024-12-11 09:57:00.636484+00
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
1	Demo project	This is a short summary of the goals of this demo project.	t	\N	2024-11-28 10:08:19.070962+00	2024-11-28 10:13:27.01768+00	demo-project	1	4	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.	{}
2	Scrum project	This is a short summary of the goals of this demo Scrum project.	t	\N	2024-11-28 10:08:20.95891+00	2024-11-28 10:13:27.01768+00	your-scrum-project	5	6	t	f	0	All tasks are on schedule. The people involved know their tasks. The system is completely set up.	{}
3	Hello		f	1	2024-11-28 10:13:26.962589+00	2024-11-28 10:13:27.01768+00	hello	2	3	t	f	\N		{}
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
3	1
3	2
3	3
\.


--
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.queries (id, project_id, name, filters, user_id, public, column_names, sort_criteria, group_by, display_sums, timeline_visible, show_hierarchies, timeline_zoom_level, timeline_labels, highlighting_mode, highlighted_attributes, created_at, updated_at, display_representation, starred, include_subprojects, timestamps) FROM stdin;
1	1	Project plan	---\nstatus_id:\n  :operator: o\n  :values: []\n	4	t	---\n- :id\n- :type\n- :subject\n- :status\n- :start_date\n- :due_date\n- :duration\n- :assigned_to\n	---\n- - id\n  - asc\n	\N	f	t	t	5	\N	\N	\N	2024-11-28 10:08:19.42132+00	2024-11-28 10:08:19.42132+00	\N	t	t	\N
2	1	Milestones	---\ntype_id:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	---\n- :id\n- :type\n- :subject\n- :status\n- :start_date\n- :due_date\n	---\n- - id\n  - asc\n	\N	f	t	f	5	\N	\N	\N	2024-11-28 10:08:19.44506+00	2024-11-28 10:08:19.44506+00	\N	f	t	\N
3	1	Tasks	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	---\n- :id\n- :subject\n- :priority\n- :status\n- :assigned_to\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:19.459909+00	2024-11-28 10:08:19.459909+00	\N	f	t	\N
4	1	Team planner	---\nassigned_to_id:\n  :operator: "="\n  :values:\n  - '4'\n	4	t	\N	\N	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:19.475929+00	2024-11-28 10:08:19.475929+00	\N	f	t	\N
5	1	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.549642+00	2024-11-28 10:08:20.549642+00	\N	f	t	\N
6	1	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.555914+00	2024-11-28 10:08:20.555914+00	\N	f	t	\N
7	1	Closed	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '12'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.560785+00	2024-11-28 10:08:20.560785+00	\N	f	t	\N
8	1	Rejected	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '14'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.56509+00	2024-11-28 10:08:20.56509+00	\N	f	t	\N
9	1	Wish list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:20.606877+00	2024-11-28 10:08:20.606877+00	\N	f	t	\N
10	1	Short list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:20.614878+00	2024-11-28 10:08:20.614878+00	\N	f	t	\N
11	1	Priority list for today	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:20.620134+00	2024-11-28 10:08:20.620134+00	\N	f	t	\N
12	1	Never	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:20.624931+00	2024-11-28 10:08:20.624931+00	\N	f	t	\N
13	1	Organize open source conference	---\nstatus_id:\n  :operator: o\n  :values:\n  - ''\nparent:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.644281+00	2024-11-28 10:08:20.644281+00	\N	f	t	\N
14	1	Follow-up tasks	---\nstatus_id:\n  :operator: o\n  :values:\n  - ''\nparent:\n  :operator: "="\n  :values:\n  - '10'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:20.654317+00	2024-11-28 10:08:20.654317+00	\N	f	t	\N
15	2	Project plan	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '2'\n  - '3'\n	4	t	\N	---\n- - id\n  - asc\n	\N	f	t	f	5	\N	\N	\N	2024-11-28 10:08:21.164283+00	2024-11-28 10:08:21.164283+00	\N	f	t	\N
16	2	Product backlog	---\nstatus_id:\n  :operator: o\n  :values: []\nversion_id:\n  :operator: "="\n  :values:\n  - '2'\n	4	t	---\n- :id\n- :type\n- :subject\n- :priority\n- :status\n- :assigned_to\n- :story_points\n	---\n- - status\n  - asc\n	status	f	f	f	5	\N	\N	\N	2024-11-28 10:08:21.182529+00	2024-11-28 10:08:21.182529+00	\N	f	t	\N
17	2	Sprint 1	---\nstatus_id:\n  :operator: o\n  :values: []\nversion_id:\n  :operator: "="\n  :values:\n  - '3'\n	4	t	---\n- :id\n- :type\n- :subject\n- :priority\n- :status\n- :assigned_to\n- :done_ratio\n- :story_points\n	\N	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:21.194767+00	2024-11-28 10:08:21.194767+00	\N	f	t	\N
18	2	Tasks	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	\N	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:21.203329+00	2024-11-28 10:08:21.203329+00	\N	f	t	\N
19	2	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:22.987672+00	2024-11-28 10:08:22.987672+00	\N	f	t	\N
20	2	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:22.992325+00	2024-11-28 10:08:22.992325+00	\N	f	t	\N
21	2	Closed	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '12'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:22.996738+00	2024-11-28 10:08:22.996738+00	\N	f	t	\N
22	2	Rejected	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '14'\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	t	5	\N	\N	\N	2024-11-28 10:08:23.000697+00	2024-11-28 10:08:23.000697+00	\N	f	t	\N
23	2	Wish list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:23.015537+00	2024-11-28 10:08:23.015537+00	\N	f	t	\N
24	2	Short list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:23.022735+00	2024-11-28 10:08:23.022735+00	\N	f	t	\N
25	2	Priority list for today	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:23.029273+00	2024-11-28 10:08:23.029273+00	\N	f	t	\N
26	2	Never	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:08:23.034974+00	2024-11-28 10:08:23.034974+00	\N	f	t	\N
27	3	Unnamed list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	f	5	\N	\N	\N	2024-11-28 10:13:51.873111+00	2024-11-28 10:13:51.873111+00	\N	f	t	\N
28	3	Unnamed list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	4	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	none	\N	2024-11-28 10:13:55.775534+00	2024-11-28 10:13:55.775534+00	\N	f	t	---\n- PT0S\n
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
1	view_work_packages	1	2024-11-28 10:07:51.504592+00	2024-11-28 10:07:51.504592+00
2	edit_work_packages	1	2024-11-28 10:07:51.508619+00	2024-11-28 10:07:51.508619+00
3	work_package_assigned	1	2024-11-28 10:07:51.511032+00	2024-11-28 10:07:51.511032+00
4	add_work_package_notes	1	2024-11-28 10:07:51.511556+00	2024-11-28 10:07:51.511556+00
5	edit_own_work_package_notes	1	2024-11-28 10:07:51.511962+00	2024-11-28 10:07:51.511962+00
6	manage_work_package_relations	1	2024-11-28 10:07:51.512423+00	2024-11-28 10:07:51.512423+00
7	copy_work_packages	1	2024-11-28 10:07:51.513042+00	2024-11-28 10:07:51.513042+00
8	export_work_packages	1	2024-11-28 10:07:51.513505+00	2024-11-28 10:07:51.513505+00
9	view_own_time_entries	1	2024-11-28 10:07:51.514099+00	2024-11-28 10:07:51.514099+00
10	log_own_time	1	2024-11-28 10:07:51.514858+00	2024-11-28 10:07:51.514858+00
11	edit_own_time_entries	1	2024-11-28 10:07:51.520941+00	2024-11-28 10:07:51.520941+00
12	show_github_content	1	2024-11-28 10:07:51.524514+00	2024-11-28 10:07:51.524514+00
13	view_file_links	1	2024-11-28 10:07:51.525167+00	2024-11-28 10:07:51.525167+00
14	view_work_packages	2	2024-11-28 10:07:51.555716+00	2024-11-28 10:07:51.555716+00
15	work_package_assigned	2	2024-11-28 10:07:51.556464+00	2024-11-28 10:07:51.556464+00
16	add_work_package_notes	2	2024-11-28 10:07:51.556887+00	2024-11-28 10:07:51.556887+00
17	add_work_package_attachments	2	2024-11-28 10:07:51.557281+00	2024-11-28 10:07:51.557281+00
18	edit_own_work_package_notes	2	2024-11-28 10:07:51.557793+00	2024-11-28 10:07:51.557793+00
19	export_work_packages	2	2024-11-28 10:07:51.558311+00	2024-11-28 10:07:51.558311+00
20	view_own_time_entries	2	2024-11-28 10:07:51.559116+00	2024-11-28 10:07:51.559116+00
21	log_own_time	2	2024-11-28 10:07:51.559715+00	2024-11-28 10:07:51.559715+00
22	edit_own_time_entries	2	2024-11-28 10:07:51.560234+00	2024-11-28 10:07:51.560234+00
23	show_github_content	2	2024-11-28 10:07:51.560753+00	2024-11-28 10:07:51.560753+00
24	view_file_links	2	2024-11-28 10:07:51.561744+00	2024-11-28 10:07:51.561744+00
25	view_work_packages	3	2024-11-28 10:07:51.571543+00	2024-11-28 10:07:51.571543+00
26	export_work_packages	3	2024-11-28 10:07:51.571879+00	2024-11-28 10:07:51.571879+00
27	show_github_content	3	2024-11-28 10:07:51.572148+00	2024-11-28 10:07:51.572148+00
28	add_work_package_attachments	2	2024-11-28 10:07:51.603196+00	2024-11-28 10:07:51.603196+00
29	view_project_query	4	2024-11-28 10:07:52.082369+00	2024-11-28 10:07:52.082369+00
30	view_project_query	5	2024-11-28 10:07:52.088729+00	2024-11-28 10:07:52.088729+00
31	edit_project_query	5	2024-11-28 10:07:52.089604+00	2024-11-28 10:07:52.089604+00
32	view_work_packages	7	2024-11-28 10:08:16.177927+00	2024-11-28 10:08:16.177927+00
33	view_calendar	7	2024-11-28 10:08:16.179084+00	2024-11-28 10:08:16.179084+00
34	comment_news	7	2024-11-28 10:08:16.179861+00	2024-11-28 10:08:16.179861+00
35	view_wiki_pages	7	2024-11-28 10:08:16.180546+00	2024-11-28 10:08:16.180546+00
36	view_project_attributes	7	2024-11-28 10:08:16.181166+00	2024-11-28 10:08:16.181166+00
37	show_board_views	7	2024-11-28 10:08:16.184541+00	2024-11-28 10:08:16.184541+00
38	share_calendars	7	2024-11-28 10:08:16.186777+00	2024-11-28 10:08:16.186777+00
39	show_github_content	7	2024-11-28 10:08:16.187817+00	2024-11-28 10:08:16.187817+00
40	view_file_links	7	2024-11-28 10:08:16.189651+00	2024-11-28 10:08:16.189651+00
41	view_project	7	2024-11-28 10:08:16.19073+00	2024-11-28 10:08:16.19073+00
42	search_project	7	2024-11-28 10:08:16.193083+00	2024-11-28 10:08:16.193083+00
43	view_news	7	2024-11-28 10:08:16.194083+00	2024-11-28 10:08:16.194083+00
44	view_messages	7	2024-11-28 10:08:16.194631+00	2024-11-28 10:08:16.194631+00
45	view_project_activity	7	2024-11-28 10:08:16.197844+00	2024-11-28 10:08:16.197844+00
46	view_work_packages	8	2024-11-28 10:08:16.218817+00	2024-11-28 10:08:16.218817+00
47	view_wiki_pages	8	2024-11-28 10:08:16.220106+00	2024-11-28 10:08:16.220106+00
48	view_project_attributes	8	2024-11-28 10:08:16.220962+00	2024-11-28 10:08:16.220962+00
49	view_file_links	8	2024-11-28 10:08:16.222361+00	2024-11-28 10:08:16.222361+00
50	view_project	8	2024-11-28 10:08:16.226387+00	2024-11-28 10:08:16.226387+00
51	search_project	8	2024-11-28 10:08:16.227264+00	2024-11-28 10:08:16.227264+00
52	view_news	8	2024-11-28 10:08:16.228481+00	2024-11-28 10:08:16.228481+00
53	view_messages	8	2024-11-28 10:08:16.22911+00	2024-11-28 10:08:16.22911+00
54	view_project_activity	8	2024-11-28 10:08:16.232738+00	2024-11-28 10:08:16.232738+00
55	view_work_packages	9	2024-11-28 10:08:16.298998+00	2024-11-28 10:08:16.298998+00
56	export_work_packages	9	2024-11-28 10:08:16.299717+00	2024-11-28 10:08:16.299717+00
57	add_work_packages	9	2024-11-28 10:08:16.301952+00	2024-11-28 10:08:16.301952+00
58	move_work_packages	9	2024-11-28 10:08:16.302787+00	2024-11-28 10:08:16.302787+00
59	edit_work_packages	9	2024-11-28 10:08:16.303334+00	2024-11-28 10:08:16.303334+00
60	assign_versions	9	2024-11-28 10:08:16.303781+00	2024-11-28 10:08:16.303781+00
61	work_package_assigned	9	2024-11-28 10:08:16.304202+00	2024-11-28 10:08:16.304202+00
62	add_work_package_notes	9	2024-11-28 10:08:16.304619+00	2024-11-28 10:08:16.304619+00
63	edit_own_work_package_notes	9	2024-11-28 10:08:16.305037+00	2024-11-28 10:08:16.305037+00
64	manage_work_package_relations	9	2024-11-28 10:08:16.305596+00	2024-11-28 10:08:16.305596+00
65	manage_subtasks	9	2024-11-28 10:08:16.306253+00	2024-11-28 10:08:16.306253+00
66	save_queries	9	2024-11-28 10:08:16.306857+00	2024-11-28 10:08:16.306857+00
67	view_work_package_watchers	9	2024-11-28 10:08:16.307311+00	2024-11-28 10:08:16.307311+00
68	add_work_package_watchers	9	2024-11-28 10:08:16.308163+00	2024-11-28 10:08:16.308163+00
69	delete_work_package_watchers	9	2024-11-28 10:08:16.308613+00	2024-11-28 10:08:16.308613+00
70	view_calendar	9	2024-11-28 10:08:16.309012+00	2024-11-28 10:08:16.309012+00
71	comment_news	9	2024-11-28 10:08:16.309435+00	2024-11-28 10:08:16.309435+00
72	manage_news	9	2024-11-28 10:08:16.309979+00	2024-11-28 10:08:16.309979+00
73	view_time_entries	9	2024-11-28 10:08:16.310376+00	2024-11-28 10:08:16.310376+00
74	view_own_time_entries	9	2024-11-28 10:08:16.310773+00	2024-11-28 10:08:16.310773+00
75	edit_own_time_entries	9	2024-11-28 10:08:16.311153+00	2024-11-28 10:08:16.311153+00
76	view_timelines	9	2024-11-28 10:08:16.31152+00	2024-11-28 10:08:16.31152+00
77	edit_timelines	9	2024-11-28 10:08:16.311889+00	2024-11-28 10:08:16.311889+00
78	delete_timelines	9	2024-11-28 10:08:16.312258+00	2024-11-28 10:08:16.312258+00
79	view_reportings	9	2024-11-28 10:08:16.312774+00	2024-11-28 10:08:16.312774+00
80	edit_reportings	9	2024-11-28 10:08:16.313223+00	2024-11-28 10:08:16.313223+00
81	delete_reportings	9	2024-11-28 10:08:16.313614+00	2024-11-28 10:08:16.313614+00
82	manage_wiki	9	2024-11-28 10:08:16.313988+00	2024-11-28 10:08:16.313988+00
83	rename_wiki_pages	9	2024-11-28 10:08:16.3156+00	2024-11-28 10:08:16.3156+00
84	change_wiki_parent_page	9	2024-11-28 10:08:16.317068+00	2024-11-28 10:08:16.317068+00
85	delete_wiki_pages	9	2024-11-28 10:08:16.318023+00	2024-11-28 10:08:16.318023+00
86	view_wiki_pages	9	2024-11-28 10:08:16.319517+00	2024-11-28 10:08:16.319517+00
87	export_wiki_pages	9	2024-11-28 10:08:16.320412+00	2024-11-28 10:08:16.320412+00
88	view_wiki_edits	9	2024-11-28 10:08:16.323096+00	2024-11-28 10:08:16.323096+00
89	edit_wiki_pages	9	2024-11-28 10:08:16.323868+00	2024-11-28 10:08:16.323868+00
90	delete_wiki_pages_attachments	9	2024-11-28 10:08:16.324455+00	2024-11-28 10:08:16.324455+00
91	protect_wiki_pages	9	2024-11-28 10:08:16.328233+00	2024-11-28 10:08:16.328233+00
92	list_attachments	9	2024-11-28 10:08:16.329098+00	2024-11-28 10:08:16.329098+00
93	add_messages	9	2024-11-28 10:08:16.329569+00	2024-11-28 10:08:16.329569+00
94	edit_own_messages	9	2024-11-28 10:08:16.330046+00	2024-11-28 10:08:16.330046+00
95	delete_own_messages	9	2024-11-28 10:08:16.330581+00	2024-11-28 10:08:16.330581+00
96	browse_repository	9	2024-11-28 10:08:16.331+00	2024-11-28 10:08:16.331+00
97	view_changesets	9	2024-11-28 10:08:16.33146+00	2024-11-28 10:08:16.33146+00
98	commit_access	9	2024-11-28 10:08:16.33185+00	2024-11-28 10:08:16.33185+00
99	view_commit_author_statistics	9	2024-11-28 10:08:16.332881+00	2024-11-28 10:08:16.332881+00
100	view_members	9	2024-11-28 10:08:16.333308+00	2024-11-28 10:08:16.333308+00
101	view_team_planner	9	2024-11-28 10:08:16.334002+00	2024-11-28 10:08:16.334002+00
102	view_shared_work_packages	9	2024-11-28 10:08:16.334406+00	2024-11-28 10:08:16.334406+00
103	copy_work_packages	9	2024-11-28 10:08:16.335427+00	2024-11-28 10:08:16.335427+00
104	add_work_package_attachments	9	2024-11-28 10:08:16.335822+00	2024-11-28 10:08:16.335822+00
105	view_project_attributes	9	2024-11-28 10:08:16.336168+00	2024-11-28 10:08:16.336168+00
106	view_master_backlog	9	2024-11-28 10:08:16.336564+00	2024-11-28 10:08:16.336564+00
107	view_taskboards	9	2024-11-28 10:08:16.336931+00	2024-11-28 10:08:16.336931+00
108	show_board_views	9	2024-11-28 10:08:16.337852+00	2024-11-28 10:08:16.337852+00
109	manage_public_queries	9	2024-11-28 10:08:16.338395+00	2024-11-28 10:08:16.338395+00
110	manage_board_views	9	2024-11-28 10:08:16.338777+00	2024-11-28 10:08:16.338777+00
111	share_calendars	9	2024-11-28 10:08:16.339123+00	2024-11-28 10:08:16.339123+00
112	view_cost_rates	9	2024-11-28 10:08:16.339617+00	2024-11-28 10:08:16.339617+00
113	log_own_costs	9	2024-11-28 10:08:16.340157+00	2024-11-28 10:08:16.340157+00
114	edit_own_cost_entries	9	2024-11-28 10:08:16.340588+00	2024-11-28 10:08:16.340588+00
115	view_budgets	9	2024-11-28 10:08:16.341367+00	2024-11-28 10:08:16.341367+00
116	view_own_cost_entries	9	2024-11-28 10:08:16.343331+00	2024-11-28 10:08:16.343331+00
117	log_own_time	9	2024-11-28 10:08:16.343751+00	2024-11-28 10:08:16.343751+00
118	save_cost_reports	9	2024-11-28 10:08:16.345037+00	2024-11-28 10:08:16.345037+00
119	save_private_cost_reports	9	2024-11-28 10:08:16.345568+00	2024-11-28 10:08:16.345568+00
120	view_documents	9	2024-11-28 10:08:16.345935+00	2024-11-28 10:08:16.345935+00
121	manage_documents	9	2024-11-28 10:08:16.346279+00	2024-11-28 10:08:16.346279+00
122	show_github_content	9	2024-11-28 10:08:16.34662+00	2024-11-28 10:08:16.34662+00
123	create_meetings	9	2024-11-28 10:08:16.347402+00	2024-11-28 10:08:16.347402+00
124	edit_meetings	9	2024-11-28 10:08:16.347847+00	2024-11-28 10:08:16.347847+00
125	delete_meetings	9	2024-11-28 10:08:16.348272+00	2024-11-28 10:08:16.348272+00
126	view_meetings	9	2024-11-28 10:08:16.348596+00	2024-11-28 10:08:16.348596+00
127	create_meeting_agendas	9	2024-11-28 10:08:16.348908+00	2024-11-28 10:08:16.348908+00
128	manage_agendas	9	2024-11-28 10:08:16.349913+00	2024-11-28 10:08:16.349913+00
129	close_meeting_agendas	9	2024-11-28 10:08:16.350546+00	2024-11-28 10:08:16.350546+00
130	send_meeting_agendas_notification	9	2024-11-28 10:08:16.351345+00	2024-11-28 10:08:16.351345+00
131	send_meeting_agendas_icalendar	9	2024-11-28 10:08:16.352158+00	2024-11-28 10:08:16.352158+00
132	create_meeting_minutes	9	2024-11-28 10:08:16.352783+00	2024-11-28 10:08:16.352783+00
133	send_meeting_minutes_notification	9	2024-11-28 10:08:16.353275+00	2024-11-28 10:08:16.353275+00
134	meetings_send_invite	9	2024-11-28 10:08:16.353672+00	2024-11-28 10:08:16.353672+00
135	view_file_links	9	2024-11-28 10:08:16.354108+00	2024-11-28 10:08:16.354108+00
136	manage_file_links	9	2024-11-28 10:08:16.3545+00	2024-11-28 10:08:16.3545+00
137	read_files	9	2024-11-28 10:08:16.354845+00	2024-11-28 10:08:16.354845+00
138	write_files	9	2024-11-28 10:08:16.355306+00	2024-11-28 10:08:16.355306+00
139	create_files	9	2024-11-28 10:08:16.356282+00	2024-11-28 10:08:16.356282+00
140	delete_files	9	2024-11-28 10:08:16.35715+00	2024-11-28 10:08:16.35715+00
141	share_files	9	2024-11-28 10:08:16.357876+00	2024-11-28 10:08:16.357876+00
142	view_project	9	2024-11-28 10:08:16.358913+00	2024-11-28 10:08:16.358913+00
143	search_project	9	2024-11-28 10:08:16.360499+00	2024-11-28 10:08:16.360499+00
144	view_news	9	2024-11-28 10:08:16.363343+00	2024-11-28 10:08:16.363343+00
145	view_messages	9	2024-11-28 10:08:16.36444+00	2024-11-28 10:08:16.36444+00
146	view_project_activity	9	2024-11-28 10:08:16.36549+00	2024-11-28 10:08:16.36549+00
147	view_work_packages	10	2024-11-28 10:08:16.396577+00	2024-11-28 10:08:16.396577+00
148	add_work_package_notes	10	2024-11-28 10:08:16.397451+00	2024-11-28 10:08:16.397451+00
149	edit_own_work_package_notes	10	2024-11-28 10:08:16.39802+00	2024-11-28 10:08:16.39802+00
150	save_queries	10	2024-11-28 10:08:16.401818+00	2024-11-28 10:08:16.401818+00
151	view_calendar	10	2024-11-28 10:08:16.403652+00	2024-11-28 10:08:16.403652+00
152	comment_news	10	2024-11-28 10:08:16.404276+00	2024-11-28 10:08:16.404276+00
153	view_timelines	10	2024-11-28 10:08:16.40465+00	2024-11-28 10:08:16.40465+00
154	view_reportings	10	2024-11-28 10:08:16.404942+00	2024-11-28 10:08:16.404942+00
155	view_wiki_pages	10	2024-11-28 10:08:16.405297+00	2024-11-28 10:08:16.405297+00
156	export_wiki_pages	10	2024-11-28 10:08:16.40564+00	2024-11-28 10:08:16.40564+00
157	list_attachments	10	2024-11-28 10:08:16.405955+00	2024-11-28 10:08:16.405955+00
158	add_messages	10	2024-11-28 10:08:16.406323+00	2024-11-28 10:08:16.406323+00
159	edit_own_messages	10	2024-11-28 10:08:16.406656+00	2024-11-28 10:08:16.406656+00
160	delete_own_messages	10	2024-11-28 10:08:16.406979+00	2024-11-28 10:08:16.406979+00
161	browse_repository	10	2024-11-28 10:08:16.40742+00	2024-11-28 10:08:16.40742+00
162	view_changesets	10	2024-11-28 10:08:16.407866+00	2024-11-28 10:08:16.407866+00
163	view_commit_author_statistics	10	2024-11-28 10:08:16.408213+00	2024-11-28 10:08:16.408213+00
164	view_team_planner	10	2024-11-28 10:08:16.408514+00	2024-11-28 10:08:16.408514+00
165	view_shared_work_packages	10	2024-11-28 10:08:16.408794+00	2024-11-28 10:08:16.408794+00
166	view_project_attributes	10	2024-11-28 10:08:16.409123+00	2024-11-28 10:08:16.409123+00
167	view_master_backlog	10	2024-11-28 10:08:16.409442+00	2024-11-28 10:08:16.409442+00
168	view_taskboards	10	2024-11-28 10:08:16.409743+00	2024-11-28 10:08:16.409743+00
169	show_board_views	10	2024-11-28 10:08:16.41004+00	2024-11-28 10:08:16.41004+00
170	share_calendars	10	2024-11-28 10:08:16.41034+00	2024-11-28 10:08:16.41034+00
171	view_documents	10	2024-11-28 10:08:16.41063+00	2024-11-28 10:08:16.41063+00
172	show_github_content	10	2024-11-28 10:08:16.410921+00	2024-11-28 10:08:16.410921+00
173	view_meetings	10	2024-11-28 10:08:16.411203+00	2024-11-28 10:08:16.411203+00
174	view_file_links	10	2024-11-28 10:08:16.411483+00	2024-11-28 10:08:16.411483+00
175	read_files	10	2024-11-28 10:08:16.411758+00	2024-11-28 10:08:16.411758+00
176	view_project	10	2024-11-28 10:08:16.412033+00	2024-11-28 10:08:16.412033+00
177	search_project	10	2024-11-28 10:08:16.41231+00	2024-11-28 10:08:16.41231+00
178	view_news	10	2024-11-28 10:08:16.412588+00	2024-11-28 10:08:16.412588+00
179	view_messages	10	2024-11-28 10:08:16.412866+00	2024-11-28 10:08:16.412866+00
180	view_project_activity	10	2024-11-28 10:08:16.413182+00	2024-11-28 10:08:16.413182+00
181	archive_project	11	2024-11-28 10:08:16.423318+00	2024-11-28 10:08:16.423318+00
182	edit_project	11	2024-11-28 10:08:16.423804+00	2024-11-28 10:08:16.423804+00
183	select_project_modules	11	2024-11-28 10:08:16.424199+00	2024-11-28 10:08:16.424199+00
184	view_project_attributes	11	2024-11-28 10:08:16.424513+00	2024-11-28 10:08:16.424513+00
185	edit_project_attributes	11	2024-11-28 10:08:16.424895+00	2024-11-28 10:08:16.424895+00
186	select_project_custom_fields	11	2024-11-28 10:08:16.425422+00	2024-11-28 10:08:16.425422+00
187	manage_members	11	2024-11-28 10:08:16.425758+00	2024-11-28 10:08:16.425758+00
188	view_members	11	2024-11-28 10:08:16.426062+00	2024-11-28 10:08:16.426062+00
189	manage_versions	11	2024-11-28 10:08:16.426364+00	2024-11-28 10:08:16.426364+00
190	manage_types	11	2024-11-28 10:08:16.426657+00	2024-11-28 10:08:16.426657+00
191	select_custom_fields	11	2024-11-28 10:08:16.426952+00	2024-11-28 10:08:16.426952+00
192	add_subprojects	11	2024-11-28 10:08:16.427247+00	2024-11-28 10:08:16.427247+00
193	copy_projects	11	2024-11-28 10:08:16.427547+00	2024-11-28 10:08:16.427547+00
194	view_work_packages	11	2024-11-28 10:08:16.427846+00	2024-11-28 10:08:16.427846+00
195	add_work_packages	11	2024-11-28 10:08:16.428157+00	2024-11-28 10:08:16.428157+00
196	edit_work_packages	11	2024-11-28 10:08:16.42853+00	2024-11-28 10:08:16.42853+00
197	move_work_packages	11	2024-11-28 10:08:16.428866+00	2024-11-28 10:08:16.428866+00
198	copy_work_packages	11	2024-11-28 10:08:16.42923+00	2024-11-28 10:08:16.42923+00
199	add_work_package_notes	11	2024-11-28 10:08:16.429579+00	2024-11-28 10:08:16.429579+00
200	edit_work_package_notes	11	2024-11-28 10:08:16.429878+00	2024-11-28 10:08:16.429878+00
201	edit_own_work_package_notes	11	2024-11-28 10:08:16.43024+00	2024-11-28 10:08:16.43024+00
202	add_work_package_attachments	11	2024-11-28 10:08:16.430547+00	2024-11-28 10:08:16.430547+00
203	manage_categories	11	2024-11-28 10:08:16.430845+00	2024-11-28 10:08:16.430845+00
204	export_work_packages	11	2024-11-28 10:08:16.43114+00	2024-11-28 10:08:16.43114+00
205	delete_work_packages	11	2024-11-28 10:08:16.431454+00	2024-11-28 10:08:16.431454+00
206	manage_work_package_relations	11	2024-11-28 10:08:16.431827+00	2024-11-28 10:08:16.431827+00
207	manage_subtasks	11	2024-11-28 10:08:16.432179+00	2024-11-28 10:08:16.432179+00
208	manage_public_queries	11	2024-11-28 10:08:16.432496+00	2024-11-28 10:08:16.432496+00
209	save_queries	11	2024-11-28 10:08:16.432787+00	2024-11-28 10:08:16.432787+00
210	view_work_package_watchers	11	2024-11-28 10:08:16.433099+00	2024-11-28 10:08:16.433099+00
211	add_work_package_watchers	11	2024-11-28 10:08:16.433403+00	2024-11-28 10:08:16.433403+00
212	delete_work_package_watchers	11	2024-11-28 10:08:16.433697+00	2024-11-28 10:08:16.433697+00
213	share_work_packages	11	2024-11-28 10:08:16.433989+00	2024-11-28 10:08:16.433989+00
214	view_shared_work_packages	11	2024-11-28 10:08:16.434283+00	2024-11-28 10:08:16.434283+00
215	assign_versions	11	2024-11-28 10:08:16.434578+00	2024-11-28 10:08:16.434578+00
216	change_work_package_status	11	2024-11-28 10:08:16.434871+00	2024-11-28 10:08:16.434871+00
217	work_package_assigned	11	2024-11-28 10:08:16.435161+00	2024-11-28 10:08:16.435161+00
218	manage_news	11	2024-11-28 10:08:16.435455+00	2024-11-28 10:08:16.435455+00
219	comment_news	11	2024-11-28 10:08:16.435746+00	2024-11-28 10:08:16.435746+00
220	view_wiki_pages	11	2024-11-28 10:08:16.436047+00	2024-11-28 10:08:16.436047+00
221	list_attachments	11	2024-11-28 10:08:16.436345+00	2024-11-28 10:08:16.436345+00
222	manage_wiki	11	2024-11-28 10:08:16.436635+00	2024-11-28 10:08:16.436635+00
223	manage_wiki_menu	11	2024-11-28 10:08:16.436924+00	2024-11-28 10:08:16.436924+00
224	rename_wiki_pages	11	2024-11-28 10:08:16.437237+00	2024-11-28 10:08:16.437237+00
225	change_wiki_parent_page	11	2024-11-28 10:08:16.437541+00	2024-11-28 10:08:16.437541+00
226	delete_wiki_pages	11	2024-11-28 10:08:16.43784+00	2024-11-28 10:08:16.43784+00
227	export_wiki_pages	11	2024-11-28 10:08:16.438148+00	2024-11-28 10:08:16.438148+00
228	view_wiki_edits	11	2024-11-28 10:08:16.438439+00	2024-11-28 10:08:16.438439+00
229	edit_wiki_pages	11	2024-11-28 10:08:16.438758+00	2024-11-28 10:08:16.438758+00
230	delete_wiki_pages_attachments	11	2024-11-28 10:08:16.439067+00	2024-11-28 10:08:16.439067+00
231	protect_wiki_pages	11	2024-11-28 10:08:16.43936+00	2024-11-28 10:08:16.43936+00
232	browse_repository	11	2024-11-28 10:08:16.439653+00	2024-11-28 10:08:16.439653+00
233	commit_access	11	2024-11-28 10:08:16.439944+00	2024-11-28 10:08:16.439944+00
234	manage_repository	11	2024-11-28 10:08:16.440234+00	2024-11-28 10:08:16.440234+00
235	view_changesets	11	2024-11-28 10:08:16.440524+00	2024-11-28 10:08:16.440524+00
236	view_commit_author_statistics	11	2024-11-28 10:08:16.440816+00	2024-11-28 10:08:16.440816+00
237	manage_forums	11	2024-11-28 10:08:16.441303+00	2024-11-28 10:08:16.441303+00
238	add_messages	11	2024-11-28 10:08:16.441647+00	2024-11-28 10:08:16.441647+00
239	edit_messages	11	2024-11-28 10:08:16.442053+00	2024-11-28 10:08:16.442053+00
240	edit_own_messages	11	2024-11-28 10:08:16.442398+00	2024-11-28 10:08:16.442398+00
241	delete_messages	11	2024-11-28 10:08:16.442702+00	2024-11-28 10:08:16.442702+00
242	delete_own_messages	11	2024-11-28 10:08:16.442993+00	2024-11-28 10:08:16.442993+00
243	view_documents	11	2024-11-28 10:08:16.443287+00	2024-11-28 10:08:16.443287+00
244	manage_documents	11	2024-11-28 10:08:16.443584+00	2024-11-28 10:08:16.443584+00
245	view_time_entries	11	2024-11-28 10:08:16.443874+00	2024-11-28 10:08:16.443874+00
246	view_own_time_entries	11	2024-11-28 10:08:16.444165+00	2024-11-28 10:08:16.444165+00
247	log_own_time	11	2024-11-28 10:08:16.444456+00	2024-11-28 10:08:16.444456+00
248	log_time	11	2024-11-28 10:08:16.444746+00	2024-11-28 10:08:16.444746+00
249	edit_own_time_entries	11	2024-11-28 10:08:16.445051+00	2024-11-28 10:08:16.445051+00
250	edit_time_entries	11	2024-11-28 10:08:16.445357+00	2024-11-28 10:08:16.445357+00
251	manage_project_activities	11	2024-11-28 10:08:16.445649+00	2024-11-28 10:08:16.445649+00
252	view_own_hourly_rate	11	2024-11-28 10:08:16.44594+00	2024-11-28 10:08:16.44594+00
253	view_hourly_rates	11	2024-11-28 10:08:16.446232+00	2024-11-28 10:08:16.446232+00
254	edit_own_hourly_rate	11	2024-11-28 10:08:16.446532+00	2024-11-28 10:08:16.446532+00
255	edit_hourly_rates	11	2024-11-28 10:08:16.446829+00	2024-11-28 10:08:16.446829+00
256	view_cost_rates	11	2024-11-28 10:08:16.44712+00	2024-11-28 10:08:16.44712+00
257	log_own_costs	11	2024-11-28 10:08:16.44741+00	2024-11-28 10:08:16.44741+00
258	log_costs	11	2024-11-28 10:08:16.4477+00	2024-11-28 10:08:16.4477+00
259	edit_own_cost_entries	11	2024-11-28 10:08:16.447994+00	2024-11-28 10:08:16.447994+00
260	edit_cost_entries	11	2024-11-28 10:08:16.448327+00	2024-11-28 10:08:16.448327+00
261	view_cost_entries	11	2024-11-28 10:08:16.448675+00	2024-11-28 10:08:16.448675+00
262	view_own_cost_entries	11	2024-11-28 10:08:16.448975+00	2024-11-28 10:08:16.448975+00
263	save_cost_reports	11	2024-11-28 10:08:16.449267+00	2024-11-28 10:08:16.449267+00
264	save_private_cost_reports	11	2024-11-28 10:08:16.44956+00	2024-11-28 10:08:16.44956+00
265	view_meetings	11	2024-11-28 10:08:16.449849+00	2024-11-28 10:08:16.449849+00
266	create_meetings	11	2024-11-28 10:08:16.450139+00	2024-11-28 10:08:16.450139+00
267	edit_meetings	11	2024-11-28 10:08:16.450432+00	2024-11-28 10:08:16.450432+00
268	delete_meetings	11	2024-11-28 10:08:16.450724+00	2024-11-28 10:08:16.450724+00
269	meetings_send_invite	11	2024-11-28 10:08:16.451012+00	2024-11-28 10:08:16.451012+00
270	create_meeting_agendas	11	2024-11-28 10:08:16.451408+00	2024-11-28 10:08:16.451408+00
271	manage_agendas	11	2024-11-28 10:08:16.451982+00	2024-11-28 10:08:16.451982+00
272	close_meeting_agendas	11	2024-11-28 10:08:16.452395+00	2024-11-28 10:08:16.452395+00
273	send_meeting_agendas_notification	11	2024-11-28 10:08:16.452757+00	2024-11-28 10:08:16.452757+00
274	send_meeting_agendas_icalendar	11	2024-11-28 10:08:16.45318+00	2024-11-28 10:08:16.45318+00
275	create_meeting_minutes	11	2024-11-28 10:08:16.45368+00	2024-11-28 10:08:16.45368+00
276	send_meeting_minutes_notification	11	2024-11-28 10:08:16.454031+00	2024-11-28 10:08:16.454031+00
277	view_master_backlog	11	2024-11-28 10:08:16.454342+00	2024-11-28 10:08:16.454342+00
278	view_taskboards	11	2024-11-28 10:08:16.454646+00	2024-11-28 10:08:16.454646+00
279	select_done_statuses	11	2024-11-28 10:08:16.454956+00	2024-11-28 10:08:16.454956+00
280	update_sprints	11	2024-11-28 10:08:16.455257+00	2024-11-28 10:08:16.455257+00
281	show_github_content	11	2024-11-28 10:08:16.455554+00	2024-11-28 10:08:16.455554+00
282	show_gitlab_content	11	2024-11-28 10:08:16.455848+00	2024-11-28 10:08:16.455848+00
283	show_board_views	11	2024-11-28 10:08:16.456201+00	2024-11-28 10:08:16.456201+00
284	manage_board_views	11	2024-11-28 10:08:16.456544+00	2024-11-28 10:08:16.456544+00
285	manage_overview	11	2024-11-28 10:08:16.456847+00	2024-11-28 10:08:16.456847+00
286	view_budgets	11	2024-11-28 10:08:16.457158+00	2024-11-28 10:08:16.457158+00
287	edit_budgets	11	2024-11-28 10:08:16.457456+00	2024-11-28 10:08:16.457456+00
288	view_team_planner	11	2024-11-28 10:08:16.457757+00	2024-11-28 10:08:16.457757+00
289	manage_team_planner	11	2024-11-28 10:08:16.458049+00	2024-11-28 10:08:16.458049+00
290	view_calendar	11	2024-11-28 10:08:16.458341+00	2024-11-28 10:08:16.458341+00
291	manage_calendars	11	2024-11-28 10:08:16.458631+00	2024-11-28 10:08:16.458631+00
292	share_calendars	11	2024-11-28 10:08:16.45892+00	2024-11-28 10:08:16.45892+00
293	manage_files_in_project	11	2024-11-28 10:08:16.45921+00	2024-11-28 10:08:16.45921+00
294	read_files	11	2024-11-28 10:08:16.459501+00	2024-11-28 10:08:16.459501+00
295	write_files	11	2024-11-28 10:08:16.459883+00	2024-11-28 10:08:16.459883+00
296	create_files	11	2024-11-28 10:08:16.460242+00	2024-11-28 10:08:16.460242+00
297	delete_files	11	2024-11-28 10:08:16.4606+00	2024-11-28 10:08:16.4606+00
298	share_files	11	2024-11-28 10:08:16.460906+00	2024-11-28 10:08:16.460906+00
299	view_file_links	11	2024-11-28 10:08:16.46123+00	2024-11-28 10:08:16.46123+00
300	manage_file_links	11	2024-11-28 10:08:16.461597+00	2024-11-28 10:08:16.461597+00
301	view_ifc_models	11	2024-11-28 10:08:16.461995+00	2024-11-28 10:08:16.461995+00
302	manage_ifc_models	11	2024-11-28 10:08:16.462412+00	2024-11-28 10:08:16.462412+00
303	view_linked_issues	11	2024-11-28 10:08:16.462865+00	2024-11-28 10:08:16.462865+00
304	manage_bcf	11	2024-11-28 10:08:16.463352+00	2024-11-28 10:08:16.463352+00
305	delete_bcf	11	2024-11-28 10:08:16.463813+00	2024-11-28 10:08:16.463813+00
306	save_bcf_queries	11	2024-11-28 10:08:16.464158+00	2024-11-28 10:08:16.464158+00
307	manage_public_bcf_queries	11	2024-11-28 10:08:16.464481+00	2024-11-28 10:08:16.464481+00
308	view_project	11	2024-11-28 10:08:16.465032+00	2024-11-28 10:08:16.465032+00
309	search_project	11	2024-11-28 10:08:16.46539+00	2024-11-28 10:08:16.46539+00
310	view_news	11	2024-11-28 10:08:16.465705+00	2024-11-28 10:08:16.465705+00
311	view_messages	11	2024-11-28 10:08:16.466088+00	2024-11-28 10:08:16.466088+00
312	view_project_activity	11	2024-11-28 10:08:16.466545+00	2024-11-28 10:08:16.466545+00
313	manage_overview	11	2024-11-28 10:08:23.162383+00	2024-11-28 10:08:23.162383+00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, "position", builtin, type, created_at, updated_at) FROM stdin;
1	Work package editor	1	5	WorkPackageRole	2024-11-28 10:07:51.498377+00	2024-11-28 10:07:51.498377+00
2	Work package commenter	2	4	WorkPackageRole	2024-11-28 10:07:51.532772+00	2024-11-28 10:07:51.532772+00
9	Member	3	0	ProjectRole	2024-11-28 10:08:16.283326+00	2024-11-28 10:08:16.283326+00
10	Reader	4	0	ProjectRole	2024-11-28 10:08:16.387867+00	2024-11-28 10:08:16.387867+00
3	Work package viewer	6	3	WorkPackageRole	2024-11-28 10:07:51.568389+00	2024-11-28 10:08:16.422224+00
4	Project query viewer	7	6	ProjectQueryRole	2024-11-28 10:07:52.076836+00	2024-11-28 10:08:16.422224+00
5	Project query editor	8	7	ProjectQueryRole	2024-11-28 10:07:52.086403+00	2024-11-28 10:08:16.422224+00
6	Standard global role	9	8	GlobalRole	2024-11-28 10:07:52.201551+00	2024-11-28 10:08:16.422224+00
7	Non member	10	1	ProjectRole	2024-11-28 10:08:16.135673+00	2024-11-28 10:08:16.422224+00
8	Anonymous	11	2	ProjectRole	2024-11-28 10:08:16.210323+00	2024-11-28 10:08:16.422224+00
11	Project admin	5	0	ProjectRole	2024-11-28 10:08:16.420148+00	2024-11-28 10:08:16.420148+00
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
39	2::f1f2a6bc34a975b85f06929dc0a3ebfccaa959642e5158866d2bd9143483ef79	BAh7DEkiDXBsYXRmb3JtBjoGRUZJIhJHZW5lcmljIExpbnV4BjsAVEkiDGJy\nb3dzZXIGOwBGSSILQ2hyb21lBjsAVEkiFGJyb3dzZXJfdmVyc2lvbgY7AEYi\nCDEzMUkiDHVzZXJfaWQGOwBGaQlJIg91cGRhdGVkX2F0BjsARkl1OglUaW1l\nDWktH4CxCaToCjoNbmFub19udW1pAjUDOg1uYW5vX2RlbmkGOg1zdWJtaWNy\nbyIHghA6C29mZnNldGkAOgl6b25lSSIIVVRDBjsARkkiEF9jc3JmX3Rva2Vu\nBjsARkkiMGNITjhySWI3RlJPRGo1WmtCRXNfZjFYM2Rxd080c0gyT0M3M0Y1\na1FROTgGOwBGSSIYcHJvamVjdHNfaW5kZXhfc29ydAY7AEZJIghsZnQGOwBG\n	2024-12-11 09:58:10.315695+00	4
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (id, name, value, updated_at) FROM stdin;
1	working_days	---\n- 1\n- 2\n- 3\n- 4\n- 5\n	2024-11-28 10:07:43.221974+00
2	lookbook_enabled	f	2024-11-28 10:08:17.862868+00
3	additional_host_names	[]	2024-11-28 10:08:17.872044+00
4	fog	{}	2024-11-28 10:08:17.876943+00
5	feature_primerized_work_package_activities_active	f	2024-11-28 10:08:17.882212+00
6	feature_built_in_oauth_applications_active	f	2024-11-28 10:08:17.886862+00
7	feature_custom_field_of_type_hierarchy_active	f	2024-11-28 10:08:17.889768+00
8	session_cookie_name	_open_project_session	2024-11-28 10:08:17.897067+00
9	plugin_openproject_auth_saml	---\nproviders:\n	2024-11-28 10:08:17.904758+00
11	cost_reporting_cache_filter_classes	true	2024-11-28 10:08:17.913384+00
13	plugin_openproject_avatars	---\nenable_gravatars: true\nenable_local_avatars: true\n	2024-11-28 10:08:17.922545+00
14	plugin_openproject_two_factor_authentication	---\nactive_strategies:\n- :totp\n- :webauthn\nenforced: false\nallow_remember_for_days: 0\n	2024-11-28 10:08:17.92625+00
15	feature_deploy_targets_active	f	2024-11-28 10:08:17.929285+00
16	plugin_openproject_github_integration	---\ngithub_user_id:\n	2024-11-28 10:08:17.933433+00
17	plugin_openproject_ldap_groups	{}	2024-11-28 10:08:17.936402+00
18	plugin_openproject_recaptcha	---\nrecaptcha_type: disabled\nresponse_limit: 5000\n	2024-11-28 10:08:17.941918+00
19	recaptcha_via_hcaptcha	f	2024-11-28 10:08:17.945398+00
20	ical_enabled	true	2024-11-28 10:08:17.948703+00
21	feature_storage_file_picking_select_all_active	f	2024-11-28 10:08:17.951553+00
22	plugin_openproject_bim	{}	2024-11-28 10:08:17.954759+00
23	available_languages	---\n- ca\n- cs\n- de\n- el\n- en\n- es\n- fr\n- hu\n- id\n- it\n- ja\n- ko\n- lt\n- nl\n- 'no'\n- pl\n- pt-BR\n- pt-PT\n- ro\n- ru\n- sk\n- sl\n- sv\n- tr\n- uk\n- vi\n- zh-CN\n- zh-TW\n	2024-11-28 10:08:17.960259+00
24	rate_limiting	{}	2024-11-28 10:08:17.963062+00
25	activity_days_default	30	2024-11-28 10:08:17.967494+00
26	apiv3_cors_enabled	f	2024-11-28 10:08:17.970478+00
27	apiv3_cors_origins	[]	2024-11-28 10:08:17.974061+00
28	apiv3_docs_enabled	true	2024-11-28 10:08:17.97744+00
29	apiv3_enable_basic_auth	true	2024-11-28 10:08:17.980312+00
30	apiv3_max_page_size	1000	2024-11-28 10:08:17.98322+00
31	apiv3_write_readonly_attributes	f	2024-11-28 10:08:17.986105+00
32	app_title	OpenProject	2024-11-28 10:08:17.990004+00
33	attachment_max_size	5120	2024-11-28 10:08:17.993177+00
34	attachment_whitelist	[]	2024-11-28 10:08:17.996139+00
35	attachments_grace_period	180	2024-11-28 10:08:17.999393+00
36	antivirus_scan_mode	disabled	2024-11-28 10:08:18.001865+00
37	antivirus_scan_action	quarantine	2024-11-28 10:08:18.004588+00
38	autofetch_changesets	true	2024-11-28 10:08:18.007923+00
39	autologin	0	2024-11-28 10:08:18.011011+00
40	autologin_cookie_name	autologin	2024-11-28 10:08:18.014702+00
41	autologin_cookie_path	/	2024-11-28 10:08:18.018033+00
42	avatar_link_expiry_seconds	86400	2024-11-28 10:08:18.032445+00
43	backup_enabled	true	2024-11-28 10:08:18.035155+00
44	backup_daily_limit	3	2024-11-28 10:08:18.038087+00
45	backup_initial_waiting_period	86400	2024-11-28 10:08:18.041189+00
46	backup_include_attachments	true	2024-11-28 10:08:18.043897+00
47	backup_attachment_size_max_sum_mb	1024	2024-11-28 10:08:18.046523+00
48	bcc_recipients	true	2024-11-28 10:08:18.050498+00
50	brute_force_block_minutes	30	2024-11-28 10:08:18.056529+00
51	brute_force_block_after_failed_logins	20	2024-11-28 10:08:18.059412+00
52	cache_formatted_text	true	2024-11-28 10:08:18.062176+00
53	total_percent_complete_mode	work_weighted_average	2024-11-28 10:08:18.065021+00
54	commit_fix_keywords	fixes,closes	2024-11-28 10:08:18.06766+00
55	commit_logs_encoding	UTF-8	2024-11-28 10:08:18.071752+00
56	commit_logtime_enabled	f	2024-11-28 10:08:18.075108+00
57	commit_ref_keywords	refs,references,IssueID	2024-11-28 10:08:18.078107+00
58	consent_info	---\nen: |-\n  ## Consent\n\n  You need to agree to the [privacy and security policy](https://www.openproject.org/data-privacy-and-security/) of this OpenProject instance.\n	2024-11-28 10:08:18.082029+00
59	consent_required	f	2024-11-28 10:08:18.08612+00
60	cross_project_work_package_relations	true	2024-11-28 10:08:18.089446+00
61	days_per_month	20	2024-11-28 10:08:18.092566+00
62	default_auto_hide_popups	true	2024-11-28 10:08:18.099336+00
63	default_comment_sort_order	asc	2024-11-28 10:08:18.102051+00
64	default_projects_modules	---\n- calendar\n- board_view\n- work_package_tracking\n- gantt\n- news\n- costs\n- wiki\n- reporting_module\n- meetings\n- backlogs\n	2024-11-28 10:08:18.105039+00
65	default_projects_public	f	2024-11-28 10:08:18.108084+00
70	development_highlight_enabled	f	2024-11-28 10:08:18.12232+00
71	diff_max_lines_displayed	1500	2024-11-28 10:08:18.125302+00
72	disable_password_choice	f	2024-11-28 10:08:18.128001+00
73	disable_password_login	f	2024-11-28 10:08:18.130691+00
74	display_subprojects_work_packages	true	2024-11-28 10:08:18.13561+00
75	drop_old_sessions_on_logout	true	2024-11-28 10:08:18.138843+00
76	drop_old_sessions_on_login	f	2024-11-28 10:08:18.142236+00
77	duration_format	hours_only	2024-11-28 10:08:18.145311+00
78	emails_salutation	firstname	2024-11-28 10:08:18.149088+00
79	emails_footer	---\nen: ''\n	2024-11-28 10:08:18.152197+00
80	emails_header	---\nen: ''\n	2024-11-28 10:08:18.155928+00
81	email_login	f	2024-11-28 10:08:18.158817+00
82	enabled_projects_columns	---\n- favored\n- name\n- project_status\n- public\n- created_at\n- latest_activity_at\n- required_disk_space\n	2024-11-28 10:08:18.161658+00
83	enabled_scm	---\n- subversion\n- git\n	2024-11-28 10:08:18.165642+00
84	feeds_enabled	true	2024-11-28 10:08:18.168612+00
85	feeds_limit	15	2024-11-28 10:08:18.171775+00
86	file_max_size_displayed	512	2024-11-28 10:08:18.17538+00
87	fog_download_url_expires_in	21600	2024-11-28 10:08:18.178367+00
88	forced_single_page_size	250	2024-11-28 10:08:18.182359+00
89	hours_per_day	8	2024-11-28 10:08:18.188224+00
90	health_checks_jobs_never_ran_minutes_ago	5	2024-11-28 10:08:18.194113+00
91	health_checks_backlog_threshold	20	2024-11-28 10:08:18.200927+00
92	gravatar_fallback_image	404	2024-11-28 10:08:18.206984+00
93	internal_password_confirmation	true	2024-11-28 10:08:18.213684+00
94	invitation_expiration_days	7	2024-11-28 10:08:18.223106+00
95	journal_aggregation_time_minutes	5	2024-11-28 10:08:18.229939+00
96	ldap_groups_disable_sync_job	f	2024-11-28 10:08:18.236279+00
97	ldap_users_disable_sync_job	f	2024-11-28 10:08:18.242115+00
98	ldap_users_sync_status	f	2024-11-28 10:08:18.249956+00
99	log_requesting_user	f	2024-11-28 10:08:18.255925+00
100	login_required	true	2024-11-28 10:08:18.26251+00
101	lost_password	true	2024-11-28 10:08:18.268644+00
102	mail_from	openproject@example.net	2024-11-28 10:08:18.274547+00
103	mail_handler_body_delimiters		2024-11-28 10:08:18.27787+00
104	mail_handler_body_delimiter_regex		2024-11-28 10:08:18.281152+00
105	mail_handler_ignore_filenames	signature.asc	2024-11-28 10:08:18.286226+00
106	mail_suffix_separators	+	2024-11-28 10:08:18.289411+00
107	notifications_hidden	f	2024-11-28 10:08:18.292736+00
108	notifications_polling_interval	60000	2024-11-28 10:08:18.297058+00
109	oauth_allow_remapping_of_existing_users	true	2024-11-28 10:08:18.301649+00
110	onboarding_video_url	https://player.vimeo.com/video/163426858?autoplay=1	2024-11-28 10:08:18.307372+00
111	onboarding_enabled	true	2024-11-28 10:08:18.313315+00
112	password_active_rules	---\n- lowercase\n- uppercase\n- numeric\n- special\n	2024-11-28 10:08:18.320099+00
113	password_count_former_banned	0	2024-11-28 10:08:18.32653+00
114	password_days_valid	0	2024-11-28 10:08:18.333013+00
115	password_min_length	10	2024-11-28 10:08:18.339623+00
116	password_min_adhered_rules	0	2024-11-28 10:08:18.343874+00
117	per_page_options	20, 100	2024-11-28 10:08:18.347035+00
118	percent_complete_on_status_closed	no_change	2024-11-28 10:08:18.350519+00
119	plain_text_mail	f	2024-11-28 10:08:18.354386+00
120	show_work_package_attachments	true	2024-11-28 10:08:18.359042+00
121	registration_footer	---\nen: ''\n	2024-11-28 10:08:18.370935+00
122	report_incoming_email_errors	true	2024-11-28 10:08:18.376567+00
123	repository_checkout_data	---\ngit:\n  enabled: 0\nsubversion:\n  enabled: 0\n	2024-11-28 10:08:18.379892+00
124	repository_log_display_limit	100	2024-11-28 10:08:18.383464+00
125	repository_storage_cache_minutes	720	2024-11-28 10:08:18.386406+00
126	repository_truncate_at	500	2024-11-28 10:08:18.38929+00
127	rest_api_enabled	true	2024-11-28 10:08:18.392065+00
128	security_badge_displayed	true	2024-11-28 10:08:18.39481+00
129	self_registration	2	2024-11-28 10:08:18.39794+00
130	sendmail_arguments	-i	2024-11-28 10:08:18.401342+00
131	sendmail_location	/usr/sbin/sendmail	2024-11-28 10:08:18.404328+00
132	session_ttl_enabled	f	2024-11-28 10:08:18.407716+00
133	session_ttl	120	2024-11-28 10:08:18.410961+00
134	show_community_links	true	2024-11-28 10:08:18.414145+00
135	show_product_version	true	2024-11-28 10:08:18.417554+00
136	show_setting_mismatch_warning	true	2024-11-28 10:08:18.420608+00
137	show_storage_information	true	2024-11-28 10:08:18.42364+00
138	show_warning_bars	true	2024-11-28 10:08:18.426735+00
139	smtp_authentication	plain	2024-11-28 10:08:18.429769+00
140	smtp_enable_starttls_auto	f	2024-11-28 10:08:18.433059+00
141	smtp_ssl	f	2024-11-28 10:08:18.435982+00
142	smtp_address		2024-11-28 10:08:18.4389+00
143	smtp_domain	your.domain.com	2024-11-28 10:08:18.442011+00
144	smtp_user_name		2024-11-28 10:08:18.444829+00
145	smtp_port	587	2024-11-28 10:08:18.44829+00
146	smtp_password		2024-11-28 10:08:18.451306+00
147	smtp_timeout	5	2024-11-28 10:08:18.454553+00
148	software_name	OpenProject	2024-11-28 10:08:18.457572+00
149	software_url	https://www.openproject.org/	2024-11-28 10:08:18.460586+00
150	sys_api_enabled	f	2024-11-28 10:08:18.463419+00
151	users_deletable_by_admins	f	2024-11-28 10:08:18.466586+00
152	user_default_theme	light	2024-11-28 10:08:18.470348+00
153	users_deletable_by_self	f	2024-11-28 10:08:18.473625+00
154	user_format	firstname_lastname	2024-11-28 10:08:18.476921+00
156	work_package_done_ratio	field	2024-11-28 10:08:18.483457+00
157	work_packages_projects_export_limit	500	2024-11-28 10:08:18.486596+00
158	work_packages_bulk_request_limit	10	2024-11-28 10:08:18.489672+00
159	work_package_list_default_highlighted_attributes	---\n- status\n- priority\n- due_date\n	2024-11-28 10:08:18.493551+00
160	work_package_list_default_columns	---\n- id\n- subject\n- type\n- status\n- assigned_to\n- priority\n	2024-11-28 10:08:18.498237+00
161	work_package_startdate_is_adddate	f	2024-11-28 10:08:18.501676+00
162	youtube_channel	https://www.youtube.com/c/OpenProjectCommunity	2024-11-28 10:08:18.504754+00
163	new_project_user_role_id	11	2024-11-28 10:08:18.508317+00
164	commit_fix_status_id	12	2024-11-28 10:08:18.511574+00
165	default_language	en	2024-11-28 10:08:18.514231+00
12	plugin_openproject_backlogs	---\nstory_types:\n- 4\n- 5\n- 6\n- 7\ntask_type: 1\npoints_burn_direction: up\nwiki_template: ''\n	2024-11-28 10:08:18.538929+00
166	welcome_title	Welcome to OpenProject!	2024-11-28 10:08:18.900809+00
167	welcome_text	OpenProject is the leading open source project management software. It supports classic, agile as well as hybrid project management and gives you full control over your data.\n\nCore features and use cases:\n\n* [Project Portfolio Management](https://www.openproject.org/collaboration-software-features/project-portfolio-management/)\n* [Project Planning and Scheduling](https://www.openproject.org/collaboration-software-features/project-planning-scheduling/)\n* [Task Management and Issue Tracking](https://www.openproject.org/collaboration-software-features/task-management/)\n* [Agile Boards (Scrum and Kanban)](https://www.openproject.org/collaboration-software-features/agile-project-management/)\n* [Requirements Management and Release Planning](https://www.openproject.org/collaboration-software-features/product-development/)\n* [Time and Cost Tracking, Budgets](https://www.openproject.org/collaboration-software-features/time-tracking/)\n* [Team Collaboration and Documentation](https://www.openproject.org/collaboration-software-features/team-collaboration/)\n\nWelcome to the future of project management.\n\nFor Admins: You can change this welcome text [here]({{opSetting:base_url}}/admin/settings/general).\n	2024-11-28 10:08:18.904857+00
155	welcome_on_homescreen	1	2024-11-28 10:08:18.909055+00
69	demo_view_of_type_gantt_seeded	true	2024-11-28 10:08:19.430163+00
67	demo_view_of_type_work_packages_table_seeded	true	2024-11-28 10:08:19.450893+00
68	demo_view_of_type_team_planner_seeded	true	2024-11-28 10:08:19.48074+00
49	boards_demo_data_available	true	2024-11-28 10:08:20.596529+00
66	demo_projects_available	true	2024-11-28 10:08:20.933939+00
168	installation_uuid	065c2633-0393-4fb0-be70-44fbbf96da6e	2024-11-28 10:12:48.025062+00
169	costs_currency	EUR	2024-12-11 09:56:36.896831+00
170	costs_currency_format	%n %u	2024-12-11 09:56:36.89959+00
171	feature_generate_pdf_from_work_package_active	f	2024-12-11 09:57:00.666434+00
172	feature_stages_and_gates_active	f	2024-12-11 09:57:00.676539+00
173	allow_tracking_start_and_end_times	f	2024-12-11 09:57:00.691186+00
174	enforce_tracking_start_and_end_times	f	2024-12-11 09:57:00.696018+00
175	feature_track_start_and_end_times_for_time_entries_active	f	2024-12-11 09:57:00.702066+00
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.statuses (id, name, is_closed, is_default, "position", default_done_ratio, created_at, updated_at, color_id, is_readonly, excluded_from_totals) FROM stdin;
1	New	f	t	1	0	2024-11-28 10:08:16.687394+00	2024-11-28 10:08:16.687394+00	92	f	f
2	In specification	f	f	2	10	2024-11-28 10:08:16.695397+00	2024-11-28 10:08:16.695397+00	77	f	f
3	Specified	f	f	3	20	2024-11-28 10:08:16.700534+00	2024-11-28 10:08:16.700534+00	77	f	f
4	Confirmed	f	f	4	20	2024-11-28 10:08:16.70496+00	2024-11-28 10:08:16.70496+00	57	f	f
5	To be scheduled	f	f	5	20	2024-11-28 10:08:16.708789+00	2024-11-28 10:08:16.708789+00	127	f	f
6	Scheduled	f	f	6	20	2024-11-28 10:08:16.712118+00	2024-11-28 10:08:16.712118+00	117	f	f
7	In progress	f	f	7	40	2024-11-28 10:08:16.716101+00	2024-11-28 10:08:16.716101+00	50	f	f
8	Developed	f	f	8	70	2024-11-28 10:08:16.719909+00	2024-11-28 10:08:16.719909+00	108	f	f
9	In testing	f	f	9	80	2024-11-28 10:08:16.724595+00	2024-11-28 10:08:16.724595+00	90	f	f
10	Tested	f	f	10	90	2024-11-28 10:08:16.728476+00	2024-11-28 10:08:16.728476+00	101	f	f
11	Test failed	f	f	11	70	2024-11-28 10:08:16.73224+00	2024-11-28 10:08:16.73224+00	30	f	f
12	Closed	t	f	12	100	2024-11-28 10:08:16.760102+00	2024-11-28 10:08:16.760102+00	18	f	f
13	On hold	f	f	13	0	2024-11-28 10:08:16.764981+00	2024-11-28 10:08:16.764981+00	138	f	f
14	Rejected	t	f	14	0	2024-11-28 10:08:16.771763+00	2024-11-28 10:08:16.771763+00	28	f	f
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
1	4	Token::RSS	92daa542e7a985a22ef084eda76acf9caa7812b50f7a359752118612b4090bf4	2024-11-28 10:14:37.641632+00	\N	\N
2	5	Token::Invitation	760fb4d2f054499bf0eb0f846e732987edbcdde4fe39fd665e2b7f153852317f	2024-11-28 10:15:07.093961+00	2024-12-05 10:15:07.079851+00	\N
35	5	Token::RSS	179cc3b9cb586b2916c8f6e5e63c129e9ecacf0ac8a955e6b82a64adc8f64da2	2024-11-29 02:09:02.434204+00	\N	\N
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
1	Task	1	t	f	t	2	2024-11-28 10:08:16.787666+00	2024-11-28 10:08:16.787666+00	f	\N	
2	Milestone	2	f	t	t	4	2024-11-28 10:08:16.793985+00	2024-11-28 10:08:16.793985+00	f	\N	
3	Phase	3	f	f	t	140	2024-11-28 10:08:16.798591+00	2024-11-28 10:08:16.798591+00	f	\N	
4	Feature	4	t	f	f	70	2024-11-28 10:08:16.802706+00	2024-11-28 10:08:16.802706+00	f	\N	
5	Epic	5	t	f	f	60	2024-11-28 10:08:16.807596+00	2024-11-28 10:08:16.807596+00	f	\N	
6	User story	6	t	f	f	3	2024-11-28 10:08:16.811215+00	2024-11-28 10:08:16.811215+00	f	\N	
7	Bug	7	t	f	f	32	2024-11-28 10:08:16.814291+00	2024-11-28 10:08:16.814291+00	f	\N	
\.


--
-- Data for Name: user_passwords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_passwords (id, user_id, hashed_password, salt, created_at, updated_at, type) FROM stdin;
2	4	$2a$12$pZuXCvPe/xXzJZPC1BIj3O92vUMXZFfX3T6HyDuM8sf4geuBiMo5y	\N	2024-11-28 10:12:47.404753+00	2024-11-28 10:12:47.404753+00	UserPassword::Bcrypt
3	5	$2a$12$ml9BvVpuvWD2UEG1ArTkveff5TvrjQ6u6W77tpzomz3RCggHRValG	\N	2024-11-28 10:15:45.798824+00	2024-11-28 10:15:45.798824+00	UserPassword::Bcrypt
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_preferences (id, user_id, settings, created_at, updated_at) FROM stdin;
1	4	{"backlogs_task_color": "#A1B8CB", "backlogs_versions_default_fold_state": "open"}	2024-11-28 10:07:52.116764+00	2024-11-28 10:13:00.91123+00
2	5	{"theme": "light", "time_zone": "Etc/UTC", "auto_hide_popups": true, "comments_sorting": "asc", "warn_on_leaving_unsaved": true}	2024-11-28 10:07:52.116764+00	2024-11-28 10:07:52.116764+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, login, firstname, lastname, mail, admin, status, last_login_on, language, ldap_auth_source_id, created_at, updated_at, type, identity_url, first_login, force_password_change, failed_login_count, last_failed_login_on, consented_at, webauthn_id) FROM stdin;
2					f	3	\N		\N	2024-11-28 10:07:41.433493+00	2024-11-28 10:07:41.433493+00	DeletedUser	\N	t	f	0	\N	\N	\N
1			System		t	1	\N		\N	2024-11-28 10:07:40.901836+00	2024-11-28 10:07:40.901836+00	SystemUser	\N	f	f	0	\N	\N	\N
3			Anonymous		f	1	\N		\N	2024-11-28 10:08:16.061789+00	2024-11-28 10:08:16.061789+00	AnonymousUser	\N	t	f	0	\N	\N	\N
5	nit	Tuon	Sreynit	tuonsreynit83@gmail.com	t	1	2024-11-29 02:08:58.578515+00	en	\N	2024-11-28 10:15:07.086664+00	2024-11-29 02:08:58.590163+00	User	\N	f	f	0	\N	\N	\N
4	admin	OpenProject	Admin	admin@example.net	t	1	2024-12-11 09:58:03.334059+00	en	\N	2024-11-28 10:08:18.618908+00	2024-12-11 09:58:03.341417+00	User	\N	f	f	0	2024-11-28 10:12:13.37171+00	\N	\N
\.


--
-- Data for Name: version_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.version_settings (id, project_id, version_id, display, created_at, updated_at) FROM stdin;
1	2	1	3	2024-11-28 10:08:21.145797+00	2024-11-28 10:08:21.145797+00
2	2	2	3	2024-11-28 10:08:21.149199+00	2024-11-28 10:08:21.149199+00
3	2	3	2	2024-11-28 10:08:21.15068+00	2024-11-28 10:08:21.15068+00
4	2	4	2	2024-11-28 10:08:21.152083+00	2024-11-28 10:08:21.152083+00
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.versions (id, project_id, name, description, effective_date, created_at, updated_at, wiki_page_title, status, sharing, start_date) FROM stdin;
1	2	Bug Backlog		\N	2024-11-28 10:08:21.073067+00	2024-11-28 10:08:21.073067+00	\N	open	none	\N
2	2	Product Backlog		\N	2024-11-28 10:08:21.085142+00	2024-11-28 10:08:21.085142+00	\N	open	none	\N
3	2	Sprint 1		\N	2024-11-28 10:08:21.087934+00	2024-11-28 10:08:21.129097+00	Sprint 1	open	none	\N
4	2	Sprint 2		\N	2024-11-28 10:08:21.133006+00	2024-11-28 10:08:21.133006+00	\N	open	none	\N
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.views (id, query_id, options, type, created_at, updated_at) FROM stdin;
1	1	{}	gantt	2024-11-28 10:08:19.427101+00	2024-11-28 10:08:19.427101+00
2	2	{}	work_packages_table	2024-11-28 10:08:19.447313+00	2024-11-28 10:08:19.447313+00
3	3	{}	work_packages_table	2024-11-28 10:08:19.461904+00	2024-11-28 10:08:19.461904+00
4	4	{}	team_planner	2024-11-28 10:08:19.477172+00	2024-11-28 10:08:19.477172+00
5	15	{}	gantt	2024-11-28 10:08:21.166533+00	2024-11-28 10:08:21.166533+00
6	16	{}	work_packages_table	2024-11-28 10:08:21.184302+00	2024-11-28 10:08:21.184302+00
7	17	{}	work_packages_table	2024-11-28 10:08:21.196129+00	2024-11-28 10:08:21.196129+00
8	18	{}	work_packages_table	2024-11-28 10:08:21.204434+00	2024-11-28 10:08:21.204434+00
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
1	1	Wiki	2024-11-28 10:08:19.493076+00	f	\N	wiki	2024-11-28 10:08:19.493076+00	4	_In this wiki you can collaboratively create and edit pages and sub-pages to create a project wiki._\n\n**You can:**\n\n* Insert text and images, also with copy and paste from other documents\n* Create a page hierarchy with parent pages\n* Include wiki pages to the project menu\n* Use macros to include, e.g. table of contents, work package lists, or Gantt charts\n* Include wiki pages in other text fields, e.g. project overview page\n* Include links to other documents\n* View the change history\n* View as Markdown\n\nMore information: [https://www.openproject.org/docs/user-guide/wiki/](https://www.openproject.org/docs/user-guide/wiki/)\n	0
2	2	Sprint 1	2024-11-28 10:08:21.098847+00	f	\N	sprint-1	2024-11-28 10:08:21.098847+00	1	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the [Task board](/projects/your-scrum-project/sprints/3/taskboard).\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down [Sprint Impediments](/projects/your-scrum-project/sprints/3/taskboard).\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n	0
3	2	Wiki	2024-11-28 10:08:21.211834+00	f	\N	wiki	2024-11-28 10:08:21.211834+00	4	### Sprint planning meeting\n\n_Please document here topics to the Sprint planning meeting_\n\n* Time boxed (8 h)\n* Input: Product Backlog\n* Output: Sprint Backlog\n\n* Divided into two additional time boxes of 4 h:\n\n    * The Product Owner presents the [Product Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs) and the priorities to the team and explains the Sprint Goal, to which the team must agree. Together, they prioritize the topics from the Product Backlog which the team will take care of in the next sprint. The team commits to the discussed delivery.\n    * The team plans autonomously (without the Product Owner) in detail and breaks down the tasks from the discussed requirements to consolidate a [Sprint Backlog]({{opSetting:base_url}}/projects/your-scrum-project/backlogs).\n\n\n### Daily Scrum meeting\n\n_Please document here topics to the Daily Scrum meeting_\n\n* Short, daily status meeting of the team.\n* Time boxed (max. 15 min).\n* Stand-up meeting to discuss the following topics from the Task board.\n    * What do I plan to do until the next Daily Scrum?\n    * What has blocked my work (Impediments)?\n* Scrum Master moderates and notes down Sprint Impediments.\n* Product Owner may participate may participate in order to stay informed.\n\n### Sprint Review meeting\n\n_Please document here topics to the Sprint Review meeting_\n\n* Time boxed (4 h).\n* A maximum of one hour of preparation time per person.\n* The team shows the product owner and other interested persons what has been achieved in this sprint.\n* Important: no dummies and no PowerPoint! Just finished product functionality (Increments) should be demonstrated.\n* Feedback from Product Owner, stakeholders and others is desired and will be included in further work.\n* Based on the demonstrated functionalities, the Product Owner decides to go live with this increment or to develop it further. This possibility allows an early ROI.\n\n\n### Sprint Retrospective\n\n_Please document here topics to the Sprint Retrospective meeting_\n\n* Time boxed (3 h).\n* After Sprint Review, will be moderated by Scrum Master.\n* The team discusses the sprint: what went well, what needs to be improved to be more productive for the next sprint or even have more fun.\n	0
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
1	1	Wiki	1	2024-11-28 10:08:19.088707+00	2024-11-28 10:08:19.495477+00
2	2	Wiki	1	2024-11-28 10:08:20.966382+00	2024-11-28 10:08:21.212729+00
3	3	Wiki	1	2024-11-28 10:13:26.987794+00	2024-11-28 10:13:26.987794+00
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
2	2	1	Start of project		2024-11-24	\N	12	4	8	\N	4	\N	\N	2024-11-24	\N	\N	\N	\N	\N	\N	f	1	t	\N	\N
7	1	1	Send invitation to speakers		2024-11-25	\N	7	4	8	\N	4	\N	\N	2024-11-25	3	\N	\N	\N	\N	\N	f	1	f	\N	\N
10	1	1	Contact sponsoring partners		2024-11-26	\N	1	4	8	\N	4	\N	\N	2024-11-25	3	\N	\N	\N	\N	\N	f	2	f	\N	\N
13	1	1	Create sponsorship brochure and hand-outs		2024-11-28	\N	1	4	8	\N	4	\N	\N	2024-11-25	3	\N	\N	\N	\N	\N	f	4	f	\N	\N
15	1	1	Set date and location of conference		2024-11-28	\N	7	4	8	\N	4	\N	\N	2024-11-25	2	\N	\N	\N	\N	\N	f	4	f	\N	\N
18	1	1	Invite attendees to conference		2024-11-29	\N	1	4	8	\N	4	\N	\N	2024-11-29	2	\N	\N	\N	\N	\N	f	1	f	\N	\N
21	1	1	Setup conference website		2024-12-09	\N	1	4	8	\N	4	\N	\N	2024-11-29	2	\N	\N	\N	\N	\N	f	7	f	\N	\N
22	3	1	Organize open source conference		2024-12-09	\N	7	4	8	\N	4	\N	\N	2024-11-25	\N	\N	\N	\N	\N	\N	f	11	f	\N	\N
24	2	1	Conference		2024-12-10	\N	6	4	8	\N	4	\N	\N	2024-12-10	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
28	1	1	Upload presentations to website		2024-12-25	\N	1	4	8	\N	4	\N	\N	2024-12-16	10	\N	\N	\N	\N	\N	f	8	f	\N	\N
31	1	1	Party for conference supporters :-)	*   [ ] Beer\n*   [ ] Snacks\n*   [ ] Music\n*   [ ] Even more beer	2024-12-26	\N	1	4	8	\N	4	\N	\N	2024-12-26	10	\N	\N	\N	\N	\N	f	1	f	\N	\N
32	3	1	Follow-up tasks		2024-12-26	\N	5	4	8	\N	4	\N	\N	2024-12-16	\N	\N	\N	\N	\N	\N	f	9	f	\N	\N
34	2	1	End of project		2024-12-27	\N	1	4	8	\N	4	\N	\N	2024-12-27	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
36	6	2	New login screen		\N	\N	2	4	8	2	4	\N	\N	2024-11-25	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N
38	7	2	Password reset does not send email		\N	\N	4	4	8	1	4	\N	\N	2024-11-25	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N
42	6	2	Newsletter registration form		\N	\N	7	4	8	2	4	\N	\N	2024-11-25	16	\N	\N	\N	\N	\N	f	\N	f	\N	\N
45	6	2	Implement product tour		\N	\N	2	4	8	2	4	\N	\N	2024-11-25	16	\N	\N	\N	\N	\N	f	\N	f	\N	\N
49	1	2	Create wireframes for new landing page		2024-12-23	\N	7	4	8	3	4	\N	\N	2024-12-23	19	\N	\N	\N	\N	\N	f	1	f	\N	\N
51	6	2	New landing page		2024-12-23	\N	3	4	8	3	4	\N	\N	2024-12-23	16	\N	\N	3	\N	\N	f	1	f	\N	\N
52	5	2	New website		2024-12-23	\N	3	4	8	\N	4	\N	\N	2024-11-25	\N	\N	\N	\N	\N	\N	f	21	f	\N	\N
54	6	2	Contact form		2024-12-16	\N	3	4	8	3	4	\N	\N	2024-12-16	\N	\N	\N	1	\N	\N	f	1	f	\N	\N
58	1	2	Make screenshots for feature tour		\N	\N	12	4	8	3	4	\N	\N	2024-11-25	22	\N	\N	\N	\N	\N	f	\N	f	\N	\N
59	6	2	Feature carousel		\N	\N	3	4	8	3	4	\N	\N	2024-11-25	\N	\N	\N	5	\N	\N	f	\N	f	\N	\N
61	7	2	Wrong hover color		2024-12-16	\N	14	4	8	3	4	\N	\N	2024-12-16	\N	\N	\N	1	\N	\N	f	1	f	\N	\N
63	6	2	SSL certificate		2024-12-17	\N	3	4	8	2	4	\N	\N	2024-12-17	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
65	6	2	Set-up Staging environment		2024-12-18	\N	2	4	8	2	4	\N	\N	2024-12-18	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
67	6	2	Choose a content management system		2024-12-19	\N	3	4	8	2	4	\N	\N	2024-12-19	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
71	1	2	Set up navigation concept for website.		2024-12-20	\N	2	4	8	3	4	\N	\N	2024-12-20	28	\N	\N	\N	\N	\N	f	1	f	\N	\N
72	6	2	Website navigation structure		2024-12-20	\N	3	4	8	3	4	\N	\N	2024-12-20	\N	\N	\N	3	\N	\N	f	1	f	\N	\N
74	6	2	Internal link structure		2024-12-20	\N	12	4	8	2	4	\N	\N	2024-12-20	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
76	3	2	Develop v1.0		2024-12-11	\N	7	4	8	\N	4	\N	\N	2024-12-09	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
78	2	2	Release v1.0		2024-12-13	\N	1	4	8	\N	4	\N	\N	2024-12-13	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
80	3	2	Develop v1.1		2024-12-18	\N	1	4	8	\N	4	\N	\N	2024-12-16	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
82	2	2	Release v1.1		2024-12-20	\N	1	4	8	\N	4	\N	\N	2024-12-20	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
84	3	2	Develop v2.0		2024-12-25	\N	1	4	8	\N	4	\N	\N	2024-12-23	\N	\N	\N	\N	\N	\N	f	3	f	\N	\N
86	2	2	Release v2.0		2024-12-27	\N	1	4	8	\N	4	\N	\N	2024-12-27	\N	\N	\N	\N	\N	\N	f	1	f	\N	\N
\.


--
-- Data for Name: work_packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.work_packages (id, type_id, project_id, subject, description, due_date, category_id, status_id, assigned_to_id, priority_id, version_id, author_id, lock_version, done_ratio, estimated_hours, created_at, updated_at, start_date, responsible_id, budget_id, "position", story_points, remaining_hours, derived_estimated_hours, schedule_manually, parent_id, duration, ignore_non_working_days, derived_remaining_hours, derived_done_ratio, project_life_cycle_step_id) FROM stdin;
1	2	1	Start of project	\N	2024-11-24	\N	12	4	8	\N	4	0	\N	\N	2024-11-28 10:08:19.556742+00	2024-11-28 10:08:19.630954+00	2024-11-24	\N	\N	1	\N	\N	\N	f	\N	1	t	\N	\N	\N
4	1	1	Send invitation to speakers		2024-11-25	\N	7	4	8	\N	4	1	\N	\N	2024-11-28 10:08:19.717776+00	2024-11-28 10:08:19.776038+00	2024-11-25	\N	\N	1	\N	\N	\N	f	3	1	f	\N	\N	\N
5	1	1	Contact sponsoring partners		2024-11-26	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:19.816175+00	2024-11-28 10:08:19.867761+00	2024-11-25	\N	\N	1	\N	\N	\N	f	3	2	f	\N	\N	\N
6	1	1	Create sponsorship brochure and hand-outs		2024-11-28	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:19.898109+00	2024-11-28 10:08:19.946665+00	2024-11-25	\N	\N	1	\N	\N	\N	f	3	4	f	\N	\N	\N
3	1	1	Set date and location of conference		2024-11-28	\N	7	4	8	\N	4	1	\N	\N	2024-11-28 10:08:19.68823+00	2024-11-28 10:08:20.008764+00	2024-11-25	\N	\N	1	\N	\N	\N	f	2	4	f	\N	\N	\N
7	1	1	Invite attendees to conference		2024-11-29	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:20.056157+00	2024-11-28 10:08:20.107544+00	2024-11-29	\N	\N	1	\N	\N	\N	f	2	1	f	\N	\N	\N
8	1	1	Setup conference website		2024-12-09	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:20.142161+00	2024-11-28 10:08:20.185332+00	2024-11-29	\N	\N	1	\N	\N	\N	f	2	7	f	\N	\N	\N
2	3	1	Organize open source conference		2024-12-09	\N	7	4	8	\N	4	0	\N	\N	2024-11-28 10:08:19.6563+00	2024-11-28 10:08:20.216647+00	2024-11-25	\N	\N	1	\N	\N	\N	f	\N	11	f	\N	\N	\N
9	2	1	Conference		2024-12-10	\N	6	4	8	\N	4	0	\N	\N	2024-11-28 10:08:20.237479+00	2024-11-28 10:08:20.264772+00	2024-12-10	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
11	1	1	Upload presentations to website		2024-12-25	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:20.30441+00	2024-11-28 10:08:20.357162+00	2024-12-16	\N	\N	1	\N	\N	\N	f	10	8	f	\N	\N	\N
12	1	1	Party for conference supporters :-)	*   [ ] Beer\n*   [ ] Snacks\n*   [ ] Music\n*   [ ] Even more beer	2024-12-26	\N	1	4	8	\N	4	1	\N	\N	2024-11-28 10:08:20.391412+00	2024-11-28 10:08:20.440651+00	2024-12-26	\N	\N	1	\N	\N	\N	f	10	1	f	\N	\N	\N
10	3	1	Follow-up tasks		2024-12-26	\N	5	4	8	\N	4	0	\N	\N	2024-11-28 10:08:20.280292+00	2024-11-28 10:08:20.470694+00	2024-12-16	\N	\N	1	\N	\N	\N	f	\N	9	f	\N	\N	\N
13	2	1	End of project	\N	2024-12-27	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:20.48736+00	2024-11-28 10:08:20.512069+00	2024-12-27	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
15	7	2	Password reset does not send email	\N	\N	\N	4	4	8	1	4	0	\N	\N	2024-11-28 10:08:21.311905+00	2024-11-28 10:08:21.353881+00	2024-11-25	\N	\N	1	\N	\N	\N	f	\N	\N	f	\N	\N	\N
16	5	2	New website	\N	2024-12-23	\N	3	4	8	\N	4	0	\N	\N	2024-11-28 10:08:21.381472+00	2024-11-28 10:08:21.730609+00	2024-11-25	\N	\N	1	\N	\N	\N	f	\N	21	f	\N	\N	\N
20	1	2	Create wireframes for new landing page	\N	2024-12-23	\N	7	4	8	3	4	1	\N	\N	2024-11-28 10:08:21.612705+00	2024-11-28 10:08:21.652757+00	2024-12-23	\N	\N	1	\N	\N	\N	f	19	1	f	\N	\N	\N
19	6	2	New landing page	\N	2024-12-23	\N	3	4	8	3	4	1	\N	\N	2024-11-28 10:08:21.585544+00	2024-11-28 10:08:21.696851+00	2024-12-23	\N	\N	2	3	\N	\N	f	16	1	f	\N	\N	\N
23	1	2	Make screenshots for feature tour	\N	\N	\N	12	4	8	3	4	1	\N	\N	2024-11-28 10:08:21.84353+00	2024-11-28 10:08:21.904313+00	2024-11-25	\N	\N	1	\N	\N	\N	f	22	\N	f	\N	\N	\N
22	6	2	Feature carousel	\N	\N	\N	3	4	8	3	4	0	\N	\N	2024-11-28 10:08:21.803135+00	2024-11-28 10:08:21.947508+00	2024-11-25	\N	\N	3	5	\N	\N	f	\N	\N	f	\N	\N	\N
24	7	2	Wrong hover color	\N	2024-12-16	\N	14	4	8	3	4	0	\N	\N	2024-11-28 10:08:21.971685+00	2024-11-28 10:08:22.010073+00	2024-12-16	\N	\N	4	1	\N	\N	f	\N	1	f	\N	\N	\N
25	6	2	SSL certificate	\N	2024-12-17	\N	3	4	8	2	4	0	\N	\N	2024-11-28 10:08:22.039579+00	2024-11-28 10:08:22.077108+00	2024-12-17	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
26	6	2	Set-up Staging environment	\N	2024-12-18	\N	2	4	8	2	4	0	\N	\N	2024-11-28 10:08:22.093397+00	2024-11-28 10:08:22.153864+00	2024-12-18	\N	\N	2	\N	\N	\N	f	\N	1	f	\N	\N	\N
21	6	2	Contact form	\N	2024-12-16	\N	3	4	8	3	4	0	\N	\N	2024-11-28 10:08:21.749861+00	2024-11-28 10:08:21.784843+00	2024-12-16	\N	\N	8	1	\N	\N	f	\N	1	f	\N	\N	\N
29	1	2	Set up navigation concept for website.	\N	2024-12-20	\N	2	4	8	3	4	1	\N	\N	2024-11-28 10:08:22.333671+00	2024-11-28 10:08:22.404644+00	2024-12-20	\N	\N	1	\N	\N	\N	f	28	1	f	\N	\N	\N
28	6	2	Website navigation structure	\N	2024-12-20	\N	3	4	8	3	4	0	\N	\N	2024-11-28 10:08:22.285489+00	2024-11-28 10:08:22.480602+00	2024-12-20	\N	\N	7	3	\N	\N	f	\N	1	f	\N	\N	\N
18	6	2	Implement product tour	\N	\N	\N	2	4	8	2	4	1	\N	\N	2024-11-28 10:08:21.503683+00	2024-11-28 10:08:21.554755+00	2024-11-25	\N	\N	7	\N	\N	\N	f	16	\N	f	\N	\N	\N
14	6	2	New login screen	\N	\N	\N	2	4	8	2	4	0	\N	\N	2024-11-28 10:08:21.248994+00	2024-11-28 10:08:21.290285+00	2024-11-25	\N	\N	6	\N	\N	\N	f	\N	\N	f	\N	\N	\N
17	6	2	Newsletter registration form	\N	\N	\N	7	4	8	2	4	1	\N	\N	2024-11-28 10:08:21.41168+00	2024-11-28 10:08:21.472098+00	2024-11-25	\N	\N	11	\N	\N	\N	f	16	\N	f	\N	\N	\N
27	6	2	Choose a content management system	\N	2024-12-19	\N	3	4	8	2	4	0	\N	\N	2024-11-28 10:08:22.200989+00	2024-11-28 10:08:22.257541+00	2024-12-19	\N	\N	8	\N	\N	\N	f	\N	1	f	\N	\N	\N
30	6	2	Internal link structure	\N	2024-12-20	\N	12	4	8	2	4	0	\N	\N	2024-11-28 10:08:22.51277+00	2024-11-28 10:08:22.566251+00	2024-12-20	\N	\N	5	\N	\N	\N	f	\N	1	f	\N	\N	\N
31	3	2	Develop v1.0	\N	2024-12-11	\N	7	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.598123+00	2024-11-28 10:08:22.642994+00	2024-12-09	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
32	2	2	Release v1.0	\N	2024-12-13	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.673149+00	2024-11-28 10:08:22.718327+00	2024-12-13	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
33	3	2	Develop v1.1	\N	2024-12-18	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.7462+00	2024-11-28 10:08:22.792691+00	2024-12-16	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
34	2	2	Release v1.1	\N	2024-12-20	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.818407+00	2024-11-28 10:08:22.859774+00	2024-12-20	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
35	3	2	Develop v2.0	\N	2024-12-25	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.885644+00	2024-11-28 10:08:22.916636+00	2024-12-23	\N	\N	1	\N	\N	\N	f	\N	3	f	\N	\N	\N
36	2	2	Release v2.0	\N	2024-12-27	\N	1	4	8	\N	4	0	\N	\N	2024-11-28 10:08:22.933187+00	2024-11-28 10:08:22.964534+00	2024-12-27	\N	\N	1	\N	\N	\N	f	\N	1	f	\N	\N	\N
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

SELECT pg_catalog.setval('public.enabled_modules_id_seq', 46, true);


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

SELECT pg_catalog.setval('public.grid_widgets_id_seq', 65, true);


--
-- Name: grids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.grids_id_seq', 40, true);


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

SELECT pg_catalog.setval('public.journals_id_seq', 79, true);


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

SELECT pg_catalog.setval('public.menu_items_id_seq', 35, true);


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

SELECT pg_catalog.setval('public.project_journals_id_seq', 35, true);


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

SELECT pg_catalog.setval('public.projects_id_seq', 35, true);


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

SELECT pg_catalog.setval('public.sessions_id_seq', 39, true);


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

SELECT pg_catalog.setval('public.wikis_id_seq', 35, true);


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

