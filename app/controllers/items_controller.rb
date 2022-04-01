class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy, :toggle_active, :toggle_feature]
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

    def edit
    end

    def create
        @item = Item.new(item_params)
        if @item.save
          flash[:notice] = "#{@item.name} was added to the system."
          redirect_to @item
        else
          render action: 'new'
        end
    end
    
    def update
        if @item.update_attributes(item_params)
            flash[:notice] = "Successfully updated #{@item.name}."
            redirect_to item_url
        else
            render action: 'edit'
        end
    end

    def destroy
        if @item.destroy
            redirect_to items_path, notice: "Item destroyed"
        else
            redirect_to item_path(@item)
        end

    end

    def toggle_active
        if @item.active 
            @item.update_attribute(:active,false)
            flash[:notice] = "#{@item.name} was made inactive"
            redirect_to item_path(@item)
        else
            @item.update_attribute(:active,true)
            flash[:notice] = "#{@item.name} was made active"
            redirect_to item_path(@item)
        end
    end

    def toggle_feature
        if @item.is_featured 
            @item.update_attribute(:is_featured ,false)
            flash[:notice] = "#{@item.name} is no longer featured"
            redirect_to item_path(@item)
        else
            @item.update_attribute(:is_featured ,true)
            flash[:notice] = "#{@item.name} is now featured"
            redirect_to item_path(@item)
        end
    end

    private
    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:category_id, :name, :description, :color, :weight, :inventory_level, :reorder_level, :is_featured, :active)
    end


end
