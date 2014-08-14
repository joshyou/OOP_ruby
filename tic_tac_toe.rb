class Board
    
  def initialize
    @columns = []
    (0...3).each do |i|
      row = []
      (0...3).each do |j|
        row << "_"
      end
      @columns << row
    end
  end
    
  def game_over?
    (0...3).each do |i|
      if @columns[i][0] == @columns[i][1] && \
         @columns[i][1] == @columns[i][2] && @columns[i][0] != "_"
        return true
      elsif @columns[0][i] == @columns[1][i] && \
            @columns[1][i] == @columns[2][i] && @columns[0][i] != "_"
        return true
      end
    end
    if @columns[0][0] == @columns[1][1] && \
       @columns[1][1] == @columns[2][2] && @columns[0][0] != "_"
        return true
    end
    false
  end
  
  def draw
    puts " "
    (0...3).each do |y|
      row_string = ""
      (0...3).each do |x|
        row_string += @columns[x][y]
      end
      puts row_string
    end
    puts " "
  end
  
  def select(marker, x, y)
    @columns[x][y] = marker
  end
    
  def selected?(x, y)
    @columns[x][y] != "_"
  end
end

class Player
    
  attr_accessor :name, :marker
    
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
    
  def initialize
    @game_board = Board.new
    @player_one = Player.new("Player 1", "X")
    @player_two = Player.new("Player 2", "O")
  end
    
  def play
    turn_count = 0
    @game_board.draw
    while turn_count < 9
      current_player = 
        if turn_count % 2 == 0
          @player_one
        else
          @player_two
        end
        
      puts "#{current_player.name}, pick a square using its coordinates"
      input = gets.chomp
      while @game_board.selected?(input[0].to_i, input[1].to_i)
        puts "square already selected, pick again"
        input = gets.chomp
        break unless @game_board.selected?(input[0].to_i, input[1].to_i)
      end
      @game_board.select(current_player.marker, input[0].to_i, input[1].to_i)
      @game_board.draw
      if @game_board.game_over?
        puts "#{current_player.name} has won"
        break
      end
      turn_count += 1
    end
    puts "game over"
  end
end

my_game = Game.new
my_game.play