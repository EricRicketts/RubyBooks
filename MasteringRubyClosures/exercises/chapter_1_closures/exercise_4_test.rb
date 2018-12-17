require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Exercise4Test < Minitest::Test
  attr_accessor :complement, :is_even

  def setup
    @is_even = lambda { |value| value.even? }
    @complement = lambda do |predicate|
      lambda do |value|
        not predicate.call(value)
      end
    end
  end

  def test_even_number
    refute(complement.call(is_even).call(4))
  end

  def test_odd_number
    assert(complement.call(is_even).call(5))
  end
end
