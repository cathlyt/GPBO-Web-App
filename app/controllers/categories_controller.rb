class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit,:update]
    before_action :check_login
    authorize_resource

    def index
        @categories = Category.alphabetical.all
        @active_categories = Category.active.alphabetical.all
        @inactive_categories = Category.inactive.alphabetical.all
    end

    def create
        @category = Category.new(category_params)
        if @category.save
          flash[:notice] = "Successfully added #{@category.name} to the system."
          redirect_to categories_path
        else
          render action: 'new'
        end
    end

    def edit
    end

    def update
        if @category.update_attributes(category_params)
          flash[:notice] = "Successfully updated #{@category.name}."
          redirect_to categories_url
        else
          render action: 'edit'
        end
    end

    private
    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name,:active)
    end
end
