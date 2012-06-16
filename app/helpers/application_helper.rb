module ApplicationHelper

  def current_user
    session[:user_id] && User.find_by_id(session[:user_id])
  end

end
