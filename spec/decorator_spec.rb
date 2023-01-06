require_relative '../models/decorator'
require_relative '../models/person'

describe Decorator do
  it 'should store a name passed' do
    dec = Decorator.new(Person.new(20, 'Korra'))
    expect(dec.correct_name).to eql 'Korra'
  end

  it 'should a captalize name' do
    dec = CapitalizeDecorator.new(Person.new(20, 'aorra'))
    expect(dec.correct_name).to eql 'Aorra'
  end

  it 'should trim long names' do
    dec = TrimmerDecorator.new(Person.new(20, 'KorraDuneBlownAndBob'))
    expect(dec.correct_name).to eql 'KorraDuneB'
  end
end
