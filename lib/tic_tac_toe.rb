# Our main TicTacToe class will be defined here with all the data and logic required to play a game of tic tac toe via instances of TicTacToe.
require "pry"

class TicTacToe
  attr_accessor :board, :input

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts (" #{@board[0]} | #{@board[1]} | #{@board[2]} ")
    puts ("-----------")
    puts(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
    puts("-----------")
    puts(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(input, player)
    @board[input] = player
  end

  def position_taken?(input)
    @board[input] != " "
  end

  def valid_move?(input)
    !position_taken?(input) && input <= 8 && input >= 0
  end

  def turn_count
    if @board.tally { |pos| pos == " " }[" "] == nil
      9
    else
      9 - @board.tally { |pos| pos == " " }[" "]
    end
  end

  def current_player
    self.turn_count.even? ? "X" : "O"
  end

  def turn(input = gets)
    @input = input_to_index(input)
    if valid_move?(@input)
      self.move(@input, self.current_player)
      display_board
    else
      puts "invalid"
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      check = []
      combo.each { |pos| check << @board[pos] }
      if check == %w[X X X] || check == %w[O O O]
        @winner = check[0]
        combo
      end
    end
  end

  def full?
    # binding.pry
    !self.won? && self.turn_count == 9 ? true : false
  end

  def draw?
    self.full? == true ? true : false
  end

  def over?
    # binding.pry
    self.draw? == true || !!self.won? != false ? true : false
  end

  def winner
    @winner if self.won?
  end

  def play
    # turn
    # if over?
    #   if won?
    #     "Congratulations #{self.winner}!"
    #   elsif draw?
    #     puts "Cat's Game!"
    #   end
    # else
    #   play
    # end

    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end

# binding.pry
