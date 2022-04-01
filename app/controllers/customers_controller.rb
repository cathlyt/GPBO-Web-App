
class CustomersController < ApplicationController
    before_action :set_customer, only: [:show,:edit]

    def index
        @customers = Customer.alphabetical.all
        @active_customers = Customer.active.all
        @inactive_customers = Customer.inactive.all
    end
    
    def show
        check_login
        if @current_user.nil?
            return
        end

        if @current_user.role?(:admin) or @current_user.role?(:customer)
            authorize! :show, @customer
            # unsure!!
            @previous_orders = Order.all
            @addresses = Address.all
        end

        
    end

    def create
        
        @customer = Customer.new(customer_params)
        @user = User.new(user_params)
        # byebug
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
