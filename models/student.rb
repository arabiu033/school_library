#!/usr/bin/env ruby
require_relative('./person')
require_relative('./classroom')

class Student < Person
  attr_reader :classroom

  def initialize(age, name, parent_permission, classroom: nil)
    super(age, name, parent_permission: parent_permission)
    self.classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless !classroom || classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def to_hash
    {
      age: @age,
      name: @name,
      parent_permission: @parent_permission,
      class: self.class
    }
  end
end
