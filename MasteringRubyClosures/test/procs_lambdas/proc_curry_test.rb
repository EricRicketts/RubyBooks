require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class ProcCurryTest < Minitest::Test
  attr_accessor :discriminant_v1, :discriminant_v2, :sum

  def setup
    @discriminant_v1 = lambda { |a, b, c| b**2 - 4*a*c }
    @discriminant_v2 = lambda { |a, b, c| b**2 - 4*a*c }.curry
    @sum = lambda do |function, start, stop|
      (start..stop).inject { |sum, x| sum + function.call(x) }
    end
  end

  def test_first_discriminant
    assert_equal(-104, discriminant_v1.call(5, 6, 7))
  end

  def test_second_discriminant_at_once
    assert_equal(-104, discriminant_v2.call(5).call(6).call(7))
  end

  def test_second_discriminant_one_at_a_time
    expected = Array.new(2, -104)
    needs_two_numbers = discriminant_v2.call(5)
    needs_one_number = discriminant_v2.call(5).call(6)
    result = [needs_two_numbers.call(6).call(7), needs_one_number.call(7)]
    assert_equal(expected, result)
  end

  def test_sum_of_ints
    sum_of_ints = sum.curry.call(lambda { |x| x })
    assert_equal(55, sum_of_ints.(1).(10))
  end

  def test_sum_of_squares
    sum_of_squares = sum.curry.call(lambda { |x| x*x })
    assert_equal(385, sum_of_squares.(1).(10))
  end
end
