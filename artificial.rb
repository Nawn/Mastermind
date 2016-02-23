require_relative 'board.rb'
class Artificial < Player
  def generate_code
    code = []
    4.times do
      code << Board.colors_available[rand(0..7)]
    end
    code
  end
end