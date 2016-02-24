require_relative 'spec_helper.rb'

describe Row do
  before(:each) do
    @row = Row.new
  end
  
  it "is a Row" do
    expect(@row).to be_a(Row)
  end
  
  context "when given no input" do
    it "returns nil on #code" do
      expect(@row.code).to be_nil
    end
    
    it "returns nil on #result" do
      expect(@row.result).to be_nil
    end
    
    it "does not have any other attributes" do
      expect {@row.caca}.to raise_error(NoMethodError)
      expect {@row.poop}.to raise_error(NoMethodError)
    end
  end
  
  context "when given input" do
    it "will return Arrays" do
      poop = Row.new(%w(Bl Br O P), %w(X X x))
      expect(poop.code).to be_an(Array)
      expect(poop.result).to be_an(Array)
    end
  end
end