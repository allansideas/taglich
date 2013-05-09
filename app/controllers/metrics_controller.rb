class MetricsController < ApplicationController
  def index
    @metrics = current_user.metrics
    render json: @metrics
  end

  def update
    render json: Metric.update(params[:id], params[:metric]), root: false
  end

  def create
    @metric = Metric.new(params[:metric])
    @metric.user = User.find(params[:user_id])
    if @metric.save!
      render json: @metric, root: false
    else
      render json: @metric, root: false
    end
  end

  def sort
    params[:metrics].each_with_index do |id, index|
      Metric.update_all({sort_order: index+1}, {id: id})
    end
    render nothing: true
  end
end
