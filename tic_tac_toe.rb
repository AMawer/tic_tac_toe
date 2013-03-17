require 'rainbow'

class TicTacToe
	@@board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]

	def self.draw_space(space)
		if space == "x"
			space.foreground(:red)
		elsif space == "o"
			space.foreground(:blue)
		else
			space
		end
	end

	def self.draw_board()
		
	end

	def self.players_turn()
	end

	def self.comps_turn()
	end

end