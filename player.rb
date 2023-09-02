# frozen_string_literal: true

# Player object for the connect four game
class Player

  attr_accessor :name, :check

  def initialize(name)
    @name = name
    @check = false
  end

end