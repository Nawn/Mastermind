require 'terminal-table'
class Board
  attr_reader :rows
  attr_reader :attempts_allowed
  attr_reader :answer
  class << self
    attr_accessor :colors_available
    def check_color_exist?(input_color)
      Board.colors_available.any? do |existing_color|
        input_color.downcase ==  existing_color.downcase
      end
    end
    
    def check_valid_code(input_array)
      raise(ArgumentError, "incorrect input") unless input_array.is_a? Array
      raise(ArgumentError, "incorrect number of colors") unless input_array.size == 4
      raise(StandardError, "color does not exist") unless input_array.all? {|color| Board.check_color_exist?(color)}
    end
  end
  @colors_available = ["Bl", "G", "Br", "O", "M", "W", "P", "R"]
  
  def initialize (attempts=12)
    raise(ArgumentError, "incorrect input to initialize board") unless attempts.is_a? Integer
    @attempts_allowed = attempts
    @rows = []
    @answer = []
  end
  
  def set_answer (input_array)
    Board.check_valid_code(input_array)    
    @answer = input_array
  end
  
  def build
    Terminal::Table.new :rows => @rows
  end
end