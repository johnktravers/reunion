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
    add_maria_luther_louis
    @reunion.add_activity(@brunch)
    assert_equal 60, @reunion.total_cost

    @reunion.add_activity(@drinks)
    assert_equal 180, @reunion.total_cost
  end

  def test_breakout
    add_maria_luther_louis
    add_brunch_and_drinks

    expected = {"Maria" => -10, "Luther" => -30, "Louis" => 40}
    assert_equal expected, @reunion.breakout
  end

  def test_summary
    add_maria_luther_louis
    add_brunch_and_drinks

    expected = "Maria: -10\nLuther: -30\nLouis: 40"
    assert_equal expected, @reunion.summary
  end

  def test_detailed_breakout
    add_all_activities_and_participants

    expected =
      {
        "Maria" => [
          {
            activity: "Brunch",
            payees: ["Luther"],
            amount: 10
          },
          {
            activity: "Drinks",
            payees: ["Louis"],
            amount: -20
          },
          {
            activity: "Bowling",
            payees: ["Louis"],
            amount: 10
          },
          {
            activity: "Jet Skiing",
            payees: ["Louis", "Nemo"],
            amount: 10
          }
        ],
        "Luther" => [
          {
            activity: "Brunch",
            payees: ["Maria"],
            amount: -10
          },
          {
            activity: "Drinks",
            payees: ["Louis"],
            amount: -20
          },
          {
            activity: "Bowling",
            payees: ["Louis"],
            amount: 10
          },
          {
            activity: "Jet Skiing",
            payees: ["Louis", "Nemo"],
            amount: 10
          }
        ],
        "Louis" => [
          {
            activity: "Drinks",
            payees: ["Maria", "Luther"],
            amount: 20
          },
          {
            activity: "Bowling",
            payees: ["Maria", "Luther"],
            amount: -10
          },
          {
            activity: "Jet Skiing",
            payees: ["Maria", "Luther"],
            amount: -10
          }
        ],
        "Nemo" => [
          {
            activity: "Jet Skiing",
            payees: ["Maria", "Luther"],
            amount: -10
          }
        ]
      }
    assert_equal expected, @reunion.detailed_breakout
  end



  #------------- Helper Methods -------------#

  def add_maria_luther_louis
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    @drinks.add_participant("Maria", 60)
    @drinks.add_participant("Luther", 60)
    @drinks.add_participant("Louis", 0)
  end

  def add_brunch_and_drinks
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)
  end

  def add_all_activities_and_participants
    add_maria_luther_louis
    add_brunch_and_drinks

    @bowling = Activity.new("Bowling")
    @bowling.add_participant("Maria", 0)
    @bowling.add_participant("Luther", 0)
    @bowling.add_participant("Louis", 30)

    @jetski = Activity.new("Jet Skiing")
    @jetski.add_participant("Maria", 0)
    @jetski.add_participant("Luther", 0)
    @jetski.add_participant("Louis", 40)
    @jetski.add_participant("Nemo", 40)

    @reunion.add_activity(@bowling)
    @reunion.add_activity(@jetski)
  end

end
