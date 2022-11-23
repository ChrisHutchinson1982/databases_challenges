# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_social_network.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY CASCADE; 
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

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

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < spec/seeds_social_network.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class User
  # Replace the attributes by your own columns.
  attr_accessor :id, :user_name, :email_address
end

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :number_of_views, :user_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, user_name, email_address FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, user_name, email_address FROM user WHERE id = $1;

    # Returns a single User object.
  end

  # Inserts a new user record
  # Takes a User object as an argument
  def create(user)
     # Executes the SQL query:
     # INSERT INTO users (username, email_address) VALUES($1, $2),
     # Doesn't need to return anything, just creates a user
  end

  def delete(user)
    # Executes the SQL query:
    # DELETE FROM users WHERE id = $1;
    # Doesn't need to return anything, just deletes a user
  end

  def update(user)
    # Executes the SQL query:
    # UPDATE users SET username = $1 , email_address = $2 WHERE id = $3;   
    # Doesn't need to return anything, just updates a user
  end

end



class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, user_id FROM user WHERE id = $1;

    # Returns a single Post object.
  end

  # Inserts a new post record
  # Takes a Post object as an argument
  def create(user)
     # Executes the SQL query:
     # INSERT INTO posts (title, content, user_id) VALUES($1, $2, $3),
     # Doesn't need to return anything, just creates a post
  end

  def delete(user)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;
    # Doesn't need to return anything, just deletes a post
  end

  def update(user)
    # Executes the SQL query:
    # UPDATE posts SET title = $1 , content = $2 , user_id = $3 WHERE id = $4;    
    # Doesn't need to return anything, just updates a post
  end

end




```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new

users = repo.all

user.length # =>  2

users[0].id # =>  1
users[0].username # =>  'Jo1234'
users[0].email_address # =>  'jo1234@fakeemail.co.uk'

users[1].id # =>  2
users[1].username # =>  'Bloggs1234'
users[1].email_address # =>  'bloggs4567@fakeemail.co.uk'

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.username # =>  'Jo1234'
user.email_address # =>  'jo1234@fakeemail.co.uk'


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_user_table
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
