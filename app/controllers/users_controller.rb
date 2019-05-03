class UsersController < ApplicationController

    def new
        redirect_to user_url(current_user) if login?
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        enforce_login
        @user = User.find_by_id(params[:id])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end