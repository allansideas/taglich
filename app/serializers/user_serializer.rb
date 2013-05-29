class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :user_card_scores
  has_many :user_card_scores, key: :card_scores
end
