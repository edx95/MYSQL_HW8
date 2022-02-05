

use vk;
-- 3 задание: Определить кто больше поставил лайков (всего) - мужчины или женщины? 

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;

SELECT 
	gender, 
	COUNT(l.id) AS total 
FROM likes AS l
	JOIN profiles AS p
		ON l.user_id = p.user_id
GROUP BY p.gender
ORDER BY total DESC
LIMIT 1; 
	



-- 4.Вывести для каждого пользователя количество созданных сообщений, постов, загруженных медиафайлов и поставленных лайков.

SELECT 
  users.first_name,
  users.last_name,
  COUNT(DISTINCT posts.id) AS 'Posts count',
  COUNT(DISTINCT messages.id) AS 'Message count',
  COUNT(DISTINCT media.id) AS 'Message count', 
  COUNT(DISTINCT likes.id) AS 'Likes count' 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN posts
      ON users.id = posts.user_id 
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id;

 
SELECT 
  users.id,
  CONCAT(users.first_name, ' ', users.last_name) AS user,
  posts_count AS 'Posts count',
  messages_count AS 'Message count',
  media_count AS 'Media count',
  likes_count AS 'Likes count'
  FROM users
    LEFT JOIN (
      SELECT user_id, COUNT(*) AS posts_count
      FROM posts GROUP BY user_id
    ) posts_counts
      ON posts_counts.user_id = users.id
    LEFT JOIN (
      SELECT from_user_id, COUNT(*) AS messages_count
      FROM messages GROUP BY from_user_id
    ) messages_counts
      ON messages_counts.from_user_id = users.id
    LEFT JOIN (
      SELECT user_id, COUNT(*) AS media_count
      FROM media GROUP BY user_id
    ) media_counts
      ON media_counts.user_id = users.id
    LEFT JOIN (
      SELECT user_id, COUNT(*) AS likes_count
      FROM likes GROUP BY user_id
    ) likes_counts 
      ON likes_counts.user_id = users.id;


SELECT 
  id,
  CONCAT(first_name, ' ', last_name) AS user,
  (SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS 'Posts count',
  (SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS 'Message count',
  (SELECT COUNT(*) FROM media WHERE media.user_id = users.id) AS 'Media count',
  (SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) AS 'Likes count'
 FROM users;