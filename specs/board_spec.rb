require_relative 'spec_helper.rb'

describe Board do
  before(:each) do
    @board = Board.new
  end
  
  describe "#new" do
    it "builds empty board" do
      expect(@board).to be_a(Board)
    end
    
    context "when freshly built" do
      it "rows will be an Empty array" do
        expect(@board.rows).to eql([])
      end
      
      it "Will have default attempts allowed(12)" do
        expect(@board.attemps_allowed).to eql(12)
      end
    end
  end
end