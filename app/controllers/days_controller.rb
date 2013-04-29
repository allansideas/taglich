class DaysController < ApplicationController
  def yesterday
    @yesterday = Day.where(date: Date.today - 1.days).first
    render json: @yesterday, root: false
  end

  def week
    @week = Day.where(date: Date.today.at_beginning_of_week..Date.today)
    render json: @week
  end
end
