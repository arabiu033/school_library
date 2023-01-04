#!/usr/bin/env ruby
require_relative('./person')

class Teacher < Person
  attr_reader :specialization

  def initialize(specialization, age, name, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    {
      age: @age,
      name: @name,
      specialization: @specialization,
      class: self.class
    }
  end
 
  def ==(other)
    age == other.age &&
      name == other.name &&
      specialization == other.specialization
  end
end
