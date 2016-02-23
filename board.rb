class Board
  class << self
    attr_accessor :colors_available
  end

  @colors_available = ["Bl", "G", "Br", "O", "M", "W", "P", "R"]
end