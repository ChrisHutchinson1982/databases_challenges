TRUNCATE TABLE users RESTART IDENTITY CASCADE; 

INSERT INTO 
  users (username, email_address) 
  VALUES ('Jo1234', 'jo1234@fakeemail.co.uk');
INSERT INTO 
  users (username, email_address) 
  VALUES ('Bloggs1234', 'bloggs4567@fakeemail.co.uk');

INSERT INTO 
  posts (title, content, number_of_views, user_id) 
  VALUES ('post title 1', 'post content 1', 1, 1);
INSERT INTO 
  posts (title, content, number_of_views, user_id) 
  VALUES ('post title 2', 'post content 2', 2, 1);
INSERT INTO 
  posts (title, content, number_of_views, user_id) 
  VALUES ('post title 3', 'post content 3', 3, 2);
INSERT INTO 
  posts (title, content, number_of_views, user_id) 
  VALUES ('post title 4', 'post content 4', 4, 2);