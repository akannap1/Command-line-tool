module SearchClient
  def setup_action
    UserPrompt.print_list_of_entities
    entity_type = gets.chomp
    file_path = get_entity_file(entity_type.to_i)
    raise UserPrompt::ENTITY_NOT_FOUND unless file_path
    data = JSON.parse File.read(file_path)
    Search.new(data)
  end

  def search
    search_data = setup_action
    puts 'Enter Field name '
    field_name = gets.chomp
    raise UserPrompt::FIELD_NOT_FOUND unless search_data.has_key?(field_name)
    puts 'Please Enter Value '
    value_name = gets.chomp
    list_of_results = search_data.find_all(field_name, value_name)
    UserPrompt.pretty_print(list_of_results)
  end

  def view_fields
    search_data = setup_action
    data = search_data.list_all_fields
    puts 'List Of Fields are ...'
    data.each { |element| puts element }
  end

  def get_entity_file(entity_type_index)
    return unless entity_type_index.between?(1, UserPrompt::ENTITY_FILE_PATHS.length)
    UserPrompt::ENTITY_FILE_PATHS[entity_type_index - 1]
    end
end
