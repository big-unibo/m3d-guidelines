set graph_path = m3d2_graph1;

-- TARGET3 a1
drop view if exists q_target3_q1;
create or replace view q_target3_q1 as
select month::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, rel_dt_date d
where ft.iddate = d.id
group by month;

	-- TARGET3 a1s1
	drop view if exists q_target3_q2;
	create or replace view q_target3_q2 as
	select month::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, rel_dt_date d
	where ft.iddate = d.id 
		and d.quarter = (select v from v_filter_values_q_q2)
	group by month;

-- TARGET3 a2
drop view if exists q_target3_q3;
create or replace view q_target3_q3 as
select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o
where ft.idorder = o.idorder
group by o.info->>'shipmentmode';

-- TARGET3 a3
drop view if exists q_target3_q4;
create or replace view q_target3_q4 as
select c.gender::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o,
    (MATCH (c:dt_customer) 
    RETURN c.id, c.gender) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by c.gender;

	-- TARGET3 a3s1
	drop view if exists q_target3_q5;
	create or replace view q_target3_q5 as
	select c.gender::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer) 
		WHERE c.browserused = (select v from v_filter_values_q_q5)
		RETURN c.id, c.gender) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by c.gender;

	-- TARGET3 a3s2
	drop view if exists q_target3_q6;
	create or replace view q_target3_q6 as
	select c.gender::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o, rel_dt_city ci,
		(MATCH (c:dt_customer) 
		RETURN c.id, c.gender, c.idcity) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
		and ci.city = (select v from v_filter_values_q_q6)
	group by c.gender;

	-- TARGET3 a4
	drop view if exists q_target3_a4;
	create or replace view q_target3_a4 as
	select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, rel_dt_date d
	where ft.iddate = d.id
	group by date;

	-- TARGET3 a4s1
	drop view if exists q_target3_q8;
	create or replace view q_target3_q8 as
	select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, rel_dt_date d
	where ft.iddate = d.id
        and d.quarter = (select v from v_filter_values_q_q8)
	group by date;

	-- TARGET3 a4s2
	drop view if exists q_target3_q9;
	create or replace view q_target3_q9 as
	select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, rel_dt_date d
	where ft.iddate = d.id
        and d.month = (select v from v_filter_values_q_q9)
	group by date;

	-- TARGET3 a4s3
	drop view if exists q_target3_q10;
	create or replace view q_target3_q10 as
	with tv as (select v from v_filter_values_q_q10)
	select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, rel_dt_date d
	where ft.iddate = d.id
        and d.date between (select tv.v from tv) and (select tv.v+2 from tv)
	group by date;

-- TARGET3 c1
drop view if exists q_target3_q11;
create or replace view q_target3_q11 as
select customerParent::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.customer as customerParent) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by customerParent;

-- TARGET3 c2
drop view if exists q_target3_q12;
create or replace view q_target3_q12 as
select genderParent::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.gender as genderParent) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by genderParent;

	-- TARGET3 c3s1
	drop view if exists q_target3_q13;
	create or replace view q_target3_q13 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.browserUsed = (select v from v_filter_values_q_q13)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s2
	drop view if exists q_target3_q14;
	create or replace view q_target3_q14 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.browserUsed = (select v from v_filter_values_q_q14)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s3
	drop view if exists q_target3_q15;
	create or replace view q_target3_q15 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		WHERE c3.browserUsed = (select v from v_filter_values_q_q15)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s4
	drop view if exists q_target3_q16;
	create or replace view q_target3_q16 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.customer = (select v from v_filter_values_q_q16)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s5
	drop view if exists q_target3_q17;
	create or replace view q_target3_q17 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.customer = (select v from v_filter_values_q_q17)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s6
	drop view if exists q_target3_q18;
	create or replace view q_target3_q18 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		 MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		 WHERE c3.customer = (select v from v_filter_values_q_q18)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s7
	drop view if exists q_target3_q19;
	create or replace view q_target3_q19 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.customer = (select c3 from v_filter_values_q_q19) and c.browserused = (select b2 from v_filter_values_q_q19)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s8
	drop view if exists q_target3_q20;
	create or replace view q_target3_q20 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.customer = (select c3 from v_filter_values_q_q20) and c1.browserused = (select b2 from v_filter_values_q_q20) and c.browserused = (select b1 from v_filter_values_q_q20)
		RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

	-- TARGET3 c3s9
	drop view if exists q_target3_q21;
	create or replace view q_target3_q21 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, doc1_dt_order o,
		(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		WHERE c3.customer = (select c3 from v_filter_values_q_q21) and c2.browserused = (select b2 from v_filter_values_q_q21) and c1.browserused = (select b1 from v_filter_values_q_q21) and c.browserused = (select b from v_filter_values_q_q21)
    	RETURN c.id) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
	group by o.info->>'shipmentmode';

-- TARGET3 d1
drop view if exists q_target3_q25;
create or replace view q_target3_q25 as
select year::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, rel_dt_date d
where ft.iddate = d.id
group by year;

-- TARGET3 f1
drop view if exists q_target3_q27;
create or replace view q_target3_q27 as
select c.browserused::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, 
    (MATCH (c:dt_customer) 
    RETURN c.id, c.browserused) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by c.browserused;

-- TARGET3 g1
drop view if exists q_target3_q28;
create or replace view q_target3_q28 as
select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
where (btop->>'idproduct'::text)::int = p.id
group by p.info->>'productasin';

	-- TARGET3 g1s1
	drop view if exists q_target3_q29;
	create or replace view q_target3_q29 as
	select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
	where (btop->>'idproduct'::text)::int = p.id 
		and p.info->>'industry'=(select v from v_filter_values_q_q29)
	group by p.info->>'productasin';

	-- TARGET3 g1s2
	drop view if exists q_target3_q30;
	create or replace view q_target3_q30 as
	select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, rel_dt_city ci, doc1_dt_product p
	where (btop->>'idproduct'::text)::int = p.id and (p.info->>'idcity'::text)::int=ci.id 
		and ci.city=(select v from v_filter_values_q_q30)
	group by p.info->>'productasin';

-- TARGET3 g2
drop view if exists q_target3_q31;
create or replace view q_target3_q31 as
select p.info->>'vendor' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
where (btop->>'idproduct'::text)::int = p.id
group by p.info->>'vendor';

	-- TARGET3 g2s1
	drop view if exists q_target3_q32;
	create or replace view q_target3_q32 as
	select c.gender::text gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, doc1_dt_order o,
		(MATCH (c:dt_customer) 
		RETURN c.id, c.gender) c
	where (btop->>'idproduct'::text)::int = p.id and ft.idorder = o.idorder and o.idcustomer = c.id::text::int
		and p.info->>'industry'=(select v from v_filter_values_q_q32)
	group by c.gender;

	-- TARGET3 g2s2
	drop view if exists q_target3_q33;
	create or replace view q_target3_q33 as
	select c.gender::text gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, rel_dt_city ci, doc1_dt_product p, doc1_dt_order o,
		(MATCH (c:dt_customer) 
		RETURN c.id, c.gender) c
	where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and (btop->>'idproduct'::text)::int = p.id and (p.info->>'idcity'::text)::int=ci.id
		and ci.city=(select v from v_filter_values_q_q33)
	group by c.gender;

-- TARGET3 g3
drop view if exists q_target3_q34;
create or replace view q_target3_q34 as
select t.tag gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_bt_customer_tag t
where ft.idorder = o.idorder and o.idcustomer = t.idcustomer
group by t.tag;

-- TARGET3 h1
drop view if exists q_target3_q36;
create or replace view q_target3_q36 as
select ci.city gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer) 
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by ci.city;

-- TARGET3 h2
drop view if exists q_target3_q37;
create or replace view q_target3_q37 as
select ci.country gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer) 
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by ci.country;

-- TARGET3 i1
drop view if exists q_target3_q38;
create or replace view q_target3_q38 as
select btop->>'rating' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop
group by btop->>'rating';

-- TARGET3 cg1
drop view if exists q_target3_q22;
create or replace view q_target3_q22 as
select t.tag gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_bt_customer_tag t,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.id as parentid) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.parentid::text::int = t.idcustomer
group by t.tag;

-- TARGET3 ch1
drop view if exists q_target3_q23;
create or replace view q_target3_q23 as
select ci.city gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.idcity as parentidcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.parentidcity::text::int = ci.id
group by ci.city;

-- TARGET3 eh1
drop view if exists q_target3_q26;
create or replace view q_target3_q26 as
select ci.city gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer)
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by ci.city;

-- TARGET3 gh1
drop view if exists q_target3_q35;
create or replace view q_target3_q35 as
select ci.city gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc1a_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, rel_dt_city ci
where (btop->>'idproduct'::text)::int = p.id and (p.info->>'idcity'::text)::int = ci.id
group by ci.city;

-- -- TARGET3 c4
drop view if exists q_target3_q24;
create or replace view q_target3_q24 as
with tv as (select v1,v2 from v_filter_values_q_q24)
select o.idcustomer, round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1a_ft ft, doc1_dt_order o, 
	(MATCH p=allShortestPaths((a:dt_customer {id: (select v1 from tv)})-[:KNOWS*]->(b:dt_customer {id: (select v2 from tv)}))
	UNWIND nodes(p) AS c 
	RETURN c.id ) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by o.idcustomer;