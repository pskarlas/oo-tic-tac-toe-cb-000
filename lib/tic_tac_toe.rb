class TicTacToe
  # Initialize winning combinantions CONSTANT
  WIN_COMBINATIONS = [
    [0,1,2], #top row win
    [3,4,5], #middle row win
    [6,7,8], #bottom row win
    [0,3,6], #first col win
    [1,4,7], #second col win
    [2,5,8], #third col win
    [0,4,8], #diagonal win
    [2,4,6] #diagonal win
  ]
  # Object instance initialization with an empty board
  def initialize
    @board = Array.new 9, " "
  end

  # Display board instance method
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # Convert users input to array index
  def input_to_index(user_input)
    index = user_input.to_i - 1
    return index
  end

  # Handles the players move - fills in user position in @board
  def move(position, char)
    @board[position] = char
  end

  def position_taken?(position)
    if @board[position] != " "
    return  true
    end
      false
  end

  def valid_move?(position)
   if position.between?(0,9) && @board[position] == " "
     return true
   end
  end

  # ASK USER TO PLAY -> VALIDATE USER INPUT -> DISPLAY BOARD
  def turn
    # puts "Please enter 1-9:"
    user_input = gets.strip
    arr_index = input_to_index(user_input)
    char = current_player

    if !valid_move?(arr_index)
      puts "Please enter a different option"
      user_input = gets.strip
    else
        move(arr_index, char)
        display_board()
    end
  end

  # DETERMINE HOW MANY TURNS HAVE PASSED
  def turn_count
    counter = 0
    @board.each do |element|
      if element == "O" || element == "X"
        counter += 1
      end
    end
    return counter
  end
  # DETERMINE CURRENT PLAYER
  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end
  # CHECK IF THERE IS ANY WINNER
  def won?
    WIN_COMBINATIONS.each do |win|
     if [@board[win[0]], @board[win[1]], @board[win[2]]] == ["X", "X", "X"] ||
        [@board[win[0]], @board[win[1]], @board[win[2]]] == ["O", "O", "O"]
       return win
     end
    end
     return false
  end
  # CHECK IF THE GAME IS FULL WITHOUT A WINNER
  def full?
    if won? == false && @board.all? {|element| element != " "}
      return true
    else
      false
    end
  end
  #CHECK IF THE GAME IS DRAW
  def draw?
    won_check = won?
    fullboard_check = full?
    if won_check == false && fullboard_check == true
      return true
    elsif won_check == false && fullboard_check == false
      return false
    elsif won_check != false
      return false
    end
  end
  # CHECK IF GAME IS OVER // WON OR DRAW
  def over?
    if won? || full? || draw?
      true
    end
  end
  # CHECK WHOS THE WINNER
  def winner
    WIN_COMBINATIONS.each do |win|
     if [@board[win[0]], @board[win[1]], @board[win[2]]] == ["X", "X", "X"]
       return "X"
     elsif [@board[win[0]], @board[win[1]], @board[win[2]]] == ["O", "O", "O"]
       return "O"
     end
    end
      return nil
  end

  def play
    until over?
      turn
    end
    if won?
      winner = winner()
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
