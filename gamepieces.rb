# frozen_string_literal: true

module GamePieces

  def deter_gm_piece(pred, sym_arr)
    pred ? sym_arr[0] : sym_arr[1]
  end

  # king piece class
  class King

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2654", "\u265A"]
      @white_piece = white_piece
      @check = nil
      @check_mate = nil
    end
  end

  # queen piece class
  class Queen

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2655", "\u265B"]
      @white_piece = white_piece
    end
  end

  # rook piece class
  class Rook

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2656", "\u265C"]
      @white_piece = white_piece
    end
    
  end

  # knight piece class
  class Knight

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2658", "\u265E"]
      @white_piece = white_piece
    end
  end

  # bishop piece class
  class Bishop

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2657", "\u265D"]
      @white_piece = white_piece
    end

  end

  # pawn piece class
  class Pawn

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = ["\u2659", "\u265F"]
      @white_piece = white_piece
    end
  end

  WHITE_PIECES = [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
    Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
    Pawn.new, Pawn.new, Pawn.new]]

  BLACK_PIECES = [[Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
    Knight.new, Rook.new], [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new,
    Pawn.new, Pawn.new, Pawn.new]]

end