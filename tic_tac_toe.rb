require 'rainbow'

class TicTacToe
	@board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
	@players_turn = true

	# is this correct to do?
	def self.board
		@board
	end

	def self.draw_space(space)
		# add colours later using rainbow, i.e. space.foreground(:blue) or space.foreground(:red)
		space
	end

	def self.draw_space_with_line(space)
		self.draw_space(space) + " | "
	end

	def self.gap 
		"  "
	end

	def self.draw_row(row_num)
		row = @board[row_num]
		self.gap +
		self.draw_space_with_line(row[0]) + 
		self.draw_space_with_line(row[1]) + 
		self.draw_space(row[2])
	end

	def self.draw_row_with_line(row_num)
		self.draw_row(row_num) + 
		"\n#{gap}---------\n"
	end

	def self.draw_board()
		"\n" +
		self.draw_row_with_line(0) +
		self.draw_row_with_line(1) +
		self.draw_row(2) + 
		"\n\n"
	end

	def self.num_to_space(num)
		coordinates = []
		@board.each_with_index do |row, row_index|
			row.each_with_index do |column, column_index|
				return coordinates << row_index << column_index if num == column.to_i
			end
		end
	end

	def self.mark_space(coordinates)
		row = coordinates[0]
		column = coordinates[1]
		mark = @players_turn ? "x" : "o"
		@board[row][column] = mark
	end

	def self.players_turn()
		num = gets[0].to_i
		coordinates = self.num_to_space(num)
		self.mark_space(coordinates)
	end

	def self.comps_turn()
	end

end