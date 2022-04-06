
class CartController < ApplicationController
    include AppHelpers::Cart
    include AppHelpers::Shipping
    before_action :check_login
    before_action :subtotal, :items_in_cart, :shipping_cost, :total


    def show
       
    end

    def add
        
        add_item_to_cart(@item)
        flash[:notice] = "#{@item.name} was added to cart.", 
    end

    def remove
        
    end

    def empty
    end

    def checkout
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
