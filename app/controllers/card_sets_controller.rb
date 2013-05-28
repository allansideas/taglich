class CardSetsController < ApplicationController
  def create
    @card_set = CardSet.new(params[:card_set])

    #assuming url for now add creation later if fed back
    if @card_set.save
      @card_set = build_cards(@card_set)
      current_user.card_sets << @card_set
      @card_set.cards.each do |card|
        card.build_score(current_user)
      end
      render json: @card_set, root: false
    end
  end

end
