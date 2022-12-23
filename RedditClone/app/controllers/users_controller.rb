class UsersController < ApplicationController

    before_action :require_logged_in?, only: [:show, :destroy, :index]
    before_action :require_logged_out, only: [:new, :create]

    def new
    end

    def destroy
    end

    def create
    end

    def index
    end

    def show
    end
end
