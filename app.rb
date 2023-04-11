require_relative './classes/music_album'
require_relative './classes/genre'
require './modules/genre_module'
require './modules/book_module'
require './modules/label_module'
require './modules/game_module'
require './modules/author_module'
require './modules/music_album_module'
class App
  include GenreModule
  include BookModule
  include LabelModule
  include GameModule
  include AuthorModule
  include MusicAlbumModule

  def display_books
    BookModule.list_all_books
  end

  def display_music_album
    MusicAlbumModule.list_all_albums
  end

  def display_game
    GameModule.list_all_games
  end

  def display_genre
    GenreModule.list_all_genre
  end

  def display_labels
    LabelModule.list_all_labels
  end

  def display_authors
    AuthorModule.list_all_authors
  end

  def add_book
    BookModule.option_add_book
  end

  def add_music_album
    MusicAlbumModule.music_main
  end

  def add_game
    GameModule.option_add_game
  end

  def load_data
    puts 'loading data------------------'
    BookModule.load_books
    GameModule.load_games
    MusicAlbumModule.load_music_album
    LabelModule.load_labels(BookModule.all_books, GameModule.all_games, MusicAlbumModule.all_albums)
    AuthorModule.load_authors(GameModule.all_games, BookModule.all_books, MusicAlbumModule.all_albums)
    GenreModule.load_genre(BookModule.all_books, GameModule.all_games, MusicAlbumModule.all_albums)
  end

  def save_data
    puts 'saving data ----------------------'
    BookModule.save_books
    LabelModule.save_labels
    GenreModule.save_genre
    MusicAlbumModule.save_music_album
    GameModule.save_games
    AuthorModule.save_authors
  end
end
