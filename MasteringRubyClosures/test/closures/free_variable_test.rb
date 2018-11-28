require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class FreeVariableTest < Minitest::Test
  attr_accessor :chalkboard_gag

  def setup
    @chalkboard_gag = lambda do |msg|
      lambda do
        prefix = "I will not"
        "#{prefix} #{msg}"
      end
    end
  end

  def test_one
    inner_lambda = chalkboard_gag.call("drive the principle's car.")
    assert_equal([Proc, Proc], [chalkboard_gag.class, inner_lambda.class])
  end

  def test_two
    expected = "I will not drive the principle's car."
    msg = "drive the principle's car."
    assert_equal(expected, chalkboard_gag.call(msg).call)
  end
end

=begin
the instance variable @chalkboard_gag is defined as a lambda, but the
return value of this lambda is another lambda.

When we define inner_lambda = chalkboard_gag.call(msg) the local
variable inner_lambda is a lambda because this is what the call to
chalkboard_gag returns.

Note the inner lambda has a body of code where the local variable prefix
is defined, however, the variable msg is passed in as a block parameter
to the outer lambda making it the free variable within the inner lambda.
We also refer to this outer lambda as the enclosing lexical scope and this
is where the free variable msg is defined.
=end
