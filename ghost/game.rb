require_relative 'player.rb'
require "set"

class Game

    attr_reader :current_player, :fragment

    def initialize(players, dictionary)
        @players = players
        @current_player = players[0]
        @previous_player = nil
        @fragment = ""
        @dictionary = dictionary
        @losses = Hash.new(0)
    end

    def record(player)
        "GHOST"[0...@losses[player]]
    end

    def is_over?        
        @players.length == 1
    end

    def display_standings
        @players.each do |player|
            puts "#{player.name}: #{record(player)}"
        end
    end

    def run
        while !is_over?
            display_standings
            while !lose?
                puts "The current fragment is #{@fragment}"
                play_round
            end
            puts "#{@current_player.name} loses!"
            if is_out?(@current_player)
                puts "#{@current_player.name} is out!"                
                next_player!
                @players.pop
            else
                next_player!
            end
            @fragment = ""          
        end
        display_standings
        puts "#{@current_player.name} is the ultimate winner!"
    end

    def is_out?(player)
        @losses[player] == 5
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
        @players.rotate!
        @current_player = @players[0]
        
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
player3 = Player.new('Bwian')

players = [player1, player2, player3]
game = Game.new(players, dictionary)

game.run