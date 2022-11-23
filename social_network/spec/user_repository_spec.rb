require 'user_repository'
require 'user'

RSpec.describe UserRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe UserRepository do
    before(:each) do 
      reset_users_table
    end
    
    it "get all users" do 
      repo = UserRepository.new
      users = repo.all
      expect(users.length).to eq 2
      expect(users[0].id).to eq 1
      expect(users[0].username).to eq 'Jo1234'
      expect(users[0].email_address).to eq 'jo1234@fakeemail.co.uk'
      expect(users[1].id).to eq 2
      expect(users[1].username).to eq 'Bloggs1234'
      expect(users[1].email_address).to eq 'bloggs4567@fakeemail.co.uk'
    end

    it "get a single user" do 
      repo = UserRepository.new
      user = repo.find(1)
      expect(user.id).to eq 1
      expect(user.username).to eq 'Jo1234'
      expect(user.email_address).to eq 'jo1234@fakeemail.co.uk'
    end
  end
end