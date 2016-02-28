
class DrawPile

  def initialize
    @deck = []
    (1..4).each do # hearts, diamonds, spades & clubs
        (1..10).each do |card_val| # ace is one, jacks, queens and kings removed
          @deck << card_val
        end
    end
    @deck.shuffle!
  end

  def hasMoreCards
    !@deck.empty?
  end

  def draw
    @deck.pop(2)
    #@deck.slice!(rand(0..(@deck.size-2)),2)
    #@deck.slice!(0,2)
    #@deck.slice!((@deck.length - 2),2)
  end

end


class Player
  attr_reader :name
  attr_accessor :score, :wins

  def initialize (player_name, even_or_odd)
    @name = player_name
    @winning_remainder = even_or_odd == :even ? 0 : 1
    @score = 0
    @wins = 0
  end

  def play(cards)
    puts "#{@name}'s cards: #{cards} "
    if @winning_remainder == (cards.reduce(:+) % 2)
      @score += 1
      puts "                         - WIN!!"
    end
  end
end


class EvenStevenOddToddGame

  def initialize
    @draws = 0
    @players = [Player.new("Even Steven", :even), Player.new("Odd Todd", :odd)]
  end

  def play
    draw_pile = DrawPile.new

    while draw_pile.hasMoreCards do
      @players.each do |player|
        player.play(draw_pile.draw)
      end
    end

    show_scores

    tally_wins

    reset_scores
  end

  def show_scores
    puts "\nScores:"
    @players.each do |player|
      puts "#{player.name}: #{player.score}"
    end
    puts "\n"
  end

  def tally_wins
    if @players[0].score > @players[1].score
      @players[0].wins += 1
    elsif @players[0].score < @players[1].score
      @players[1].wins += 1
    else
      @draws += 1
    end
  end

  def reset_scores
    @players.each do |player|
      player.score = 0
    end
  end

  def percent_of_total(value)
    total_games = @draws + @players.map{ |player| player.wins }.reduce(:+)
    "#{(100.0 * value / (total_games)).round(2)}%"
  end

  def show_results
    total_games = @draws
    @players.each do |player|
      total_games += player.wins
      puts "#{player.name} Wins: #{player.wins} (#{percent_of_total(player.wins)})"
    end
    puts "Draws: #{@draws} (#{percent_of_total(@draws)})"
    puts "===================================="
    puts "Total Games Played: #{total_games}"
    puts "\n\n"
  end
end


game = EvenStevenOddToddGame.new

times_to_play = ARGV.first.to_i
exit_message = ""

if (times_to_play < 1)
  exit_message = "\nTo make the program play more than once, run: ruby evenodd.rb [number of times to play]\n\n"
  times_to_play = 1
end

times_to_play.times do
  game.play
end

game.show_results

puts exit_message
