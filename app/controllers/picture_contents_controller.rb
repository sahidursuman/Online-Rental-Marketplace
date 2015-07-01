class PictureContentsController < ApplicationController
	respond_to :json, :html

	def index
    	@picture_contents = Picture.all
  end

	def create

    @media = Picture.new(file_name: params[:file], item_id: params[:item_id] )
    if @media.save!
	  respond_to do |format|
	    format.json{ render :json => @media }
	  end
    end
  end

	def delete_media
	  Picture.where(id: params[:media_contents]).destroy_all
	  redirect_to root_url
	end

end
