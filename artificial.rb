require_relative 'board'
class Artificial < Player
  attr_accessor :rows
  def initialize
    @colors_found = []
    @base = 0
    @test = 0
  end

  def generate_code
    code = []
    4.times do
      code << Board.colors_available[rand(0..7)]
    end
    code
  end
  
  def turn
    code = []
    
    
    unless @colors_found == 4
      2.times do
        code << Board.colors_available[@base]
      end
      
      2.times do
        code << Board.colors_available[@test]
      end
    end
    
    @test += 1
    
    code
  end
end