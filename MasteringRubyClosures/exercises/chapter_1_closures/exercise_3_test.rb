require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Exercise3Test < Minitest::Test
  attr_accessor :db, :db1, :db2

  def setup
    new_db = lambda do
      hsh = {}

      {
        insert: lambda { |band, song| hsh[band] = song },
        delete: lambda do |band|
          deleted_song = hsh[band]
          hsh[band] = nil
          deleted_song
        end,
        dump: lambda { hsh }
      }
    end
    @db = new_db.call
    @db1 = new_db.call
    @db2 = new_db.call
  end

  def test_db_init
    assert_instance_of(Hash, db)
  end

  def test_add_delete_dump_db
    result1 = db[:insert].call("Eagles", "Hell Freezes Over")
    result2 = db[:insert].call("Pink Floyd", "The Wall")
    result3 = db[:dump].call
    result = [result1, result2, result3]
    expected = [
      "Hell Freezes Over",
      "The Wall",
      { "Eagles" => "Hell Freezes Over",
        "Pink Floyd" => "The Wall"
      }
    ]
    assert_equal(expected, result)

    result4 = db[:delete].call("Pink Floyd")
    result = [result4, db[:dump].call]
    expected = [
      "The Wall",
      { "Eagles" => "Hell Freezes Over",
        "Pink Floyd" => nil
      }
    ]
    assert_equal(result, expected)
  end

  def test_dbs_are_different
    db1[:insert].call("Abba", "The Eagle")
    db2[:insert].call("Fleetwood Mac", "Dreams")
    expected = [
      { "Abba" => "The Eagle" },
      { "Fleetwood Mac" => "Dreams" }
    ]
    result = [db1[:dump].call, db2[:dump].call]
    assert_equal(expected, result)
  end
end
