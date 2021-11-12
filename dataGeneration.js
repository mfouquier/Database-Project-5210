var faker = require('c:\\Program Files\\nodejs\\node_modules\\faker');
var mysql = require('c:\\Program Files\\nodejs\\node_modules\\mysql');


var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12qwaszx!@QWASZX',
    database: 'photoDojo'
});

//************** Random number generator ****************
function randomNum(low, high) {
    return Math.floor(Math.random() * (high - low + 1) + low)
}

//************** Inserting Users data Dynamically ****************
var user_data = [];
for (var i = 0; i < 50; i++) {
    user_data.push([
        faker.internet.userName(),
        faker.date.past()
    ]);
}

var q = 'INSERT INTO users (username, created_at) VALUES ?';

connection.query(q, [user_data], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Inserting Photos data Dynamically ****************
var photo_data = [];
for (var i = 0; i < 50; i++) {
    photo_data.push([
        faker.image.image(),
        randomNum(1, 50)
    ]);
}

var a = 'INSERT INTO photos (image_url, user_id) VALUES ?';

connection.query(a, [photo_data], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Inserting Comments data Dynamically ****************
var comments_data = [];
for (var i = 0; i < 200; i++) {
    comments_data.push([
        faker.lorem.sentence(),
        randomNum(1, 50),
        randomNum(1, 50)
    ]);
}

var a = 'INSERT INTO comments (comment_text, photo_id, user_id) VALUES ?';

connection.query(a, [comments_data], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Inserting Likes data Dynamically ****************
var likes_data = [];
for (var i = 0; i < 200; i++) {
    likes_data.push([
        randomNum(1, 50),
        randomNum(1, 50)
    ]);
}
// Remove any duplicate (user_id, photo_id) Likes as it will violate Primary Key
let stringArray = likes_data.map(JSON.stringify);
let uniqueStringArray = new Set(stringArray);
let uniqueLikes = Array.from(uniqueStringArray, JSON.parse);

var a = 'INSERT INTO likes (photo_id, user_id) VALUES ?';

connection.query(a, [uniqueLikes], function (error, results) {
    if (error) throw error;
    console.log(results);
})


//************** Inserting Follows data Dynamically ****************
var follows_data = [];
for (var i = 0; i < 100; i++) {
    follows_data.push([
        randomNum(1, 50),
        randomNum(1, 50)
    ]);
}
// Remove any duplicate (follower_id, followee_id) Follows as it will violate Primary Key
let followStringArray = follows_data.map(JSON.stringify);
let uniqueFollowStringArray = new Set(followStringArray);
let uniqueFollows = Array.from(uniqueFollowStringArray, JSON.parse);

var a = 'INSERT INTO follows (follower_id, followee_id) VALUES ?';

connection.query(a, [uniqueFollows], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Inserting Tag data ****************
tags = [['sunset'], ['photography'], ['sunrise'], ['landscape'], ['food'], ['foodie'], ['delicious'], ['beauty'], ['stunning'], ['dreamy'], ['lol'], ['happy'], ['fun'], ['style'], ['hair'], ['fashion'], ['party'], ['concert'], ['drunk'], ['beach'], ['smile'], ['mountains'], ['yolo'], ['cats'], ['dogs']];

var a = 'INSERT INTO tags (tag_name) VALUES ?';

connection.query(a, [tags], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Inserting Photo Tags data Dynamically ****************
var photoTag_data = [];
for (var i = 0; i < 100; i++) {
    photoTag_data.push([
        randomNum(1, 50),
        randomNum(1, 25)
    ]);
}
// Remove any duplicate (follower_id, followee_id) Follows as it will violate Primary Key
let photoTagStringArray = photoTag_data.map(JSON.stringify);
let uniquePhotoTagStringArray = new Set(photoTagStringArray);
let uniquePhotoTag = Array.from(uniquePhotoTagStringArray, JSON.parse);

var a = 'INSERT INTO photo_tags (photo_id, tag_id) VALUES ?';

connection.query(a, [uniquePhotoTag], function (error, results) {
    if (error) throw error;
    console.log(results);
})

//************** Create a Bot that likes all photos ****************
var q = 'insert into users (username) values ("Botty_McBotterson")';
connection.query(q, function (error, results, fields) {
    if (error) throw error;
})

var likes_data = [];
for (var i = 0; i < 50; i++) {
    likes_data.push([
        i + 1,
        51
    ]);
}

var a = 'INSERT INTO likes (photo_id, user_id) VALUES ?';

connection.query(a, [likes_data], function (error, results) {
    if (error) throw error;
    console.log(results);
})

connection.end();