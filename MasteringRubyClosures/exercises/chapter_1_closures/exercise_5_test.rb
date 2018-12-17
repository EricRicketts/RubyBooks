require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Exercise5Test < Minitest::Test
  attr_accessor :reducer

  def setup
    @reducer = lambda do |acc, arr, binary_function|
      reducer_aux = lambda do |acc, arr|
        if arr.empty?
          acc
        else
          reducer_aux.call(binary_function.call(acc, arr.first), arr.drop(1))
        end
      end
      reducer_aux.call(acc, arr)
    end
  end

  def test_reducer_on_array
    arr = [1, 2, 3, 4, 5]
    expected = [2, 4, 6, 8, 10]
    binary_function = lambda { |x, y| x << 2*y }
    assert_equal(expected, reducer.call([], arr, binary_function))
  end
end
