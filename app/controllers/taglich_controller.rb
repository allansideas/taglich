class TaglichController < ApplicationController
  before_filter :authenticate_user!

  def index
    @today = Day.where(date: Date.today, user_id: current_user.id).first
    if @today.blank?
      Day.create_first_or_fill_in_days(current_user)
    end
  end
end
