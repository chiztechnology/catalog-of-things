require_relative '../classes/author'

describe 'Test of Author class' do
  author = Author.new('Israel', 'Chizungu')

  it 'takes first_name and last_name and returns  author object' do
    expect(author).to be_instance_of(Author)
  end

  it "author's first name should be Israel" do
    expect(author.first_name).to eql 'Israel'
  end

  it "author's last name should be Chizungu" do
    expect(author.last_name).to eql 'Chizungu'
  end
end
