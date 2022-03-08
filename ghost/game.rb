require_relative 'player.rb'
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
         guess = player.guess_char

    end

    def valid_play?(string)
        alphabet = ('a'..'z').to_a
        return false if !alphabet.include?(string)

        new_fragment = @fragment + string

        return @dictionary.any? { |el| el.start_with?(new_fragment) }
    end

end


file = File.open("dictionary.txt")
dictionary = file.readlines.map(&:chomp)
file.close
dictionary = dictionary.to_set

player1 = Player.new('Steve')
player2 = Player.new('Ernesta')

game = Game.new(player1, player2, dictionary)

