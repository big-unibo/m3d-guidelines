-- DOC1 a1
drop view if exists q_doc1_q1;
create or replace view q_doc1_q1 as
select d.info->>'month' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_date d
where ft.iddate = d.id
group by d.info->>'month';

	-- DOC1 a1s1
	drop view if exists q_doc1_q2;
	create or replace view q_doc1_q2 as
	select d.info->>'month' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_date d
	where ft.iddate = d.id
		and d.info->>'quarter' = (select v from v_filter_values_q_q2)
	group by d.info->>'month';

-- DOC1 a2
drop view if exists q_doc1_q3;
create or replace view q_doc1_q3 as
select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o
where ft.idorder = o.idorder
group by o.info->>'shipmentmode';

-- DOC1 a3
drop view if exists q_doc1_q4;
create or replace view q_doc1_q4 as
select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c
where ft.idorder = o.idorder and o.idcustomer = c.id
group by c.info->>'gender';

	-- DOC1 a3s1
	drop view if exists q_doc1_q5;
	create or replace view q_doc1_q5 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c
	where ft.idorder = o.idorder and o.idcustomer = c.id
        and c.info->>'browserused' = (select v from v_filter_values_q_q5)
	group by c.info->>'gender';

	-- DOC1 a3s2
	drop view if exists q_doc1_q6;
	create or replace view q_doc1_q6 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_city ci
	where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
        and ci.info->>'city' = (select v from v_filter_values_q_q6)
	group by c.info->>'gender';

	-- DOC1 a4
	drop view if exists q_doc1_a4;
	create or replace view q_doc1_a4 as
	select d.info->>'date' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_date d
	where ft.iddate = d.id
	group by d.info->>'date';

	-- DOC1 a4s1
	drop view if exists q_doc1_q8;
	create or replace view q_doc1_q8 as
	select d.info->>'date' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_date d
	where ft.iddate = d.id
        and d.info->>'quarter' = (select v from v_filter_values_q_q8)
	group by d.info->>'date';

	-- DOC1 a4s2
	drop view if exists q_doc1_q9;
	create or replace view q_doc1_q9 as
	select d.info->>'date' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_date d
	where ft.iddate = d.id
        and (d.info->>'month')::int = (select v from v_filter_values_q_q9)
	group by d.info->>'date';

	-- DOC1 a4s3
	drop view if exists q_doc1_q10;
	create or replace view q_doc1_q10 as
	with tv as (select v from v_filter_values_q_q10)
	select d.info->>'date' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_date d
	where ft.iddate = d.id
        and d.info->>'date' between (select to_char(tv.v,'YYYY-MM-DD') from tv) and (select to_char(tv.v+2,'YYYY-MM-DD') from tv)
	group by d.info->>'date';

-- DOC1 c1
drop view if exists q_doc1_q11;
create or replace view q_doc1_q11 as
select c1.info->>'customer' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
     	else '[]' end
	) as ckc
where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
group by c1.info->>'customer';

-- DOC1 c2
drop view if exists q_doc1_q12;
create or replace view q_doc1_q12 as
select c1.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
        else '[]' end
	) as ckc
where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
group by c1.info->>'gender';

	-- DOC1 c3s1
	drop view if exists q_doc1_q13;
	create or replace view q_doc1_q13 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
		and c1.info->>'browserused' = (select v from v_filter_values_q_q13)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s2
	drop view if exists q_doc1_q14;
	create or replace view q_doc1_q14 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1, doc1_dt_customer c2,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int
		and c2.info->>'browserused' = (select v from v_filter_values_q_q14)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s3
	drop view if exists q_doc1_q15;
	create or replace view q_doc1_q15 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1, doc1_dt_customer c2, doc1_dt_customer c3,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1,
		jsonb_array_elements(
			case jsonb_typeof(c3.info->'knownCustomers') 
			when 'array' then c3.info->'knownCustomers' 
			else '[]' end
		) as ckc2
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'browserused' = (select v from v_filter_values_q_q15)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s4
	drop view if exists q_doc1_q16;
	create or replace view q_doc1_q16 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
		and c1.info->>'customer' = (select v from v_filter_values_q_q16)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s5
	drop view if exists q_doc1_q17;
	create or replace view q_doc1_q17 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1, doc1_dt_customer c2,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int
		and c2.info->>'customer' = (select v from v_filter_values_q_q17)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s6
	drop view if exists q_doc1_q18;
	create or replace view q_doc1_q18 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1, doc1_dt_customer c2, doc1_dt_customer c3,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1,
		jsonb_array_elements(
			case jsonb_typeof(c3.info->'knownCustomers') 
			when 'array' then c3.info->'knownCustomers' 
			else '[]' end
		) as ckc2
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'customer' = (select v from v_filter_values_q_q18)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s7
	drop view if exists q_doc1_q19;
	create or replace view q_doc1_q19 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
		and c.id = ckc.value::text::int
		and c1.info->>'customer' = (select c3 from v_filter_values_q_q19) and c.info->>'browserused' = (select b2 from v_filter_values_q_q19)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s8
	drop view if exists q_doc1_q20;
	create or replace view q_doc1_q20 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_customer c1, doc1_dt_customer c2,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int
		and c.id = ckc.value::text::int and c1.id = ckc1.value::text::int
		and c2.info->>'customer' = (select c3 from v_filter_values_q_q20) and c1.info->>'browserused' = (select b2 from v_filter_values_q_q20) and c.info->>'browserused' = (select b1 from v_filter_values_q_q20)
	group by o.info->>'shipmentmode';

	-- DOC1 c3s9
	drop view if exists q_doc1_q21;
	create or replace view q_doc1_q21 as
	select o.info->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_customer c1, doc1_dt_customer c2, doc1_dt_customer c3,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc,
		jsonb_array_elements(
			case jsonb_typeof(c2.info->'knownCustomers') 
			when 'array' then c2.info->'knownCustomers' 
			else '[]' end
		) as ckc1,
		jsonb_array_elements(
			case jsonb_typeof(c3.info->'knownCustomers') 
			when 'array' then c3.info->'knownCustomers' 
			else '[]' end
		) as ckc2
	where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c.id = ckc.value::text::int and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'customer' = (select c3 from v_filter_values_q_q21) and c2.info->>'browserused' = (select b2 from v_filter_values_q_q21) and c1.info->>'browserused' = (select b1 from v_filter_values_q_q21) and c.info->>'browserused' = (select b from v_filter_values_q_q21)
	group by o.info->>'shipmentmode';

-- DOC1 d1
drop view if exists q_doc1_q25;
create or replace view q_doc1_q25 as
select d.info->>'year' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_date d
where ft.iddate = d.id
group by d.info->>'year';

-- DOC1 f1
drop view if exists q_doc1_q27;
create or replace view q_doc1_q27 as
select c.info->>'browserused' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c
where ft.idorder = o.idorder and o.idcustomer = c.id
group by c.info->>'browserused';

-- DOC1 g1
drop view if exists q_doc1_q28;
create or replace view q_doc1_q28 as
select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
where (btop->>'idproduct')::int = p.id
group by p.info->>'productasin';

	-- DOC1 g1s1
	drop view if exists q_doc1_q29;
	create or replace view q_doc1_q29 as
	select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
	where (btop->>'idproduct')::int = p.id
		and p.info->>'industry'=(select v from v_filter_values_q_q29)
	group by p.info->>'productasin';

	-- DOC1 g1s2
	drop view if exists q_doc1_q30;
	create or replace view q_doc1_q30 as
	select p.info->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, doc1_dt_city ci
	where (btop->>'idproduct')::int = p.id and p.idcity = ci.id
		and ci.info->>'city'=(select v from v_filter_values_q_q30)
	group by p.info->>'productasin';

-- DOC1 g2
drop view if exists q_doc1_q31;
create or replace view q_doc1_q31 as
select p.info->>'vendor' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p
where (btop->>'idproduct')::int = p.id
group by p.info->>'vendor';

	-- DOC1 g2s1
	drop view if exists q_doc1_q32;
	create or replace view q_doc1_q32 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, doc1_dt_order o, doc1_dt_customer c
	where (btop->>'idproduct')::int = p.id and ft.idorder = o.idorder and o.idcustomer = c.id
		and p.info->>'industry'=(select v from v_filter_values_q_q32)
	group by c.info->>'gender';

	-- DOC1 g2s2
	drop view if exists q_doc1_q33;
	create or replace view q_doc1_q33 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, doc1_dt_city ci, doc1_dt_order o, doc1_dt_customer c
	where (btop->>'idproduct')::int = p.id and p.idcity = ci.id and ft.idorder = o.idorder and o.idcustomer = c.id
		and ci.info->>'city'=(select v from v_filter_values_q_q33)
	group by c.info->>'gender';

-- DOC1 g3
drop view if exists q_doc1_q34;
create or replace view q_doc1_q34 as
select ct->>'tag' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, 
	jsonb_array_elements(
		case jsonb_typeof(c.info->'tags') 
        when 'array' then c.info->'tags' 
        else '[]' end
	) as ct
where ft.idorder = o.idorder and o.idcustomer = c.id
group by ct->>'tag';

-- DOC1 h1
drop view if exists q_doc1_q36;
create or replace view q_doc1_q36 as
select ci.info->>'city' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by ci.info->>'city';

-- DOC1 h2
drop view if exists q_doc1_q37;
create or replace view q_doc1_q37 as
select ci.info->>'country' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by ci.info->>'country';

-- DOC1 i1
drop view if exists q_doc1_q38;
create or replace view q_doc1_q38 as
select r.info->>'rating' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_bt_rating r, doc1_dt_order o
where (btop->>'idproduct')::int = r.idproduct and ft.idorder = o.idorder and o.idcustomer = r.idcustomer
group by r.info->>'rating';

-- DOC1 cg1
drop view if exists q_doc1_q22;
create or replace view q_doc1_q22 as
select ct->>'tag' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
        else '[]' end
	) as ckc, 
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'tags') 
        when 'array' then c1.info->'tags' 
        else '[]' end
	) as ct
where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int
group by ct->>'tag';

-- DOC1 ch1
drop view if exists q_doc1_q23;
create or replace view q_doc1_q23 as
select ci.info->>'city' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
        else '[]' end
	) as ckc, 
	doc1_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = ckc.value::text::int and c1.idcity = ci.id
group by ci.info->>'city';

-- DOC1 eh1
drop view if exists q_doc1_q26;
create or replace view q_doc1_q26 as
select ci.info->>'state' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o, doc1_dt_customer c, doc1_dt_city ci
where ft.idorder = o.idorder and o.idcustomer = c.id and c.idcity = ci.id
group by ci.info->>'state';

-- DOC1 gh1
drop view if exists q_doc1_q35;
create or replace view q_doc1_q35 as
select ci.info->>'city' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc1_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc1_dt_product p, doc1_dt_city ci
where (btop->>'idproduct')::int = p.id and p.idcity = ci.id
group by ci.info->>'city';

-- -- DOC1 c4
drop view if exists q_doc1_q24;
create or replace view q_doc1_q24 as
with recursive t(idcustomerchild, idcustomerparent, dist) as (
	select c.id idcustomerchild, ckc.value::text::int idcustomerparent, 1 
	from doc1_dt_customer c,
		jsonb_array_elements(
			case jsonb_typeof(c.info->'knownCustomers') 
			when 'array' then c.info->'knownCustomers' 
			else '[]' end
		) as ckc
	union
	select t.idcustomerchild, ckc1.value::text::int idcustomerparent, dist+1 
	from t, doc1_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc1
	where t.idcustomerparent = c1.id
), minpath(idcustomerchild, idcustomerparent, dist) as (
	select idcustomerchild, idcustomerparent, min(dist) as dist 
	from t 
	group by idcustomerchild, idcustomerparent
)
select o.idcustomer gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc1_ft ft, doc1_dt_order o
where ft.idorder = o.idorder 
	and o.idcustomer in (
        select distinct m1.idcustomerparent
        from minpath m1, minpath m2, minpath m3 
        where m1.idcustomerchild = 132991 and m1.idcustomerparent = m2.idcustomerchild	and m2.idcustomerparent = 140644
            and m3.idcustomerchild = 132991	and m3.idcustomerparent = 140644 and m3.dist=m1.dist+m2.dist
    )
group by o.idcustomer;