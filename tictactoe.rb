class TicTacToe
  attr_accessor :grid, :current_player
  def initialize
    puts "Player 1 Name:"
    x = gets.chomp
    @player_1 = Player.new(x, "X")
    puts "Player 2 Name:"
    o = gets.chomp
    @player_2 = Player.new(o, "O")
    @grid = ["1","2","3","4","5","6","7","8","9"]
    @win = [["1","2","3"],["1","4","7"],["1","5","9"],["3","4","5"],["6","7","8"],
      ["2","5","8"], ["3","6","9"], ["3","5","7"]]
    @current_player = @player_1
    display
  end

  def display
    puts "-------------"
    puts "| #{@grid[0..2].join(" | ")} |"
    puts "-------------"
    puts "| #{@grid[3..5].join(" | ")} |"
    puts "-------------"
    puts "| #{@grid[6..8].join(" | ")} |"
    puts "-------------"
    next_move
  end

  def next_move
    puts "#{@current_player.name}, select a numbered box to make your move."
    number = gets.chomp
    if @grid.include?(number)
      @current_player.add_box(number)
      grid_mark(number)
      if victory?(@current_player)
        self.finish
      else
        switch_players
        display
      end
    else
      puts "That's not a valid number!"
      display
    end
  end

  def switch_players
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def grid_mark(number)
    @grid.map! do |x|
      if x == number
        x = @current_player.type
      else
        x
      end
    end
  end

  #This sees if the current player has all the boxes of any one "win set"
  def victory?(player)
    victory = false
    @win.each do |set|
      if (set - @current_player.boxes).empty?
        victory = true
        break
      end
    end
    return victory
  end

  def finish
    puts "#{@current_player.name} won!"
    puts "Do you want to start a new game? [Yes/No]"
    choice = gets.chomp.downcase
    case choice
    when 'yes'
      TicTacToe.new
    when 'no'
      puts "Well, gg then."
    else
      puts 'I\'ll take that as a no, then. Goodbye.'
  end

end

class Player
  attr_accessor :boxes, :name, :type

  def initialize(name, type)
    @name = name
    @type = type
    @boxes = []
  end

  def add_box(number)
    boxes << number
  end

end
end
game = TicTacToe.new
test
