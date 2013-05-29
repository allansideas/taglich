class CardSerializer < ActiveModel::Serializer
  attributes :id, :steps
  has_many :steps
end
