require_relative 'board'
class Artificial < Player
  attr_accessor :rows
  def initialize
    @colors_found = 0
    @base = 0
    @test = 0
    @base_num = 0
  end

  def generate_code
    code = []
    4.times do
      code << Board.colors_available[rand(0..7)] #pick 4 random colors
    end
    code
  end
  
  def turn
    code = []
    
    @colors_found += (@rows.last.result.size - @base_num) unless @test == 0
    
    @base_num = @rows.first.result.size if @test == 1
    
    unless @colors_found >= 4
      2.times do
        code << Board.colors_available[@base]
      end
      
      2.times do
        code << Board.colors_available[@test]
      end
    end
    
    @test += 1
    
    exit if @colors_found >= 5
    code
  end
end