-- Display the earliest user to join in a specific format
select DATE_FORMAT(created_at, '%M %D %Y') as 'earliest_date' from users order by created_at limit 1;
-- OR
select DATE_FORMAT(min(created_at), '%M %D %Y') as 'earliest_date' from users;
 
-- Display that users email address
select email, DATE_FORMAT(created_at, '%M %D %Y') as 'earliest_date' from users order by created_at limit 1;
-- OR
select * from users where created_at = (select min(created_at) from users);

-- Display the number of joins by month 
 select DATE_FORMAT(created_at, '%M') as month, count(*) as 'Count' from users group by month;
-- OR 
select monthname(created_at) as month, count(*) as 'Count' from users group by month order by Count desc; 
 
-- Display number of yahoo users
select count(*) as 'yahoo_users' from users where email like '%yahoo.com';

-- Display the number of users from each mail host
select  
case
	when email like '%yahoo.com' then 'yahoo'
	when email like '%gmail.com' then 'google'
	when email like '%hotmail.com' then 'hotmail'
	else 'other'
end as provider,
count(*) as 'total_users'
from users
group by provider
order by total_users desc;