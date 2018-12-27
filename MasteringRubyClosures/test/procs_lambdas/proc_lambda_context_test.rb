require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
require_relative '../../code/procs_lambdas/someclass'
Minitest::Reporters.use!

class ProcLambdaContextTest < Minitest::Test
  attr_accessor :obj

  def setup
    @obj = SomeClass.new
  end

  def call_proc
    puts "before Proc"
    my_proc = Proc.new { return 1 }
    my_proc.call
    puts "after Proc"
  end

  def call_proc_in_method
    obj.method_that_calls_proc_or_lambda(Proc.new { return "foo" })
  end

  def test_call_proc_method
    x = 0
    assert_output("before Proc\n") { x = call_proc }
    assert_equal(1, x)
  end

  def test_lambda_context
    # this test shows that a Lambda returns from the block
    # of code associated with it, this is why the second puts
    # statment got executed in #method_that_calls_proc_or_lambda
    x = 0
    expected_output = "calling Lambda now!\nLambda gets called!\n"
    assert_output(expected_output) do
      x = obj.method_that_calls_proc_or_lambda(->{ return })
    end
    assert_nil(x)
  end

  def test_proc_context
    # this test shows that a Proc returns from the context
    # in which it was defined.  The Proc was defined #call_proc_in_method
    # but the call took place in #method_that_calls_proc_or_lambda
    # however the return is from where the Proc is defined so it returns
    # from #call_proc_in_method and it returns "foo"
    x = 0
    assert_output("calling Proc now!\n") do
      x = call_proc_in_method
    end
    assert_equal("foo", x)
  end
end
