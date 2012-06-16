class SessionsController < ApplicationController
  def create
    session[:user_id] = User.find(params[:id]).id
    redirect_to :back
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back
  end
end