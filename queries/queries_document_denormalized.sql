-- DOC2 a1
drop view if exists q_doc2_q1;
create or replace view q_doc2_q1 as
select ft.info->'date'->>'month'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft
group by ft.info->'date'->>'month';

	-- DOC2 a1s1
	drop view if exists q_doc2_q2;
	create or replace view q_doc2_q2 as
	select ft.info->'date'->>'month'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft
	where ft.info->'date'->>'quarter' = (select v from v_filter_values_q_q2)
	group by ft.info->'date'->>'month';

-- DOC2 a2
drop view if exists q_doc2_q3;
create or replace view q_doc2_q3 as
select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft
group by ft.info->'order'->>'shipmentmode';

-- DOC2 a3
drop view if exists q_doc2_q4;
create or replace view q_doc2_q4 as
select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c
where (ft.info->'order'->>'idcustomer')::int = c.id
group by c.info->>'gender';

	-- DOC2 a3s1
	drop view if exists q_doc2_q5;
	create or replace view q_doc2_q5 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c
	where (ft.info->'order'->>'idcustomer')::int = c.id
		and c.info->>'browserused' = (select v from v_filter_values_q_q5)
	group by c.info->>'gender';

	-- DOC2 a3s2
	drop view if exists q_doc2_q6;
	create or replace view q_doc2_q6 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c
	where (ft.info->'order'->>'idcustomer')::int = c.id
		and c.info->>'city' = (select v from v_filter_values_q_q6)
	group by c.info->>'gender';

	-- DOC2 a4
	drop view if exists q_doc2_a4;
	create or replace view q_doc2_a4 as
	select ft.info->'date'->>'date'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft
	group by ft.info->'date'->>'date';

	-- DOC2 a4s1
	drop view if exists q_doc2_q8;
	create or replace view q_doc2_q8 as
	select ft.info->'date'->>'date'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft
	where ft.info->'date'->>'quarter' = (select v from v_filter_values_q_q8)
	group by ft.info->'date'->>'date';

	-- DOC2 a4s2
	drop view if exists q_doc2_q9;
	create or replace view q_doc2_q9 as
	select ft.info->'date'->>'date'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft
	where (ft.info->'date'->>'month')::int = (select v from v_filter_values_q_q9)
	group by ft.info->'date'->>'date';

	-- DOC2 a4s3
	drop view if exists q_doc2_q10;
	create or replace view q_doc2_q10 as
	with tv as (select v from v_filter_values_q_q10)
	select ft.info->'date'->>'date'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft
	where ft.info->'date'->>'date' between (select to_char(tv.v,'YYYY-MM-DD') from tv) and (select to_char(tv.v+2,'YYYY-MM-DD') from tv)
	group by ft.info->'date'->>'date';

-- DOC2 c1
drop view if exists q_doc2_q11;
create or replace view q_doc2_q11 as
select c1.info->>'customer' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
     	else '[]' end
	) as ckc
where ft.info->'order'->>'idcustomer'::text = ckc.value::text
group by c1.info->>'customer';

-- DOC2 c2
drop view if exists q_doc2_q12;
create or replace view q_doc2_q12 as
select c1.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
     	else '[]' end
	) as ckc
where ft.info->'order'->>'idcustomer'::text = ckc.value::text
group by c1.info->>'gender';

	-- DOC2 c3s1
	drop view if exists q_doc2_q13;
	create or replace view q_doc2_q13 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text
		and c1.info->>'browserused' = (select v from v_filter_values_q_q13)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s2
	drop view if exists q_doc2_q14;
	create or replace view q_doc2_q14 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1, doc2_dt_customer c2,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int
		and c2.info->>'browserused' = (select v from v_filter_values_q_q14)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s3
	drop view if exists q_doc2_q15;
	create or replace view q_doc2_q15 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1, doc2_dt_customer c2, doc2_dt_customer c3,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'browserused' = (select v from v_filter_values_q_q15)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s4
	drop view if exists q_doc2_q16;
	create or replace view q_doc2_q16 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text
		and c1.info->>'customer' = (select v from v_filter_values_q_q16)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s5
	drop view if exists q_doc2_q17;
	create or replace view q_doc2_q17 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1, doc2_dt_customer c2,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int
		and c2.info->>'customer' = (select v from v_filter_values_q_q17)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s6
	drop view if exists q_doc2_q18;
	create or replace view q_doc2_q18 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c1, doc2_dt_customer c2, doc2_dt_customer c3,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'customer' = (select v from v_filter_values_q_q18)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s7
	drop view if exists q_doc2_q19;
	create or replace view q_doc2_q19 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c, doc2_dt_customer c1,
		jsonb_array_elements(
			case jsonb_typeof(c1.info->'knownCustomers') 
			when 'array' then c1.info->'knownCustomers' 
			else '[]' end
		) as ckc
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text
		and c.id = ckc.value::text::int
		and c1.info->>'customer' = (select c3 from v_filter_values_q_q19) and c.info->>'browserused' = (select b2 from v_filter_values_q_q19)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s8
	drop view if exists q_doc2_q20;
	create or replace view q_doc2_q20 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c, doc2_dt_customer c1, doc2_dt_customer c2,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int
		and c.id = ckc.value::text::int and c1.id = ckc1.value::text::int
		and c2.info->>'customer' = (select c3 from v_filter_values_q_q20) and c1.info->>'browserused' = (select b2 from v_filter_values_q_q20) and c.info->>'browserused' = (select b1 from v_filter_values_q_q20)
	group by ft.info->'order'->>'shipmentmode';

	-- DOC2 c3s9
	drop view if exists q_doc2_q21;
	create or replace view q_doc2_q21 as
	select ft.info->'order'->>'shipmentmode' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, doc2_dt_customer c, doc2_dt_customer c1, doc2_dt_customer c2, doc2_dt_customer c3,
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
	where ft.info->'order'->>'idcustomer'::text = ckc.value::text and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c.id = ckc.value::text::int and c1.id = ckc1.value::text::int and c2.id = ckc2.value::text::int
		and c3.info->>'customer' = (select c3 from v_filter_values_q_q21) and c2.info->>'browserused' = (select b2 from v_filter_values_q_q21) and c1.info->>'browserused' = (select b1 from v_filter_values_q_q21) and c.info->>'browserused' = (select b from v_filter_values_q_q21)
	group by ft.info->'order'->>'shipmentmode';

-- DOC2 d1
drop view if exists q_doc2_q25;
create or replace view q_doc2_q25 as
select ft.info->'date'->>'year'::text gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft
group by ft.info->'date'->>'year';

-- DOC2 f1
drop view if exists q_doc2_q27;
create or replace view q_doc2_q27 as
select c.info->>'browserused' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c
where (ft.info->'order'->>'idcustomer')::int = c.id
group by c.info->>'browserused';

-- DOC2 g1
drop view if exists q_doc2_q28;
create or replace view q_doc2_q28 as
select btop->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
group by btop->>'productasin';

	-- DOC2 g1s1
	drop view if exists q_doc2_q29;
	create or replace view q_doc2_q29 as
	select btop->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
	where btop->>'industry'=(select v from v_filter_values_q_q29)
	group by btop->>'productasin';

	-- DOC2 g1s2
	drop view if exists q_doc2_q30;
	create or replace view q_doc2_q30 as
	select btop->>'productasin' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
	from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
	where btop->>'city'=(select v from v_filter_values_q_q30)
	group by btop->>'productasin';

-- DOC2 g2
drop view if exists q_doc2_q31;
create or replace view q_doc2_q31 as
select btop->>'vendor' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
group by btop->>'vendor';

	-- DOC2 g2s1
	drop view if exists q_doc2_q32;
	create or replace view q_doc2_q32 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc2_dt_customer c
	where (ft.info->'order'->>'idcustomer')::int = c.id
		and btop->>'industry'=(select v from v_filter_values_q_q32)
	group by c.info->>'gender';

	-- DOC2 g2s2
	drop view if exists q_doc2_q33;
	create or replace view q_doc2_q33 as
	select c.info->>'gender' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
	from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop, doc2_dt_customer c
	where (ft.info->'order'->>'idcustomer')::int = c.id
		and btop->>'city'=(select v from v_filter_values_q_q33)
	group by c.info->>'gender';

-- DOC2 g3
drop view if exists q_doc2_q34;
create or replace view q_doc2_q34 as
select ct->>'tag' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c, 
	jsonb_array_elements(
		case jsonb_typeof(c.info->'tags') 
        when 'array' then c.info->'tags' 
        else '[]' end
	) as ct
where (ft.info->'order'->>'idcustomer')::int = c.id
group by ct->>'tag';

-- DOC2 h1
drop view if exists q_doc2_q36;
create or replace view q_doc2_q36 as
select c.info->>'city' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c
where (ft.info->'order'->>'idcustomer')::int = c.id
group by c.info->>'city';

-- DOC2 h2
drop view if exists q_doc2_q37;
create or replace view q_doc2_q37 as
select c.info->>'country' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c
where (ft.info->'order'->>'idcustomer')::int = c.id
group by c.info->>'country';

-- DOC2 i1
drop view if exists q_doc2_q38;
create or replace view q_doc2_q38 as
select btop->>'rating' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
group by btop->>'rating';

-- DOC2 cg1
drop view if exists q_doc2_q22;
create or replace view q_doc2_q22 as
select ct->>'tag' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c1,
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
where ft.info->'order'->>'idcustomer'::text = ckc.value::text
group by ct->>'tag';

-- DOC2 ch1
drop view if exists q_doc2_q23;
create or replace view q_doc2_q23 as
select c1.info->>'city' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c1,
	jsonb_array_elements(
		case jsonb_typeof(c1.info->'knownCustomers') 
        when 'array' then c1.info->'knownCustomers' 
     	else '[]' end
	) as ckc
where ft.info->'order'->>'idcustomer'::text = ckc.value::text
group by c1.info->>'city';

-- DOC2 eh1
drop view if exists q_doc2_q26;
create or replace view q_doc2_q26 as
select c.info->>'state' gb , round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft, doc2_dt_customer c
where (ft.info->'order'->>'idcustomer')::int = c.id
group by c.info->>'state';

-- DOC2 gh1
drop view if exists q_doc2_q35;
create or replace view q_doc2_q35 as
select btop->>'city' gb , round(sum((ft.info->>'totalprice')::numeric*(btop->>'weight')::numeric),5) a,  round(sum((ft.info->>'discount')::numeric*(btop->>'weight')::numeric)/sum((btop->>'weight')::numeric),5) b, count(*) c
from doc2_ft ft, jsonb_array_elements(ft.info->'products') as btop
group by btop->>'city';

-- -- DOC2 c4
drop view if exists q_doc2_q24;
create or replace view q_doc2_q24 as
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
select ft.info->'order'->>'idcustomer'::text gb, round(sum((ft.info->>'totalprice')::numeric),5) a,  round(avg((ft.info->>'discount')::numeric),5) b, count(*) c
from doc2_ft ft
where ft.info->'order'->>'idcustomer'::text::int in (
        select distinct m1.idcustomerparent
        from minpath m1, minpath m2, minpath m3 
        where m1.idcustomerchild = 132991 and m1.idcustomerparent = m2.idcustomerchild	and m2.idcustomerparent = 140644
            and m3.idcustomerchild = 132991	and m3.idcustomerparent = 140644 and m3.dist=m1.dist+m2.dist
    )
group by ft.info->'order'->>'idcustomer'::text;