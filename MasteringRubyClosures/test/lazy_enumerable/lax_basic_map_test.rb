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

  def map(&block)
    Lax.new(self) do |yielder, val|
      yielder << block.call(val)
    end
  end
end

class LaxBasicMapTest < Minitest::Test

  def test_lax_basic_map
    expected = [2, 5, 10, 17, 26]
    result = 1.upto(Float::INFINITY).lax.map { |x| x**2 }.map { |x| x + 1 }.first(5)
    assert_equal(expected, result)
  end
end
