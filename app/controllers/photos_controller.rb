class PhotosController < ApplicationController
 	
 	def new
    @item = Item.find(params[:id])
  	@photo = Photo.new
	end

	def show
		@item = Item.find(params[:id])
		@photo = @item.photos
	end

	def create
		@item = Item.find params[:photo][:item_id]
  	@photo = @item.photos.build(photo_params)
		if @item.save
      redirect_to edit_photos_url(@item) 
    else
      render edit_photos_url(@item)
    end
	end

private

  def photo_params
    params.require(:photo).permit(:title, :image, :item_id)
  end
end
