class UsersController < ApplicationController

    before_action :require_logged_in?, only: [:show, :destroy, :index]
    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        redirect_to new_session_url
    end

    def destroy
    end

    def create
    end

    def index
    end

    def show
        @user = User.find_by(id: params[:id])
    end
end
