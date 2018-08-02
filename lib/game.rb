require "game/version"
require "spicy-proton"

module Game
  class Config
    CHECKPOINT = 10
    POINT_INCREMENT = 1
  end

  class Base
     def play
      puts "Press exit or quit to exit"
      input = nil
      loop do
        word = Game::Word.new
        puts "Tebak kata: #{word.random}"
        input = gets.chomp

        break if over? input

        if word.match?(input)
          Game::Point.increase
          puts "BENAR! point anda #{Game::Point.point}."
        else
          puts "SALAH! silahkan coba lagi."
        end
      end

      puts "Goodbye!"
    end

    def over? input
      input =~ /(?:ex|qu)it/i
    end
  end

  class Word
    def word
      @word ||= Spicy::Proton.noun
    end

    def random
      first, *middle, last = word.chars
      [first, middle.shuffle, last].shuffle.join
    end

    def match? input
      word === input
    end
  end

  class Point
    @point = 0

    class << self
      def point
        @point
      end

      def increase
        @point += Config::POINT_INCREMENT
      end
    end
  end
end
