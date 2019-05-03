class ApplicationController < ActionController::Base
    helper_method :current_user, :login?

    def current_user
        @user ||= User.find_by_session_token(session[:session_token])
    end

    def login_user(user)
        @user = user
        session[:session_token] = @user.reset_session_token
    end

    def login?
        !!current_user
    end
    
    def log_out
        current_user.reset_session_token
        @user = nil # I don't think this is a necessity
        session[:session_token] = nil
        redirect_to users_url
    end

    def enforce_login
        redirect_to users_url unless login?
    end
end
