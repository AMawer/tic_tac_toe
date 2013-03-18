require 'test/unit'
require './tic_tac_toe.rb'
require './tic_tac_toe_ai.rb'

class TicTacToeTest < Test::Unit::TestCase

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
		TicTacToe.mark_space([2, 0])
		assert_equal [["1", "2", "3"], ["4", "5", "x"], ["x", "8", "9"]], TicTacToe.board
	end

	def test_AI_play

	end

	

end