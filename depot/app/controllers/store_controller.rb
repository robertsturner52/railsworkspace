class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
    if session[:counter].nil?
      @visits = 1
    else
      @visits = session[:counter] + 1
    end
    session[:counter] = @visits
  end
end
