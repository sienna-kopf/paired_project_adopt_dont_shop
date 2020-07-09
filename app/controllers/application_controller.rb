class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def favorites
    session[:favorites] ||= []
    binding.pry
    Favorite.new(session[:favorites])
  end
end
