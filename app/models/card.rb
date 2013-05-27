class Card < ActiveRecord::Base
  attr_accessible :card_set_id
  belongs_to :card_set
  has_many :card_steps
  has_many :card_scores
end
