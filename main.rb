# frozen_string_literal: true

class GameBoard

  attr_accessor :board, :player_one, :player_two, :current_player

  def initialize
    @board = Array.new(8) { Array.new(8, "\u25AA")}
    @player_one = player_one
    @player_two = player_two
    @current_player = nil
  end

  def show_board_with_numbers
    puts '   a  b  c  d  e  f  g  h'
    @board.each_with_index do |sub_arr, row_num|
      row_str = sub_arr.join('  ')
      puts "#{row_num + 1}  #{row_str}"
    end
  end

end

my_board = GameBoard.new

my_board.show_board_with_numbers