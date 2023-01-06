require_relative '../models./book'

describe Book do
  before(:each) do
    @book = Book.new('Dune', 'Korra')
  end

  it 'should print the argument passed when creating instance of the class' do
    expect(@book.title).to eql 'Dune'
    expect(@book.author).to eql 'Korra'
  end

  it 'should return the object state in hash format' do
    hash = @book.to_hash
    expect(hash[:author]).to eql 'Korra'
  end

  it 'should return true for objects with the same attribute values' do
    @book1 = Book.new('Dune', 'Korra')
    expect(@book == @book1).to eql true
  end
end
