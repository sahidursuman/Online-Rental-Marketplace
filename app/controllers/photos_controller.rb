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
		if @photo.save
      respond_to do |format|
				format.html { redirect_to edit_photos_url(@item)}
				format.js 
			end	
    else
      render edit_photos_url(@item)
    end
	end

	def destroy 
		@photo_destroy = Photo.find_by_id(params[:id])
		@item = Item.find(@photo_destroy.item_id)
		if @photo_destroy.present?
			@photo_destroy.destroy
		end
		@photo = @item.photos
		respond_to do |format|
			format.html { redirect_to edit_photos_url(@item)}
			format.js 
		end
	end

private

  def photo_params
    params.require(:photo).permit(:title, :image, :item_id)
  end
end
