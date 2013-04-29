class TaglichController < ApplicationController
  before_filter :authenticate_user!
  def index
    @day = Day.where(date: Date.today, user_id: current_user.id).first
    if @day.blank?
      @day = Day.create({ date: Date.today, user: current_user })
      puts current_user.metrics
      current_user.metrics.each do |m|
        @ms = MetricScore.new
        @ms.day = @day
        @ms.metric = m
        @ms.save!
        @day.metric_scores << @ms
      end
      @day.save!
    end
  end
end
