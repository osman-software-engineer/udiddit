INSERT INTO users (username)
SELECT DISTINCT username
FROM bad_comments
UNION
SELECT DISTINCT username
FROM bad_posts;

INSERT INTO topics (name, user_id)
SELECT DISTINCT ON (topic) bp.topic, u.id
FROM users AS u
         JOIN bad_posts AS bp
              ON u.username = bp.username
GROUP BY 1, 2;

INSERT INTO posts (title, url, content, topic_id, user_id)
SELECT LEFT(bp.title, 100), bp.url, bp.text_content, t.id, u.id
FROM bad_posts AS bp
         JOIN users AS u
              ON bp.username = u.username
         JOIN topics AS t
              ON bp.topic = t.name
ORDER BY u.id;

INSERT INTO comments(content, post_id, user_id)
SELECT bc.text_content, p.id, u.id
FROM bad_comments AS bc
         JOIN bad_posts AS bp
              ON bc.post_id = bp.id
         JOIN users AS u
              ON bc.username = u.username
         JOIN posts AS p
              ON bp.title = p.title
ORDER BY u.id;

WITH t1 AS
         (SELECT title AS title, regexp_split_to_table(upvotes, ',') AS username
          FROM bad_posts)
INSERT
INTO votes (vote, user_id, post_id)
SELECT 1, u.id, p.id
FROM t1 AS up_vote_list
         JOIN users AS u
              ON u.username = up_vote_list.username
         JOIN posts AS p
              ON up_vote_list.title = p.title
ORDER BY u.id;

WITH t2 AS
         (SELECT title AS title, regexp_split_to_table(downvotes, ',') AS username
          FROM bad_posts)
INSERT
INTO votes (vote, user_id, post_id)
SELECT -1, u.id, p.id
FROM t2 AS down_vote_list
         JOIN users AS u
              ON u.username = down_vote_list.username
         JOIN posts AS p
              ON down_vote_list.title = p.title
ORDER BY u.id;

