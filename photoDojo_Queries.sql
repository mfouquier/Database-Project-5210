-- Query 1 -> 5 oldest users
select username, created_at from users order by created_at desc limit 5;

-- Query 2 -> What day do most registrations happen
 select 
 	dayname(created_at) as day, 
 	count(*) as total 
 from users 
 group by day
 order by total desc; 

-- Query 3 -> Average number of posts per user
 select 
 	(select count(*) from photos) / (select count(*) from users) as avg

-- Query 4 -> Find users(bots) that have liked every photo
 select 
 	username,
 	COUNT(*) as num_likes
 from users u 
 join likes l 	
 	on u.id = l.user_id 
 group by l.user_id 
 having num_likes = (select count(*) from photos);

-- Query 5 -> Demonstrate CommonHashtags View
SELECT * FROM commonhashtags;

-- Query 6 -> Demonstrate InactiveUsers View
SELECT * FROM inactiveusers;

-- Query 7 -> Demonstrate LikedPhotos View
SELECT * FROM likedphotos;
-- Limit to Top 10 liked photos
SELECT * FROM likedphotos LIMIT 10;


 