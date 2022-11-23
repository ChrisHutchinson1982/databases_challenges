class UserRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    users = []
    result_set.each do |record|
      user = User.new
      user.id = record["id"].to_i
      user.username = record["username"]
      user.email_address = record['email_address']
      users << user
    end

    return users

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, user_name, email_address FROM user WHERE id = $1;

  #   # Returns a single User object.
  # end

  # # Inserts a new user record
  # # Takes a User object as an argument
  # def create(user)
  #    # Executes the SQL query:
  #    # INSERT INTO users (username, email_address) VALUES($1, $2),
  #    # Doesn't need to return anything, just creates a user
  # end

  # def delete(user)
  #   # Executes the SQL query:
  #   # DELETE FROM users WHERE id = $1;
  #   # Doesn't need to return anything, just deletes a user
  # end

  # def update(user)
  #   # Executes the SQL query:
  #   # UPDATE users SET username = $1 , email_address = $2 WHERE id = $3;   
  #   # Doesn't need to return anything, just updates a user
  # end

end