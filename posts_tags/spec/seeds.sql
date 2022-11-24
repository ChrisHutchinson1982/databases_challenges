TRUNCATE TABLE tags RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO posts (title) VALUES ('My amazing post');
INSERT INTO posts (title) VALUES ('My amazing post 2');
-- New post inserted with id 3

INSERT INTO tags (name) VALUES ('poetry');
INSERT INTO tags (name) VALUES ('travel');
-- New tag inserted with id 5

INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 1);
