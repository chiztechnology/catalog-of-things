require 'date'
require_relative '../classes/book'

describe Book do
  context 'Testing Book Class' do
    it 'Creates a book object with a item and their properties' do
      book = Book.new('2022-02-02', 'James Bond', '007')
      expect(book).to be_instance_of(Book)
      expect(book.publish_date).to eq Date.parse('2022-02-02')
      expect(book.publisher).to eq 'James Bond'
      expect(book.cover_state).to eq '007'
    end
  end
end
