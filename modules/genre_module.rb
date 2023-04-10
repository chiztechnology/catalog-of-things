require './classes/genre'
require 'json'

module GenreModule
  module_function

  @all_genre = []

  def show_genre(list_of_genre = @all_genre)
    puts('Select genre from the list:')
    list_all_genre(list_of_genre)
    puts("Enter [#{list_of_genre.length}] Create a new genre")
    option = gets.chomp
    genre = select_genre(list_of_genre, option.to_i)
    @all_genre.push(genre) unless @all_genre.include?(genre)
    genre
  end

  def list_all_genre(list_of_genre = @all_genre)
    if list_of_genre.empty?
      puts 'No genre to display. You can add one.'
    else
      list_of_genre.each_with_index { |genre, i| puts(" | #{i}. Genre: #{genre.name} | ") }
    end
  end

  def select_genre(list_of_genre, index)
    if index < list_of_genre.length
      list_of_genre[index]
    else
      print('Enter the name of the genre: ')
      name = gets.chomp
      new_genre(name)

    end
  end

  def new_genre(name)
    Genre.new(name)
  end

  def return_genre(id)
    @all_genre.each do |genre|
      genre if genre.id == id
    end
  end

  def save_genre
    genre_list = []
    @all_genre.each do |genre|
      list_of_item_ids = []
      genre.items.each do |item|
        list_of_item_ids.push(item.id)
      end
      genre_obj = {
        id: genre.id,
        name: genre.name,
        items: list_of_item_ids
      }
      genre_list << genre_obj
    end
    File.new('./storage/genre.json', 'w') unless File.exist?('./storage/genre.json')
    File.write('./storage/genre.json', JSON.pretty_generate(genre_list))
  end

  def filter_items(genre, ids, all_books, all_games, all_albums) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    items = []
    ids.each do |id|
      book = all_books.find { |book_element| book_element.id == id }
      game = all_games.find { |game_element| game_element.id == id }
      album = all_albums.find { |album_element| album_element.id == id }

      if book
        items << book
        book.genre = genre
      elsif game
        items << game
        game.genre = genre
      elsif album
        items << album
        album.genre = genre
      end
    end
    items
  end

  def load_genre(all_books, all_games, all_albums)
    return unless File.exist?('./storage/genre.json') && !File.empty?('./storage/genre.json')

    @all_genre = JSON.parse(File.read('./storage/genre.json')).map do |genre|
      new_genre = Genre.new(genre['name'])
      new_genre.id = genre['id']
      new_genre.items = filter_items(new_genre, genre['items'], all_books, all_games, all_albums)
      new_genre
    end
  end
end
