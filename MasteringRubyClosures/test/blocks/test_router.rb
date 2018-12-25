require 'minitest/autorun'
require 'minitest/pride'
require 'spy'
require 'pry-byebug'

class TestRouter < Minitest::Test

  class Router
    def initialize(&block)
      instance_eval(&block)
    end

    def match(route)
      route
    end
  end

  class Foo
    def initialize
      yield self
    end

    def match(route)
      route
    end
  end

  def test_route
    spy = Spy.on_instance_method(Router, :match)
    router = Router.new do
      match "/about" => "home#about"
    end
    verify_call_args = spy.has_been_called_with?({ "/about" => "home#about" })
    assert(spy.calls.size == 1 && verify_call_args)
  end

  def test_foo_route
    err = assert_raises(NoMethodError) do
      foo = Foo.new do
        match "/about" => "home#about"
      end
    end
    assert_match(/undefined method `match' for #<TestRouter/, err.message)
  end
end
