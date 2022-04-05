class ItemPricesController < ApplicationController
    # before_action :set_item_price, only: [:new]



    def new
        # @item_price = ItemPrice.new(item_price_params)
        @item = ItemPrice.last.item
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        
        if @item_price.save
          flash[:notice] = "Successfully updated the price."
          redirect_to item_path(ItemPrice.last.item)
        else
          render action: 'new'
        end
    end

    private
    def set_item_price
        @item_price = ItemPrice.find(params[:id])
    end

    def item_price_params
        params.require(:item_price).permit(:item_id,:price)
    end
end
