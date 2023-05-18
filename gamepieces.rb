# frozen_string_literal: true

module GamePieces

  PIECES = [Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new,
     Knight.new, Rook.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, 
     Pawn.new, Pawn.new, Pawn.new]

  
  # king piece class
  class King

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2654" : "\u265A"
      @white_piece = nil
      @check = nil
      @check_mate = nil
    end
  end

  # queen piece class
  class Queen

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2655" : "\u265B"
      @white_piece = nil
    end
  end

  # rook piece class
  class Rook

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2656" : "\u265C"
      @white_piece = nil
    end
    
  end

  # knight piece class
  class Knight

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2658" : "\u265E"
      @white_piece = nil
    end
  end

  # bishop piece class
  class Bishop

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate

    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2657" : "\u265D"
      @white_piece = nil
    end

  end

  # pawn piece class
  class Pawn

    attr_accessor :start_pos, :end_pos, :symbol, :white_piece, :check, :check_mate
    
    def initialize
      @start_pos = start_pos
      @end_pos = end_pos
      @symbol = @white_piece ? "\u2659" : "\u265F"
      @white_piece = nil
    end

  end   
end