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
    # the correct answer is that amount is the free variable
    # I orgininally thought it was amount and a, but since
    # a is the block parameter for the lambda in question, it
    # is not a free variable, the free variable amount is defined
    # in the parent scope which in this case is the method parameter
    # list, but remember, amount is also a local variable with respect
    # to the method body so in that case it is defined in a parent
    # scope relative to the lambda
  end
end
