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

    def create
        @address = Address.new(address_params)
        if @address.save
            flash[:notice] = "The address was added to #{@address.customer.proper_name}."
            redirect_to customer_path(@address.customer_id) 
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

    # def customer_params
    #     params.require(:customer).permit(:first_name,:last_name,:email,:phone,:active)
    # end

    def address_params
        params.require(:address).permit(:customer_id, :recipient, :street_1, :city, :state, :zip, :active, :is_billing)
    end
end
