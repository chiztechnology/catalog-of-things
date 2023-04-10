require_relative '../classes/label'
require_relative '../classes/item'

describe Label do
  label = Label.new('Pink', 'Majenta')

  context 'Testing  Label Class' do
    it 'should create a Label instance ' do
      expect(label).to be_instance_of(Label)
      expect(label.title).to eq 'Pink'
      expect(label.color).to eq 'Majenta'
    end
  end

  context 'Testing Label methods' do
    it 'add_item should add the item to the items array and set self to item.label property' do
      item = Item.new('2002-02-02')
      label.add_item(item)
      expect(label.items).to eq [item]
      expect(item.label).to eq label
    end
  end
end
