class CardsController < ApplicationController
  def index
    @cards = []
    current_user.card_sets.each do |cs|
      puts cs
      cs.cards.map {|c| @cards << c}
    end
    render json: @cards, root:false
  end

  def show
    @card = Card.find(params[:id])
    render json: @card, root:false
  end

  def only_ids
    @card_ids = []
    current_user.card_sets.each do |cs|
      cs.card_ids.map {|cid| @card_ids << cid}
    end
    render json: @card_ids.to_json, root: false
  end

  def update_score
    @card = Card.find(params[:id])
    case params[:score]
      when 'correct'
        @card.correct_count += 1
      when 'incorrect'
        @card.incorrect_count += 1
    end
    @card.last_interacted_at = Time.zone.now.to_date
    if @card.save
      render json: @card, root: false
    else
      render :nothing => true, :status => 500
    end
  end

  def update_seen
    @card = Card.find(params[:id])
    @card.seen_times += 1
    @card.last_seen_at = Time.zone.now
    if @card.save
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end

end
