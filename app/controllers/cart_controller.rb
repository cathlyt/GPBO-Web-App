
class CartController < ApplicationController
    include AppHelpers::Cart
    include AppHelpers::Shipping
    # before_action :check_login
    # before_action :subtotal, :items_in_cart, :shipping_cost, :total


    def show 
        @subtotal = subtotal
        @items_in_cart = items_in_cart
        @shipping_cost = shipping_cost
        @total = total
    end

    def add
        @item = Item.find(params[:id])
        add_item_to_cart(params[:id])
        redirect_to item_path(params[:id])
        flash[:notice] = "#{@item.name} was added to cart."
    end

    def remove
        @item = Item.find(params[:id])
        remove_item_from_cart(params[:id])
        redirect_to view_cart_path
        flash[:notice] = "#{@item.name} was removed from cart."
    end

    def empty
        clear_cart
        redirect_to view_cart_path
        flash[:notice] = "Cart is emptied."
        
    end

    def checkout
        @subtotal = subtotal
        @items_in_cart = items_in_cart
        @shipping_cost = shipping_cost
        @total = total
        @addresses = current_user.customer.addresses
        @order = Order.new

    end

    private
    def subtotal
        @subtotal = calculate_cart_items_cost
    end

    def items_in_cart
        @items_in_cart = get_list_of_items_in_cart
    end

    def shipping_cost
        @shipping_cost = calculate_cart_shipping
    end

    def total
        @total = subtotal + shipping_cost
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def order_params
        params.require(:order).permit(:customer_id,:address_id,:credit_card_number,:expiration_year,:expiration_month)
    end

end
