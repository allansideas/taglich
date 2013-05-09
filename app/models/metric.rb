class Metric < ActiveRecord::Base
  attr_accessible :name, :score, :score_type, :sort_order, :state
  SCORE_TYPES = %w{big_number small_number boolean}

  validates :score_type, :inclusion => { :in => SCORE_TYPES, :message => "%{value} is not a valid score type."}
  has_many :metric_scores
  belongs_to :user
  scope :active, where(state: 'active')
end
