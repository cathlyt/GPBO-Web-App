class ItemPricesController < ApplicationController

    def new
        @item_price = ItemPrice.new
        @item = Item.find(params[:item_id])
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        @item = Item.find(params[:item_id])
        if @item_price.save
          flash[:notice] = "Successfully updated the price."
          redirect_to item_path(ItemPrice.last.item)
        else
          @item = Item.find(params[:item_id])
          render action: 'new', locals:{item: @item}
        end
    end

    private
    def item_price_params
        params.require(:item_price).permit(:item_id,:price,:start_date)
    end
end
