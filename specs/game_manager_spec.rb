require_relative 'spec_helper.rb'

describe GameManager do
  before(:each) do
    @manager = GameManager.new
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
      it "adds Array to board row" do
        @manager.take_turn(%w(Bl G Br O))
        
        expect(@manager.board.rows[0]).to be_an(Array)
        expect(@manager.board.rows[0]).to eql(["Bl", "G", "Br", "O"])
        
        @manager.take_turn(%w(M W P R))
        
        expect(@manager.board.rows[1]).to be_an(Array)
        expect(@manager.board.rows[1]).to eql(["M", "W", "P", "R"])
        expect(@manager.board.rows[2]).to be_nil
      end
    end
  end
end