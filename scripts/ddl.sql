CREATE TABLE IF NOT EXISTS "users"
(
    "id"         BIGSERIAL PRIMARY KEY,
    "username"   VARCHAR(25) UNIQUE NOT NULL CHECK (Length(Trim("username")) > 0),
    "last_login" TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "find_users_by_last_login" ON "users" ("username",
"last_login");


CREATE TABLE IF NOT EXISTS "topics"
(
    "id"          BIGSERIAL PRIMARY KEY,
    "name"        VARCHAR(30) UNIQUE NOT NULL CHECK (Length(Trim("name")) > 0),
    "description" VARCHAR(500),
    "user_id"     BIGINT REFERENCES "users" ("id")

);
CREATE INDEX IF NOT EXISTS "find_topics_by_user_id" ON "topics" ("user_id");


CREATE TABLE IF NOT EXISTS "posts"
(
    "id"       BIGSERIAL PRIMARY KEY,
    "title"    VARCHAR(100) NOT NULL CHECK (Length(Trim("title")) > 0),
    "url"      TEXT,
    "content"  TEXT,
    "topic_id" BIGINT REFERENCES "topics" ("id") ON DELETE CASCADE,
    "user_id"  BIGINT REFERENCES "users" ("id") ON DELETE SET NULL,
    CONSTRAINT either_url_or_content_should_be_empty
        CHECK (("url" IS NOT NULL AND content IS NULL)
            OR (content IS NOT NULL AND "url" IS NULL)),
    CONSTRAINT "check_title_length_is_not_zero" CHECK (Length(Trim("title")) > 0)
);

CREATE INDEX IF NOT EXISTS "find_posts_by_topic_id" ON "posts"("topic_id");
CREATE INDEX IF NOT EXISTS "find_posts_by_user_id" ON "posts"("user_id");

CREATE TABLE IF NOT EXISTS "comments"
(
    "id"                BIGSERIAL PRIMARY KEY,
    "content"           TEXT   NOT NULL CHECK (Length(Trim("content")) > 0 ),
    "user_id"           BIGINT  REFERENCES "users" ("id") ON DELETE SET NULL,
    "topic_id"          BIGINT REFERENCES "topics" ("id") ON DELETE CASCADE,
    "post_id"           BIGINT  REFERENCES "posts" ("id") ON DELETE CASCADE,
    "parent_comment_id" BIGINT  DEFAULT NULL  REFERENCES "comments" ("id") ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS "find_comments_by_post_id" ON "comments"("post_id");
CREATE INDEX IF NOT EXISTS "find_comments_by_user_id" ON "comments"("user_id");


CREATE TABLE IF NOT EXISTS "votes"
(
    "id"      BIGSERIAL PRIMARY KEY,
    "vote"    SMALLINT NOT NULL CHECK (vote = 1 or vote = -1),
    "user_id" BIGINT   REFERENCES "users" ("id") ON DELETE SET NULL,
    "post_id" BIGINT   REFERENCES "posts" ("id") ON DELETE CASCADE

);

CREATE INDEX IF NOT EXISTS "find_votes_by_post_id" ON "votes"("post_id");
CREATE INDEX IF NOT EXISTS "find_votes_by_user_id" ON "votes"("user_id");