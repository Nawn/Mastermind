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
end