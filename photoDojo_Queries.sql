--Delete a Follow to show that the unfollows table gets populated
DELETE FROM follows WHERE follower_id LIKE 50;

-- Query 1 -> 5 newest / oldest users
select username, created_at from users order by created_at limit 5;
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
 	(select count(*) from photos) / (select count(*) from users) as avg;

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

-- Query 8 -> Number of Comments on each Photo
 select image_url, COUNT(*) AS num_comments from comments
 join photos on comments.photo_id = photos.id
 group by photo_id
 order by num_comments desc;

-- Query 9 -> Number of followers per user
select username, count(*) as num_followers from users u
join follows f on u.id = f.followee_id
group by f.followee_id
order by num_followers desc;


 