
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
        add_item_to_cart(@item)
        redirect_to view_cart_path
        flash[:notice] = "#{@item.name} was added to cart."
    end

    def remove
        @item = Item.find(params[:id])
        remove_item_from_cart(@item)
        redirect_to view_cart_path
        flash[:notice] = "#{@item.name} was removed from cart."
    end

    def empty
        clear_cart
        flash[:notice] = "Cart is emptied."
        redirect_to view_cart
    end

    def checkout
        @addresses = Customer.find(params[:customer_id])
        @order = Order.find(params[:customer_id])
        
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

end
