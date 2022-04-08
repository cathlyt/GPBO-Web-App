class HomeController < ApplicationController
    def index
    end

    def show
    end
    
    def contact
    end

    def about
    end

    def search
        check_login
        if params[:query].blank?
            redirect_back(fallback_location: home_path) 
        end
        @query = params[:query]
        @items = Item.search(@query)
        if current_user.role? :customer
            @total_hits = @items.size
        end
        if current_user.role? :admin
            @customers = Customer.search(@query)
            @total_hits = @customers.size + @items.size
        end
        
    end

    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
