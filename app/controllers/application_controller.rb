class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :now#, if: :whilelist
  before_action :authorize

  def now
      @time = Time.now
  end

  private

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "ログインして下さい"
    end
  end

  def whilelist
    %w{store products carts}.include?(controller_name)
  end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end


end
