class CardScoresController < ApplicationController
  def delete_card_scores_by_set
    @scores = UserCardScore.joins(:card).where("user_card_scores.user_id = ? AND cards.card_set_id = ?", current_user.id, params[:id])
    if @scores.destroy_all
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end

  def update_score
    @card_score = UserCardScore.find_or_create_by_user_id_and_card_id(params[:user_id], params[:card_id])
    case params[:score]
      when 'pass'
        @card_score.metric_1_count += 1
      when 'fail'
        @card_score.metric_2_count += 1
    end
    @card_score.last_interacted_at = Time.zone.now
    if @card_score.save
      render json: current_user.user_card_scores, root: false
    else
      render :nothing => true, :status => 500
    end
  end

  def update_seen
    @card_score = UserCardScore.find_or_create_by_user_id_and_card_id(params[:user_id], params[:card_id])
    @card_score.seen_times += 1
    @card_score.last_seen_at = Time.zone.now
    if @card_score.save
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end

end
