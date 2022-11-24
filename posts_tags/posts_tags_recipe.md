# Posts and Tags Model and Repository Classes Design Recipe

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
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

-- TRUNCATE TABLE posts_tags RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO posts (title) VALUES ('My amazing post');
-- New post inserted with id 3

INSERT INTO tags (name) VALUES ('poetry');
-- New tag inserted with id 5

INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/posts.rb)
class Posts
end

# Model class
# (in lib/tags.rb)
class Tags
end

# Model class
# (in lib/post_tags.rb)
class PostsTags
end

# Repository class
# (in lib/posts_tags_repository.rb)
class PostsTagsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title
end

class Tag
  # Replace the attributes by your own columns.
  attr_accessor :id, :name
end

class PostTag
  # Replace the attributes by your own columns.
  attr_accessor :post_id, :tag_id
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
# (in lib/student_repository.rb)

class TagRepository

  
  def find_by_post(post_id)
    # This method should accept a post ID, and return an array of related Tag objects.
    # Executes the SQL query:
    # SELECT tags.id, tags.name, posts.title
        # FROM tags
        # JOIN posts_tags ON posts_tags.tag_id = tags.id
        # JOIN posts ON posts_tags.post_id = posts.id
        # WHERE posts.id = $1;

    # Returns a single Student object.
  end

  
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Takes a post ID and return an array of related Tag objects.

repo = TagRepository.new
post = repo.find_by_post(1)

post.title # => My amazing post'
post.tags.length  => 2
post.tags[0].name # =>  'poetry'




# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/tag_repository_spec.rb

def reset_tags_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'posts_tags_test' })
  connection.exec(seed_sql)
end

describe TagRepository do
  before(:each) do 
    reset_tags_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
