require_relative 'board'
require_relative 'player'
require_relative 'artificial'

class GameManager
  attr_accessor :board, :players
    
  def initialize(input_symbol=:code_breaker)
    raise(ArgumentError, "wrong input") unless (input_symbol == :code_breaker || input_symbol == :code_maker)
    @board = Board.new
    @players = {:code_maker => Artificial.new, :code_breaker => Player.new} if input_symbol == :code_breaker
    @players = {:code_maker => Player.new, :code_breaker => Artificial.new} if input_symbol == :code_maker
  end
  
  def take_turn
    puts "caca"
  end
  
  def set_board_answer(input_array)
    Board.check_valid_code(input_array)
  end
end