# lib/connect_four.rb
require 'pry'

NUMBER_OF_COLUMNS = 7
NUMBER_OF_ROWS = 6

# I got this code on some randon github, and it works
class Array
  def diagonals
    [self, self.map(&:reverse)].inject([]) do |all_diags, matrix|
      ((-matrix.count + 1)..matrix.first.count).each do |offet_index|
        diagonal = []
        (matrix.count).times do |row_index|
          col_index = offet_index + row_index
          diagonal << matrix[row_index][col_index] if col_index >= 0
        end
        all_diags << diagonal.compact if diagonal.compact.count > 1
      end
      all_diags
    end
  end
end

# The game board, with methods to add tiles, print, and verify if a player has won the game
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
    winning_line = player_token * 4
    all_diagonals = @tiles.diagonals
    all_diagonals.each do |diagonal|
      diag_string = diagonal.join
      puts diag_string
      return true if diag_string.include?(winning_line)
    end
    false
  end

  def full_print
    reversed_transposed_array = @tiles.transpose.reverse
    reversed_transposed_array.each do |row|
      row.each do |tile|
        print '⬜' if tile == 0
        print '💩' if tile == 'r'
        print '😹' if tile == 'y'
        print ' '
      end
      print "\n"
    end
  end
end

class ConnectFour
  def initialize
    
end


# 💩 ⛴ 😹

board = Board.new
board.drop_piece('r', 0)
board.drop_piece('r', 1)
board.drop_piece('r', 2)
board.drop_piece('r', 3)
board.drop_piece('r', 4)
4.times { board.drop_piece('y', 3) }
4.times { board.drop_piece('r', 2) }
board.full_print


