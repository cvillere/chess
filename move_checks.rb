# frozen_string_literal: true

# module to hold methods checking validity of game moves
module MoveChecks

  def deter_piece_check(start_pos, end_pos, obj, piece)
    check_back_row(start_pos, end_pos, obj, piece) if piece.is_a? GamePieces::Pawn
  end

  def check_back_row(start_pos, end_pos, obj, piece)
    return true if piece.queen_mode == true
    return false if pawn_move_checks(start_pos, end_pos, obj, piece) == false
    # pawn_move_checks(start_pos, end_pos, obj, piece)
    if (end_pos[0] == 0 || end_pos[0] == 7) && piece.queen_mode == false
      piece.queen_mode = true
    end
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
  end

  def taking_piece(start_pos, end_pos, obj)
    return false if (start_pos[1] - end_pos[1]).abs > 2
    return false if (start_pos[1] - end_pos[1]).abs == 1 && obj.board[end_pos[0]][end_pos[1]] == "\u25AA"
  end

  def pawn_move_checks(start_pos, end_pos, obj, piece)
    return true if first_pawn_move_check(start_pos, end_pos, obj, piece) == true
    return false if check_norm_move(start_pos, end_pos, obj) == false
    return false if taking_piece(start_pos, end_pos, obj) == false

    #true
  end

end
