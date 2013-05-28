class CardSerializer < ActiveModel::Serializer
  has_many :card_steps
end
