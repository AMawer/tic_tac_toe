require './tic_tac_toe.rb'

class AI < TicTacToe

	def self.play()
		if check_board(win) != 0
			check_board(win)
		elsif check_board(lose) != 0
			check_board(lose)
		else
			spaces = spaces.values.grep(/[1-9]/)
			spaces.map { |num| num.to_i }
			spaces.sample.to_i
		end
	end
end