require_relative('app')
class Main
  def menu
    puts '**** CHOOSE AN OPTION ******'
    puts '----------------------------'
    print("
        1   -   List Books
        2   -   List Music Album
        3   -   List Games
        4   -   List Genres
        5   -   List Labels
        6   -   List authors
        7   -   Add a book
        8   -   Add a music album
        9   -   Add a game
        0   -   Exit
        ")
  end

  def run_menu(app, option)
    case option
    when 1
      app.display_books
    when 2
      app.display_music_album
    when 3
      app.display_game
    when 4
      app.display_genre
    when 5
      app.display_labels
    when 6
      app.display_authors
    when 7
      app.add_book
    when 8
      app.add_music_album
    when 9
      app.add_game
    else
      puts 'Invalid option ; Please choose one of the options below'
    end
  end

  def wait_user
    puts 'Press any key to continue'
    gets.chomp
  end

  # App entry point
  def main
    option = -1
    app = App.new
    app.load_data

    until option.zero?
      menu
      option = gets.chomp.to_i
      puts ''
      run_menu(app, option) unless option.zero?
      wait_user unless option.zero?
    end
    # saving the data to JSON when exiting the app
    app.save_data
  end
end

Main.new.main
