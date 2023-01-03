#!/usr/bin/env ruby
require_relative('./person')
require('json')

class Teacher < Person
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
end
