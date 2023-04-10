require 'json'
require './classes/game'
require_relative 'author_module'
require_relative 'label_module'
require_relative 'genre_module'
require_relative 'date_module'

module GameModule
  module_function

  include AuthorModule
  include LabelModule
  include GenreModule
  include DateModule

  @list_of_games = []
  @file = './storage/games.json'

  def option_add_game
    puts "\n*- Add a game -*\n"
    print 'Is it a multiplayer game? [Y/N]: '
    multiplayer = gets.chomp.to_s.downcase == 'y'
    print 'When was it last played at? (YYYY-MM-DD): '
    last_played_at = gets.chomp
    print 'Published Date (YYYY-MM-DD): '
    publish_date = gets.chomp
    game = Game.new(publish_date, multiplayer, last_played_at)
    game.add_label(LabelModule.add_label_ui)
    game.add_author(AuthorModule.add_author_ui)
    game.add_genre(GenreModule.show_genre)
    @list_of_games << game
    puts 'Game successfully created!'
  end

  def list_all_games
    puts "\n*- Games list -*"
    puts 'Game list is empty' if @list_of_games.empty?
    @list_of_games.each_with_index do |game, index|
      puts "[#{index}] - Publish date: #{game.publish_date} Last played: #{game.last_played_at} "
      puts "      Multiplayer: #{game.multiplayer}\n"
      puts "      Author: #{game.author.first_name} #{game.author.last_name}"
      puts "      Label: #{game.label.title}"
      puts "      Genre: #{game.genre.name}\n"
    end
  end

  def all_games
    @list_of_games
  end

  def load_games
    return unless File.exist?(@file) && !File.empty?(@file)

    JSON.parse(File.read(@file)).each do |game|
      new_game = Game.new(game['publish_date'], game['multiplayer'], game['last_played_at'])
      new_game.id = game['id']
      new_game.archived = game['archived']
      @list_of_games << new_game
    end
  end

  def save_games
    File.new(@file, 'w') unless File.exist?(@file)
    data = []
    @list_of_games.each do |game|
      data.push({ id: game.id, publish_date: game.publish_date, multiplayer: game.multiplayer,
                  last_played_at: game.last_played_at, archived: game.archived,
                  author: game.author.id, label: game.label.id, genre: game.genre.id })
    end
    File.write(@file, JSON.generate(data))
  end
end
