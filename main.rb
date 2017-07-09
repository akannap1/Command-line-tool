require 'pry'
require 'json'

Dir["#{Dir.pwd}/lib/*.rb"].each {|w|  require w}

class Main
  extend SearchClient 

  class << self
  def run
    loop do
      execute_action
    end
  end

  private

  def execute_action
    puts UserPrompt::WELCOME_MESSAGE
    action_type = gets.chomp

    case action_type
    when '1'
      search
    when '2'
      view_fields
    when 'quit'
      puts UserPrompt::EXIT_MESSAGE
      exit
    else
      puts UserPrompt::INVALID_MESSAGE
    end
    rescue => error
      puts error
    end
  end
end


Main.run
