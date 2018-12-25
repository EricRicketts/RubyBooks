require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Array
  def my_map
    result = Array.new
    self.each do |el|
      result << yield(el) if block_given?
    end
    result
  end
end

class Exercise1Test < Minitest::Test

  def test_my_map
    expected = %w[LOOK MA NO FOR LOOPS]
    result = %w(look ma no for loops).my_map { |word| word.upcase }
    assert_equal(expected, result)
  end
end
