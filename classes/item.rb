require 'date'

class Item
    attr_accessor :label, :genre, :author, :id, :publish_date, :archived

    def initialize(publish_date)
        @id = Time.now.to_i
        @publish_date = Date.parse(publish_date)
        @archived = false
        @label = {}
        @genre = {}
        @author = {}
    end

    def move_to_archive
        return unless can_be_archived?
        @archived = true
    end

    # relational methods
    def add_label(label)
        @label = label
        label.add_item(self) unless label.items.include?(self)
    end

    def add_author(author)
        @author = author
        author.add_item(self) unless author.items.include?(self)
    end

    def add_genre(genre)
        @genre = genre
        genre.add_item(self) unless genre.items.include?(self)
    end

    # end of relational methods

    private

    def can_be_archived?
        today = Date.today
        ten_years_ago = today << 120
        @publish_date < ten_years_ago
    end
end