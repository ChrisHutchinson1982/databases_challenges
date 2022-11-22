```mermaid
sequenceDiagram
    participant t as terminal
    participant app as Main program (in app.rb)
    participant ar as AlbumRepository class <br /> (in lib/album_repository.rb)
    participant db_conn as Album class in (in lib/album.rb)
    participant db as Postgres database

    Note left of t: Flow of time <br />⬇ <br /> ⬇ <br /> ⬇ 

    t->>app: Runs `ruby app.rb`
    app->>db_conn: Opens connection to database by calling .connect('music_library') method on DatabaseConnection
    db_conn->>db_conn: Opens database connection using PG and stores the connection
    app->>ar: Calls all method on AlbumRepository.new
    ar->>db_conn: Sends SQL query by calling exec_params(sql, []) method on DatabaseConnection
    db_conn->>db: Sends query to database via the open database connection
    db->>db_conn: Returns an element of albums, one for each row of the album table

    db_conn->>ar: Returns an element of albums, one for each row of the album table
    loop 
        ar->>ar: Loops through result_set and creates a album object for every row
    end
    ar->>app: Returns arary of album objects
    app->>t: Prints list of albums to terminal

  ```
