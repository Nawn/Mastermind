require_relative 'board'
class Player
  def generate_code
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Okay Code Maker, Please enter board's answer. Example: (Bl G Br O)"
    answer = gets.chomp
    answer.split(" ")
  end
  
  def turn
    puts "Colors/Letters to choose from: #{Board.colors_available.join(", ")}"
    puts "Please enter a 4 color/letter guess. Example: (Bl G Br O)"
    answer = gets.chomp
    answer.split(" ")
  end
end