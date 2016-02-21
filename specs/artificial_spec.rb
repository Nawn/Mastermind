require_relative 'spec_helper.rb'

describe Artificial do
  before(:each) do
    @enemy = Artificial.new
  end
  
  it "inherits from Player" do
    expect(Artificial).to be < Player
  end
  
  describe "#generate_code" do
    it "returns an Array" do
      expect(@enemy.generate_code).to be_an(Array)
    end
    
    it "returns 4 colors" do
      expect(@enemy.generate_code.size).to eql(4)
    end
    
    it "will be random every time" do
      poop = @enemy.generate_code
      poop_two = @enemy.generate_code
      expect(poop).not_to eql(poop_two)
    end
  end
  
  #need to make the Turns AI
end