require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
require_relative '../../code/lazy_enumerable/final/lax'
Minitest::Reporters.use!


class Lax
  def drop(n, &block)
    dropped = 0
    Lax.new(self) do |yielder, val|
      if dropped < n
        dropped += 1
      else
        yielder << val
      end
    end
  end
end

class Exercise2Test < Minitest::Test

  def test_lax_drop
    expected = [5, 6]
    result = 1.upto(Float::INFINITY).lax.map { |x| x + 1 }.take(5).drop(3).to_a
    assert_equal(expected, result)
  end
end
