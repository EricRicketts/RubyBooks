require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

module Enumerable
  def lax
    Lax.new(self)
  end
end

class Lax < Enumerator

  def initialize(receiver)
    super() do |yielder|
      begin
        receiver.each do |val|
          if block_given?
            yield(yielder, val)
          else
            yielder << val
          end
        end
      rescue StopIteration
      end
    end
  end
end

class LaxBasicTest < Minitest::Test

  def test_lax_basic
    expected = [[1, 1], [2, 4], [3, 9]]
    iterator = [1, 2, 3].lax
    result = iterator.map { |x| [x, x*x] }
    assert_equal(expected, result)
  end

  def test_another_enumerator
    e = Enumerator.new do |yielder|
      [1, 2, 3].each do |val|
        yielder.yield(val) # yielder << val is aliased to this
      end
    end
    x1 = e.next
    x2 = e.next
    x3 = e.next
    assert_equal([1, 2, 3], [x1, x2, x3])
    assert_raises(StopIteration) { e.next }
  end
end
