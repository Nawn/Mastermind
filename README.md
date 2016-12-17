# Mastermind
Hello, this is a test of my skills, by creating Mastermind as a command line only game. If you're unfamiliar with Mastermind
It's a board game abour deciphering a 4 Color code combination made up of possible 8 colors.
See more: ([Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game) "Mastermind Wikipedia").)

For this project, I was able to create a functional AI to "Play against". The AI will use an algorithm that I used when learning
how to win that uses information given by the Results, to figure out what colors are in the code, and unfortunately I had to stop there, as I was going to program it to figure out the code, rather than guess it. Oh well. 

##Installation
* Ruby installed
* `gem install terminal-table` For the ASCII board

##Usage
1. Navigate to the directory
2. `ruby play.rb`

Once you've opened the program, the menu will come up asking if you'd like to be the CodeBreaker, or the CodeMaker

* To Select the CodeBreaker, means that the bot will generate a 4 color code, and you'll have to guess it
* To Select the CodeMaker, means that you will decide the 4 color code, and then the bot will try to figure it out.

###CodeBreaker
If you've selected Code breaker, you will be met with a screen such as: 
![Breaker Menu](https://raw.githubusercontent.com/Nawn/Mastermind/master/mastermind-breaker.PNG)
Here it will simply be a matter of guessing until you've either run out of turns or guess correctly and win
![Breaker Win](https://raw.githubusercontent.com/Nawn/Mastermind/master/mastermind-breaker-win.PNG)

###CodeMaker
If you've selected Code Maker, you will be met with a screen such as:
![Maker Menu](https://raw.githubusercontent.com/Nawn/Mastermind/master/mastermind-maker.PNG)

Simply enter the code you wish for, and watch the machine do it's best to guess!
![Maker Win](https://raw.githubusercontent.com/Nawn/Mastermind/master/mastermind-maker-end.PNG)

Looks like it figured it out! Lol :) 
*Thank you*
