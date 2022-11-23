require 'post_repository'
require 'post'

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sql = File.read('spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe PostRepository do
    before(:each) do 
      reset_posts_table
    end
    
    it "get all posts" do 
      repo = PostRepository.new
      posts = repo.all
      expect(posts.length).to eq 4
      expect(posts[0].id).to eq 1
      expect(posts[0].title).to eq 'post title 1'
      expect(posts[0].content).to eq 'post content 1'
      expect(posts[0].number_of_views).to eq 1
      expect(posts[0].user_id).to eq 1
    end

    it "get a single post" do 
      repo = PostRepository.new
      post = repo.find(1)
      expect(post.id).to eq 1
      expect(post.title).to eq 'post title 1'
      expect(post.content).to eq 'post content 1'
      expect(post.number_of_views).to eq 1
      expect(post.user_id).to eq 1
    end

    it "create a single post" do
      repo = PostRepository.new
      new_post = Post.new
      new_post.title = 'post title 5'
      new_post.content = 'post content 5'
      new_post.number_of_views = 10
      new_post.user_id = 1
      repo.create(new_post)

      all_posts = repo.all
      
      expect(all_posts).to include (
        have_attributes(
          title: new_post.title,
          content: new_post.content,
          number_of_views: new_post.number_of_views,
          user_id: new_post.user_id,
        )
      )
    end

    it 'Deleting a single post' do
      repo = PostRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)
      all_posts = repo.all
      expect(all_posts.length).to eq 3
      expect(all_posts.first.id).to eq 2
    end

    it 'Updates a single record' do
      repo = PostRepository.new
      post = repo.find(1)
      post.title = 'post title 5'
      post.content = 'post content 5'
      post.number_of_views = 10
      post.user_id = 2

      repo.update(post)

      updated_post = repo.find(1)

      expect(updated_post.title).to eq 'post title 5'
      expect(updated_post.content).to eq 'post content 5'
      expect(updated_post.number_of_views).to eq 10
      expect(updated_post.user_id).to eq 2

    end

    it 'Updates a with new title only' do
      repo = PostRepository.new
      post = repo.find(1)
      post.title = 'post title 5'
      repo.update(post)
      updated_post = repo.find(1)
      expect(updated_post.title).to eq 'post title 5'
      expect(updated_post.content).to eq 'post content 1'
      expect(updated_post.number_of_views).to eq 1
      expect(updated_post.user_id).to eq 1
    end
  end
end