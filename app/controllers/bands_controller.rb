class BandsController < ApplicationController
    
    before_action :redirect_if_logged_out, except: [:index]

    def new
        @band = Band.new
        render :new
    end

    def create
        new_band = Band.new(band_params)

        if new_band.save
            redirect_to band_url(new_band)
        else
            flash.now[:errors] = new_band.errors.full_messages
            render :new
        end
    end

    def index
        @bands = Band.all
        render :index
    end

    def show
        @band = Band.find_by(id: params[:id])
        render :show
    end

    def destroy
        band = Band.find_by(id: params[:id])
        band.delete
        redirect_to bands_url
    end

    def update
        new_band = Band.find_by(id: params[:id])

        if new_band.update(band_params)
            redirect_to band_url(new_band)
        else
            flash.now[:errors] = new_band.errors.full_messages
            render :new
        end
    end

    def edit
        @band = Band.find_by(id: params[:id])
        render :edit
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end
