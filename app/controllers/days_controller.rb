class DaysController < ApplicationController
  def find_by_date
    incoming_date = params[:year] + "/" + params[:month] + "/" + params[:day]
    incoming_date = Date.strptime(incoming_date, "%Y/%m/%d")
    @day = current_user.days.where(date: incoming_date).first
    #@metric_scores = MetricScore.includes(:metric).where(day_id: @day.id).order('metrics.sort_order ASC')
    #@day.metric_scores = @metric_scores
    render json: @day, root: false
  end
end

