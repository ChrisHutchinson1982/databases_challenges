-- file: social_network_tables.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  number_of_views int,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);