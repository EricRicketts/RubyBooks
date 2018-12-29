require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Enumerator::Lazy
  def filter_map
    Lazy.new(self) do |yielder, *values|
      binding.pry
      result = yield(*values)
      yielder << result if result
    end
  end
end

class LazyFilterMapTest < Minitest::Test

  def test_lazy_filter_map
    expected = [4, 16, 36, 64, 100]
    result = 1.upto(Float::INFINITY).lazy.filter_map { |x| x*x if x.even? }.first(5)
    assert_equal(expected, result)
  end
end
