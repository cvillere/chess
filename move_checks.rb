# frozen_string_literal: true

# module to hold methods checking validity of game moves
module MoveChecks

  KNIGHT_MOVES = [[2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2], [-2, -1], [-2, 1]].freeze
  BISHOP_PATHS = [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze
  ROOK_MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze
  QUEEN_MOVES = [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def deter_piece_check(start_pos, end_pos, obj, piece)
    return check_back_row(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Pawn
    return check_knight_move(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Knight
    return check_bishop_move(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Bishop
    return check_rook_move(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Rook
    return check_queen_move(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Queen
  end

  def check_back_row(start_pos, end_pos, obj, piece)
    return true if piece.queen_mode == true
    return false if pawn_move_checks(start_pos, end_pos, obj, piece) == false
    if (end_pos[0] == 0 || end_pos[0] == 7) && piece.queen_mode == false
      piece.queen_mode = true
    end
    true
  end

  def first_pawn_move_check(start_pos, end_pos, obj, piece)
    if piece.num_of_turns == 0 && ((start_pos[0] - end_pos[0]).abs <= 2) && obj.board[end_pos[0]][end_pos[1]] == "\u25AA" && (start_pos[1] - end_pos[1]) == 0
      piece.num_of_turns += 1
      return true
    end
  end

  def check_norm_move(start_pos, end_pos, obj)
    return false if (start_pos[0] - end_pos[0]) == 0
    return false if (start_pos[0] - end_pos[0]) > 1
    return false if (start_pos[0] - end_pos[0]) < -1
    return false if obj.board[start_pos[0]][start_pos[1]] == "\u25AA"
    return false if obj.board[end_pos[0]][end_pos[1]] != "\u25AA"
  end

  def taking_piece(start_pos, end_pos, obj)
    return false if (start_pos[1] - end_pos[1]).abs > 1
    return false if (start_pos[1] - end_pos[1]).abs == 1 && obj.board[end_pos[0]][end_pos[1]] == "\u25AA"
  end

  def pawn_move_checks(start_pos, end_pos, obj, piece)
    return true if first_pawn_move_check(start_pos, end_pos, obj, piece) == true
    return false if check_norm_move(start_pos, end_pos, obj) == false
    return false if taking_piece(start_pos, end_pos, obj) == false
  end

  def check_knight_move(start_pos, end_pos, _obj, _piece)
    knight_move = [start_pos[0] - end_pos[0], start_pos[1] - end_pos[1]]
    MoveChecks::KNIGHT_MOVES.find { |n| return true if n == knight_move }
    false
  end

  def check_bishop_move(start_pos, end_pos, obj, _piece)
    return false if (start_pos[0] - end_pos[0] == 0 || start_pos[1] - end_pos[1] == 0)
    if patt_finder(start_pos, end_pos, MoveChecks::BISHOP_PATHS) == false
      return false
    else
      return check_pieces_between(start_pos, end_pos, obj, patt_finder(start_pos, end_pos, MoveChecks::BISHOP_PATHS))
    end
  end

  def check_rook_move(start_pos, end_pos, obj, _piece)
    return false if (start_pos[0] - end_pos[0] == 0 && start_pos[1] - end_pos[1] == 0)
    if patt_finder(start_pos, end_pos, MoveChecks::ROOK_MOVES) == false
      return false
    else
      return check_pieces_between(start_pos, end_pos, obj, patt_finder(start_pos, end_pos, MoveChecks::ROOK_MOVES))
    end
  end

  def check_queen_move(start_pos, end_pos, obj, _piece)
    return false if (start_pos[0] - end_pos[0] == 0 && start_pos[1] - end_pos[1] == 0)
    if patt_finder(start_pos, end_pos, MoveChecks::QUEEN_MOVES) == false
      return false
    else
      return check_pieces_between(start_pos, end_pos, obj, patt_finder(start_pos, end_pos, MoveChecks::QUEEN_MOVES))
    end
  end

  def patt_finder(start_pos, end_pos, patt)
    patt.each do |n|
      new_row_pos = start_pos[0]
      new_col_pos = start_pos[1]
      7.times do 
        new_row_pos += n[0]
        new_col_pos += n[1]
        return n if [new_row_pos, new_col_pos] == [end_pos[0], end_pos[1]]
      end
    end
    return false
  end

  def check_pieces_between(start_pos, end_pos, obj, patt)
    loop_val = (start_pos[0] - end_pos[0]).abs - 1
    new_row_pos = start_pos[0]
    new_col_pos = start_pos[1]
    loop_val.times do
      new_row_pos += patt[0]
      new_col_pos += patt[1]
      return false if obj.board[new_row_pos][new_col_pos] != "\u25AA"
    end
    true
  end

end
