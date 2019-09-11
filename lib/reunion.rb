class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities.push(activity)
  end

  def total_cost
    @activities.sum { |activity| activity.total_cost }
  end

  def breakout
    debt = Hash.new(0)
    @activities.each do |activity|
      activity.owed.each do |name, money_owed|
        debt[name] += money_owed
      end
    end
    debt
  end

  def summary
    string = ""
    breakout.each do |name, owed|
      string.concat("#{name}: #{owed}\n")
    end
    string.chomp
  end

  def detailed_breakout
    debt = Hash.new { |h,k| h[k] = Array.new }
    @activities.each do |activity|
      activity.owed.each do |name, owed|

        payees = []
        activity.owed.each do |payee, amount|
          if (owed > 0 && amount < 0) || (owed < 0 && amount > 0)
            payees.push(payee)
          end
        end

        debt[name].push(
          {
            activity: activity.name,
            payees: payees,
            amount: owed / payees.length
          }
        )
      end
    end
    debt
  end

end
