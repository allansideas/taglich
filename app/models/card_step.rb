class CardStep < ActiveRecord::Base
  attr_accessible :card_id, :content
  belongs_to :card
end
