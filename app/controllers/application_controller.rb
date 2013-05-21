class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone 

  layout 'angular'

  def index

  end

  def set_timezone  
    if current_user && current_user.time_zone
      Time.zone = current_user.time_zone if current_user
    else
      Time.zone = cookies["jstz_time_zone"]
    end
  end
end
