


drop trigger trig3

use schronisko;


create trigger trig3
on pies
after update
as
	update pies
	set klatka_id=null
	where data_wydania is not null
go

update pies set data_wydania='2004-01-01' where pies_id = 3
select * from pies