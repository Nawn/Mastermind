require_relative 'board'
class Artificial < Player
  attr_accessor :rows
  def initialize
    @colors_found = 0
    @found = []
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
    if @base_num > 0
      @base = @test 
      @base_num = 0
    end
    code = []
    
    #@colors_found += (@rows.last.result.size - @base_num) unless @test == 0
    
    unless @test == 0
      if (@rows.last.result.size - @base_num) > 0
        @found << @test - 1
      end
    end
    
    @base_num = @rows.last.result.size unless @rows.empty?
    
    unless @found.size >= 4
      2.times do
        code << Board.colors_available[@base]
      end
      
      2.times do
        code << Board.colors_available[@test]
      end
    else
      
    end
    puts "Current found list: #{@found}"
    puts "Current code #{code}"
    @test += 1
    
    exit if @found.size >= 5
    code
  end
end