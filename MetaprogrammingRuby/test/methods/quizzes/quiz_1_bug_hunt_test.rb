require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Roulette
  def method_missing(name, *args)
    arr = []
    person = name.to_s.capitalize
    3.times do
      number = rand(10) + 1
      arr << "#{number} ..."
    end
    arr << "#{person} got a #{number}"
    arr
  end
end

class RouletteFix
  def method_missing(name, *args)
    arr = []
    number = 0
    person = name.to_s.capitalize
    super unless %w[Bob Bill Fred Stan].include?(person)
    3.times do
      number = rand(10) + 1
      arr << number
    end
    arr << "#{person} got a #{number}"
    arr
  end
end

=begin
We are going to have a SytemsStackError noted below
because the block variable number goes out of scope
outside of the #times block.  Thus Ruby moves up the
method hiearch until it hits method_missing, but
method_missing has been overridden in this class, so
it gets called again at "#{person} got a #{number}" at
the invocation of number which it interprets as a method.

After checking with the Quiz Solution in the book, my
explanation of the behavior was correct.  This makes me
feel pretty good.  One thing I should not is what initiates
the call to #method_missing?  Well, in line 13, there is
no explicit receiver so the method gets called on 'self', which
is an instance of the Roulette class.
=end
class Quiz1BugHuntTest < Minitest::Test

  def test_original_roulette
    message = 'stack level too deep'
    number_of = Roulette.new
    exception = assert_raises(SystemStackError) { number_of.bob }
    assert_equal(message, exception.message)
  end

  def test_roulette_fix
    number_of = RouletteFix.new
    results = number_of.bob
    assert results[0..-2].all?(Integer)
    assert_match(/Bob got a \d+/, results.last)
  end

  def test_roulette_fix_wrong_name
    number_of = RouletteFix.new
    assert_raises(NoMethodError) { number_of.elmer }
  end
end
