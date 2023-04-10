require_relative '../classes/genre'
require_relative '../classes/music_album'

describe 'Test genre class' do
  genre = Genre.new('Hip hop')
  new_item = MusicAlbum.new('2022-10-10', true)
  genre.add_item(new_item)

  it 'takes parameters and returns a genre object' do
    expect(genre).to be_instance_of(Genre)
  end

  it "genre name should be Hip hop" do
    expect(genre.name).to eql 'Hip hop'
  end

  it 'The item list should have a length of 1' do
    expect(genre.items.length).to be(1)
  end
end
