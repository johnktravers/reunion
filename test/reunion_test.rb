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

end
