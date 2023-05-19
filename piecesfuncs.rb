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

  def assign_vars(pos, color, init_obj)
    init_obj.start_pos = pos
    init_obj.white_piece = color
    init_obj.symbol = deter_gm_piece(init_obj.white_piece, init_obj.symbol)
    init_obj
  end

end