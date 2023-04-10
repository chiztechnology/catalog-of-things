require_relative 'genre_module'
require_relative 'label_module'
require './classes/music_album'
require_relative 'author_module'
require 'json'

module MusicAlbumModule
  module_function

  include GenreModule
  include LabelModule
  include AuthorModule

  @music_albums = []

  def music_main
    label = LabelModule.add_label_ui
    genre = GenreModule.show_genre
    author = AuthorModule.add_author_ui
    print('Enter publish date (YYYY-MM-DD): ')
    publish_date = gets.chomp
    print('Is it on spotify (Y/N)?')
    on_spotify = gets.chomp
    on_spotify = on_spotify != ('n' || 'N')
    new_album = MusicAlbum.new(publish_date, on_spotify)
    new_album.add_label(label)
    new_album.add_author(author)
    new_album.add_genre(genre)
    @music_albums.push(new_album)
    puts 'New Music Album created!'
  end

  def list_all_albums
    if @music_albums.empty?
      puts 'No music to display. You can add one.'
    else
      @music_albums.each do |music|
        puts(" [#{music.class}] | Title: #{music.label.title} Author: #{music.author.first_name} #{music.author.last_name} Genre: #{music.genre.name} | ") # rubocop:disable Layout/LineLength
      end
    end
  end

  def all_albums
    @music_albums
  end

  def save_music_album
    album_list = []
    @music_albums.each do |album|
      album_obj = {
        id: album.id,
        genre: album.genre.id,
        author: album.author.id,
        label: album.label.id,
        publish_date: album.publish_date,
        on_spotify: album.on_spotify
      }
      album_list << album_obj
    end
    File.new('./storage/music_album.json', 'w') unless File.exist?('./storage/music_album.json')
    File.write('./storage/music_album.json', JSON.pretty_generate(album_list))
  end

  def load_music_album
    return unless File.exist?('./storage/music_album.json') && !File.empty?('./storage/music_album.json')

    @music_albums = JSON.parse(File.read('./storage/music_album.json')).map do |album|
      new_album = MusicAlbum.new(album['publish_date'], album['on_spotify'])
      new_album.id = album['id']
      new_album
    end
  end
end
