--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Data for Name: resource_data; Type: TABLE DATA; Schema: public;
--

INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (12, 6, '{"name": "Dune", "reviews": [], "author_id": 11, "publishers": []}', '2022-04-05 13:56:54.098364', '2022-04-05 13:56:54.098364');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (13, 6, '{"name": "Dune Messiah", "reviews": [], "author_id": 11, "publishers": []}', '2022-04-05 13:56:54.10181', '2022-04-05 13:56:54.10181');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (14, 6, '{"name": "Children of Dune", "reviews": [], "author_id": 11, "publishers": []}', '2022-04-05 13:56:54.105412', '2022-04-05 13:56:54.105412');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (11, 3, '{"name": "Frank Herbert", "books": [12, 13, 14], "email": "frank.herbert@gmail.com", "date_of_birth": "1920-10-08"}', '2022-04-05 13:56:54.094536', '2022-04-05 13:56:54.10729');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (15, 3, '{"name": "Stephen King", "books": [16, 17, 18, 19], "email": "stephen.king@gmail.com", "date_of_birth": "1947-09-21"}', '2022-04-05 13:56:54.111788', '2022-04-05 13:56:54.128913');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (20, 4, '{"stars": 5, "review": "Couldn''t sleep for a week - amazing writing !!!", "book_id": 16}', '2022-04-05 13:56:54.133625', '2022-04-05 13:56:54.133625');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (21, 4, '{"stars": 4, "review": "A real ''page turner''", "book_id": 16}', '2022-04-05 13:56:54.137676', '2022-04-05 13:56:54.137676');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (22, 5, '{"date": "1974-04-01", "name": "Simon And Shuster", "book_id": 16}', '2022-04-05 13:56:54.14537', '2022-04-05 13:56:54.14537');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (23, 5, '{"date": "1977-01-01", "name": "Simon And Shuster", "book_id": 17}', '2022-04-05 13:56:54.149137', '2022-04-05 13:56:54.149137');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (24, 5, '{"date": "1978-10-01", "name": "John Wiley & Sons", "book_id": 18}', '2022-04-05 13:56:54.152777', '2022-04-05 13:56:54.152777');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (25, 5, '{"date": "2004-09-01", "name": "HarperCollins", "book_id": 19}', '2022-04-05 13:56:54.156471', '2022-04-05 13:56:54.156471');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (16, 6, '{"name": "Carrie", "reviews": [20, 21], "author_id": 15, "publishers": [22]}', '2022-04-05 13:56:54.115339', '2022-04-05 13:56:54.158355');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (17, 6, '{"name": "The Shining", "reviews": [], "author_id": 15, "publishers": [23]}', '2022-04-05 13:56:54.118877', '2022-04-05 13:56:54.160805');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (18, 6, '{"name": "The Stand", "reviews": [], "author_id": 15, "publishers": [24]}', '2022-04-05 13:56:54.1233', '2022-04-05 13:56:54.163088');
INSERT INTO public.resource_data (id, resource_id, data, created_at, updated_at) VALUES (19, 6, '{"name": "The Dark Tower", "reviews": [], "author_id": 15, "publishers": [25]}', '2022-04-05 13:56:54.126997', '2022-04-05 13:56:54.165381');


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public;
--

INSERT INTO public.resources (id, name, version, schema, created_at, updated_at) VALUES (3, 'Author', 1, '{"name": {"type": "string", "label": "Name", "accessor": "name", "is_association": false}, "books": {"type": "array", "label": "Books", "accessor": "books", "is_association": true}, "email": {"type": "string", "label": "Email", "accessor": "email", "is_association": false}, "date_of_birth": {"type": "date", "label": "Birthday", "accessor": "date_of_birth", "is_association": false}}', '2022-04-05 13:56:53.745293', '2022-04-05 13:56:53.745293');
INSERT INTO public.resources (id, name, version, schema, created_at, updated_at) VALUES (4, 'Review', 1, '{"stars": {"type": "integer", "label": "Stars", "accessor": "stars", "is_association": false}, "review": {"type": "string", "label": "Review", "accessor": "review", "is_association": false}}', '2022-04-05 13:56:53.749094', '2022-04-05 13:56:53.749094');
INSERT INTO public.resources (id, name, version, schema, created_at, updated_at) VALUES (5, 'Publisher', 1, '{"date": {"type": "date", "label": "Date", "accessor": "date", "is_association": false}, "name": {"type": "string", "label": "Name", "accessor": "name", "is_association": false}}', '2022-04-05 13:56:53.752112', '2022-04-05 13:56:53.752112');
INSERT INTO public.resources (id, name, version, schema, created_at, updated_at) VALUES (6, 'Book', 1, '{"name": {"type": "string", "label": "Name", "accessor": "name", "is_association": false}, "reviews": {"type": "array", "label": "Reviews", "accessor": "reviews", "is_association": true}, "author_id": {"type": "integer", "label": "Author", "accessor": "author_id", "is_association": false}, "publishers": {"type": "array", "label": "Publishers", "accessor": "publishers", "is_association": true}}', '2022-04-05 13:56:53.755169', '2022-04-05 13:56:53.755169');


--
-- Name: resource_data_id_seq; Type: SEQUENCE SET; Schema: public;
--

SELECT pg_catalog.setval('public.resource_data_id_seq', 25, true);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public;
--

SELECT pg_catalog.setval('public.resources_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--
