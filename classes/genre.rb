require 'date'
class Genre
  attr_accessor :id, :name, :items

  def initialize(name)
    @id = Time.now.to_i
    @name = name
    @items = []
  end

  def add_item(item)
    @items.push(item)
    item.genre = self
  end
end
