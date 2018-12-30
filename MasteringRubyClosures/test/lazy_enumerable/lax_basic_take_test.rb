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

  def take(n)
    taken = 0
    Lax.new(self) do |yielder, val|
      if taken < n
        yielder << val
        taken += 1
      else
        raise StopIteration
      end
    end
  end
end

class LaxBasicTest < Minitest::Test

  def test_lax_basic_take
    expected = [2, 5, 10, 17, 26]
    result = 1.upto(Float::INFINITY).lax.map { |x| x*x }.map { |x| x + 1 }.take(5).to_a
    assert_equal(expected, result)
  end
end
