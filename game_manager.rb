require_relative 'board'
require_relative 'player'
require_relative 'artificial'

class GameManager
  attr_accessor :board, :players
    
  def initialize(input_symbol=:code_breaker)
    raise(ArgumentError, "wrong input") unless (input_symbol == :code_breaker || input_symbol == :code_maker)
    @board = Board.new
    @players = {:code_maker => Artificial.new, :code_breaker => Player.new} if input_symbol == :code_breaker #player will be code_breaker.
    @players = {:code_maker => Player.new, :code_breaker => Artificial.new} if input_symbol == :code_maker #player will be code_maker
  end
  
  def take_turn (input_array)
    Board.check_valid_code(input_array) #makes sure it's acceptable
    @board.add_row(input_array) #adds the row to the board
  end
  
  def set_board_answer(input_array)
    Board.check_valid_code(input_array) #acceptable check
    @board.set_answer(input_array) #sets as the board's answer.
  end
  
  def check_over
    @board.rows.size >= @board.attempts_allowed || check_victory #turns whether it's out of room, or if someone has won
  end
  
  def check_victory
    return false if @board.rows[-1].nil? #if the last one is nil
    @board.rows[-1].result == %w(X X X X) #if the last row's result is winning(4 X's)
  end
  
  def display
    puts @board.build #returns a Table.
  end
  
  def turn_announce
    "Turn #{@board.rows.size + 1} of #{@board.attempts_allowed}"
    @players[:code_breaker].rows = @board.rows.clone if @players[:code_breaker].is_a? Artificial #will send the Artificial a copy of the board's rows
  end
end