class MetricScoresController < ApplicationController
  def index
    @day = Day.where(date: Date.today, user_id: current_user.id).first
    @metric_scores = MetricScore.find(:all, joins: :metric, order: 'metric.sort_order ASC').where(user: current_user, day: @day)
    render json: @metric_scores
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
    metric_id = metric_score.metric.id
    @data = []
    current_user.days.each do |d|
      d.metric_scores.where(metric_id: metric_id).order('created_at desc').each do |ms|
        @data << [d.date.to_time.utc.to_i, ms.score]
      end
    end
    render json: @data
  end
end
