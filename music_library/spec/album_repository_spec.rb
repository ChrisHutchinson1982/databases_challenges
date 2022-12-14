require 'album_repository'
require 'album'

def reset_students_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  before(:each) do
    reset_students_table
  end
  
  it "returns the list of albums" do
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq 2
    expect(albums.first.id).to eq 1
    expect(albums.first.title).to eq 'Doolittle'
    expect(albums[1].release_year).to eq 1974
    expect(albums.first.artist_id).to eq 1
  end


  it "get a single album" do 
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.title).to eq 'Doolittle'
    expect(album.release_year).to eq 1989
  end
  
  it "get a single album" do
    repo = AlbumRepository.new
    album = repo.find(2)
    expect(album.title).to eq 'Waterloo'
    expect(album.release_year).to eq 1974
  end

  it "creates a new album" do
    repository = AlbumRepository.new
    new_album = Album.new
    new_album.title = 'Trompe le Monde'
    new_album.release_year = 1991
    new_album.artist_id = 1

    repository.create(new_album)

    all_albums = repository.all

    expect(all_albums).to include (
      have_attributes(
        title: new_album.title,
        release_year: new_album.release_year,
        artist_id: new_album.artist_id, 
      )
    )

  end

end