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
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
  
    return record_user_object(record)
  end

  def create(user)
    sql = 'INSERT INTO 
            users (username, email_address) 
            VALUES($1, $2);'
    sql_params = [user.username, user.email_address]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

  end

  def delete(id)
    sql= 'DELETE FROM users WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def update(user)
    sql = 'UPDATE users SET username = $1 , email_address = $2 WHERE id = $3;'
    sql_params = [user.username, user.email_address, user.id] 
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  private

  def record_user_object(record)
    user = User.new
    user.id = record["id"].to_i
    user.username = record["username"]
    user.email_address = record['email_address']

    return user
  end

end