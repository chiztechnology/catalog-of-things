require 'json'
require './classes/book'
require_relative 'label_module'
require_relative 'author_module'
require_relative 'genre_module'
require_relative 'date_module'

module BookModule
  module_function

  include LabelModule
  include AuthorModule
  include GenreModule
  include DateModule

  @list_of_books = []
  @file = './storage/books.json'

  def option_add_book
    puts "\n*- Add a book -*\n"
    print 'Cover state: '
    cover_state = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    book = Book.new(DateModule.correct_date_format, publisher, cover_state)
    book.add_label(LabelModule.add_label_ui)
    book.add_author(AuthorModule.add_author_ui)
    book.add_genre(GenreModule.show_genre)
    @list_of_books << book
    puts 'Book successfully created!'
  end

  def list_all_books
    puts "\n*- Books list -*"
    puts 'Books list is empty' if @list_of_books.empty?
    @list_of_books.each_with_index do |book, index|
      puts "\n[#{index}] - Cover state: #{book.cover_state} Publisher: #{book.publisher}"
      puts "      Publish date: #{book.publish_date} Label: #{book.label.title}"
      puts "      Author: #{book.author.first_name} #{book.author.last_name}"
      puts "      Genre: #{book.genre.name}\n"
    end
  end

  def all_books
    @list_of_books
  end

  def load_books
    return unless File.exist?(@file) && !File.empty?(@file)

    JSON.parse(File.read(@file)).each do |book|
      new_book = Book.new(book['publish_date'], book['publisher'], book['cover_state'])
      new_book.id = book['id']
      new_book.archived = book['archived']
      @list_of_books << new_book
    end
  end

  def save_books
    File.new(@file, 'w') unless File.exist?(@file)
    data = []
    @list_of_books.each do |book|
      data.push({ id: book.id, publisher: book.publisher, cover_state: book.cover_state,
                  publish_date: book.publish_date, archived: book.archived,
                  label: book.label.id, author: book.author.id, genre: book.genre.id })
    end
    File.write(@file, JSON.generate(data))
  end
end
