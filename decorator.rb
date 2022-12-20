#!/usr/bin/env ruby
require_relative('./nameable')

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.upcase
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    str = @nameable.correct_name
    str.length > 10 ? str[0..9] : str
  end
end
