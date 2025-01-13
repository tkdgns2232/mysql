insert into data_b_tb -- 마스터 테이블 
values
	(default, '111'), -- 111이라는 값에 하위로 aaa,bbb가 있다
	(default, '222'),
	(default, '333'); -- 트리거 


insert into data_a_tb
values
	(default, 'aaa' ,1),
	(default, 'bbb' ,1),
	(default, 'ccc' ,2),
	(default, 'ddd' ,3),
	(default, 'eee' ,3);
    
select
	*
from
	data_b_tb b
    left outer join data_a_tb a on(a.data_b_id = b.data_b_id);
    
delete
from
	data_b_tb
where
	data_b_value = '333';
    
insert into data_b_tb
values
	(default, '555');
    
select
	*
from
	data_c_tb;


select
	*
from
	data_d_tb;

# transaction

select @@autocommit; -- 변수명앞에 @@가 있으면 전역변수
set autocommit = 0;

insert into data_b_tb
values(default, '777');

commit;

select * from data_b_tb;

start transaction;

insert into data_b_tb
values(default, '4040');

update
	data_b_tb
set
	data_b_value = '999'
where
	data_b_value = '777';
    
rollback;    -- 되돌리기

savepoint aa;  -- 지정한 부분까지 세이브 할 수 있다
rollback to aa;
commit; -- commit은 마지막에 한다.

SELECT * FROM study.data_b_tb;
call sp_loop_insert_data_b(10);

select @@log_bin_trust_function_creators;
set global log_bin_trust_function_creators = 1;

select study.add(10,20);

select
	*
from
	course_registering_information_tb
where
	instructor_id = study.find_instructor_id_by_name('김준일');
