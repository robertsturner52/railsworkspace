#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :check_for_login
  before_action :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def check_for_login
    temp = User.find_by(id: session[:user_id])
    if temp
      @logged_in_user_name = temp.name
    end
  end

  protected

    def authorize
      unless User.find_by(id: session[:user_id]) || User.count.zero?
          redirect_to login_url, notice: "Please Log In"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).
            include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
              "#{params[:locale]} translation not available."
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

end
