require 'terminal-table'
require_relative 'row'
class Board
  attr_reader :rows
  attr_reader :attempts_allowed
  attr_reader :answer
  class << self
    attr_accessor :colors_available, :example
   
    def check_color_exist?(input_color)
      Board.colors_available.any? do |existing_color|
        input_color.downcase ==  existing_color.downcase
      end
    end
    
    def check_valid_code(input_array)
      raise(ArgumentError, "incorrect input") unless input_array.is_a? Array
      raise(ArgumentError, "incorrect number of colors") unless input_array.size == 4
      raise(ArgumentError, "color does not exist") unless input_array.all? {|color| Board.check_color_exist?(color)}
    end
  end
  @colors_available = ["Y", "G", "B", "O", "M", "W", "P", "R"]
  @example = @colors_available[0..3].join(" ")
  
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
  
  def add_row(input_array)
    temp_row = Row.new(input_array)
    temp_row.result = check_match(input_array)
    @rows << temp_row
  end
  
  def build
    Terminal::Table.new :rows => @rows
  end
  
  private
  def check_match(input_array)
    temp = input_array.clone
    temp_answer = @answer.clone
    result = []
    temp.each_with_index do |color, index|
      next if color.nil?
      
      if temp[index] == temp_answer[index]
        result << "X" 
        temp[index] = nil
        temp_answer[index] = nil
      end
    end
    
    temp.each_with_index do |color, index|
      next if color.nil?
      
      temp_answer.each_with_index do |answer_color, answer_index|
        next if color.nil?
        
        if color == answer_color
          result << "o"
          temp[index] = nil
          temp_answer[answer_index] = nil
        end
      end
    end
    
    result
  end
end