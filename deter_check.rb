# methods to determine board positions where a king is vulnerable to being in check
module DeterCheck

  def deter_check_pieces(start_spot)
    @current_player == @player_one ? my_pieces = @white_pieces : my_pieces = @black_pieces
    my_pieces.each do |n|
      n.find { |pie| return pie if pie.start_pos == start_spot }
    end
    nil
  end
  
  
  def check_king_color(start_pos, end_pos, obj)
    return true if obj.deter_check_pieces(end_pos) == nil
    if obj.deter_check_pieces(start_pos).black_piece == obj.deter_check_pieces(end_pos).black_piece
      false
    else
      true
    end
  end
  
  
  def check_king_poss_moves(start_pos, end_pos, obj, piece)
    return false if (start_pos[0] - end_pos[0] == 0 && start_pos[1] - end_pos[1] == 0)
    return false if ((start_pos[0] - end_pos[0]).abs > 1 || (start_pos[1] - end_pos[1]).abs > 1)
    return false if check_king_color(start_pos, end_pos, obj) == false
    # puts "c_s_c #{check_same_color(start_pos, end_pos, obj)}"
    true
  end
  
end