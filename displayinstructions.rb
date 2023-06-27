# frozen_string_literal: true

# module for showing the game instructions
module DisplayInstructions

  def game_instructions
    puts <<-HEREDOC

    CHESS:
    I'm not explaining the rules of chess here. First to check mate the other
    player's King wins. Google if you don't know what's what.

    HEREDOC

  end

  def try_again
    puts "Your move isn't legal! Try again!"
  end

  def get_start_spot(player)
    puts "#{player.name}, please select the row of the piece you would like to move."
    row = gets.chomp.to_i
    (try_again; get_start_spot(player)) if !(1..8).include?(row)
    #(try_again; get_start_spot) if (row < 1 || row > 8)
    puts "#{player.name}, please select the col of the piece you would like to move."
    col = gets.chomp.to_i
    (try_again; get_start_spot(player)) if !(1..8).include?(col)
    row -= 1
    col -= 1
    [row, col]
  end

  def get_stop_spot(player)
    puts "#{player.name}, please select the row you would like to move your piece to."
    row = gets.chomp.to_i
    (try_again; get_stop_spot(player)) if !(1..8).include?(row)
    puts "#{player.name}, please select the col you would like to move your piece to."
    col = gets.chomp.to_i
    (try_again; get_start_spot(player)) if !(1..8).include?(col)
    row -= 1
    col -= 1
    [row, col]
  end
end

=begin

  def get_player_name(player_num)
    puts "what is player #{player_num}'s name"
    player_name = gets.chomp
  end

  def get_player_sym(player_name)
    puts "#{player_name}, what letter would you like to use?"
    player_sym = gets.chomp.upcase
    player_sym_check(player_name, player_sym)
    player_sym
  end

  def player_sym_check(player_name, player_sym)
    get_player_sym(player_name) if player_sym.length > 1
    get_player_sym(player_name) if player_sym.between?('A', 'Z') == false
  end

  def try_again
    puts "Your move isn't legal! Try again!"
  end

=end
