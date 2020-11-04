# spec/connect_four_spec.rb
require './lib/connect_four.rb'
describe Board do
  context 'Test if a Grid was correctly created' do
    it 'The array contains the right number of collumns (7)' do
      board = Board.new
      columns = board.tiles.length
      expect(columns).to eql(7)
    end
    it 'The array contains the right number of rows (6)' do
      board = Board.new
      result = board.tiles.all? { |column| column.length == 6}
      expect(result).to be true
    end
    it 'All grid values are initially set to 0' do
      board = Board.new
      result = board.tiles.all? do |column|
        column.all? {|row_element| row_element.zero?}
      end
      expect(result).to be true
    end
    it 'Can access the last element of the Grid (Board.tiles[6][5])' do
      board = Board.new
      expect(board.tiles[6][5]).to eql(0)
    end
  end
  describe '#drop_piece' do
    it 'correctly adds a "red" piece on the first, empty column' do
      board = Board.new
      board.drop_piece('red', 0)
      expect(board.tiles[0][0]).to eql('red')
    end
    it 'correctly adds a "yellow" piece on the last column, which already contains two tiles' do
      board = Board.new
      board.tiles[6][0] = 'red'
      board.tiles[6][1] = 'red'
      board.drop_piece('yellow', 6)
      expect(board.tiles[6][2]).to eql('yellow')
    end
    it 'does not add a piece when the column is full' do
      board = Board.new
      board.tiles[6][0] = 'red'
      board.tiles[6][1] = 'red'
      board.tiles[6][2] = 'red'
      board.tiles[6][3] = 'red'
      board.tiles[6][4] = 'red'
      board.tiles[6][5] = 'red'
      board.drop_piece('yellow', 6)
      expect(board.tiles[6][5]).to eql('red')
    end
    it 'returns true when a piece was added' do
      board = Board.new
      actual = board.drop_piece('yellow', 1)
      expect(actual).to be true
    end
    it 'returns false when it was not able to add a piece to a full column' do
      board = Board.new
      board.tiles[6][0] = 'red'
      board.tiles[6][1] = 'red'
      board.tiles[6][2] = 'red'
      board.tiles[6][3] = 'red'
      board.tiles[6][4] = 'red'
      board.tiles[6][5] = 'red'
      actual = board.drop_piece('yellow', 6)
      expect(actual).to be false
    end
  end
  describe '#horizontal_win?' do
    it 'returns true if elements from tiles[0][0] to tiles[3][0] are all "r"' do
      board = Board.new
      board.drop_piece('r', 0)
      board.drop_piece('r', 1)
      board.drop_piece('r', 2)
      board.drop_piece('r', 3)
      actual = board.horizontal_win?('r')
      expect(actual).to be true
    end
    it 'returns false if not all elements from tiles[0][0] to tiles[3][0] are "r"' do
      board = Board.new
      board.drop_piece('r', 0)
      board.drop_piece('r', 1)
      board.drop_piece('y', 2)
      board.drop_piece('r', 3)
      actual = board.horizontal_win?('r')
      expect(actual).to be false
    end
    it 'returns true if all elements from tiles[1][3] to tiles[4][3] are "y"' do
      board = Board.new
      4.times { board.drop_piece('y', 1) }
      4.times { board.drop_piece('y', 2) }
      3.times { board.drop_piece('r', 3) }
      board.drop_piece('y', 3)
      4.times { board.drop_piece('y', 4) }
      actual = board.horizontal_win?('y')
      expect(actual).to be true
    end
  end

  describe '#vertical_win?' do
    it 'returns true if elements from tiles[0][0] to tiles[0][3] are all "r"' do
      board = Board.new
      4.times { board.drop_piece('r', 0) }
      actual = board.vertical_win?('r')
      expect(actual).to be true
    end
    it 'returns false if not all elements from tiles[0][0] to tiles[0][3] are "r"' do
      board = Board.new
      3.times { board.drop_piece('r', 0) }
      board.drop_piece('y', 0)
      actual = board.vertical_win?('r')
      expect(actual).to be false
    end
    it 'returns true if all elements from tiles[3][2] to tiles[3][5] are "y"' do
      board = Board.new
      2.times { board.drop_piece('r', 3) }
      4.times { board.drop_piece('y', 3) }
      actual = board.vertical_win?('y')
      expect(actual).to be true
    end
  end
  describe 'diagonal_win?' do
    it 'returns true if elements from tiles[0][0] to tiles[3][3] are all "r"' do
      board = Board.new
      board.drop_piece('r', 0)
      2.times { board.drop_piece('r', 1) }
      3.times { board.drop_piece('r', 2) }
      4.times { board.drop_piece('r', 3) }
      actual = board.diagonal_win?('r')
      expect(actual).to be true
    end
    it 'returns false if elements from tiles[0][0] to tiles[3][3] are not all "r"' do
      board = Board.new
      board.drop_piece('r', 0)
      2.times { board.drop_piece('r', 1) }
      3.times { board.drop_piece('r', 2) }
      4.times { board.drop_piece('y', 3) }
      actual = board.diagonal_win?('r')
      expect(actual).to be false
    end
    it 'returns false if no tiles where added' do
      board = Board.new
      actual = board.diagonal_win?('r')
      expect(actual).to be false
    end

  end


end
