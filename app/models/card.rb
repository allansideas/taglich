class Card < ActiveRecord::Base
  attr_accessible :card_set_id
  belongs_to :card_set
  has_many :card_steps
  has_many :user_card_scores

  def build_score(user)
    UserCardScore.create(user_id: user.id, card_id: self.id)
  end
end

