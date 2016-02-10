require 'terminal-table'
require 'colorize'
  rows = []
12.times do
  rows << %w(B B R G)
end

table = Terminal::Table.new :rows => rows
puts table