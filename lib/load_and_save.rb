module LoadAndSave
  def display_saved_games
    Dir.glob('saved_games/*').map do |file|
      file.delete_prefix('saved_games/').delete_suffix('.yaml')
    end
  end

  def save_game
    ask_save
    response = gets.chomp
    return unless %w[Y y].include?(response)

    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    yaml = serialize
    save_name
    filename = gets.chomp
    File.open("saved_games/#{filename}.yaml", 'w') do |file|
      file.write(yaml)
    end

    exit_prompt
    response = gets.chomp
    exit if response == 'exit'
  end

  def load_game(filename)
    game_file = File.open("saved_games/#{filename}.yaml", 'r') do |file|
      YAML.load(file.read)
    end
    game_file.each_key do |key|
      instance_variable_set(key, game_file[key])
    end
  end

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    YAML.dump(obj)
  end
end
