class UsersController < ApplicationController

    before_action :require_logged_in?, only: [:show, :destroy, :index]
    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        # redirect_to new_user_url
        render :new
    end

    def destroy
        @user = current_user
        logout!
        @user.destroy
        render :new
        
        # render :new is faster than redirecting since it doesn't make another HTTP request
        # redirect_to new_user_url
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

    def require_logged_in?
        redirect_to new_user_url unless logged_in?
    end
end
