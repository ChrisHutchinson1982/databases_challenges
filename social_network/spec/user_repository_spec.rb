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

    it "create a single user" do
      repo = UserRepository.new
      new_user = User.new
      new_user.username = 'Fred9999'
      new_user.email_address = 'Fred9999@fakeemail.co.uk'
      repo.create(new_user)

      all_users = repo.all
      
      expect(all_users).to include (
        have_attributes(
          username: new_user.username,
          email_address: new_user.email_address,
        )
      )
    end

    it 'Deleting a single user' do
      repo = UserRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)
      all_users = repo.all
      expect(all_users.length).to eq 1
      expect(all_users.first.id).to eq 2
    end

    it 'Updates a single record' do
      repo = UserRepository.new
      user = repo.find(1)
      user.username = 'JoBloggs'
      user.email_address = 'jobloggs1234@fakeemail.co.uk'
      
      repo.update(user)

      updated_user = repo.find(1)
      expect(updated_user.username).to eq 'JoBloggs'
      expect(updated_user.email_address).to eq 'jobloggs1234@fakeemail.co.uk'
    end


    it 'Updates a with new username only' do
      repo = UserRepository.new
      user = repo.find(1)
      user.username = 'JoBloggs'
      repo.update(user)
      updated_user = repo.find(1)
      expect(updated_user.username).to eq 'JoBloggs'
      expect(updated_user.email_address).to eq 'jo1234@fakeemail.co.uk'
    end
  end
end