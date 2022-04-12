class OrdersController < ApplicationController
    include AppHelpers::Shipping
    include AppHelpers::Cart
    require 'will_paginate/array'
    before_action :set_order, only: [:show]
    before_action :check_login
    authorize_resource

    def index
        @orders = Order.chronological.all.paginate(page: params[:page]).per_page(15)
        if current_user.role? :admin
            @pending_orders = Order.chronological.all.paginate(page: params[:page]).per_page(10) - Order.paid.all.paginate(page: params[:page]).per_page(10)
            @past_orders = Order.paid.chronological.all.paginate(page: params[:page]).per_page(10)
        elsif current_user.role? :customer
            @all_orders = Order.for_customer(@customer).all.paginate(page: params[:page]).per_page(10)
        end

    end

    def show
        @previous_orders = Order.for_customer(@customer).chronological.all.paginate(page: params[:page]).per_page(15) - [@order]
        @order_items = @order.order_items.all.paginate(page: params[:page]).per_page(15)
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
