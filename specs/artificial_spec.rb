require_relative 'spec_helper.rb'

describe Artificial do
  before(:each) do
    @enemy = Artificial.new
  end
  
  it "inherits from Player" do
    expect(Artificial).to be < Player
  end
end