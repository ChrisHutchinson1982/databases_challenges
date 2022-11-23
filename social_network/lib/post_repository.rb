class PostRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM posts;'
    result_set = DatabaseConnection.exec_params(sql,[])
    posts = []

    result_set.each do |record|
      posts << record_post_object(record)
    end

    return posts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, title, content, number_of_views, user_id FROM posts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    return record_post_object(record)
  end

  # Inserts a new post record
  # Takes a Post object as an argument
  def create(post)
     sql = 'INSERT INTO posts (title, content, number_of_views, user_id) VALUES($1, $2, $3, $4);'
     params = [post.title, post.content, post.number_of_views, post.user_id]
     
     DatabaseConnection.exec_params(sql, params)

     return nil
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def update(post)
    sql = 'UPDATE posts SET title = $1 , content = $2 , number_of_views = $3, user_id = $4 WHERE id = $5;'
    params = [post.title, post.content, post.number_of_views, post.user_id, post.id]

    DatabaseConnection.exec_params(sql, params)

    return nil

  end

  private

  def record_post_object(record)
    post = Post.new
    post.id = record["id"].to_i
    post.title = record["title"]
    post.content = record["content"]
    post.number_of_views = record["number_of_views"].to_i
    post.user_id = record["user_id"].to_i

    return post
  end

end