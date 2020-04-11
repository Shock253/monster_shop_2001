class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart,
                :current_user,
                :current_regular?,
                :current_merchant?,
                :current_admin?,
                :visitor?

  def cart
    @cart ||= Cart.new(session[:cart] ||= {} )
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_regular?
    current_user && current_user.regular?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def visitor?
    current_user.nil?
  end

end
