#!/usr/bin/env ruby
require_relative('./models/book')
require_relative('./models/person')
require_relative('./models/rentals')
require_relative('./models/student')
require_relative('./models/teacher')
require('json')

class App
  def initialize
    @func = { '1' => :list_books, '2' => :list_people, '3' => :create_person,
              '4' => :create_book, '5' => :create_rental, '6' => :list_rental,
              '7' => :exit }

    @person = { '1' => :create_student, '2' => :create_teacher }

    @books = []
    @persons = []
    @rentals = []
    @persons_id = []
    puts('Welcome to School Library!')
    read_from_files
  end

  def run
    k = ''
    while k != '7'
      print_info
      k = gets.chomp
      @func.key?(k) ? send(@func[k].to_s) : puts('Invalid number selected, Please pick from 1 - 7')
    end
  end

  def list_books
    @books.each { |e| puts("Title: \"#{e.title}\", Author: #{e.author}") }
  end

  def list_people
    @persons.each { |e| puts("[#{e.class}] Name: #{e.name}, ID: #{e.id}, Age: #{e.age}") }
  end

  def create_person
    k = ''
    until @func.key?(k)
      print('Do you want to create a student (1) or a teacher (2)? [Input the number]: ')
      k = gets.chomp
      @person.key?(k) ? send(@person[k].to_s) : puts('Invalid number selected, Please pick from 1 - 2')
    end
  end

  def create_book
    info = []
    print('Title: ')
    info.push(gets.chomp)
    print('Author: ')
    info.push(gets.chomp)
    @books.push(Book.new(info[0], info[1]))
    puts('Book created successfully')
  end

  def create_rental
    if !@books.empty? && !@persons.empty?
      puts('Select a book from the following list by number')
      info = []
      @books.each_with_index do |e, i|
        puts("#{i}) Title: \"#{e.title}\", Author: #{e.author}")
      end
      info.push(gets.chomp)
      @persons.each_with_index do |e, i|
        puts("#{i}) [#{e.class}] Name: #{e.name}, ID: #{e.id}, Age: #{e.age}")
      end
      info.push(gets.chomp)
      print('Date: ')
      info.push(gets.chomp)
      rental = Rentals.new(@persons[info[1].to_i], @books[info[0].to_i], info[2])
      p rental
      @rentals << rental
      puts('Rental created successfully')
    else
      puts('No books or persons available')
    end
  end

  def list_rental
    print('ID of person: ')
    info = gets.chomp.to_i
    puts('Rentals: ')
    return if @persons_id.index(info).nil?

    @persons[@persons_id.index(info)].rentals.each do |e|
      puts("Date: #{e.date}, Book: #{e.book.title} by #{e.book.author}")
    end
  end

  private

  def print_info
    puts("\nPlease choose an option by entering a number:")
    puts('1 - List all books')
    puts('2 - List all people')
    puts('3 - Create a person')
    puts('4 - Create a book')
    puts('5 - Create a rental')
    puts('6 - List all rentals for a given person id')
    puts('7 - Exit')
  end

  def exit
    save_to_files
    puts("Thank you for using this app!\n\n")
  end

  def create_student
    info = []
    print('Age: ')
    info.push(gets.chomp)
    print('Name: ')
    info.push(gets.chomp)
    print('Has parent permission? [y/n]: ')
    info.push(gets.chomp)
    person = Student.new(info[0], info[1], info[2].strip[0].downcase == 'y')
    @persons << person
    @persons_id << person.id
    puts('Student created successfully')
  end

  def create_teacher
    info = []
    print('Age: ')
    info.push(gets.chomp)
    print('Name: ')
    info.push(gets.chomp)
    print('Specialization: ')
    info.push(gets.chomp)
    person = Teacher.new(info[2], info[0], info[1])
    @persons << person
    @persons_id << person.id
    puts('Teacher created successfully')
  end

  def save_to_files
    @persons.each_with_index do |obj, i|
      @persons[i] = obj.to_hash
    end
    File.write('./storage_files/persons.json', JSON.generate(@persons))

    @books.each_with_index do |obj, i|
      @books[i] = obj.to_hash
    end
    File.write('./storage_files/books.json', JSON.generate(@books))
  end

  def read_from_files
    if File.exist? './storage_files/persons.json'
      @persons = JSON.parse(File.read('./storage_files/persons.json'))
      @persons.each_with_index do |obj, i|
        @persons[i] = if obj['class'] == 'Teacher'
                        Teacher.new(obj['specialization'], obj['age'], obj['name'])
                      else
                        Student.new(obj['age'], obj['name'], obj['parent_permission'])
                      end
      end
    end

    return unless File.exist? './storage_files/books.json'

    @books = JSON.parse(File.read('./storage_files/books.json'))
    @books.each_with_index do |obj, i|
      @books[i] = Book.new(obj['title'], obj['author'])
    end
  end
end
