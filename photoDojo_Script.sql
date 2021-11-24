DROP DATABASE IF EXISTS photoDojo;
CREATE DATABASE photoDojo;
USE photoDojo; 

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

CREATE TABLE unfollows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);


-- Triggers 
-- DELIMITER $$
--  	create trigger prevent_self_follows
--  		before insert on follows for each row 
--  			begin 
--  					if new.follower_id = new.followee_id
--  				then
--  					signal sqlstate '45000'
--  					set message_text = 'You cannot follow yourself!';
--  				end if;
--  			end
--  			$$
-- DELIMITER ;

DELIMITER $$
create trigger capture_unfollows
	after delete on follows for each row 	
	begin
		insert into unfollows(follower_id, followee_id)
		values(old.follower_id, old.followee_id);
	end;
$$
DELIMITER ;


-- INDEXES
CREATE INDEX IX_PhotosUserID
ON photos(user_id);

CREATE INDEX IX_Username
ON users(username);


CREATE INDEX IX_CommentsPhotoUserID
ON comments(photo_id, user_id);

CREATE INDEX IX_LikesPhotoUserID
ON likes(photo_id, user_id);

CREATE INDEX IX_followsID
ON follows(follower_id, followee_id);

CREATE INDEX IX_tagID
ON photo_tags(photo_id, tag_id);


-- VIEWS
CREATE VIEW LikedPhotos AS
select username, image_url, count(l.photo_id) as likes
from photos p 
left join likes l 
	on p.id = l.photo_id 
join users u 
	on u.id = p.user_id 
group by p.id 
order by likes desc;

CREATE VIEW InactiveUsers AS
select username
from users u 
left join photos p 
	on u.id = p.user_id
where p.id is null;

CREATE VIEW CommonHashTags AS
select t.tag_name, count(*) as total
from photo_tags pt
join tags t 
	on pt.tag_id = t.id 
group by t.id
order by total desc 
limit 10;


