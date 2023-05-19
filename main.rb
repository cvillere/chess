# frozen_string_literal: true

require_relative './gamepieces'
require_relative './player'

# board class for chess game
class GameBoard

  include GamePieces

  attr_accessor :board, :player_one, :player_two, :current_player

  def initialize
    @board = Array.new(8) { Array.new(8, "\u25AA") }
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

  def populat_board(pieces, board_rev = false)
    pieces.each_with_index do |k, k_index|
      k.each_with_index do |l, l_index|
        curr_pie = assign_vars([k_index, l_index], board_rev, l)
        board_rev ? @board.reverse[k_index][l_index] = curr_pie.symbol : @board[k_index][l_index] = curr_pie.symbol
      end
    end 
  end

  def assign_vars(pos, color, init_obj)
    init_obj.start_pos = pos
    init_obj.white_piece = color
    init_obj.symbol = deter_gm_piece(init_obj.white_piece, init_obj.symbol)
    init_obj
  end

  def initiate_board
    populat_board(GamePieces::WHITE_PIECES, false)
    populat_board(GamePieces::BLACK_PIECES, true)
    show_board_with_numbers
    assign_players
  end

  def create_player(num)
    name = get_player_name(num)
    Player.new(name)
  end

  def assign_players
    @player_one = create_player(1)
    GamePieces::BLACK_PIECES.each {|piec| piec.player = @player_one} 
    @player_two = create_player(2)
    GamePieces::WHITE_PIECES.each {|piec| piec.player = @player_two}
  end

  def get_player_name(player_num)
    puts "what is player #{player_num}'s name"
    gets.chomp
  end



end

my_board = GameBoard.new

my_board.initiate_board