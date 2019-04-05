class AlbumsController < ApplicationController

    before_action :redirect_if_logged_out

    def new
        @album = Album.new
        render :new
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end
    end

    def index
        @albums = Album.all
        render :index
    end

    def show
        @album = Album.find_by(id: params[:id])
    end

    def destroy
        album = Album.find_by(id: params[:id])
        band = album.band
        album.delete
        redirect_to band_url(band)
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album.update(album_params)
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        render :edit
    end

    private
    def album_params
        params.require(:album).permit(:title, :year, :band_id)
    end

end
