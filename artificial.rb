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
    code = []
    
    unless @rows.empty?
      if (@rows.last.result.size - @base_num) > 0 #If there is a new color match here
        (@rows.last.result.size - @base_num).times do #Add the color id to the found array
          @found << @test - 1 unless @found.size == 4
        end
      end
    end

    if @base_num > 0 #Reset the Base_num 
      @base = @test #test the next as base
      @base_num = 0
    end
    
    @base_num = @rows.last.result.size unless (@rows.empty? || @test == @base || !@rows.last.code.all? {|color| @rows.last.code[0] == color})
    #^Set the base number as the last one's result
    #leave it at 0 if the last code was a base test or if this one is a base test
    unless @found.size >= 4
      puts "TESTING TO FIND COLORS"
      2.times do
        code << Board.colors_available[@base]
      end
      
      2.times do
        code << Board.colors_available[@test]
      end #Keep testing until we found all 4 colors
    else
      puts "DID NOT FINISH, STUPID AI SIMPLY RANDOMIZES AND HOPES FOR THE BEST"
      @found.shuffle.each do |color_id|
        code << Board.colors_available[color_id]
      end
    end
    @test += 1
    
    code
  end
end