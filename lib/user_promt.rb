class UserPrompt
  WELCOME_MESSAGE = "Welcome To Zendesk Search\n" \
					  "\tSelect Search Options\n" \
					  "\t* Press 1 to search \n" \
					  "\t* Press 2 to view a list of searchable fields\n" \
					  "\t* Type quit to exit".freeze
  ENTITY_FILE_PATHS = Dir["#{Dir.pwd}/json_data/*.json"]
  EXIT_MESSAGE = 'See you later...'.freeze
  INVALID_MESSAGE = 'Invalid Option, Please choose right option and try again ...'.freeze
  FIELD_NOT_FOUND = 'Field Doesnt Exist For The Entity'.freeze
  ENTITY_NOT_FOUND = 'Please select a valid entity'.freeze
  RESULTS_NOT_FOUND = 'Results not Found ...'.freeze

  def self.print_list_of_entities
    print 'Select'
    ENTITY_FILE_PATHS.each_with_index do |e, i|
      print " #{i + 1}. #{File.basename(e, '.json').capitalize}"
    end

    puts
  end

  def self.pretty_print(list_of_results)
    raise RESULTS_NOT_FOUND if list_of_results.empty?
    list_of_results.each do |element|
      puts '*' * 40
      element.each { |k, v| printf("%-30s %s\n", k, v) }
      puts '*' * 40
    end
  end
end
