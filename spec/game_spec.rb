require_relative '../classes/game'

describe 'Test Game class' do
  game = Game.new('1910-10-10', 'Y', '2022-10-10')

  it 'takes parameters and returns a game object' do
    expect(game).to be_instance_of(Game)
  end

  it "game publish date should be '1910-10-10'" do
    expect(game.publish_date).to eq Date.new(1910, 10, 10)
  end

  it "Game last played date is '2022-10-10'" do
    expect(game.last_played_at).to eq '2022-10-10'
  end
end
