class AppleMusicSearchesController < ApplicationController
  before_action :authenticate_user

  def index
    url = AppleSearch.album_search params[:artist], params[:album]
    render json: [url]
  end
end