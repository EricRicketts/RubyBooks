require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require 'ostruct'
require_relative '../../code/closures/generator'
require_relative '../../code/closures/notifier'

class ImplementingNotifierTest < Minitest::Test
  attr_accessor :good_report, :bad_report

  def setup
    @good_report = OpenStruct.new(to_csv: '59.99, Great Success')
    @bad_report = OpenStruct.new(to_csv: nil)
  end

  def test_good_report
    success = Minitest::Mock.new
    failure = Minitest::Mock.new
    success.expect(:call, good_report.to_csv, [good_report.to_csv])
    notify = Notifier.new(Generator.new(good_report),
      on_success: success,
      on_failure: failure
    ).tap do |n|
      n.run
    end
    assert_mock(success)
  end

  def test_bad_report
    success = Minitest::Mock.new
    failure = Minitest::Mock.new
    failure.expect(:call, true, [])
    notify = Notifier.new(Generator.new(bad_report),
      on_success: success,
      on_failure: failure
    ).tap do |n|
      n.run
    end
    assert_mock(failure)
  end
end
