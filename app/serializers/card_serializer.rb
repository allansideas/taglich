class CardSerializer < ActiveModel::Serializer
  attributes :id, :steps
  has_many :steps
  has_one :card_set
end
