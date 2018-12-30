require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
require_relative '../../code/lazy_enumerable/final/lax'
Minitest::Reporters.use!


class Lax
  def select(&block)
    Lax.new(self) do |yielder, val|
      yielder << val if block.call(val)
    end
  end
end

class Exercise1Test < Minitest::Test

  def test_lax_select
    expected = [1, 3, 5, 7, 9]
    result = 1.upto(Float::INFINITY).lax.select { |x| x.odd? }.take(5).to_a
    assert_equal(expected, result)
  end
end
