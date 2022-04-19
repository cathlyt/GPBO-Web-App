class AddressesController < ApplicationController
    before_action :set_address, only: [:show, :edit, :update]
    before_action :check_login
    authorize_resource

    def index
        @addresses = Address.all
        @active_addresses = Address.active.all
        @inactive_addresses = Address.inactive.all
    end

    def show
    end

    def new
        @address = Address.new
    end
    

    def create
        @address = Address.new(address_params)
        @address.customer = current_user.customer
        if @address.save
            flash[:notice] = "The address was added to #{@address.customer.proper_name}."
            redirect_to customer_path(@address.customer.id) 
        else
            render action: 'new'
        end      
    end

    def edit
    end

    def update
        if @address.update_attributes(address_params)
            flash[:notice] = "Successfully updated the address."
            redirect_to addresses_path
        else
            render action: 'edit'
        end
    end



    private
    def set_address
        @address = Address.find(params[:id])
    end

    def address_params
        params.require(:address).permit(:customer_id, :recipient, :street_1, :city, :state, :zip, :active, :is_billing)
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
