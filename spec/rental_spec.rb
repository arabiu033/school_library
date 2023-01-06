require_relative '../models/student'
require_relative '../models/book'
require_relative '../models/rentals'

describe Rentals do
  it 'should accept and return attributes passed' do
    student = Student.new(21, 'Korra', true)
    book = Book.new('Dune', 'Korra')
    rental = Rentals.new(student, book, '2020')
    expect(rental.person).to be student
  end

  it 'should retuen the object state in hash' do
    student = Student.new(21, 'Korra', true)
    book = Book.new('Dune', 'Korra')
    rental = Rentals.new(student, book, '2020').to_hash
    expect(rental[:p]).to eql student.to_hash
  end
end
