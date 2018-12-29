require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

module Enumerable
  def filter_map(&block)
    self.map(&block).compact
  end
end

class NonLazyFilterMapTest < Minitest::Test

  def test_filter_map
    expected = [4, 16, 36, 64, 100]
    result = (1..10).filter_map { |x| x*x if x.even? }
    assert_equal(expected, result)
  end

end
