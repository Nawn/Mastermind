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
    elsif answer.to_i == 2
      game = GameManager.new(:code_maker)
      menu_select = false
    elsif answer.downcase == "exit"
      exit
    else
      puts "INCORRECT OPTION \nReturning to main Menu"
    end
  end
  
	game.set_board_answer(game.players[:code_maker].generate_code()) #Set board answer to an Array, (Which generate_code returns an Array)
  
	until game.check_over do #till this game is over
		puts game.turn_announce #returns string saying the Turn number
    begin
      game.display #Puts a Table
      game.take_turn(game.players[:code_breaker].turn) #Has whoever is set to the Code_breaker return an Array 
    rescue ArgumentError => a
      puts "\nError: #{a}"
      retry 
    end
  end
  
	puts game.check_victory ? "\nYou win!".upcase : "\nYou Lose!".upcase
	game.display
	puts "Again!? (Anything for yes, N for No)"
  menu_select = true
  reply = gets.chomp
	done_playing = true if reply.downcase == "no" || reply.downcase == "n"
end