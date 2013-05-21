class TaglichController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless current_user.time_zone
      current_user.update_attributes(:time_zone => cookies["jstz_time_zone"])
    else

    end
    @today = Day.where(date: Time.zone.now.to_date, user_id: current_user.id).first
    if @today.blank?
      Day.create_first_or_fill_in_days(current_user)
    end
  end
end
