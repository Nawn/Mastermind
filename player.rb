require_relative 'board'
class Player
  def generate_code
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Okay Code Maker, Please enter board's answer. Example: (#{Board.example})"
    answer = gets.chomp 
    exit if answer.downcase == "exit"
    clean(answer) #clean player input into acceptable Array
  end
  
  def turn
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Please enter a 4 color/letter guess. Example: (#{Board.example})"
    answer = gets.chomp 
    exit if answer.downcase == "exit"
    clean(answer) #Clean to acceptable
  end
  
  private
  def clean(input_string)
    answer_array = input_string.split("") #split into an array of characters
    answer_array.delete(" ") #get rid of the spaces
    answer_array.each_with_index do |color, index|
      answer_array[index] = color.upcase #capitalize to make sure it's fine
    end
  end
end