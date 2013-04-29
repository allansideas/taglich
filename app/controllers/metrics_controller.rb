class MetricsController < ApplicationController
  def index
    @metrics = current_user.metrics
    render json: @metrics
  end

  def update
    render json: Metric.update(params[:id], params[:metric]), root: false
  end
end
