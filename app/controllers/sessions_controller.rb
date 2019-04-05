class SessionsController < ApplicationController

    before_action :redirect_if_logged_in, only: [:new, :create]
    
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
        if user
            login!(user)
            redirect_to bands_url
        else
            flash.now[:erros] = "Invalid login credentials"
            render :new
        end
    end

    def destroy
        current_user.reset_session_token! if logged_in?
        redirect_to new_session_url
        #user reset session token
    end

end
