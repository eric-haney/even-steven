
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
  attr_reader :score, :name, :won_last

  def initialize (player_name, even_or_odd)
    @name = player_name
    @winning_remainder = even_or_odd == :even ? 0 : 1
    @score = 0
  end

  def play(cards)
    puts "#{@name}'s cards: #{cards} "
    @won_last = false
    if @winning_remainder == (cards.reduce(:+) % 2)
      @score += 1
      @won_last = true
      puts "                         - WIN!!"
    end
  end
end


class EvenStevenOddTodd

  def initialize
    @even_steven_wins = 0
    @odd_todd_wins = 0
    @draws = 0
  end

  def play
    draw_pile = DrawPile.new

    even_steven = Player.new("Even Steven", :even)
    odd_todd = Player.new("Odd Todd", :odd)

    @players = [even_steven, odd_todd]
    #@players = [odd_todd, even_steven]

    while draw_pile.hasMoreCards do
      @players.each do |player|
        player.play(draw_pile.draw)
      end
    end

    @players.each do |player|
      puts "#{player.name}: #{player.score}"
    end

    if odd_todd.score > even_steven.score
      @odd_todd_wins += 1
    elsif odd_todd.score < even_steven.score
      @even_steven_wins += 1
    else
      @draws += 1
    end
  end

  def percent_of_total(value)
    "#{100.0 * value / (@even_steven_wins + @odd_todd_wins + @draws)}%"
  end

  def show_results
    puts "\n\n\n"
    puts "Even Steven Wins: #{@even_steven_wins} (#{percent_of_total(@even_steven_wins)})"
    puts "Odd Todd Wins: #{@odd_todd_wins} (#{percent_of_total(@odd_todd_wins)})"
    puts "Draws: #{@draws} (#{percent_of_total(@draws)})"
    puts "\n\n"
  end
end


game = EvenStevenOddTodd.new

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
