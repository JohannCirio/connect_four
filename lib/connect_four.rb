# lib/connect_four.rb
require 'pry'

NUMBER_OF_COLUMNS = 7
NUMBER_OF_ROWS = 6

class Board
  attr_accessor :tiles
  def initialize
    @tiles = create_grid
  end

  def create_grid
    array = []
    NUMBER_OF_COLUMNS.times do
      another_array = []
      NUMBER_OF_ROWS.times { another_array.push 0 }
      array.push(another_array)
    end
    array
  end

  def drop_piece(player_token, column_number)
    counter = 0
    until counter == 6
      if @tiles[column_number][counter] == 0
        @tiles[column_number][counter] = player_token
        return true
      else
        counter += 1
      end
    end
    false
  end

  def horizontal_win?(player_token)
    winning_line = player_token * 4
    transposed_grid = @tiles.transpose
    transposed_grid.each do |row|
      row_string = row.join
      return true if row_string.include?(winning_line)
    end
    false
  end

  def vertical_win?(player_token)
    winning_line = player_token * 4
    @tiles.each do |column|
      column_string = column.join
      puts column_string
      return true if column_string.include?(winning_line)
    end
    false
  end
  def diagonal_win?(player_token)
    

  end
end
