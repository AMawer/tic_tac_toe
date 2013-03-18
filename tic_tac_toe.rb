require 'rainbow'

class TicTacToe
	@board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
	@players_turn = true

	# is this correct to do?
	def self.board
		@board
	end

	def self.players_turn=(value)
		@players_turn = value
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
		coordinates = AI.play()
		self.mark_space(coordinates)
	end

	def self.play_turn()
	end

	# check if there is any line in the board that has
	# 	a) two o's and an empty space
	# 	b) two x's and an empty space
	# 	c) three o's
	# 	d) three x's

	# first method: check_board(), which calls check_lines
	# second method: check_lines(), which calls check_line
	# third method: check_line(), which checks if line has between a) and d)

	# so check_line() 
	# 	takes an array of three elements, each element being coordinates
	# 	gets the value of each coordinate from @board
	# 	and returns whether the line satisfies the criteria

	# the critera is between a) and d), and each of them will be a lambda

	def self.get_coordinates_space(coordinates)
		row = coordinates[0]
		column = coordinates[1]
		@board[row][column]
	end

	def self.get_lines_spaces(line)
		three_spaces = []
		space1 = self.get_coordinates_space(line[0])
		space2 = self.get_coordinates_space(line[1])
		space3 = self.get_coordinates_space(line[2])
		three_spaces << space1 << space2 << space3
	end

	def self.possible(three_spaces, mark)
		empty_spaces = three_spaces.select { |space| space.to_i != 0 } # to_i returns 0 if string does not have an integer
		if three_spaces.count(mark) == 2 and empty_spaces.size == 1
			empty_spaces[0].to_i
		end
	end

	could_the_comp_win = lambda do |three_spaces|
		self.possible(three_spaces, "o")
	end

	could_the_comp_lose = lambda do |three_spaces|
		self.possible(three_spaces, "x")
	end

	did_player_win_game = lambda do |three_spaces|
		true if three_spaces.all?("x") == 3
	end

	did_player_lose_game = lambda do |three_spaces|
		true if three_spaces.all?("o") == 3
	end

	def self.check_line(line, method)
		three_spaces = self.get_lines_spaces(line)
		method.call(three_spaces)
	end

	def self.check_lines(method)
		lines = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]], [[0, 0], [1, 0], [2, 0]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]], [[0, 2], [1, 1], [2, 0]], [[0, 0], [1, 1], [2, 2]]]
		spaces_to_play = []
		for i in 0..7
			space = self.check_line(lines[i], method)
			spaces_to_play << space if space != 0 
		end
		spaces_to_play
	end

	def check_board(method)
		spaces_to_play = check_lines(method)
		if spaces_to_play.size != 0 
			spaces_to_play.sample
		end
	end

end