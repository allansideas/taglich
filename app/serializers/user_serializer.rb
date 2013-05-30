class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :user_card_scores
  has_many :user_card_scores, key: :card_scores


  def attributes
    data = super
    data[:card_sets] = build_card_sets
    data
  end

  def build_card_sets
    unless object.card_scores.blank?
      card_set_ids = object.card_scores.all.map{|cs|  cs.card.card_set_id }.uniq!.join(' ')
      card_set_ids = card_set_ids.split(' ').map(&:to_i)
      puts card_set_ids.inspect
      CardSet.where(id: card_set_ids)
    else 
      false
    end
  end
end
