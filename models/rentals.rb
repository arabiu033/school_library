#!/usr/bin/env ruby

class Rentals
  attr_reader :person, :book
  attr_accessor :date

  def initialize(person, book, date)
    self.person = person
    self.book = book
    @date = date
  end

  def person=(person)
    @person = person
    person.rentals.push(self) unless person.rentals.include?(self)
  end

  def book=(book)
    @book = book
    book.rentals.push(self) unless book.rentals.include?(self)
  end

  def to_hash
    {
      date: @date,
      p: @person.to_hash,
      b: @book.to_hash
    }
  end
end
