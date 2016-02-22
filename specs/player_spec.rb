require_relative 'spec_helper.rb'

describe Player do
  before(:each) do
    @player = Player.new
  end
  
  describe "#generate_code" do
    it "will return an Array" do
      expect(@player.generate_code).to be_an(Array)
    end
  end
  
  describe "#turn" do
    it "returns an array" do
      expect(@player.turn).to be_an(Array)
    end
  end
end