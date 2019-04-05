class UsersController < ApplicationController

    before_action :redirect_if_logged_in, only: [:new, :create]
    #sign up
    def new
        render :new
    end

    def create
        user = User.new(user_params)
        if user.save
            login!(user)
            redirect_to bands_url
        else
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end

    def edit

    end

    def udpate

    end

    def show
        
        render :show
    end

    def destroy

    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password)
    end

end
