require 'test/unit'
require './tic_tac_toe.rb'

class TicTacToeTest < Test::Unit::TestCase

	def test_draw_space
		assert_equal "x", TicTacToe.draw_space("x")
	end

	def test_draw_space_with_line
		assert_equal "3 | ", TicTacToe.draw_space_with_line("3")
	end

	def test_draw_row
		assert_equal "  7 | 8 | 9", TicTacToe.draw_row(2)
	end

	def test_draw_row_with_line
		assert_equal "  4 | 5 | 6\n  ---------\n", TicTacToe.draw_row_with_line(1)
	end

	def test_draw_board
		assert_equal "\n  1 | 2 | 3\n  ---------\n  4 | 5 | 6\n  ---------\n  7 | 8 | 9\n\n", TicTacToe.draw_board()
	end

	def test_num_to_space
		assert_equal [0, 1], TicTacToe.num_to_space(2)
		assert_equal [2, 2], TicTacToe.num_to_space(9)
	end

	def test_mark_space
		TicTacToe.mark_space([1, 2])
		assert_equal [["1", "2", "3"], ["4", "5", "x"], ["7", "8", "9"]], TicTacToe.board
		TicTacToe.mark_space([1, 2])
		assert_equal [["1", "2", "3"], ["4", "5", "x"], ["7", "8", "9"]], TicTacToe.board
	end

end