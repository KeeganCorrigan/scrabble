require "pry"

class Scrabble

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end

  def score(word)
    word = '' if word == nil
    word_score = []
    word.split('').each do |letter|
      word_score << point_values.values_at(letter.upcase)
    end
    word_score.flatten.sum
  end

  def score_with_multipliers(word, letter_position, word_multiplier = 1)
    new_word = ''
    word.split('').each_with_index do |letter, index|
      new_word << (letter * letter_position[index])
    end
    word_score = score(new_word)
    word_score = word_score + 10 if word.length >= 7
    return word_score * word_multiplier
  end

  def highest_scoring_word(words)
    highest_scoring_words = {}
    words.each do |word|
      highest_scoring_words[score(word)] = word
    end
    highest_scoring_words.max_by do |score, word|
      return word
    end
  end
end
