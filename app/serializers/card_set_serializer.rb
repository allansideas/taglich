class CardSetSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_cards

  def total_cards
    object.cards.size
  end
end
