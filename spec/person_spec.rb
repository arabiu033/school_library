require_relative '../models/person'

describe Person do
  before(:each) do
    @person = Person.new(20, 'Korra')
  end

  it 'should return the name of the person' do
    expect(@person.correct_name).to eql 'Korra'
  end

  it 'should return true if person can use service' do
    expect(@person.can_use_services?).to eql true
  end
end
