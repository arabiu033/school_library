#!/usr/bin/env ruby
require_relative('./book')
require_relative('./person')
require_relative('./rentals')
require_relative('./student')
require_relative('./teacher')
require('json')

class Storage
  def self.save_to_files(persons, books, rentals)
    persons.each_with_index do |obj, i|
      persons[i] = obj.to_hash
    end
    File.write('./storage_files/persons.json', JSON.generate(persons))

    books.each_with_index do |obj, i|
      books[i] = obj.to_hash
    end
    File.write('./storage_files/books.json', JSON.generate(books))

    rentals.each_with_index do |obj, i|
      rentals[i] = obj.to_hash
    end
    File.write('./storage_files/rentals.json', JSON.generate(rentals))
  end

  def self.read_persons
    persons = [[], []]
    if File.exist? './storage_files/persons.json'
      persons[0] = JSON.parse(File.read('./storage_files/persons.json'))
      persons[0].each_with_index do |obj, i|
        persons[0][i] = Storage.return_person(obj)
        persons[1] << persons[0][i].id
      end
    end
    persons
  end

  def self.read_books
    books = []
    if File.exist? './storage_files/books.json'
      books = JSON.parse(File.read('./storage_files/books.json'))
      books.each_with_index do |obj, i|
        books[i] = Book.new(obj['title'], obj['author'])
      end
    end
    books
  end

  def self.read_rentals
    rentals = []
    if File.exist? './storage_files/rentals.json'
      rentals = JSON.parse(File.read('./storage_files/rentals.json'))
      rentals.each_with_index do |obj, i|
        rentals[i] = Rentals.new(
          Storage.return_person(obj['p']), Book.new(obj['b']['title'], obj['b']['author']), obj['date']
        )
      end
    end
    rentals
  end

  def self.return_person(obj)
    return Teacher.new(obj['specialization'], obj['age'], obj['name']) if obj['clas'] == 'Teacher'

    Student.new(obj['age'], obj['name'], obj['parent_permission'])
  end
end
