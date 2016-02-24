require_relative 'spec_helper'

describe GameManager do
  before(:each) do
    @manager = GameManager.new
    @manager.set_board_answer(%w(R P W M))
  end
  
  describe "#new" do
    it "will create an empty board" do
      expect(@manager.board.rows).to eql([])
    end
    
    context "when given no input" do
      it "will set the player to be code breaker" do
        expect(@manager.players[:code_breaker]).to be_a(Player)
      end
      
      it "will set AI to be code maker" do
        expect(@manager.players[:code_maker]).to be_an(Artificial)
      end
    end
    
    context "when given wrong input" do
      it "will raise an ArgumentError" do
        expect{GameManager.new("Caca")}.to raise_error(ArgumentError)
        expect{GameManager.new(4)}.to raise_error(ArgumentError)
      end
    end
    
    context "when given correct input (symbol)" do
      context "when given :code_maker" do
        it "will make the player be the code maker" do
          @manager = GameManager.new(:code_maker)
          expect(@manager.players[:code_maker]).to be_a(Player)
          expect(@manager.players[:code_breaker]).to be_an(Artificial)
        end
      end
      
      context "when given :code_breaker" do
        it "will set player to be code breaker" do
          @manager = GameManager.new(:code_breaker)
          expect(@manager.players[:code_breaker]).to be_a(Player)
          expect(@manager.players[:code_maker]).to be_an(Artificial)
        end
      end
    end
  end
  
  describe "#set_board_answer" do
    context "when given wrong input" do
      it "raises ArgumentError" do
        expect {@manager.set_board_answer()}.to raise_error(ArgumentError)
        expect {@manager.set_board_answer("Caca")}.to raise_error(ArgumentError)
        expect {@manager.set_board_answer(%w(G W))}.to raise_error(ArgumentError)
        expect {@manager.set_board_answer(4)}.to raise_error(ArgumentError)
      end
    end
    
    context "When given non-existant color" do
      it "raises Standard Error" do 
        expect {@manager.set_board_answer(%w(Z W L E))}.to raise_error(StandardError)
        expect {@manager.set_board_answer(%w(N Q Y Z))}.to raise_error(StandardError)
        expect {@manager.set_board_answer(%w(Bl Br W Z))}.to raise_error(StandardError)
      end
    end
    
    context "when given correct input" do
      it "sets board's answer to input" do
        @manager.set_board_answer(%w(Bl Br W P))
        expect(@manager.board.answer).to eql(["Bl", "Br", "W", "P"])
      end
    end
  end
  
  describe "#turn_announce" do
    it "returns a string" do
      expect(@manager.turn_announce).to be_a(String)
    end
    
    it "will be turn num out of attempts allowed" do
      expect(@manager.turn_announce).to eql("Turn 1 of 12")
      @manager.take_turn(%w(W P R M))
      expect(@manager.turn_announce).to eql("Turn 2 of 12")
    end
  end
  
  describe "#take_turn" do
    context "When given wrong input" do
      it "returns an Argument error" do
        expect {@manager.take_turn()}.to raise_error(ArgumentError)
        expect {@manager.take_turn(%w(Z W L E))}.to raise_error(ArgumentError)
      end
    end
    
    context "when given correct input" do
      it "adds Rows to board row" do
        @manager.take_turn(%w(Bl G Br O))
        
        expect(@manager.board.rows[0]).to be_a(Row)
        expect(@manager.board.rows[0].code).to eql(["Bl", "G", "Br", "O"])
        
        @manager.take_turn(%w(M W P R))
        
        expect(@manager.board.rows[1]).to be_a(Row)
        expect(@manager.board.rows[1].code).to eql(["M", "W", "P", "R"])
        expect(@manager.board.rows[2]).to be_nil
      end
      
      context "when code matches exactly" do
        it "sets result to an Array of 4 Capital X's" do
          @manager.take_turn(%w(R P W M))
          expect(@manager.board.rows[0].result).to eql(%w(X X X X))
        end
      end
      
      context "when code has all colors but in wrong order" do
        it "returns 4 o's" do
          @manager.take_turn(%w(M W P R))
          expect(@manager.board.rows[0].result).to eql(%w(o o o o))
        end
      end
      
      context "when code is completely wrong" do
        it "sets result to an empty Array" do
          @manager.take_turn(%w(Bl G Br O))
          expect(@manager.board.rows[0].result).to be_empty
        end
      end
      
      context "when code has 2 correct colors in correct spaces and 2 incorrect colors" do
        it "returns 2 X pegs" do
          @manager.take_turn(%w(R P Br O))
          expect(@manager.board.rows[0].result.size).to eql(2)
          expect(@manager.board.rows[0].result).to eql(["X", "X"])
        end
      end
      
      context "When code has 2 correct colors in incorrect spaces" do
        it "returns 2 o pegs" do
          @manager.take_turn(%w(Bl Br P R))
          expect(@manager.board.rows[0].result.size).to eql(2)
          expect(@manager.board.rows[0].result).to eql(["o", "o"])
        end
      end
      
      context "When given all colors but one combination is wrong" do
        it "returns 2 Xs and 2 os" do
          @manager.take_turn(%w(P R W M))
          expect(@manager.board.rows[0].result.size).to eql(4)
          expect(@manager.board.rows[0].result).to eql(["X", "X", "o", "o"])
        end
      end
    end
  end
  
  describe "#check_over" do
    context "if the player has room to guess more" do
      it "should not be true" do
        5.times do
          @manager.take_turn(%w(Bl G Br O))
        end
        
        expect(@manager.check_over).to be_false
      end
    end
    
    context "If the player has run out of tries" do
      it "returns true" do
        12.times do
          @manager.take_turn(%w(Bl G Br O))
        end
        
        expect(@manager.check_over).to be_true
      end
    end
    
    context "if the player has not guessed code" do
      it "returns false" do
        @manager.take_turn(%w(Bl G Br O))
        expect(@manager.check_over).to be_false
        @manager.take_turn(%w(O Br G Bl))
        expect(@manager.check_over).to be_false
      end
    end
    
    context "when player has guessed code" do
      it "will return true" do
        5.times do
          @manager.take_turn(%w(Bl Br G O))
        end
        expect(@manager.check_over).to be_false
        @manager.take_turn(%w(R P W M))
        expect(@manager.check_over).to be_true
      end
    end
  end
  
  describe "#check_victory" do
    context "when the player has not input correct code" do
      context "when given absolutely wrong code" do
        it "returns false" do
          expect(@manager.check_victory).to be_false
          @manager.take_turn(%w(Bl G Br O))
          expect(@manager.check_victory).to be_false
          5.times do
            @manager.take_turn(%w(G Bl O Br))
          end
          expect(@manager.check_victory).to be_false
        end
      end
      
      context "when input correct colors in wrong order" do
        it "returns false" do
          expect(@manager.check_victory).to be_false
          @manager.take_turn(%w(M W P R))
          expect(@manager.check_victory).to be_false
        end
      end
      
      context "when the player runs out of turns" do
        it "returns false" do
          13.times do 
            @manager.take_turn(%w(M W P R))
          end
          
          expect(@manager.check_victory).to be_false
        end
      end
    end
    
    context "when player has input correct code" do
      context "when player inputs right away" do
        it "returns true" do
          expect(@manager.check_victory).to be_false
          @manager.take_turn(%w(R P W M))
          expect(@manager.check_victory).to be_true
        end
      end
      
      context "when player inputs after some turns" do
        it "returns true" do
          expect(@manager.check_victory).to be_false
          5.times do
            @manager.take_turn(%w(Bl G Br O))
          end
          expect(@manager.check_victory).to be_false
          @manager.take_turn(%w(R P W M))
          expect(@manager.check_victory).to be_true
        end
      end
    end
  end
end