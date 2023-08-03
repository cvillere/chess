# frozen_string_literal: true

require_relative 'move_checks'

module GamePieces

  def deter_gm_piece(pred, sym_arr)
    pred ? sym_arr[0] : sym_arr[1]
  end

  # king piece class
  class King

    include MoveChecks
    include DeterCheck

    attr_accessor :start_pos, :end_pos, :symbol, :pos,
                  :black_piece, :player, :check, :check_mate

    def initialize
      @start_pos = start_pos
      @symbol = ["\u265A", "\u2654"]
      @pos = [0, 7]
      @black_piece = black_piece
      @player = player
      @check = nil
      @check_mate = nil
    end
  end

  # queen piece class
  class Queen

    include MoveChecks

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :black_piece

    def initialize
      @start_pos = start_pos
      @symbol = ["\u265B", "\u2655"]
      @pos = [0, 7]
      @black_piece = black_piece
      @player = player
    end
  end

  # rook piece class
  class Rook

    include MoveChecks

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :black_piece

    def initialize
      @start_pos = start_pos
      @symbol = ["\u265C", "\u2656"]
      @pos = [0, 7]
      @black_piece = black_piece
      @player = player
    end
    
  end

  # knight piece class
  class Knight

    include MoveChecks

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :black_piece
    
    def initialize
      @start_pos = start_pos
      @symbol = ["\u265E", "\u2658"]
      @pos = [0, 7]
      @black_piece = black_piece
      @player = player
    end
  end

  # bishop piece class
  class Bishop

    include MoveChecks

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :black_piece

    def initialize
      @start_pos = start_pos
      @symbol = ["\u265D", "\u2657"]
      @pos = [0, 7]
      @black_piece = black_piece
      @player = player
    end

  end

  # pawn piece class
  class Pawn

    include MoveChecks

    attr_accessor :start_pos, :end_pos, :symbol, :pos, :player, :black_piece,
                  :queen_mode, :num_of_turns
    
    def initialize
      @start_pos = start_pos
      @num_of_turns = 0
      @symbol = ["\u265F", "\u2659"]
      @pos = [1, 6]
      @black_piece = black_piece
      @player = player
      @queen_mode = false
    end
    
  end

end