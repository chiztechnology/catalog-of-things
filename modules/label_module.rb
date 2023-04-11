require './classes/label'

module LabelModule
  module_function

  @list_of_labels = []
  @file = './storage/labels.json'

  def add_label_ui
    list_all_labels
    print "\nSelect a label [number on the list] or create a new label [0]: "
    label = gets.chomp
    select_create_label(label)
  end

  def list_all_labels
    puts '*- Labels -*'
    puts 'Label list is empty, please create a new one' if @list_of_labels.empty?
    @list_of_labels.each_with_index do |label, index|
      puts "#{index + 1} - Title: #{label.title} Color: #{label.color}"
    end
  end

  def create_label
    puts "\n*- New Label -*"
    print 'Title: '
    title = gets.chomp
    print 'Color: '
    color = gets.chomp
    Label.new(title, color)
  end

  def filter_label(index)
    @list_of_labels.each_with_index do |label, i|
      return label if i == index
    end
  end

  def select_create_label(index)
    index = index.to_i
    return 'Invalid number' unless index <= @list_of_labels.length && index >= 0

    if index.zero?
      new_label = create_label
      @list_of_labels << new_label unless @list_of_labels.include?(new_label)
      new_label
    else
      filter_label(index - 1)
    end
  end

  def filter_items(label, ids, all_books, all_games, all_albums)
    items = []
    ids.each do |id|
      book = all_books.find { |book_element| book_element.id == id }
      game = all_games.find { |game_element| game_element.id == id }
      album = all_albums.find { |album_element| album_element.id == id }

      if book
        items << book
        book.label = label
      elsif game
        items << game
        game.label = label
      elsif album
        items << album
        album.label = label
      end
    end
    items
  end

  def load_labels(all_books, all_games, all_albums)
    return unless File.exist?(@file) && !File.empty?(@file)

    JSON.parse(File.read(@file)).each do |label|
      new_label = Label.new(label['title'], label['color'])
      new_label.id = label['id']
      new_label.items = filter_items(new_label, label['items'], all_books, all_games, all_albums)
      @list_of_labels << new_label
    end
  end

  def save_labels
    File.new(@file, 'w') unless File.exist?(@file)
    data = []

    @list_of_labels.each do |label|
      items_ids = []
      label.items.each do |item|
        items_ids << item.id
      end
      data.push({ id: label.id, title: label.title, color: label.color,
                  items: items_ids })
    end
    File.write(@file, JSON.generate(data))
  end
end
