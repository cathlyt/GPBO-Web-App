class ItemPricesController < ApplicationController

    def new
        @item_price = ItemPrice.new
        @item = Item.find(params[:item_id])
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        @item_price.start_date = Date.tomorrow
        @item = Item.find(params[:item_id])
        if @item_price.save
          flash[:notice] = "Successfully updated the price."
          redirect_to item_path(ItemPrice.last.item)
        else
          render action: 'new'
        end
    end

    private
    def item_price_params
        params.require(:item_price).permit(:item_id,:price,:start_date)
    end
end
