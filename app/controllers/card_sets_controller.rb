class CardSetsController < ApplicationController
  def create
    @card_set = CardSet.new(params[:card_set])

    if @card_set.save
      @card_set.build_cards_for(current_user)
      render json: current_user.card_scores, root: false
    end
  end
end
