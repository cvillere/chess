# frozen_string_literal: true

# Addl functions for pieces
module PiecesFuncs

  def add_player_to_piece(pieces_arr, player)
    pieces_arr.each do |item|
      item.each do |i|
        i.player = player
      end
    end
  end

  def assign_vars(color, init_obj)
    init_obj.white_piece = color
    init_obj.symbol = deter_gm_piece(init_obj.white_piece, init_obj.symbol)
    init_obj
  end

  def pick_move_val_meth(obj_name, start_pos, stop_pos)
    check_pawn_move_validity(start_pos, stop_pos) if obj_name.class.name == "Pawn"
  end

  def check_pawn_move_validity(start_pos, stop_pos)
    return false if (start_pos[0] - stop_pos[0]).abs > 1 || (start_pos[1] - stop_pos[1]).abs > 1

    return false if (start_pos[0] - stop_pos[0]).abs.zero? && (start_pos[1] - stop_pos[1]).abs >= 1

    true
  end



end