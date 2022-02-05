

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
	
