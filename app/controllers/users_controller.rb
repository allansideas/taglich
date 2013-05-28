class UsersController < ApplicationController
  def cards
    @user = User.find_by_id(params[:user_id])
    @user_cards = @user.cards
    render json: @user.cards
  end
end
