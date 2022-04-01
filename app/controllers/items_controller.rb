class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update]
    before_action :check_login
    authorize_resource

    def index
        @items = Item.alphabetical.all
        @categories = Category.alphabetical.all
        @featured_items = Item.featured.alphabetical.all
        @other_items = Item.alphabetical.all - Item.featured.alphabetical.all
    end

    def show
        @prices = ItemPrice.all
        @similar_items = Item.search(@item.name).all
    end

    private
    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:category_id, :name, :description, :color, :weight, :inventory_level, :reorder_level, :is_featured, :active)
    end


end
