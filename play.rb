require_relative 'specs/spec_helper'

done_playing = false

until done_playing do
  menu_select = true
  
  while menu_select
    puts "Hello! Thanks for playing Mastermind! Will you be the: \n1.Code Breaker\n2.Code Maker\n enter 'exit' to close at any time"
    answer = gets.chomp

    if answer.to_i == 1
      game = GameManager.new(:code_breaker)
      menu_select = false
    elsif answer.downcase == "exit"
      exit
    else
      puts " "
      puts "Not implemented yet, only option available is 1"
      puts "returning to menu"
    end
  end
  
	game.set_board_answer(game.players[:code_maker].generate_code()) 
  
	until game.check_over do
		puts game.turn_announce 
    begin
      game.display()
      game.take_turn(game.players[:code_breaker].turn) 
    rescue 
      puts "Error: incorrect input"
      retry 
    end
  end
  
	puts game.check_victory ? game.display + "\n You win!" : "You Lose!"
	
	puts "Again!? (Anything for yes, N for No)"
  menu_select = true
  reply = gets.chomp
	done_playing = true if reply.downcase == "no" || reply.downcase == "n"
end