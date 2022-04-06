class OrdersController < ApplicationController
    before_action :set_order, only: [:show]
    before_action :check_login
    authorize_resource

    def index
        @order = Order.chronological.all
        if logged_in?
            authorize! :index, @admin
            @pending_orders = Order.paid.chronological.all
            @past_orders = Order.chronological.all - Order.paid.chronological.all
        elsif logged_in?
            authorize! :index, @customer
            @all_orders = Order.for_customer(@customer)
        end

    end

    def show
        @previous_orders = Order.find(params[:customer_id])
        @order_items = @order.order_items
    end

    private
    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:customer_id,:address_id,:credit_card_number,:expiration_year,:expiration_month )
    end
end
