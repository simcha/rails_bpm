
class RailsBpmController < ActionController::Base
  
  ITEMS_PER_PAGE = 10
  
  protect_from_forgery

  before_filter :login_required

  layout 'rails_bpm'

  protected # if it makes any sense

  def login_required

    return true if self.class == SessionsController
      # no login required for the login/logout screens

    return true if session[:username]

    redirect_to :controller => 'sessions', :action => 'new'
    false
  end
end
