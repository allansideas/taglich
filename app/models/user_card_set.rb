class UserCardSet < ActiveRecord::Base
  attr_accessible :card_set_id, :user_id
  belongs_to :card_set
  belongs_to :user
end
