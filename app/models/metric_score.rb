class MetricScore < ActiveRecord::Base
  attr_accessible :user, :day, :metric, :score
  belongs_to :day
  belongs_to :metric
  default_scope joins(:metric).order('metrics.sort_order ASC, metric_scores.created_at desc').readonly(false)
end
