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
    puts "#{player.name}, please select the col of the piece you would like to move."
    col = gets.chomp.to_i
    check_input = check_user_input(row, col)
    row -= 1
    col -= 1
    return [row, col] if check_input == true
    (try_again; get_start_spot(player)) if check_input == false
  end

  def get_stop_spot(player)
    puts "#{player.name}, please select the row you would like to move your piece to."
    row = gets.chomp.to_i
    puts "#{player.name}, please select the col you would like to move your piece to."
    col = gets.chomp.to_i
    check_input = check_user_input(row, col)
    row -= 1
    col -= 1
    #puts "--------------------------------------------------------------------------"
    return [row, col] if check_input == true
    (try_again; get_stop_spot(player)) if check_input == false
  end

  def check_user_input(row, col)
    # user_input = [row, column]
    # return false if row =~ /\D/ || col =~ /\D/
    return false if row == '' || col == ''
    return false if row.between?(1, 8) == false || col.between?(1, 8) == false
    true
  end

end


