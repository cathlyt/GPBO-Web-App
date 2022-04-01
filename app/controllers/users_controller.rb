class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        @users = User.all
    end


    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :active, :role, :greeting, :password, :password_confirmation)
    end
end
