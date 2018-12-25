require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

module ActiveRecord
  class Schema
    def self.define(version, &block)
      instance_eval(&block)
    end

    def self.create_table(table_name, options = {}, &block)
      t = Table.new(table_name, options)
      block.call(t) if block_given?
    end
  end

  class Table
    def initialize(name, options)
      @name = name
      @options = options
    end

    def string(value)
      puts "Creating columns of type string named #{value}"
    end

    def integer(value)
      puts "Creating columns of type integer named #{value}"
    end

    def datetime(value)
      puts "Creating columns of type datetime named #{value}"
    end
  end
end

class Exercise5Test < Minitest::Test

  def test_active_record
    expected = "Creating columns of type string named content\n" +
      "Creating columns of type integer named user_id\n" +
      "Creating columns of type datetime named created_at\n" +
      "Creating columns of type datetime named updated_at\n"

    assert_output(expected) do
      ActiveRecord::Schema.define(version: 20130315230445) do
        create_table "microposts", force: true do |t|
          t.string "content"
          t.integer "user_id"
          t.datetime "created_at"
          t.datetime "updated_at"
        end
      end
    end
  end
end
