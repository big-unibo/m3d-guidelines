drop view if exists q_rel_q1;
create or replace view q_rel_q1 as
select month::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_date d
where ft.iddate = d.id
group by month;

    drop view if exists q_rel_q2;
    create or replace view q_rel_q2 as
    select month::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.quarter = (select v from v_filter_values_q_q2)
    group by month;

drop view if exists q_rel_q3;
create or replace view q_rel_q3 as
select shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o
where ft.idorder = o.idorder
group by shipmentMode;

drop view if exists q_rel_q4;
create or replace view q_rel_q4 as
select gender gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_dt_customer c
where ft.idorder = o.idorder and o.idcustomer = c.id
group by gender;

    drop view if exists q_rel_q5;
    create or replace view q_rel_q5 as
    select gender gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_dt_customer c
    where ft.idorder = o.idorder and o.idcustomer = c.id 
        and c.browserUsed = (select v from v_filter_values_q_q5)
    group by gender;

    drop view if exists q_rel_q6;
    create or replace view q_rel_q6 as
    select gender gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_dt_customer c, rel_dt_city ci
    where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id 
        and ci.city = (select v from v_filter_values_q_q6)
    group by gender;

    drop view if exists q_rel_a4;
    create or replace view q_rel_a4 as
    select date::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_date d
    where ft.iddate = d.id
    group by date;

    drop view if exists q_rel_q8;
    create or replace view q_rel_q8 as
    select date::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.quarter = (select v from v_filter_values_q_q8)
    group by date;

    drop view if exists q_rel_q9;
    create or replace view q_rel_q9 as
    select date::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.month = (select v from v_filter_values_q_q9)
    group by date;

    drop view if exists q_rel_q10;
    create or replace view q_rel_q10 as
    with tv as (select v from v_filter_values_q_q10)
    select date::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_date d
    where ft.iddate = d.id 
        and d.date between (select tv.v from tv) and (select tv.v+2 from tv)
    group by date;

drop view if exists q_rel_q11;
create or replace view q_rel_q11 as
select c1.customer gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c1
where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id
group by c1.customer;

drop view if exists q_rel_q12;
create or replace view q_rel_q12 as
select c1.gender gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c1
where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id
group by c1.gender;

    drop view if exists q_rel_q13;
    create or replace view q_rel_q13 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c1
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id 
        and c1.browserUsed = (select v from v_filter_values_q_q13)
    group by o.shipmentMode;

    drop view if exists q_rel_q14;
    create or replace view q_rel_q14 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_dt_customer c2
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = c2.id 
        and c2.browserUsed = (select v from v_filter_values_q_q14)
    group by o.shipmentMode;

    drop view if exists q_rel_q15;
    create or replace view q_rel_q15 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_bt_ckc ckc2, rel_dt_customer c3
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = ckc2.idcustomerchild and ckc2.idcustomerparent = c3.id 
        and c3.browserUsed = (select v from v_filter_values_q_q15)
    group by o.shipmentMode;

    drop view if exists q_rel_q16;
    create or replace view q_rel_q16 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c1
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id 
        and c1.customer = (select v from v_filter_values_q_q16)
    group by o.shipmentMode;

    drop view if exists q_rel_q17;
    create or replace view q_rel_q17 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_dt_customer c2
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = c2.id 
        and c2.customer = (select v from v_filter_values_q_q17)
    group by o.shipmentMode;

    drop view if exists q_rel_q18;
    create or replace view q_rel_q18 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_bt_ckc ckc2, rel_dt_customer c3
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = ckc2.idcustomerchild and ckc2.idcustomerparent = c3.id 
        and c3.customer = (select v from v_filter_values_q_q18)
    group by o.shipmentMode;

    drop view if exists q_rel_q19;
    create or replace view q_rel_q19 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c, rel_dt_customer c1
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id 
        and ckc.idcustomerchild = c.id
        and c1.customer = (select c3 from v_filter_values_q_q19) and c.browserUsed=(select b2 from v_filter_values_q_q19)
    group by o.shipmentMode;

    drop view if exists q_rel_q20;
    create or replace view q_rel_q20 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_dt_customer c, rel_dt_customer c1, rel_dt_customer c2
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = c2.id 
        and ckc.idcustomerchild = c.id and ckc1.idcustomerchild = c1.id
        and c2.customer = (select c3 from v_filter_values_q_q20) and c1.browserUsed=(select b2 from v_filter_values_q_q20) and c.browserUsed=(select b1 from v_filter_values_q_q20)
    group by o.shipmentMode;

    drop view if exists q_rel_q21;
    create or replace view q_rel_q21 as
    select o.shipmentMode gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_ckc ckc1, rel_bt_ckc ckc2, rel_dt_customer c, rel_dt_customer c1, rel_dt_customer c2, rel_dt_customer c3
    where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ckc1.idcustomerchild and ckc1.idcustomerparent = ckc2.idcustomerchild and ckc2.idcustomerparent = c3.id 
        and ckc.idcustomerchild = c.id and ckc1.idcustomerchild = c1.id and ckc2.idcustomerchild = c2.id
        and c3.customer = (select c3 from v_filter_values_q_q21) and c2.browserUsed=(select b2 from v_filter_values_q_q21) and c1.browserUsed=(select b1 from v_filter_values_q_q21) and c.browserUsed=(select b from v_filter_values_q_q21)
    group by o.shipmentMode;

drop view if exists q_rel_q24;
create or replace view q_rel_q24 as
with recursive t(idcustomerchild, idcustomerparent, dist) as (
	select idcustomerchild, idcustomerparent, 1 
	from rel_bt_ckc
	union
	select t.idcustomerchild, g.idcustomerparent, dist+1 
	from rel_bt_ckc g, t
	where t.idcustomerparent = g.idcustomerchild
), minpath(idcustomerchild, idcustomerparent, dist) as (
	select idcustomerchild, idcustomerparent, min(dist) as dist 
	from t 
	group by idcustomerchild, idcustomerparent
)
select o.idcustomer::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o
where ft.idorder = o.idorder and o.idcustomer in (
	select distinct m1.idcustomerparent
	from minpath m1, minpath m2, minpath m3 
	where m1.idcustomerchild = (select v1 from v_filter_values_q_q24) and m1.idcustomerparent = m2.idcustomerchild and m2.idcustomerparent = (select v2 from v_filter_values_q_q24)
		and m3.idcustomerchild = (select v1 from v_filter_values_q_q24)	and m3.idcustomerparent = (select v2 from v_filter_values_q_q24) and m3.dist=m1.dist+m2.dist
)
group by o.idcustomer;

drop view if exists q_rel_q25;
create or replace view q_rel_q25 as
select year::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_date d
where ft.iddate = d.id
group by year;

drop view if exists q_rel_q27;
create or replace view q_rel_q27 as
select browserUsed gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_dt_customer c
where ft.idorder = o.idorder and o.idcustomer = c.id
group by browserUsed;

drop view if exists q_rel_q28;
create or replace view q_rel_q28 as
select productASIN gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_bt_order_product btop, rel_dt_product p
where ft.idorder = btop.idorder and btop.idproduct = p.id
group by productASIN;

    drop view if exists q_rel_q29;
    create or replace view q_rel_q29 as
    select productASIN gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_bt_order_product btop, rel_dt_product p
    where ft.idorder = btop.idorder and btop.idproduct = p.id
        and p.industry=(select v from v_filter_values_q_q29)
    group by productASIN;

    drop view if exists q_rel_q30;
    create or replace view q_rel_q30 as
    select productASIN gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
    from rel_ft ft, rel_bt_order_product btop, rel_dt_product p, rel_dt_city ci
    where ft.idorder = btop.idorder and btop.idproduct = p.id and p.idcity = ci.id
        and ci.city=(select v from v_filter_values_q_q30)
    group by productASIN;

drop view if exists q_rel_q31;
create or replace view q_rel_q31 as
select vendor gb , round(sum(totalprice*btop.weight)::numeric,5) a, round((sum(discount*btop.weight)/sum(btop.weight))::numeric,5) b, count(*) c
from rel_ft ft, rel_bt_order_product btop, rel_dt_product p
where ft.idorder = btop.idorder and btop.idproduct = p.id
group by vendor;

    drop view if exists q_rel_q32;
    create or replace view q_rel_q32 as
    select gender gb , round(sum(totalprice*btop.weight)::numeric,5) a, round((sum(discount*btop.weight)/sum(btop.weight))::numeric,5) b, count(*) c
    from rel_ft ft, rel_bt_order_product btop, rel_dt_product p, rel_dt_order o, rel_dt_customer c
    where ft.idorder = btop.idorder and btop.idproduct = p.id and ft.idorder = o.idorder and o.idcustomer = c.id
        and p.industry=(select v from v_filter_values_q_q32)
    group by gender;

    drop view if exists q_rel_q33;
    create or replace view q_rel_q33 as
    select gender gb , round(sum(totalprice*btop.weight)::numeric,5) a, round((sum(discount*btop.weight)/sum(btop.weight))::numeric,5) b, count(*) c
    from rel_ft ft, rel_bt_order_product btop, rel_dt_product p, rel_dt_city ci, rel_dt_order o, rel_dt_customer c
    where ft.idorder = btop.idorder and btop.idproduct = p.id and p.idcity = ci.id and ft.idorder = o.idorder and o.idcustomer = c.id
        and ci.city=(select v from v_filter_values_q_q33)
    group by gender;

drop view if exists q_rel_q34;
create or replace view q_rel_q34 as
select tag gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_bt_customer_tag ct
where ft.idorder = o.idorder and o.idcustomer = ct.idcustomer
group by tag;

drop view if exists q_rel_q36;
create or replace view q_rel_q36 as
select city gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_dt_customer c, rel_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by city;

drop view if exists q_rel_q37;
create or replace view q_rel_q37 as
select country gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_dt_customer c, rel_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by country;

drop view if exists q_rel_q38;
create or replace view q_rel_q38 as
select rating::text gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_bt_order_product btop, rel_bt_rating r, rel_dt_order o
where ft.idorder = btop.idorder and btop.idproduct = r.idproduct and ft.idorder = o.idorder and o.idcustomer = r.idcustomer
group by rating;

drop view if exists q_rel_q22;
create or replace view q_rel_q22 as
select tag gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_bt_customer_tag ct
where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = ct.idcustomer
group by tag;

drop view if exists q_rel_q23;
create or replace view q_rel_q23 as
select city gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_bt_ckc ckc, rel_dt_customer c1, rel_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = ckc.idcustomerchild and ckc.idcustomerparent = c1.id and c1.idcity = ci.id
group by city;

drop view if exists q_rel_q26;
create or replace view q_rel_q26 as
select state gb , round(sum(totalprice)::numeric,5) a, round(avg(discount)::numeric,5) b, count(*) c
from rel_ft ft, rel_dt_order o, rel_dt_customer c, rel_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by state;

drop view if exists q_rel_q35;
create or replace view q_rel_q35 as
select city gb , round(sum(totalprice*btop.weight)::numeric,5) a, round((sum(discount*btop.weight)/sum(btop.weight))::numeric,5) b, count(*) c
from rel_ft ft, rel_bt_order_product btop, rel_dt_product p, rel_dt_city ci
where ft.idorder = btop.idorder and btop.idproduct = p.id and p.idcity = ci.id
group by city;