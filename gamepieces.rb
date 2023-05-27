# frozen_string_literal: true

module GamePieces

  def deter_gm_piece(pred, sym_arr)
    pred ? sym_arr[0] : sym_arr[1]
  end

  # king piece class
  class King

    attr_accessor :start_pos, :end_pos, :symbol, :pos, 
                  :white_piece, :player, :check,:check_mate

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2654", "\u265A"]
      @pos = [0, 7]
      @white_piece = white_piece
      @player = player
      @check = nil
      @check_mate = nil
    end
  end

  # queen piece class
  class Queen

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2655", "\u265B"]
      @pos = [0, 7]
      @white_piece = white_piece
      @player = player
    end
  end

  # rook piece class
  class Rook

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2656", "\u265C"]
      @pos = [0, 7]
      @white_piece = white_piece
      @player = player
    end
    
  end

  # knight piece class
  class Knight

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :white_piece
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2658", "\u265E"]
      @pos = [0, 7]
      @white_piece = white_piece
      @player = player
    end
  end

  # bishop piece class
  class Bishop

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2657", "\u265D"]
      @pos = [0, 7]
      @white_piece = white_piece
      @player = player
    end

  end

  # pawn piece class
  class Pawn

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :white_piece
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2659", "\u265F"]
      @pos = [1, 6]
      @white_piece = white_piece
      @player = player
    end

    def check_move_validity(start_pos, stop_pos)
      return false if (start_pos[0] - stop_pos[0]).abs > 1 || (start_pos[1] - stop_pos[1]).abs > 1

      return false if (start_pos[0] - stop_pos[0]).abs.zero? && (start_pos[1] - stop_pos[1]).abs >= 1

      true
    end


  end

  WHITE_PIECES = [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
    Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
    Pawn.new, Pawn.new, Pawn.new]]

  BLACK_PIECES = [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
    Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
    Pawn.new, Pawn.new, Pawn.new]]

end