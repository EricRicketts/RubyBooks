require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class File
  def self.my_open(name, mode)
    file = File.new(name, mode)
    return file unless block_given?

    yield(file)
  ensure
    file.close
  end
end

class Exercise3Test < Minitest::Test

  def test_File_my_open
    result = []
    expected = [
      "This is a test.\n",
      "This is a sentence.\n",
      "This is the final sentence."
    ]
    File.my_open("./exercise_3.txt", "r") do |f|
      f.each_line do |line|
        result << line
      end
    end
    assert_equal(expected, result)
  end
end
