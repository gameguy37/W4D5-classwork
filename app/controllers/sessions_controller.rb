class SessionsController < ApplicationController
    def new
        redirect_to user_url(current_user) if login?
        render :new
    end

    def create  
        user = User.find_by_credentials(user_params[:username], user_params[:password])

        if user
            login_user(user)
            redirect_to user_url(user)
        else
            flash.now[:error] = user.errors.full_messages
            render :new
        end

    end


    def destroy
        log_out
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end