require 'tag_repository'

RSpec.describe TagRepository do
  def reset_tags_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'posts_tags_test' })
    connection.exec(seed_sql)
  end
  
  describe TagRepository do
    before(:each) do 
      reset_tags_table
    end
  
    it 'Takes a post ID and return an array of related Tag objects.' do
      repo = TagRepository.new
      post = repo.find_by_post(1)
      expect(post.title).to eq 'My amazing post'
      expect(post.tags.length).to eq 2
      expect(post.tags[0].name).to eq 'poetry'
    end
  end


end