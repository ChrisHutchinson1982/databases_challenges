class UserRepository

  def all
    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    users = []
    result_set.each do |record|
      users << record_user_object(record)
    end

    return users
  end

  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, username, email_address FROM users WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
  
    return record_user_object(record)
  end

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

  private

  def record_user_object(record)
    user = User.new
    user.id = record["id"].to_i
    user.username = record["username"]
    user.email_address = record['email_address']

    return user
  end

end