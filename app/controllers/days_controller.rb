class DaysController < ApplicationController
  #def yesterday
    #@yesterday = Day.where(date: Date.today - 1.days).first
    #render json: @yesterday, root: false
  #end

  #not used
  #def current_week
    #@week = current_user.days.where(date: Date.today.at_beginning_of_week..Date.today)
    #render json: @week
  #end
  def find_by_date
    incoming_date = params[:year] + "/" + params[:month] + "/" + params[:day]
    incoming_date = Date.strptime(incoming_date, "%Y/%m/%d")
    @day = current_user.days.where(date: incoming_date).first
    @metric_scores = MetricScore.joins(:metric).where(day_id: @day.id).order('metrics.sort_order ASC')
    @day.metric_scores = @metric_scores
    render json: @day, root: false
  end
end

