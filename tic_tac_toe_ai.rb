require_relative 'tic_tac_toe'


class AI

	def self.play()
		@tictactoe = TicTacToe.new
		if @tictactoe.check_board(win) != 0
			@tictactoe.check_board(win)
		elsif @tictactoe.check_board(lose) != 0
			@tictactoe.check_board(lose)
		else
			@tictactoe.spaces = @tictactoe.spaces.values.grep(/[1-9]/)
			@tictactoe.spaces.map { |num| num.to_i }
			@tictactoe.spaces.sample.to_i
		end
	end
end
