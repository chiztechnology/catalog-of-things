require_relative './classes/genre'
require './modules/genre_module'
require './modules/book_module'
require './modules/label_module'
require './modules/author_module'

class App
  include GenreModule
  include BookModule
  include LabelModule
  include AuthorModule

  def display_books
    BookModule.list_all_books
  end

  def display_music_album
    puts 'display albums'
  end

  def display_game
    puts 'display games'
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
    puts 'add Music album'
  end

  def add_game
    puts 'Add game'
  end

  def load_data
    BookModule.load_books
    LabelModule.load_labels(BookModule.all_books, GameModule.all_games, MusicAlbumModule.all_albums)
    AuthorModule.load_authors(GameModule.all_games, BookModule.all_books, MusicAlbumModule.all_albums)
    GenreModule.load_genre(BookModule.all_books, GameModule.all_games, MusicAlbumModule.all_albums)
  end

  def save_data
    BookModule.save_books
    LabelModule.save_labels
    GenreModule.save_genre
    AuthorModule.save_authors
  end
end
