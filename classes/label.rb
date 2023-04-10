require 'date'
class Label
  attr_accessor :id, :title, :color, :items

  def initialize(title, color)
    @id = Time.now.to_i
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items.push(item)
    item.label = self
  end
end
