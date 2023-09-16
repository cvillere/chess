# frozen_string_literal: true
require 'yaml'

require_relative 'gamepieces'
require_relative 'player'
require_relative 'piecesfuncs'
require_relative 'displayinstructions'
require_relative 'deter_check'
require_relative 'game_save'

# board class for chess game
class GameBoard

  include GamePieces
  include PiecesFuncs
  include DisplayInstructions
  include DeterCheck
  include GameSave

  attr_accessor :board, :player_one, :player_two, :black_pieces, :white_pieces, :current_player,
                :turn_count

  def initialize
    @board = Array.new(8) { Array.new(8, "\u25AA") }
    @player_one = player_one
    @player_two = player_two
    @black_pieces = b_pieces
    @white_pieces = w_pieces
    @current_player = nil
    @turn_count = 0
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
    # gets.chomp
    name = gets.chomp
    return name if player_name_check(name) == true
    get_player_name(player_num) if player_name_check(name) == false
  end

  def player_name_check(name)
    return false if name.nil?
    return false if name == ''
    true
  end

  def make_all_piec_arr
    all_pieces = []
    @black_pieces.each do |n|
      all_pieces.push(n)
    end
    @white_pieces.each do |n|
      all_pieces.push(n)
    end
    all_pieces
  end

  def deter_piece(start_spot)
    my_pieces = make_all_piec_arr
    my_pieces.each do |n|
      n.find { |pie| return pie if pie.start_pos == start_spot }
    end
    nil
  end

  def initiate_deser_game
    previous_game = choose_previous_game
    return if previous_game.nil?
    @board = previous_game.board
    @player_one = previous_game.player_one
    @player_two = previous_game.player_two
    @black_pieces = previous_game.black_pieces
    @white_pieces = previous_game.white_pieces
    @current_player = previous_game.current_player
    @turn_count = previous_game.turn_count
    previous_game
  end

  def initiate_game
    game_instructions
    # return choose_previous_game.show_board_with_numbers if !choose_previous_game.nil?
    previous_game = initiate_deser_game
    puts "previous_game #{previous_game}"
    return previous_game.start_game if previous_game != nil
    initiate_board
    turns
  end

  def game_save
    save_game if (@turn_count % 5).zero?
  end

  def start_game
    initiate_game if @current_player.nil?
    until deter_checkmate(find_legal_moves) == true
      puts "#{@current_player.name}, you are in check!" if deter_check(deter_king_piece.start_pos) == true #3
      play_game
      turns
      @turn_count += 1
      game_save
    end
    new_game
  end

  def play_game
    made_move = player_move
    place_piece(made_move)
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
    return false if piece.nil?
    return false if @current_player != piece.player
    # puts "deter_check #{deter_check(stop_spot)}" # 1
    # return false if piece.is_a?(GamePieces::King) && deter_check(stop_spot) == true #2
    # need another check for if moving another piece puts you in check
    # return false if deter_check(deter_king_piece.start_pos) == true
    # piece.deter_piece_check(start_spot, stop_spot, obj, piece)
    deter_check_status(start_spot, stop_spot, obj, piece)
  end

  def deter_check_status(start_spot, stop_spot, obj, piece)
    legal_pie_move = piece.deter_piece_check(start_spot, stop_spot, obj, piece)
    return false if legal_pie_move == false
    piece.start_pos = stop_spot
    return false if check_same_color(stop_spot) == false
    check_status = deter_check(deter_king_piece.start_pos)
    if check_status == true
      piece.start_pos = start_spot
      return false
    end
    true
  end

  def check_same_color(end_pos)
    @current_player == @player_one ? pieces = @black_pieces : pieces = @white_pieces
    all_pieces = pieces.flatten
    count = 0
    all_pieces.each do |r|
      count += 1 if r.start_pos == end_pos
    end
    return false if count >= 2
    true
  end


  def place_piece(move_info)
    puts "line 142 - move_info #{move_info}"
    # move_info[2].start_pos = move_info[1] -- No longer needed due to reconfiguring to check check
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
  
  def deter_king_piece
    # puts "black_pieces - #{@black_pieces}"
    # puts "white_pieces - #{@white_pieces}"
    @current_player == @player_one ? my_pieces = @black_pieces : my_pieces = @white_pieces
    my_pieces.each do |n|
      n.find { |pie| return pie if pie.is_a? GamePieces::King }
    end
    nil
  end

  def find_potent_legals(piece)
    potent_legal_posits = []
    MoveChecks::KING_MOVES.each do |n|
      puts "n - #{n}"
      puts "piece #{piece}"
      puts "piece.start_pos #{piece.start_pos}"
      puts "piece.symbol #{piece.symbol}"
      puts "piece.black_piece #{piece.black_piece}"
      legal_row = n[0] + piece.start_pos[0]
      legal_col = n[1] + piece.start_pos[1]
      potent_legal_posits.push([legal_row, legal_col]) if (0..7).include?(legal_row) && (0..7).include?(legal_col)
    end
    potent_legal_posits
  end

  def find_legal_moves
    piece = deter_king_piece
    puts "king_piece #{piece}"
    legal_king_moves = []
    potent_moves = find_potent_legals(piece)
    puts "potent_moves #{potent_moves}"
    potent_moves.each do |n|
      if piece.check_king_poss_moves(piece.start_pos, n, self, piece) == true
        legal_king_moves.push(n)
      end
    end
    legal_king_moves.push(piece.start_pos)
    legal_king_moves
  end

  def push_king_pos(king_posit)
    king_pos = []
    king_pos.push(king_posit)
    king_pos
  end

  def deter_potent_checkmate(legal_moves)
    @current_player == @player_one ? other_player_p = @white_pieces : other_player_p = @black_pieces
    game_deter_arr = []
    other_player_p_1d = other_player_p.flatten
    legal_moves.each do |n|
      puts "line 202 legal_moves #{legal_moves}"
      posit_deter = []
      other_player_p_1d.each do |r|
        #puts "pr.sp - #{pr.start_pos}, n - #{n}, self - #{self}, pr - #{pr}"
        posit_deter.push(r.deter_piece_check(r.start_pos, n, self, r))
      end
      posit_deter.include?(true) ? game_deter_arr.push(true) : game_deter_arr.push(false)
      # puts "line 218 posit_deter #{posit_deter}"
    end
    puts "line 239 game_deter_arr #{game_deter_arr}"
    game_deter_arr
  end

  def deter_checkmate(spots)
    @current_player == @player_two ? win_player = @player_one : win_player = @player_two
    @current_player == @player_two ? los_player = @player_two : los_player = @player_one
    outcome_arr = deter_potent_checkmate(spots)
    if outcome_arr.all? { |n| n == true } 
      puts "#{win_player.name}, you have put #{los_player.name} into checkmate and have won the game!"
      return true
    end
    false
  end

  def deter_check(spot)
    # king_piece = deter_king_piece
    test_spot = push_king_pos(spot)
    outcome_arr = deter_potent_checkmate(test_spot)
    puts "line 225 outcome_arr #{outcome_arr}"
    return true if outcome_arr.any? { |n| n == true }
    false
  end

  def new_game
    puts 'Would you like to play another game? 1 for yes. 2 for no.'
    game_reply = gets.chomp
    return if game_reply != "1"
    GameBoard.new.start_game
  end
  
end

GameBoard.new.start_game





#my_board.play_game