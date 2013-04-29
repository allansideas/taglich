class MetricScore < ActiveRecord::Base
  attr_accessible :user, :day, :metric, :score
  belongs_to :day
  belongs_to :metric
end
