class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites 

  def favorites
    session[:favorites] ||= []
    Favorite.new(session[:favorites])
  end
end
