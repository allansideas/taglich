class MetricScoresController < ApplicationController
  def index
    @day = Day.where(date: Date.today, user_id: current_user.id).first
    @metric_scores = @day.metric_scores
    render json: @metric_scores
  end

  def update
    render json: MetricScore.update(params[:id], params[:metric_score]), root: false
  end
end
