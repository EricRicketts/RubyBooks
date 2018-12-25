require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class String
  def my_each_word
    self.scan(/\w+/).each do |word|
      yield(word)
    end
    self
  end
end

class Exercise2Test < Minitest::Test

  def test_my_each_word
    str = "Nothing lasts forever but cold November Rain"
    expected = "Nothing\nlasts\nforever\nbut\ncold\nNovember\nRain\n"
    assert_output(expected) { str.my_each_word { |word| puts word } }
  end
end
