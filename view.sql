# row_number(), rank()에서의 partition by

select
	row_number() over(partition by category_id order by author_id),
    book_tb.*
from
	book_tb
where
	book_name like '%가%';
    
# 흐름제어
# CASE, IF, IFUNLL, NULLIF
select
		case 
			when 5 > 5 then '5보다 큽니다' 
			when 5 > 4 then '4보다 큽니다' 
			when 5 > 3 then '3보다 큽니다' 
            else '5보다 작습니다' 
		end,   -- case로 열고 end로 닫는 형태를 사용
        if(10 > 5, '5보다 큽니다', '5보다 작습니다');  -- 참이면 앞에값 거짓이면 뒤에값
        
select
	*,
    if(trim(isbn) = '', 'O','X') as oANDX, -- trim 공백사이를 지워줌 --
    case
		when category_id < 100 then '0 ~ 99'
		when category_id < 200 then '100 ~ 199'
		when category_id < 300 then '200 ~ 299'
		else '300 ~'
   end as scope,   
   ifnull(category_id, '40') as ifnull, -- ifnull()은 값이 null이면 값을 지정할 수 있다.
   nullif(category_id, 37) as nullif -- nullif는 값이 동일하면 null로 지정할수있다 --
from
	book_tb;
    
select
	*
from
	book_tb;
update
	book_tb
set    
    category_id = null 
where
	category_id between 40 and 49;
	
update
	book_tb
set
	category_id = case 
		when category_id % 3 = 0 then 3000
        when category_id % 2 = 0 then 2000
    end;    
    
select
	*
from
	book_tb
where
    category_id is not null; -- null을 다룰때는 is를 쓴다
    
update
	book_tb
set
	category_id = ifnull(category_id, 4000);
    
# view 테이블
create view book_view as(
	select
		bt.book_id,
		bt.book_name,
		bt.isbn,
		bt.author_id,
		at.author_id as at_author_id,
		at.author_name,
		bt.publisher_id,
		pt.publisher_id  as pt_publisher_id,
		pt.publisher_name,
		bt.category_id,
		ct.category_id as ct_category_id,
		ct.category_name,
		bt.book_img_url
	from
		book_tb bt
		left outer join author_tb at on at.author_id = bt.author_id
		left outer join category_tb ct on ct.category_id = bt.category_id
		left outer join publisher_tb pt on pt.publisher_id = bt.publisher_id
);    

select
	*
from
	book_view;
    
# with 공통 테이블 표현식(common table expression, cte)
set @searchData = '비'; -- @사용--

with publisher_count_cte as (
	select
		publisher_id,
        count(publisher_id) as publisher_count
	from
		book_tb
	group by
		publisher_id
        
),
author_count_cte as (
	select
		author_id,
        count(author_id) as author_count
	from
		book_tb
	group by
		author_id
 )
 

 
select
	*
from
	book_tb bt
	left outer join publisher_count_cte pcc on(pcc.publisher_id = bt.publisher_id)
    left outer join author_count_cte acc on(acc.author_id = bt.author_id)
 where
	bt.book_name like concat('%', @searchData, '%');

select
	lpad('123', 5, 0); -- lpad(원하는값, 자릿수, 나머지부분 값)
    
select
	year(now()),
    month(now()),
    day(now()),
    hour(now()),
    minute(now()),
    second(now());
    
select
	date_format(now(), '%Y년 %m월 %d일'); -- format 문자열로 반환함


-- delete
-- from
-- 	book_tb
-- where
-- 	book_id = 1;