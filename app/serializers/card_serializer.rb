class CardSerializer < ActiveModel::Serializer
  attributes :id, :front, :back, :correct_count, :incorrect_count, :last_seen_at
end
