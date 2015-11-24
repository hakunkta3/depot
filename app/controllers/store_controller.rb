class StoreController < ApplicationController
  skip_before_action :authorize

  def index

    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      @products = Product.order(:title)
      @cart = current_cart
    end


    # #デバッグ用
    # puts "-------------------------"
    # puts session[:counter]
    # puts "-------------------------"

    if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
    end

    @counter = session[:counter]
    @cart = current_cart
  end

end
