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
    owed = Hash.new(0)
    @activities.each do |activity|
      activity.participants.each do |name, paid|
        owed[name] += activity.owed[name]
      end
    end
    owed
  end

  def summary
    string = ""
    breakout.each do |name, owed|
      string.concat("#{name}: #{owed}\n")
    end
    string.chomp
  end

end
