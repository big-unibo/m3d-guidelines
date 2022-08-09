# Logical design of multi-model data warehouses

This repository contains the material relative to the paper "Logical design of multi-model data warehouses", by Sandro Bimonte, Enrico Gallinucci, Patrick Marcel, and Stefano Rizzi, submitted to the Knowledge and Information Systems journal.

## Abstract
Multi-model DBMSs, which natively support different data models with a fully integrated backend, have been shown to be beneficial to data warehouses and OLAP systems. Indeed, they can store data according to the multidimensional model and, at the same time, let each of its elements be represented through the most appropriate model. An open challenge in this context is the lack of methods for logical design. Indeed, in a multi-model context, several alternatives emerge for the logical representation of dimensions and facts. The goal of this paper is to devise a set of guidelines for the logical design of multi-model data warehouses so that the designer can achieve the best trade-off between features such as querying, storage, and ETL. To this end, for each model considered (relational, document-based, and graph-based) and for each type of multidimensional element (e.g., non-strict hierarchy) we propose some solutions and carry out a set of intra-model and inter-model comparisons. The resulting guidelines are then tested on a case study that shows all types of multidimensional elements.

## Data

The database with the implementation of every solution in the paper can be downloaded [here](https://big.csr.unibo.it/downloads/m3d_guidelines) (9.6 GB); 
it is a dump file obtained by running the ```pg_dump``` utility of PostgreSQL.

The code used to generate the same data is available in this repo, written in Java. 
All dataset parameters can be changed in the ```Main``` class.
Connection to the AgensGraph database is set up in the ```it.unibo.big.m3d.utils.db.DbUtils``` class. 
A ```credentials.txt``` must be created in the ```resources``` folder 
(see the ```credentials_example.txt``` for an example). 

Requirement: an [Agensgraph](https://bitnine.net/agensgraph/) database.

Each solution is composed by the following tables:

- RELATIONAL
  - rel_ft
  - rel_dt_city
  - rel_dt_customer
  - rel_dt_date
  - rel_dt_order
  - rel_dt_product
  - rel_bt_ckc
  - rel_bt_customer_tag
  - rel_bt_order_product
  - rel_bt_rating
- DOCUMENT - SHATTERED
  - doc1_ft
  - doc1_dt_city
  - doc1_dt_customer
  - doc1_dt_date
  - doc1_dt_order
  - doc1_dt_product
  - doc1_bt_rating
- DOCUMENT - DENORMALIZED
  - doc2_ft
  - doc2_dt_customer
- GRAPH - FLAT
  - The graph in schema 'm3d2_graph1'
- GRAPH - SHORTCUT
  - The graph in schema 'm3d2_graph2'
- M3D-R
  - doc1t4a_ft
  - rel_dt_city
  - rel_dt_date
  - doc1_dt_order
  - doc1_dt_product
  - rel_bt_customer_tag
  - rel_bt_order_product
  - rel_bt_rating
  - The graph in schema 'm3d2_graph1'
- M3D-D
  - doc1a_ft
  - rel_dt_city
  - rel_dt_date
  - doc1_dt_order
  - doc1_dt_product
  - rel_bt_customer_tag
  - The graph in schema 'm3d2_graph1'

## Workload

The queries executed for each solution are available in the ```queries``` folder.

Queries with selection predicates take the value of the predicate from a materialized view 
```v_filter_values_q_[query_id]```, containing a single column and a single record with such value.
The materialied views are included in the dump file and should be refreshed at every experimental run
to avoid caching by the DBMS. 
