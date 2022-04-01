
class CustomersController < ApplicationController
    before_action :set_customer, only: [:show,:edit,:update]

    def index
        @customers = Customer.alphabetical.all
        @active_customers = Customer.active.alphabetical.all
        @inactive_customers = Customer.inactive.alphabetical.all
    end
    
    def show
        check_login
        if logged_in?
            authorize! :show, @customer
            @previous_orders = @customer.orders
            @addresses = @customer.addresses
        end
    end

    def create
        @customer = Customer.new(customer_params)
        @user = User.new(user_params)
        @user.role = "customer"
        if !@user.save
            @customer.valid?
            render action: 'new'
        else
            @customer.user_id = @user.id
            if @customer.save
                flash[:notice] = "#{@customer.proper_name} was added to the system."
                redirect_to customer_path(@customer) 
            else
                render action: 'new'
            end      
        end
    end

    def edit
        authorize! :edit, @customer
    end

    def update
        if @customer.update_attributes(customer_params)
            flash[:notice] = "Successfully updated #{@customer.proper_name}."
            redirect_to customer_url
        else
            render action: 'edit'
        end
    end

    
    private
    def set_customer
        @customer = Customer.find(params[:id])
    end

    def customer_params
        params.require(:customer).permit(:first_name,:last_name,:email,:phone,:active)
    end

    def user_params
        params.require(:customer).permit(:username, :active, :role, :greeting, :password, :password_confirmation)
    end


end
