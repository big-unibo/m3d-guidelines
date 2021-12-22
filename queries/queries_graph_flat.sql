set graph_path = m3d2_graph1;

-- GRA1 a1
drop view if exists q_graph1_q1;
create or replace view q_graph1_q1 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date) 
RETURN d.month as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a1s1
    drop view if exists q_graph1_q2;
    create or replace view q_graph1_q2 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date)
    WHERE d.quarter = (select v from v_filter_values_q_q2)
    RETURN d.month as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 a2
drop view if exists q_graph1_q3;
create or replace view q_graph1_q3 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order) 
RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 a3
drop view if exists q_graph1_q4;
create or replace view q_graph1_q4 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer) 
RETURN c.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a3s1
    drop view if exists q_graph1_q5;
    create or replace view q_graph1_q5 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer) 
    WHERE c.browserused = (select v from v_filter_values_q_q5)
    RETURN c.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a3s2
    drop view if exists q_graph1_q6;
    create or replace view q_graph1_q6 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_TO_CITY]->(ci:dt_city) 
    WHERE ci.city = (select v from v_filter_values_q_q6)
    RETURN c.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a4
    drop view if exists q_graph1_a4;
    create or replace view q_graph1_a4 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date)
    RETURN d.date as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a4s1
    drop view if exists q_graph1_q8;
    create or replace view q_graph1_q8 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date)
    WHERE d.quarter = (select v from v_filter_values_q_q8)
    RETURN d.date as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a4s2
    drop view if exists q_graph1_q9;
    create or replace view q_graph1_q9 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date)
    WHERE d.month = (select v from v_filter_values_q_q9)
    RETURN d.date as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 a4s3
    drop view if exists q_graph1_q10;
    create or replace view q_graph1_q10 as
    with tv as (select v from v_filter_values_q_q10)
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date)
    WHERE d.date >= (select to_char(tv.v,'YYYY-MM-DD') from tv) and d.date <= (select to_char(tv.v+2,'YYYY-MM-DD') from tv)
    RETURN d.date as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 c1
drop view if exists q_graph1_q11;
create or replace view q_graph1_q11 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer) 
RETURN c1.customer as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 c2
drop view if exists q_graph1_q12;
create or replace view q_graph1_q12 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer) 
RETURN c1.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s1
    drop view if exists q_graph1_q13;
    create or replace view q_graph1_q13 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer) 
    WHERE c1.browserUsed = (select v from v_filter_values_q_q13)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s2
    drop view if exists q_graph1_q14;
    create or replace view q_graph1_q14 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer) 
    WHERE c2.browserUsed = (select v from v_filter_values_q_q14)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s3
    drop view if exists q_graph1_q15;
    create or replace view q_graph1_q15 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
    MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
    WHERE c3.browserUsed = (select v from v_filter_values_q_q15)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s4
    drop view if exists q_graph1_q16;
    create or replace view q_graph1_q16 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer) 
    WHERE c1.customer = (select v from v_filter_values_q_q16)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s5
    drop view if exists q_graph1_q17;
    create or replace view q_graph1_q17 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer) 
    WHERE c2.customer = (select v from v_filter_values_q_q17)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s6
    drop view if exists q_graph1_q18;
    create or replace view q_graph1_q18 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
    MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
    WHERE c3.customer = (select v from v_filter_values_q_q18)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s7
    drop view if exists q_graph1_q19;
    create or replace view q_graph1_q19 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer) 
    WHERE c1.customer = (select c3 from v_filter_values_q_q19) and c.browserused = (select b2 from v_filter_values_q_q19)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s8
    drop view if exists q_graph1_q20;
    create or replace view q_graph1_q20 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer) 
    WHERE c2.customer = (select c3 from v_filter_values_q_q20) and c1.browserused = (select b2 from v_filter_values_q_q20) and c.browserused = (select b1 from v_filter_values_q_q20)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 c3s9
    drop view if exists q_graph1_q21;
    create or replace view q_graph1_q21 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
    MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
    WHERE c3.customer = (select c3 from v_filter_values_q_q21) and c2.browserused = (select b2 from v_filter_values_q_q21) and c1.browserused = (select b1 from v_filter_values_q_q21) and c.browserused = (select b from v_filter_values_q_q21)
    RETURN o.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 c4
drop view if exists q_graph1_q24;
create or replace view q_graph1_q24 as
with tv as (select v1,v2 from v_filter_values_q_q24)
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH p=allShortestPaths((a:dt_customer {id: (select v1 from tv)})-[:KNOWS*]->(b:dt_customer {id: (select v2 from tv)}))
UNWIND nodes(p) AS c
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c)
RETURN c.id as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 d1
drop view if exists q_graph1_q25;
create or replace view q_graph1_q25 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:dt_date) 
RETURN d.year as gb, sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 f1
drop view if exists q_graph1_q27;
create or replace view q_graph1_q27 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer) 
RETURN c.browserused as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 g1
drop view if exists q_graph1_q28;
create or replace view q_graph1_q28 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(p:dt_product) 
RETURN p.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 g1s1
    drop view if exists q_graph1_q29;
    create or replace view q_graph1_q29 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(p:dt_product)
    WHERE p.industry=(select v from v_filter_values_q_q29)
    RETURN p.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA1 g1s2
    drop view if exists q_graph1_q30;
    create or replace view q_graph1_q30 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(p:dt_product)-[:ROLLUP_TO_CITY]->(ci:dt_city)
    WHERE ci.city=(select v from v_filter_values_q_q30)
    RETURN p.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 g2
drop view if exists q_graph1_q31;
create or replace view q_graph1_q31 as
select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
MATCH (f:ft)-[r:ROLLUP_TO_PRODUCT]->(p:dt_product) 
RETURN p.vendor as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

    -- GRA1 g2s1
    drop view if exists q_graph1_q32;
    create or replace view q_graph1_q32 as
    select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
    MATCH (f:ft)-[r:ROLLUP_TO_PRODUCT]->(p:dt_product), (f)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)
    WHERE p.industry=(select v from v_filter_values_q_q32)
    RETURN c.gender as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

    -- GRA1 g2s2
    drop view if exists q_graph1_q33;
    create or replace view q_graph1_q33 as
    select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
    MATCH (f:ft)-[r:ROLLUP_TO_PRODUCT]->(p:dt_product)-[:ROLLUP_PRODUCT_TO_CITY]->(ci:dt_city), (f)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)
    WHERE ci.city=(select v from v_filter_values_q_q33)
    RETURN c.gender as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

-- GRA1 g3
drop view if exists q_graph1_q34;
create or replace view q_graph1_q34 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_TO_TAG]->(t:dt_tag) 
RETURN t.tag as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 h1
drop view if exists q_graph1_q36;
create or replace view q_graph1_q36 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_TO_CITY]->(ci:dt_city) 
RETURN ci.city as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 h2
drop view if exists q_graph1_q37;
create or replace view q_graph1_q37 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_TO_CITY]->(ci:dt_city) 
RETURN ci.country as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 i1
drop view if exists q_graph1_q38;
create or replace view q_graph1_q38 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_CUSTOMER_TO_RATING]->(r:bt_rating),
    (r)<-[:ROLLUP_PRODUCT_TO_RATING]-(p:dt_product)<-[:ROLLUP_TO_PRODUCT]-(f)
RETURN r.rating as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 cg1
drop view if exists q_graph1_q22;
create or replace view q_graph1_q22 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:ROLLUP_TO_TAG]->(t:dt_tag) 
RETURN t.tag as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 ch1
drop view if exists q_graph1_q23;
create or replace view q_graph1_q23 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:ROLLUP_TO_CITY]->(ci:dt_city)  
RETURN ci.city as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 eh1
drop view if exists q_graph1_q26;
create or replace view q_graph1_q26 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_ORDER]->(o:dt_order)-[:ROLLUP_TO_CUSTOMER]->(c:dt_customer)-[:ROLLUP_TO_CITY]->(ci:dt_city)  
RETURN ci.state as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA1 gh1
drop view if exists q_graph1_q35;
create or replace view q_graph1_q35 as
select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
MATCH (f:ft)-[r:ROLLUP_TO_PRODUCT]->(p:dt_product)-[:ROLLUP_TO_CITY]->(ci:dt_city) 
RETURN ci.city as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;