-- Challenge 1 -> 5 oldest users
-- select username, created_at from users order by created_at desc limit 5;

-- Challenge 2 -> What day do most registrations happen
-- select 
-- 	dayname(created_at) as day, 
-- 	count(*) as total 
-- from users 
-- group by day
-- order by total desc; 

-- Challenge 3 -> Find Inactive users (never posted a photo)
-- select 
-- 	username
-- from users u 
-- left join photos p 
-- 	on u.id = p.user_id
-- where p.id is null;

-- Challenge 4 -> Most likes on a single photo
-- select 
-- 	username,
-- 	image_url,
-- 	count(l.photo_id) as likes
-- from photos p 
-- left join likes l 
-- 	on p.id = l.photo_id 
-- join users u 
-- 	on u.id = p.user_id 
-- group by p.id 
-- order by likes desc
-- limit 1;

-- Challenge 5 -> Average number of posts per user
-- select 
-- 	(select count(*) from photos) / (select count(*) from users) as avg

-- Challenge 6 -> Find the 5 most commonly used hashtags
-- select 
-- 	t.tag_name,
-- 	count(*) as total
-- from photo_tags pt
-- join tags t 
-- 	on pt.tag_id = t.id 
-- group by t.id
-- order by total desc 
-- limit 5;

-- Challenge 7 -> Find users(bots) that have liked every photo
-- select 
-- 	username,
-- 	COUNT(*) as num_likes
-- from users u 
-- join likes l 	
-- 	on u.id = l.user_id 
-- group by l.user_id 
-- having num_likes = (select count(*) from photos);

-- Trigger
-- DELIMITER $$
-- 	create trigger prevent_self_follows
-- 		before insert on follows for each row 
-- 			begin 
-- 					if new.follower_id = new.followee_id
-- 				then
-- 					signal sqlstate '45000'
-- 					set message_text = 'You cannot follow yourself!';
-- 				end if;
-- 			end
-- 			$$
-- DELIMITER ;

-- Trigger - for logging
-- delimiter $$
-- create trigger capture_unfollow
-- 	after delete on follows for each row 
-- 		begin
-- 			insert into unfollows
-- 			set follower_id = old.follower_id,
-- 				followee_id = old.followee_id;
-- 		end;
-- 	$$
-- delimiter ;

-- CREATE A VIEW
-- create view [view name] as 
-- select col1, col2, ...
-- from [table]
-- where [condition];
 