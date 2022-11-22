require_relative 'lib/database_connection'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('movies_directory')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title, genre, release_year FROM movies;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end



INSERT INTO movies
  (title, genre, release_year)
  VALUES( 'Forest Gump', 'Drama', 1994);