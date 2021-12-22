create table doc1t4_ft as (
    select iddate, idorder, jsonb_build_object(
        'vat', info->>'vat', 
        'discount', info->>'discount', 
        'netprice', info->>'netprice', 
        'totalprice', info->>'totalprice'
    ) info
    from doc1_ft
);
alter table doc1t4_ft add primary key (idorder);
create index doc1t4_ft_ix_date on doc1t4_ft using btree (iddate);
create index doc1t4_ft_ix_order on doc1t4_ft using btree (idorder);

---------------------
---------------------

set graph_path = m3d2_graph1;

drop view if exists q_target4_q1;
create or replace view q_target4_q1 as
select month::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_date d
where ft.iddate = d.id
group by month;

    drop view if exists q_target4_q2;
    create or replace view q_target4_q2 as
    select month::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.quarter = (select v from v_filter_values_q_q2)
    group by month;

drop view if exists q_target4_q3;
create or replace view q_target4_q3 as
select shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o
where ft.idorder = o.idorder
group by shipmentMode;

drop view if exists q_target4_q4;
create or replace view q_target4_q4 as
select gender gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, 
    (MATCH (c:dt_customer) 
    RETURN c.id, c.gender) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by gender;

    drop view if exists q_target4_q5;
    create or replace view q_target4_q5 as
    select gender gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o, 
        (MATCH (c:dt_customer) 
		WHERE c.browserused = (select v from v_filter_values_q_q5)
        RETURN c.id, c.gender) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by gender;

    drop view if exists q_target4_q6;
    create or replace view q_target4_q6 as
    select gender gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o, rel_dt_city ci,
        (MATCH (c:dt_customer) 
        RETURN c.id, c.gender, c.idcity) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
		and ci.city = (select v from v_filter_values_q_q6)
    group by gender;

    drop view if exists q_target4_a4;
    create or replace view q_target4_a4 as
    select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_date d
    where ft.iddate = d.id
    group by date;

    drop view if exists q_target4_q8;
    create or replace view q_target4_q8 as
    select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.quarter = (select v from v_filter_values_q_q8)
    group by date;

    drop view if exists q_target4_q9;
    create or replace view q_target4_q9 as
    select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.month = (select v from v_filter_values_q_q9)
    group by date;

    drop view if exists q_target4_q10;
    create or replace view q_target4_q10 as
    with tv as (select v from v_filter_values_q_q10)
    select date::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.date between (select tv.v from tv) and (select tv.v+2 from tv)
    group by date;

drop view if exists q_target4_q11;
create or replace view q_target4_q11 as
select customerParent::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.customer as customerParent) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by customerParent;

drop view if exists q_target4_q12;
create or replace view q_target4_q12 as
select genderParent::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.gender as genderParent) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by genderParent;

    drop view if exists q_target4_q13;
    create or replace view q_target4_q13 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.browserUsed = (select v from v_filter_values_q_q13)
        RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q14;
    create or replace view q_target4_q14 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.browserUsed = (select v from v_filter_values_q_q14)
        RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q15;
    create or replace view q_target4_q15 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
        MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		WHERE c3.browserUsed = (select v from v_filter_values_q_q15)
        RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q16;
    create or replace view q_target4_q16 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.customer = (select v from v_filter_values_q_q16)
		RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q17;
    create or replace view q_target4_q17 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.customer = (select v from v_filter_values_q_q17)
		RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q18;
    create or replace view q_target4_q18 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
        MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		WHERE c3.customer = (select v from v_filter_values_q_q18)
		RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q19;
    create or replace view q_target4_q19 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
		WHERE c1.customer = (select c3 from v_filter_values_q_q19) and c.browserused = (select b2 from v_filter_values_q_q19)
		RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q20;
    create or replace view q_target4_q20 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
		WHERE c2.customer = (select c3 from v_filter_values_q_q20) and c1.browserused = (select b2 from v_filter_values_q_q20) and c.browserused = (select b1 from v_filter_values_q_q20)
		RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

    drop view if exists q_target4_q21;
    create or replace view q_target4_q21 as
    select o.shipmentMode gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_dt_order o,
        (MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)-[:KNOWS]->(c2:dt_customer)
        MATCH (c2)-[:KNOWS]->(c3:dt_customer) 
		WHERE c3.customer = (select c3 from v_filter_values_q_q21) and c2.browserused = (select b2 from v_filter_values_q_q21) and c1.browserused = (select b1 from v_filter_values_q_q21) and c.browserused = (select b from v_filter_values_q_q21)
    	RETURN c.id) c
    where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
    group by o.shipmentMode;

drop view if exists q_target4_q25;
create or replace view q_target4_q25 as
select year::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_date d
where ft.iddate = d.id
group by year;

drop view if exists q_target4_q27;
create or replace view q_target4_q27 as
select browserused::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, 
    (MATCH (c:dt_customer) 
    RETURN c.id, c.browserused) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by browserused;

drop view if exists q_target4_q28;
create or replace view q_target4_q28 as
select p.info->>'productasin'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p
where ft.idorder = btop.idorder and btop.idproduct = p.id
group by p.info->>'productasin';

    drop view if exists q_target4_q29;
    create or replace view q_target4_q29 as
    select p.info->>'productasin'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p
    where ft.idorder = btop.idorder and btop.idproduct = p.id
        and p.info->>'industry'=(select v from v_filter_values_q_q29)
    group by p.info->>'productasin';

    drop view if exists q_target4_q30;
    create or replace view q_target4_q30 as
    select p.info->>'productasin'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p, rel_dt_city ci
    where ft.idorder = btop.idorder and btop.idproduct = p.id and (p.info->>'idcity'::text)::int = ci.id
        and ci.city=(select v from v_filter_values_q_q30)
    group by p.info->>'productasin';

drop view if exists q_target4_q31;
create or replace view q_target4_q31 as
select p.info->>'vendor'::text gb , round(sum((ft.info->>'totalprice')::numeric*btop.weight::numeric),5) a, round(sum((ft.info->>'discount')::numeric*btop.weight::numeric)/sum(btop.weight::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p
where ft.idorder = btop.idorder and btop.idproduct = p.id
group by p.info->>'vendor';

    drop view if exists q_target4_q32;
    create or replace view q_target4_q32 as
    select gender gb , round(sum((ft.info->>'totalprice')::numeric*btop.weight::numeric),5) a, round(sum((ft.info->>'discount')::numeric*btop.weight::numeric)/sum(btop.weight::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p, rel_dt_order o,
		(MATCH (c:dt_customer) 
		RETURN c.id, c.gender) c
    where ft.idorder = btop.idorder and btop.idproduct = p.id and ft.idorder = o.idorder and o.idcustomer = c.id::text::int
        and p.info->>'industry'=(select v from v_filter_values_q_q32)
    group by gender;

    drop view if exists q_target4_q33;
    create or replace view q_target4_q33 as
    select gender gb , round(sum((ft.info->>'totalprice')::numeric*btop.weight::numeric),5) a, round(sum((ft.info->>'discount')::numeric*btop.weight::numeric)/sum(btop.weight::numeric),5) b, count(*) c
    from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p, rel_dt_city ci, rel_dt_order o,
		(MATCH (c:dt_customer) 
		RETURN c.id, c.gender) c
    where ft.idorder = btop.idorder and btop.idproduct = p.id and p.idcity = ci.id and ft.idorder = o.idorder and o.idcustomer = c.id::text::int
        and ci.city=(select v from v_filter_values_q_q33)
    group by gender;

drop view if exists q_target4_q34;
create or replace view q_target4_q34 as
select tag gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_bt_customer_tag ct
where ft.idorder = o.idorder and o.idcustomer = ct.idcustomer
group by tag;

drop view if exists q_target4_q36;
create or replace view q_target4_q36 as
select city gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer) 
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by city;

drop view if exists q_target4_q37;
create or replace view q_target4_q37 as
select country gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer) 
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by country;

drop view if exists q_target4_q38;
create or replace view q_target4_q38 as
select rating::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_bt_order_product btop, rel_bt_rating r, rel_dt_order o
where ft.idorder = btop.idorder and btop.idproduct = r.idproduct and ft.idorder = o.idorder and o.idcustomer = r.idcustomer
group by rating;

drop view if exists q_target4_q22;
create or replace view q_target4_q22 as
select tag gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_bt_customer_tag ct,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.id as parentid) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.parentid::text::int = ct.idcustomer
group by tag;

drop view if exists q_target4_q23;
create or replace view q_target4_q23 as
select city gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer)-[:KNOWS]->(c1:dt_customer)
	RETURN c.id, c1.idcity as parentidcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.parentidcity::text::int = ci.id
group by city;

drop view if exists q_target4_q26;
create or replace view q_target4_q26 as
select state gb , round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, rel_dt_city ci,
	(MATCH (c:dt_customer)
	RETURN c.id, c.idcity) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int and c.idcity::text::int = ci.id
group by state;

drop view if exists q_target4_q35;
create or replace view q_target4_q35 as
select city gb , round(sum((ft.info->>'totalprice')::numeric*btop.weight::numeric),5) a, round(sum((ft.info->>'discount')::numeric*btop.weight::numeric)/sum(btop.weight::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_bt_order_product btop, doc1_dt_product p, rel_dt_city ci
where ft.idorder = btop.idorder and btop.idproduct = p.id and (p.info->>'idcity'::text)::int = ci.id
group by city;

drop view if exists q_target4_q24;
create or replace view q_target4_q24 as
with tv as (select v1,v2 from v_filter_values_q_q24)
select o.idcustomer, round(sum((ft.info->>'totalprice')::numeric),5) a, round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1t4_ft ft, rel_dt_order o, 
	(MATCH p=allShortestPaths((a:dt_customer {id: (select v1 from tv)})-[:KNOWS*]->(b:dt_customer {id: (select v2 from tv)}))
	UNWIND nodes(p) AS c 
	RETURN c.id ) c
where ft.idorder = o.idorder and o.idcustomer = c.id::text::int
group by o.idcustomer;