require_relative 'spec_helper.rb'

describe Board, :focus => true do
  before(:each) do
    @board = Board.new
  end
  
  describe "#new" do
    it "builds empty board" do
      expect(@board).to be_a(Board)
    end
    
    context "when given no input" do
      it "will have empty rows" do
        expect(@board.rows).to eql([])
      end
      
      it "Will have default attempts allowed(12)" do
        expect(@board.attempts_allowed).to eql(12)
      end
    end
    
    context "when given an input" do
      context "when input is incorrect" do
        it "raises an Argument Error" do
          expect {Board.new([])}.to raise_error(ArgumentError)
          expect {Board.new("Caca")}.to raise_error(ArgumentError)
        end
      end
      
      context "when input is correct" do
        it "sets attempts_allowed to input" do
          temp_board = Board.new(30)
          temp_board_two = Board.new(3)
          expect(temp_board.attempts_allowed).to eql(30)
          expect(temp_board_two.attempts_allowed).to eql(3)
        end
      end
    end
  end
  
  describe "#colors_available" do
    it "returns an Array" do
      expect(Board.colors_available).to be_an(Array)
    end
    
    it "will be an array of allowed colors" do
      expect(Board.colors_available).to eql(%w(Bl G Br O M W P R))
    end
  end
  
  describe "#answer" do
    it "will return an Array" do
      expect(@board.answer).to be_an(Array)
    end
  end
  
  describe "#set_answer" do
    context "when given incorrect input" do
      it "raises an error" do
        expect{@board.set_answer()}.to raise_error(ArgumentError)
        expect{@board.set_answer(%w(Bl Br))}.to raise_error(ArgumentError)
        expect{@board.set_answer(%w(Caca 23))}.to raise_error(ArgumentError)
        expect{@board.set_answer(24)}.to raise_error(ArgumentError)
      end
    end
    
    context "when given correct input" do
      it "sets board's answer to input" do
        @board.set_answer(["Br", "Bl", "O", "P"])
        expect(@board.answer).to eql(["Br", "Bl", "O", "P"])
        @board.set_answer(["O", "P", "Br", "W"])
        expect(@board.answer).to eql(["O", "P", "Br", "W"])
      end
    end
  end
  
  describe "#attempts_allowed" do
    it "returns an Int" do
      expect(@board.attempts_allowed).to be_an(Integer)
    end
  end
  
  describe "#build" do
    it "returns a Table" do
      expect(@board.build).to be_a(Terminal::Table)
    end
  end
end