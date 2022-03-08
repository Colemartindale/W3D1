require_relative 'player.rb'
require "set"

class Game

    attr_reader :current_player, :fragment

    def initialize(player1, player2, dictionary)
        @player1 = player1
        @player2 = player2
        @current_player = player1
        @previous_player = nil
        @fragment = ""
        @dictionary = dictionary
        @losses = Hash.new(0)
    end

    def record(player)
        "GHOST"[0...@losses[player]]
    end

    def is_over?
        @losses[@player1] == 5 || @losses[@player2] == 5
    end

    def display_standings
        puts "#{@player1.name}: #{record(@player1)}"
        puts "#{@player2.name}: #{record(@player2)}"
    end

    def run
        while !is_over?
            display_standings
            while !lose?
                puts "The current fragment is #{@fragment}"
                play_round
            end
            puts "#{@current_player.name} loses!"
            @fragment = ""
            next_player!
        end
        display_standings
        next_player!
        puts "#{@current_player.name} is the ultimate loser!"
    end

    def play_round
        guess = @current_player.guess_char
        if valid_play?(guess)
            @fragment += guess
            if lose?
                @losses[@current_player] += 1
            else
                next_player!
            end
        else
            puts "Invalid guess"
            raise "Invalid guess"
        end
    rescue
        retry
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

    def lose?
        @dictionary.include?(fragment)
    end



end


file = File.open("dictionary.txt")
dictionary = file.readlines.map(&:chomp)
file.close
dictionary = dictionary.to_set

player1 = Player.new('Steve')
player2 = Player.new('Ernesta')

game = Game.new(player1, player2, dictionary)

game.run