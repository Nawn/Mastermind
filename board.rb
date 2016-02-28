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
      raise(ArgumentError, "incorrect input".upcase) unless input_array.is_a? Array
      raise(ArgumentError, "incorrect number of colors".upcase) unless input_array.size == 4
      raise(ArgumentError, "color does not exist".upcase) unless input_array.all? {|color| Board.check_color_exist?(color)}
    end
  end
  @colors_available = ["Y", "G", "B", "O", "M", "W", "P", "R"]
  @example = @colors_available[0..3].join("")
  
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
    temp_row = Row.new(input_array) #Create Row struct with player's input
    temp_row.result = check_match(input_array) #Review the input and add Array of results (Xs or Os)
    @rows << temp_row #Add the last input, and result to the Board.
  end
  
  def build
    puts "In Result: X means a color matches exactly, o means that a color matches but in wrong slot"
    Terminal::Table.new :headings => ["Code", "Result"], :rows => @rows 
  end
  
  private
  def check_match(input_array)
    temp = input_array.clone
    temp_answer = @answer.clone
    result = []
    temp.each_with_index do |color, index|
      next if color.nil? #If it runs into an empty slow, skip this iteration
      
      if temp[index] == temp_answer[index] #if they match in the perfect slot
        result << "X" #add an X to the result
        temp[index] = nil #Set both to Nil so they don't match AGAIN
        temp_answer[index] = nil
      end
    end
    
    temp.each_with_index do |color, index|
      next if color.nil? #skip if empty
      
      temp_answer.each_with_index do |answer_color, answer_index|
        next if color.nil? #skip again if nil
        
        if color == answer_color #if the color at one point, matches another color in the arrays
          result << "o" #add an O to result 
          temp[index] = nil #set both to Nil so they don't match again
          temp_answer[answer_index] = nil
        end
      end
    end
    
    result #return the result (array of Xs and Os)
  end
end