class UserSerializer < ActiveModel::Serializer
  attributes :id, :email 

  def attributes
    data = super
    data[:cards] = build_cards
    data
  end

  def build_cards
    @data = []
    object.cards.each do |card|
      #card[:scores] = UserCardScore.where(user_id: object.id, card_id: card.id)
      card[:steps] = card.card_steps
      @data << card
    end
    @data
  end
end
