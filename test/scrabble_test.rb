gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ScrabbleTest < Minitest::Test

  def test_scrabble_exists
    new_game = Scrabble.new
    assert_instance_of(Scrabble, new_game)
  end

  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.new.score("e")
    assert_equal 4, Scrabble.new.score("f")
  end

  def test_it_can_score_a_longer_word
    assert_equal 8, Scrabble.new.score("banana")
  end

  def test_score_can_be_zero
    assert_equal 0, Scrabble.new.score("")
  end

  def test_score_can_be_nil
    assert_equal 0, Scrabble.new.score(nil)
  end

  def test_score_with_letter_multipliers
    assert_equal 9, Scrabble.new.score_with_multipliers('hello', [1,2,1,1,1])
    assert_equal 15, Scrabble.new.score_with_multipliers('banana', [1, 2, 3, 4, 2, 1])
  end

  def test_score_with_multi_word_score
    assert_equal 18, Scrabble.new.score_with_multipliers('hello', [1,2,1,1,1], 2)
    assert_equal 30, Scrabble.new.score_with_multipliers('banana', [1, 2, 3, 4, 2, 1], 2)
  end

  def test_add_10_to_score_if_word_is_seven_letters
    assert_equal 54, Scrabble.new.score_with_multipliers('bananan', [1, 2, 3, 4, 2, 1, 2], 2)
    assert_equal 17, Scrabble.new.score_with_multipliers('aaaaaaa', [1, 1, 1, 1, 1, 1, 1])
  end

  def test_highest_scoring_word_method_works_on_two_words
    game = Scrabble.new
    assert_equal "home", game.highest_scoring_word(['home', 'word'])
  end

  def test_highest_scoring_word_method_works_on_a_series_of_words
    game = Scrabble.new
    assert_equal "home", game.highest_scoring_word(['home', 'word', 'hello', 'sound'])
  end

  def test_highest_scoring_word_method_returns_shortest_word_in_case_of_tie
    game = Scrabble.new
    assert_equal "word", game.highest_scoring_word(['hello', 'word', 'sound', 'buzzer'])
  end

  def test_highest_scoring_word_chooses_7_letter_words
    game = Scrabble.new
    assert_equal "silence", game.highest_scoring_word(['home', 'word', 'silence'])
  end

  def test_chooses_first_word_in_list
    game = Scrabble.new
    assert_equal 'word', game.highest_scoring_word(['hi', 'word', 'ward'])
  end
end
