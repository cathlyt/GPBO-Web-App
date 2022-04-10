class OrdersController < ApplicationController
    include AppHelpers::Shipping
    include AppHelpers::Cart
    before_action :set_order, only: [:show]
    before_action :check_login
    authorize_resource

    def index
        @order = Order.chronological.all
        if current_user.role? :admin
            @pending_orders = Order.paid.chronological.all
            @past_orders = Order.chronological.all - Order.not_shipped
        elsif current_user.role? :customer
            @all_orders = Order.for_customer(@customer)
        end

    end

    def show
        @previous_orders = Order.for_customer(@customer) - [@order]
        @order_items = @order.order_items
    end
    

    def create
        @order = Order.new(order_params)
        @order.date = Date.today
        @order.products_total = calculate_cart_items_cost
        @order.shipping = calculate_cart_shipping
        if @order.save
            # puts "order saved"
            flash[:notice] = "Thank you for ordering from GPBO."
            redirect_to order_path(Order.last)
        else 
            if !@order.valid?
                redirect_to checkout_path
                return
            end
        end
    end

    private
    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:customer_id,:address_id,:credit_card_number,:expiration_year,:expiration_month)
    end
end
