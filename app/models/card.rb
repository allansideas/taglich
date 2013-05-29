class Card < ActiveRecord::Base
  attr_accessible :card_set_id
  belongs_to :card_set
  has_many :user_card_scores
  has_many :steps, :foreign_key => 'card_id', :class_name => "CardStep", dependent: :destroy
end

