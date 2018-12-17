require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Exercise2Test < Minitest::Test

  def is_larger_than(amount)
    lambda do |a|
      a > amount
    end
  end

  def test_1
    expected = [false, false, true]
    larger_than_five_5 = is_larger_than(5)
    result = [
      larger_than_five_5.call(4),
      larger_than_five_5.call(5),
      larger_than_five_5.call(6)
    ]
    assert_equal(expected, result)
    # I would say both a and amount are free variables
    # because they are declared outside of the do...end
    # block of the lambda
  end
end
