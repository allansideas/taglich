class Day < ActiveRecord::Base
  attr_accessible :date, :user, :metric_scores
  has_many :metric_scores
  validate :date, :uniqueness => true, :scope => :user_id
  
  belongs_to :user

  def self.create_first_or_fill_in_days(user)
    user_last_day = user.days.last
    if user_last_day.blank? || user_last_day.date == Time.zone.now.to_date - 1.days 
      build_day(Time.zone.now.to_date, user)
    elsif user_last_day.date != Time.zone.now.to_date
      ((user_last_day.date + 1.day)..Time.zone.now.to_date).each do |date|
        build_day(date, user)
      end
    end
  end

  def self.build_day(date, user)
    day = Day.create({ date: date, user: user })
    user.metrics.active.each do |m|
      build_day_metrics(day, m)
    end
    day.save!
  end

  def self.build_day_metrics(day, metric_item)
    ms = MetricScore.new
    ms.day = day
    ms.metric = metric_item
    ms.save!
    day.metric_scores << ms
  end
end
