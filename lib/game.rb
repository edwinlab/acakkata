require "game/version"
require "spicy-proton"

module Game
  class Config
    POINT_INCREMENT = 1
    LEVEL_CHECKPOINT = 10
    LEVEL_INCREMENT = 1
  end

  class Base
     def play
      puts "Game acak kata"
      puts "Level naik setiap #{Config::LEVEL_CHECKPOINT} point"
      input = nil
      loop do
        word = Word.new
        puts "Tebak kata: #{word.random} (Type 'exit' or 'quit' to exit)"
        input = gets.chomp

        break if over? input

        if word.match?(input)
          Point.increase
          puts "BENAR! point anda #{Point.point}."
        else
          puts "SALAH! silahkan coba lagi."
        end

        if Level.levelup? Point.point
          Level.increase
          puts "LEVEL UP! level anda #{Level.level}"
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
      @word ||= Spicy::Proton.noun(max: Level.word_level)
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

  class Level
    @level = 1

    class << self
      def level
        @level
      end

      def increase
        @level += Config::LEVEL_INCREMENT
      end

      def levelup? point
        point != 0 && point % Config::LEVEL_CHECKPOINT == 0
      end

      def word_level
        level + Config::LEVEL_INCREMENT
      end
    end
  end
end
