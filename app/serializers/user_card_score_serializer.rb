class UserCardScoreSerializer < ActiveModel::Serializer
  attributes :id, :card
  has_one :card
end
