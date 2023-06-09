# frozen_string_literal: true

require 'pry'

require_relative 'gamepieces'
require_relative 'player'
require_relative 'piecesfuncs'
require_relative 'displayinstructions'


# board class for chess game
class GameBoard

  include GamePieces
  include PiecesFuncs
  include DisplayInstructions

  attr_accessor :board, :player_one, :player_two, :current_player

  def initialize
    @board = Array.new(8) { Array.new(8, "\u25AA") }
    @player_one = player_one
    @player_two = player_two
    @black_pieces = b_pieces
    @white_pieces = w_pieces
    @current_player = nil
  end

  def b_pieces
    [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
      Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
      Pawn.new, Pawn.new, Pawn.new]]
  end

  def w_pieces
    [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
      Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
      Pawn.new, Pawn.new, Pawn.new]]
  end

  def turns
    @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
  end

  def show_board_with_numbers
    puts '   1  2  3  4  5  6  7  8'
    @board.each_with_index do |sub_arr, row_num|
      row_str = sub_arr.join('  ')
      puts "#{row_num + 1}  #{row_str}"
    end
  end

  def populat_board(pieces, board_rev = false)
    pieces.each_with_index do |k, k_index|
      k.each_with_index do |l, l_index|
        curr_pie = assign_vars(board_rev, l)
        board_rev ? @board[k_index][l_index] = curr_pie.symbol : @board.reverse[k_index][l_index] = curr_pie.symbol
        board_rev ? curr_pie.start_pos = [curr_pie.pos[0], l_index] : curr_pie.start_pos = [curr_pie.pos[1], l_index]
      end
    end
  end

  def initiate_board
    populat_board(@white_pieces, false)
    populat_board(@black_pieces, true)
    show_board_with_numbers
    assign_players
  end

  def create_player(num)
    name = get_player_name(num)
    Player.new(name)
  end

  def assign_players
    @player_one = create_player(1)
    puts "player 1, you will be playing the black pieces"
    add_player_to_piece(@black_pieces, @player_one)
    @player_two = create_player(2)
    puts "player 2, you will be playing the white pieces"
    add_player_to_piece(@white_pieces, @player_two)
  end

  def get_player_name(player_num)
    puts "what is player #{player_num}'s name"
    gets.chomp
  end

=begin
  def deter_piece(start_spot)
    @current_player == @player_one ? my_pieces = @black_pieces : my_pieces = @white_pieces
    # puts "my_pieces #{my_pieces}"
    my_pieces.each do |n|
      n.find { |pie| return pie if pie.start_pos == start_spot }
    end
    nil
  end
=end

  def deter_piece(start_spot)
    @current_player == @player_one ? my_pieces = @black_pieces : my_pieces = @white_pieces
    # puts "my_pieces #{my_pieces}"
    my_pieces.each do |n|
      n.find { |pie| return pie if pie.start_pos == start_spot }
    end
      nil
  end

  def start_game
    game_instructions
    initiate_board
    turns
    x = true
    until x == false
      play_game
      turns
    end
    new_game
  end

  def play_game
    made_move = player_move
    place_piece(made_move)
    puts "@w_p #{@white_pieces}"
  end

  def player_move
    show_board_with_numbers
    start_spot = get_start_spot(@current_player)
    stop_spot = get_stop_spot(@current_player)
    curr_pie = deter_piece(start_spot)
    check_move = deter_leg_move(start_spot, stop_spot, self, curr_pie)
    puts "check_move #{check_move}"
    move_info = [start_spot, stop_spot, curr_pie]
    return move_info if check_move == true
    (try_again; player_move) if check_move == false
  end

  def deter_leg_move(start_spot, stop_spot, obj, piece)
    puts "current_player -- #{@current_player}"
    return false if piece == nil
    return false if @current_player != piece.player 
    piece.deter_piece_check(start_spot, stop_spot, obj, piece)
  end

  def place_piece(move_info)
    move_info[2].start_pos = move_info[1]
    @board[move_info[1][0]][move_info[1][1]] = move_info[2].symbol
    @board[move_info[0][0]][move_info[0][1]] = "\u25AA"
    remove_piece(move_info[1])
  end

  def remove_piece(stop_spot)
    @current_player == @player_one ? remove_arr = @white_pieces : remove_arr = @black_pieces
    elim_piece(remove_arr, stop_spot)
  end

  def elim_piece(pieces_arr, spot)
    pieces_arr.each do |n|
      n.find do |pie|
        n.delete(pie) if pie.start_pos == spot
      end
    end
  end


end

GameBoard.new.start_game





#my_board.play_game