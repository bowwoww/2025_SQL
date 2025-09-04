-- Write your own SQL object definition here, and it'll be included in your package.
create login [test] with password = '12345678';
use [Products];
create user [test] FOR login [test];
alter role [db_owner] add member [test];
-- 增加 db_owner角色的成员