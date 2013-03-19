#require_relative 'tic_tac_toe_ai'

class TicTacToe
	attr_reader :board

	def initialize
		@board        = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
		@players_mark = "x"
		@comps_mark   = "o"
		@players_turn = true
		#@ai = AI.new
		# @game_won    = false
	end

	def draw_board()
		"\n" +
		draw_row_with_line(0) +
		draw_row_with_line(1) +
		draw_row(2) + 
		"\n\n"
	end

	def num_to_space(num)
		coordinates = []
		@board.each_with_index do |row, row_index|
			row.each_with_index do |column, column_index|
				return coordinates << row_index << column_index if num == column.to_i
			end
		end
	end

	def mark_space(coordinates)
		row = coordinates[0]
		column = coordinates[1]
		mark = @players_turn ? "x" : "o"
		@board[row][column] = mark
	end

	def players_turn()
		num = gets[0].to_i
		coordinates = num_to_space(num)
		mark_space(coordinates)
	end

	def comps_turn()
		coordinates = AI.play()
		mark_space(coordinates)
	end

	def play_turn()
		print draw_board()
		players_turn()
		comps_turn()
	end

	did_player_win_game = lambda do |three_spaces|
		three_spaces.all?(@players_mark) == 3
	end

	did_comp_win_game = lambda do |three_spaces|
		three_spaces.all?(@comps_mark) == 3
	end

	def game_won?
		#check_board(did_comp_win_game) || check_board(did_player_win_game)
		false
	end

	def play_game()
		until game_won? do
			play_turn()
		end
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

	#private

	def draw_space(space)
		# add colours later using rainbow, i.e. space.foreground(:blue) or space.foreground(:red)
		space
	end

	def draw_space_with_line(space)
		draw_space(space) + " | "
	end

	def gap 
		"  "
	end

	def draw_row(row_num)
		row = @board[row_num]
		gap +
		draw_space_with_line(row[0]) + 
		draw_space_with_line(row[1]) + 
		draw_space(row[2])
	end

	def draw_row_with_line(row_num)
		draw_row(row_num) + 
		"\n#{gap}---------\n"
	end

	def get_coordinates_space(coordinates)
		row = coordinates[0]
		column = coordinates[1]
		@board[row][column]
	end

	def get_lines_spaces(line)
		three_spaces = []
		space1 = get_coordinates_space(line[0])
		space2 = get_coordinates_space(line[1])
		space3 = get_coordinates_space(line[2])
		three_spaces << space1 << space2 << space3
	end

	def check_line(line, method)
		three_spaces = get_lines_spaces(line)
		method.call(three_spaces)
	end

	def check_lines_for_spaces_to_play(method)
		lines = [
			[[0, 0], [0, 1], [0, 2]], 
			[[1, 0], [1, 1], [1, 2]], 
			[[2, 0], [2, 1], [2, 2]], 
			[[0, 0], [1, 0], [2, 0]], 
			[[0, 1], [1, 1], [2, 1]], 
			[[0, 2], [1, 2], [2, 2]], 
			[[0, 2], [1, 1], [2, 0]], 
			[[0, 0], [1, 1], [2, 2]]
		]
		spaces_to_play = []
		for i in 0..7
			space = check_line(lines[i], method)
			spaces_to_play << space if space != 0 
		end
		spaces_to_play
	end


	def check_lines(method)
		lines = [
			[[0, 0], [0, 1], [0, 2]], 
			[[1, 0], [1, 1], [1, 2]], 
			[[2, 0], [2, 1], [2, 2]], 
			[[0, 0], [1, 0], [2, 0]], 
			[[0, 1], [1, 1], [2, 1]], 
			[[0, 2], [1, 2], [2, 2]], 
			[[0, 2], [1, 1], [2, 0]], 
			[[0, 0], [1, 1], [2, 2]]
		]
		for i in 0..7
			check_line(lines[i], method)
		end
	end

	def check_board(method)
		check_lines(method)
	end

	def check_board_for_spaces_to_play(method)
		spaces_to_play = check_lines(method)
		if spaces_to_play.size != 0 
			spaces_to_play.sample
		end
	end

	def possible(three_spaces, mark)
		empty_spaces = three_spaces.select { |space| space.to_i != 0 } # to_i returns 0 if string does not have an integer
		if three_spaces.count(mark) == 2 and empty_spaces.size == 1
			empty_spaces[0].to_i
		end
	end

	could_the_player_win = lambda do |three_spaces|
		possible(three_spaces, @players_mark)
	end

	could_the_comp_win = lambda do |three_spaces|
		possible(three_spaces, @comps_mark)
	end
end

@tictactoe = TicTacToe.new