class UsersController < ApplicationController
  def current
    render json: current_user, root: false
  end
  #old
  def cards
    @user = User.find_by_id(params[:user_id])
    @user_cards = @user.cards
    render json: @user.cards
  end
end
