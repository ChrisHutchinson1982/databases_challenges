require_relative './album'
require_relative './database_connection'

class AlbumRepository
  def all
    sql = 'SELECT * FROM albums'

    result_set = DatabaseConnection.exec_params(sql,[])
    albums = []
    result_set.each{ |record|
      albums << record_to_album_object(record)
    }
    return albums
  end

  def find(id)

    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    record = result[0]
    return record_to_album_object(record)

  end

  def create(album)
    sql = 'INSERT INTO 
            albums (title, release_year, artist_id) 
            VALUES($1, $2, $3)'
    sql_params = [album.title, album.release_year, album.artist_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

    def record_to_album_object(record)
      album = Album.new
      album.id = record["id"].to_i
      album.title = record["title"]
      album.release_year = record["release_year"].to_i
      album.artist_id = record["artist_id"].to_i

      return album
    end

end