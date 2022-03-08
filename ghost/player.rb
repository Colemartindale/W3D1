

class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess_char
        puts "#{@name}, please add a character"
        response = gets.chomp
        response
    end


end


