set graph_path = m3d2_graph2;

-- GRA2 a1
drop view if exists q_graph2_q1;
create or replace view q_graph2_q1 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_MONTH]->(d:month)
RETURN d.month as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a1s1
    drop view if exists q_graph2_q2;
    create or replace view q_graph2_q2 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_FT_TO_MONTH]->(d:month), (f)-[:ROLLUP_FT_TO_QUARTER]->(q:quarter)
    WHERE q.quarter = (select v from v_filter_values_q_a1s1)
    RETURN d.month as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 a2
drop view if exists q_graph2_q3;
create or replace view q_graph2_q3 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(d:shipmentMode) 
RETURN d.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 a3
drop view if exists q_graph2_q4;
create or replace view q_graph2_q4 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_GENDER]->(d:gender) 
RETURN d.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a3s1
    drop view if exists q_graph2_q5;
    create or replace view q_graph2_q5 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:ROLLUP_TO_GENDER]->(d:gender), (c)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE b.browserused = (select v from v_filter_values_q_a3s1)
    RETURN d.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a3s2
    drop view if exists q_graph2_q6;
    create or replace view q_graph2_q6 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:ROLLUP_TO_GENDER]->(d:gender), (c)-[:ROLLUP_CUSTOMER_TO_CITY]->(ci:city)
    WHERE ci.city = (select v from v_filter_values_q_a3s2)
    RETURN d.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a4
    drop view if exists q_graph2_a4;
    create or replace view q_graph2_a4 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:date)
    RETURN d.date as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a4s1
    drop view if exists q_graph2_q8;
    create or replace view q_graph2_q8 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:date)-[:ROLLUP_TO_MONTHYEAR]->(:monthyear)-[:ROLLUP_TO_QUARTER]->(q:quarter)
    WHERE q.quarter = (select v from v_filter_values_q_a4s1)
    RETURN d.date as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a4s2
    drop view if exists q_graph2_q9;
    create or replace view q_graph2_q9 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:date)-[:ROLLUP_TO_MONTH]->(m:month)
    WHERE m.month = (select v from v_filter_values_q_a4s2)
    RETURN d.date as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 a4s3
    drop view if exists q_graph2_q10;
    create or replace view q_graph2_q10 as
    with tv as (select v from v_filter_values_q_a4s3)
	select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_DATE]->(d:date)
    WHERE d.date >= (select to_char(tv.v,'YYYY-MM-DD') from tv) and d.date <= (select to_char(tv.v+2,'YYYY-MM-DD') from tv)
    RETURN d.date as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 c1
drop view if exists q_graph2_q11;
create or replace view q_graph2_q11 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(d:customer) 
RETURN d.customer as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 c2
drop view if exists q_graph2_q12;
create or replace view q_graph2_q12 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(:customer)-[:ROLLUP_TO_GENDER]->(d:gender) 
RETURN d.gender as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s1
    drop view if exists q_graph2_q13;
    create or replace view q_graph2_q13 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(:customer)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE b.browserused = (select v from v_filter_values_q_c3s1)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s2
    drop view if exists q_graph2_q14;
    create or replace view q_graph2_q14 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(:customer)-[:KNOWS]->(:customer)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE b.browserused = (select v from v_filter_values_q_c3s2)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s3
    drop view if exists q_graph2_q15;
    create or replace view q_graph2_q15 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)-[:KNOWS]->(c2:customer)
    MATCH (c2)-[:KNOWS]->(c3:customer)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE b.browserused = (select v from v_filter_values_q_c3s3)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s4
    drop view if exists q_graph2_q16;
    create or replace view q_graph2_q16 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)
    WHERE c1.customer = (select v from v_filter_values_q_c3s4)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s5
    drop view if exists q_graph2_q17;
    create or replace view q_graph2_q17 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)-[:KNOWS]->(c2:customer)
    WHERE c2.customer = (select v from v_filter_values_q_c3s5)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s6
    drop view if exists q_graph2_q18;
    create or replace view q_graph2_q18 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)-[:KNOWS]->(c2:customer)
    MATCH (c2)-[:KNOWS]->(c3:customer)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE c3.customer = (select v from v_filter_values_q_c3s6)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s7
    drop view if exists q_graph2_q19;
    create or replace view q_graph2_q19 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer),
        (c)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused)
    WHERE c1.customer = (select c3 from v_filter_values_q_c3s7) and b.browserused = (select b2 from v_filter_values_q_c3s7)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s8
    drop view if exists q_graph2_q20;
    create or replace view q_graph2_q20 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f)-[:ROLLUP_FT_TO_SHIPMENTMODE]->(s:shipmentMode), (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)-[:KNOWS]->(c2:customer),
        (c)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused),
        (c1)-[:ROLLUP_TO_BROWSERUSED]->(b1:browserused)
    WHERE c2.customer = (select c3 from v_filter_values_q_c3s8) and b1.browserused = (select b2 from v_filter_values_q_c3s8) and b.browserused = (select b1 from v_filter_values_q_c3s8)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 c3s9
    drop view if exists q_graph2_q21;
    create or replace view q_graph2_q21 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (s:shipmentMode)<-[:ROLLUP_FT_TO_SHIPMENTMODE]-(f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c:customer)-[:KNOWS]->(c1:customer)-[:KNOWS]->(c2:customer),
        (c)-[:ROLLUP_TO_BROWSERUSED]->(b:browserused),
        (c1)-[:ROLLUP_TO_BROWSERUSED]->(b1:browserused),
        (c2)-[:ROLLUP_TO_BROWSERUSED]->(b2:browserused)
    MATCH (c2)-[:KNOWS]->(c3:customer)
    WHERE c3.customer = (select c3 from v_filter_values_q_c3s9) and b2.browserused = (select b2 from v_filter_values_q_c3s9) 
        and b1.browserused = (select b1 from v_filter_values_q_c3s9) and b.browserused = (select b from v_filter_values_q_c3s9)
    RETURN s.shipmentMode as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 c4
drop view if exists q_graph2_q24;
create or replace view q_graph2_q24 as
with tv as (select v1,v2 from v_filter_values_q_q24)
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH p=allShortestPaths((a:customer {id: (select v1 from tv)})-[:KNOWS*]->(b:customer {id: (select v2 from tv)}))
UNWIND nodes(p) AS c
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(c)
RETURN c.id as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 d1
drop view if exists q_graph2_q25;
create or replace view q_graph2_q25 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_YEAR]->(d:year) 
RETURN d.year as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 f1
drop view if exists q_graph2_q27;
create or replace view q_graph2_q27 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_BROWSERUSED]->(d:browserused) 
RETURN d.browserused as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 g1
drop view if exists q_graph2_q28;
create or replace view q_graph2_q28 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(d:product) 
RETURN d.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 g1s1
    drop view if exists q_graph2_q29;
    create or replace view q_graph2_q29 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(d:product)-[:ROLLUP_TO_VENDOR]->(:vendor)-[:ROLLUP_TO_INDUSTRY]->(i:industry)
    WHERE i.industry=(select v from v_filter_values_q_g1s1)
    RETURN d.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

    -- GRA2 g1s2
    drop view if exists q_graph2_q30;
    create or replace view q_graph2_q30 as
    select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
    MATCH (f:ft)-[:ROLLUP_TO_PRODUCT]->(d:product)-[:ROLLUP_TO_VENDOR]->(:vendor)-[:ROLLUP_VENDOR_TO_CITY]->(ci:city)
    WHERE ci.city=(select v from v_filter_values_q_g1s2)
    RETURN d.productASIN as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 g2
drop view if exists q_graph2_q31;
create or replace view q_graph2_q31 as
select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
MATCH (f:ft)-[r:ROLLUP_FT_TO_VENDOR]->(d:vendor) 
RETURN d.vendor as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

    -- GRA2 g2s1
    drop view if exists q_graph2_q32;
    create or replace view q_graph2_q32 as
    select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
    MATCH (f:ft)-[r:ROLLUP_FT_TO_INDUSTRY]->(i:industry), (f)-[:ROLLUP_FT_TO_GENDER]->(d:gender)
    WHERE i.industry=(select v from v_filter_values_q_g2s1)
    RETURN d.gender as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

    -- GRA2 g2s2
    drop view if exists q_graph2_q33;
    create or replace view q_graph2_q33 as
    select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
    MATCH (f:ft)-[r:ROLLUP_FT_TO_PRODUCT_CITY]->(ci:city), (f)-[:ROLLUP_FT_TO_GENDER]->(d:gender)
    WHERE ci.city=(select v from v_filter_values_q_g2s2)
    RETURN d.gender as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;

-- GRA2 g3
drop view if exists q_graph2_q34;
create or replace view q_graph2_q34 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_TAG]->(d:tag) 
RETURN d.tag as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 h1
drop view if exists q_graph2_q36;
create or replace view q_graph2_q36 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER_CITY]->(d:city) 
RETURN d.city as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 h2
drop view if exists q_graph2_q37;
create or replace view q_graph2_q37 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER_COUNTRY]->(d:country) 
RETURN d.country as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 i1
drop view if exists q_graph2_q38;
create or replace view q_graph2_q38 as
select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
MATCH (f:ft)-[r:ROLLUP_FT_TO_RATING]->(d:rating) 
RETURN d.rating as gb , sum(f.totalprice*r.n) as a, sum(f.discount*r.n) as b1, sum(r.n) as b2, count(*) as c ) v;

-- GRA2 cg1
drop view if exists q_graph2_q22;
create or replace view q_graph2_q22 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(:customer)-[:ROLLUP_TO_TAG]->(d:tag)
RETURN d.tag as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 ch1
drop view if exists q_graph2_q23;
create or replace view q_graph2_q23 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER]->(:customer)-[:KNOWS]->(:customer)-[:ROLLUP_CUSTOMER_TO_CITY]->(d:city) 
RETURN d.city as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 eh1
drop view if exists q_graph2_q26;
create or replace view q_graph2_q26 as
select gb::text, round(a::text::numeric,5) a, round(b::text::numeric,5) b, c::text::int from (
MATCH (f:ft)-[:ROLLUP_FT_TO_CUSTOMER_STATE2]->(d:state) 
RETURN d.state as gb , sum(f.totalprice) as a, avg(f.discount) as b, count(*) as c ) v;

-- GRA2 gh1
drop view if exists q_graph2_q35;
create or replace view q_graph2_q35 as
select gb::text, round(a::text::numeric,5) a, round((b1::text::numeric/b2::text::numeric),5) b, c::text::int from (
MATCH (f:ft)-[r:ROLLUP_FT_TO_PRODUCT_CITY]->(d:city) 
RETURN d.city as gb , sum(f.totalprice*r.weight) as a, sum(f.discount*r.weight) as b1, sum(r.weight) as b2, count(*) as c ) v;