class ApplicationController < ActionController::Base

    helper_method :current_user
    helper_method :logged_in?

    def current_user
        User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!(current_user)
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def redirect_if_logged_in
        redirect_to user_url(current_user) if logged_in?
    end

    def redirect_if_logged_out
        redirect_to new_session_url unless logged_in?
    end
end
