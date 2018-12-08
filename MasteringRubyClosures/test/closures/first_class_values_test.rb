require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class FirstClassValuesTest < Minitest::Test
  attr_reader :is_even, :expected

  def setup
    @is_even = lambda { |n| n % 2 == 0 }
    @expected = [true, false]
  end

  def complement_version_one(predicate, value)
    not predicate.call(value)
  end

  def complement_version_two(predicate)
    lambda do |value|
      not predicate.call(value)
    end
  end

  def test_version_one
    result = [
      complement_version_one(is_even, 5),
      complement_version_one(is_even, 4)
    ]
    assert_equal(expected, result)
  end

  def test_version_two
    x = complement_version_two(is_even)
    result = [x.call(5), x.call(4)]
    assert_equal(expected, result)
  end
end

=begin
Something is considered as a first class value, sometimes called
first class citizen if it can do 3 things:

1.  thing in question can be assigned to a variable, notice
instance variable @is_even is assigned to a lambda
2.  thing in question can be passed into to a method as
part of a method parameter list.  Notice in both versions
of #complement predicate is a lambda.
3.  Finally, thing in question can serve as a return value
from a method, note in @complement_version_two this is what
is happening.
=end
