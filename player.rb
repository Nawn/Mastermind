require_relative 'board'
class Player
  def generate_code
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Okay Code Maker, Please enter board's answer. Example: (#{Board.example})"
    answer = gets.chomp
    exit if answer.downcase == "exit"
    answer_array = answer.split("")
    answer_array.delete(" ")
    answer_array.each_with_index do |color, index|
      answer_array[index] = color.upcase
    end
    end
  
  def turn
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Please enter a 4 color/letter guess. Example: (#{Board.example})"
    answer = gets.chomp
    exit if answer.downcase == "exit"
    answer_array = answer.split("")
    answer_array.delete(" ")
    answer_array.each_with_index do |color, index|
      answer_array[index] = color.upcase
    end
  end
end