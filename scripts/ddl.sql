CREATE TABLE IF NOT EXISTS "users"
(
    "id"         BIGSERIAL PRIMARY KEY,
    "username"   VARCHAR(25) UNIQUE NOT NULL,
    "last_login" TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "topics"
(
    "id"          BIGSERIAL PRIMARY KEY,
    "name"        VARCHAR(30) UNIQUE NOT NULL,
    "description" VARCHAR(500),
    "user_id"     BIGINT             NOT NULL REFERENCES "users" ("id")
);
CREATE TABLE IF NOT EXISTS "posts"
(
    "id"       BIGSERIAL PRIMARY KEY,
    "title"    VARCHAR(100) NOT NULL,
    "url"      TEXT,
    "content"  TEXT,
    CONSTRAINT either_url_or_content
        CHECK (("url" IS NOT NULL AND content IS NULL)
            OR (content IS NOT NULL AND "url" IS NULL)),
    "topic_id" BIGINT       NOT NULL REFERENCES "topics" ("id") ON DELETE CASCADE,
    "user_id"  BIGINT       NOT NULL REFERENCES "users" ("id") ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS "comments"
(
    "id"                BIGSERIAL PRIMARY KEY,
    "content"           TEXT   NOT NULL,
    "post_id"           BIGINT NOT NULL REFERENCES "posts" ("id") ON DELETE CASCADE,
    "user_id"           BIGINT NOT NULL REFERENCES "users" ("id") ON DELETE SET NULL,
    "parent_comment_id" BIGINT REFERENCES "comments" ("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "votes"
(
    "id"      BIGSERIAL PRIMARY KEY,
    "vote"    SMALLINT  CHECK (vote = 1 or vote = -1),
    "user_id" BIGINT NOT NULL REFERENCES "users" ("id") ON DELETE SET NULL,
    "post_id" BIGINT NOT NULL REFERENCES "posts" ("id") ON DELETE CASCADE

);