class HomeController < ApplicationController
    def index
    end

    def show
    end

    def search
        redirect_back(fallback_location: home_path) if params[:query].blank?
        @query = params[:query]
        @items = Item.search(@query)
        if current_user.role?:admin
            @customers = Customer.search(@query)
            @total_hits = @customer.size + @items.size
        end
    end

    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

end
