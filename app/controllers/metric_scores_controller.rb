class MetricScoresController < ApplicationController
  def index
    @metric_scores = current_user.metric_scores.where(day_id: params[:day_id])
    render json: @metric_scores, root: false
  end

  def only_ids
    @metric_score_ids = current_user.days.find(params[:day_id]).metric_score_ids
    render json: @metric_score_ids.to_json
  end

  def show
    @metric_score = MetricScore.find(params[:id])
    render json: @metric_score, root: false
  end

  def update
    render json: MetricScore.update(params[:id], params[:metric_score]), root: false
  end

  def create
    @day = Day.find(params[:day_id])
    @metric = Metric.find(params[:metric_id])
    @ms = MetricScore.new
    @ms.day = @day
    @ms.metric = @metric
    if @ms.save!
      render json: @ms, root: false
    else
      render json: @ms, root: false
    end
  end

  def destroy
    @metric_score = MetricScore.find(params[:id])
    if @metric_score.destroy
      render json: @metric_score, root: false
    else
      render json: @metric_score, root: false, status: :unprocessable_entity
    end
  end

  def historical_data
    ms = MetricScore.find(params[:id])
    @data = []
    days = current_user.days.where('date < ? AND date >= ?', ms.day.date, ms.day.date - 8.days)
    days.each do |d|
      @data << MetricScore.where(day_id: d.id, metric_id: ms.metric.id).first
    end
    render json: @data, root: false
  end

  def graph_data
    metric_score = MetricScore.find(params[:id])
    @data = []
    past_scores = MetricScore.includes(:day, :metric).where("days.user_id = ? AND metric_scores.metric_id = ?", metric_score.day.user.id, metric_score.metric.id).order('days.date DESC').offset(1).reverse!
    if past_scores
      past_scores.each do |ps|
        @data << [ps.day.date.to_time.utc.to_i, ps.score]
      end
    end
    #If infact there are days with no scores use this, but they should be built each time user logs in
    #metric_score = MetricScore.find(params[:id])
    #metric_id = metric_score.metric.id
    #@data = []
    #current_user.days.each do |d|
      #d.metric_scores.includes(:day).where('metric_scores.metric_id = ?', metric_id).order('days.date desc').each do |ms|
        #@data << [d.date.to_time.utc.to_i, ms.score]
      #end
    #end
    render json: @data
  end
end
