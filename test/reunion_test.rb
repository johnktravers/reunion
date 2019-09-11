require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'
require './lib/reunion'

class ReunionTest < Minitest::Test

  def setup
    @reunion = Reunion.new("1406 BE")

    @brunch = Activity.new("Brunch")
    @drinks = Activity.new("Drinks")
  end

  def test_it_exists
    assert_instance_of Reunion, @reunion
  end

  def test_initialize
    assert_equal "1406 BE", @reunion.name
    assert_equal [], @reunion.activities
  end

  def test_add_activity
    @reunion.add_activity(@brunch)
    assert_equal [@brunch], @reunion.activities

    @reunion.add_activity(@drinks)
    assert_equal [@brunch, @drinks], @reunion.activities
  end

  def test_total_cost
    add_participants
    @reunion.add_activity(@brunch)
    assert_equal 60, @reunion.total_cost

    @reunion.add_activity(@drinks)
    assert_equal 180, @reunion.total_cost
  end

  def test_breakout
    add_participants
    add_activities

    expected = {"Maria" => -10, "Luther" => -30, "Louis" => 40}
    assert_equal expected, @reunion.breakout
  end

  def test_summary
    add_participants
    add_activities

    expected = "Maria: -10\nLuther: -30\nLouis: 40"
    assert_equal expected, @reunion.summary
  end



  #------------- Helper Methods -------------#

  def add_participants
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    @drinks.add_participant("Maria", 60)
    @drinks.add_participant("Luther", 60)
    @drinks.add_participant("Louis", 0)
  end

  def add_activities
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)
  end

end
