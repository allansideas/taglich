class Day < ActiveRecord::Base
  attr_accessible :date, :user, :metric_scores
  has_many :metric_scores
  belongs_to :user
end
