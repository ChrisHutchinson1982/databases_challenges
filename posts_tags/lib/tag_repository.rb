
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