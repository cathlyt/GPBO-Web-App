class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]
    before_action :check_login
    authorize_resource

    def index
        @users = User.alphabetical.all
        @employees = User.all.employees
    end

    def create
        @user = User.new(user_params)
        if @user.save
          flash[:notice] = "Successfully added #{@user.username} as a user."
          redirect_to users_url
        else
          render action: 'new'
        end
    end

    def edit

    end

    def update
        if @user.update_attributes(user_params)
          flash[:notice] = "Successfully updated #{@user.username}."
          redirect_to users_url
        else
          render action: 'edit'
        end
    end

    


    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :active, :role, :greeting, :password, :password_confirmation)
    end
end
