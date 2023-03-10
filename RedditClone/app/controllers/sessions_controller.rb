class SessionsController < ApplicationController

    # skip_forgery_protection

    #skip_before_action :verify_authenticity_token

    before_action :require_logged_in?, only: [:destroy]
    before_action :require_logged_out, only: [:new, :create]

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(username: params[:user][:username], password:params[:user][:password] )
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        logout! if logged_in?
        redirect_to new_session_url
    end

    def new
        @user = User.new
    end

end
