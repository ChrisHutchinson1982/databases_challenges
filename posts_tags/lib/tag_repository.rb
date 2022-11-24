require_relative './post'
require_relative './tag'
require_relative './database_connection'

class TagRepository

  def find_by_post(id)
    sql = 'SELECT tags.id, 
                  tags.name,
                  posts.id AS post_id, 
                  posts.title
          FROM tags
            JOIN posts_tags 
              ON posts_tags.tag_id = tags.id
            JOIN posts 
              ON posts_tags.post_id = posts.id
                WHERE posts.id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    post = Post.new

    post.id = result.first['post_id'].to_i
    post.title = result.first['title']

    result.each do |record|
      tag = Tag.new
      tag.id = record['id'].to_i
      tag.name = record['name']
      post.tags << tag
    end

    return post
  end

end