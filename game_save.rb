module GameSave

  # method to prompt user if they want to save game
  def save_game
    puts 'Enter 1 to save game & 2 to continue playing'
    game_save_resp = gets.chomp
    if game_save_resp == '1'
      serialize_game
      puts "game saved!!"
    elsif game_save_resp == '2'
      return
    else
      puts 'Incorrect response.'
      save_game
    end
  end

  # method to save a game to a directly
  def serialize_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    puts 'Name of saved game?'
    saved_name = gets.chomp
    saved_file = "saved_games/game_#{saved_name}.yaml"
    File.open(saved_file, 'w') { |f| YAML.dump([] << self, f) }
  end

  # method to deserialize a game
  def deserialize_game(selection)
    restarted_game = Dir['./saved_games/*'][selection]
    while Dir['./saved_games/*'].include?(restarted_game) == false
      puts 'That saved game does not exist. Please try another entry.'
      player_selection = gets.chomp
      restarted_game = Dir['./saved_games/*'][player_selection]
    end
    old_game = File.open(restarted_game, 'r') { YAML.load_file(restarted_game.to_s) }
    # old_game[0].display_correct_letters
    p "old_game - #{old_game}"
    p "old_game[0] - #{old_game[0]}"
    old_game[0]
  end

  # Selecting a saved game to resume
  def choose_deser_game
    (Dir['./saved_games/*']).each_with_index { |h, i| puts "Game Number(#{i + 1}) -- #{h}" }
    puts 'Select Game Number.'
    game_num = gets.chomp.to_i
    selected_game = game_num - 1
    return deserialize_game(selected_game) if game_num.between?(1, Dir['./saved_games/*'].length)
    puts 'invalid selection' unless game_num.between?(1, Dir['./saved_games/*'].length)
    choose_deser_game
  end

  # method to prompt user whether they would like to resume a saved game
  def choose_previous_game
    # unless Dir.exist?('./saved_games')
    return unless Dir.exist?('./saved_games')
    puts 'Would you like to restart a game? Enter 1 for yes and 2 for no'
    user_choice = gets.chomp
    if user_choice == '1'
      choose_deser_game
    else
      return
    end
  end

end