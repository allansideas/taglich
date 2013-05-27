class CardSet < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :cards
  has_many :user_card_sets
end
