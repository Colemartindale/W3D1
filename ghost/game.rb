
require "set"

class Game

    attr_reader :current_player

    def initialize(player1, player2, dictionary)
        @player1 = player1
        @player2 = player2
        @current_player = player1
        @previous_player = nil
        @fragment = ""
        @dictionary = dictionary
    end

    def play_round

    end

    def next_player!
        @previous_player = @current_player
        @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def take_turn(player)
        puts "Please add a character"
    end
end


file = File.open("dictionary.txt")
dictionary = file.readlines.map(&:chomp)
file.close
dictionary = dictionary.to_set