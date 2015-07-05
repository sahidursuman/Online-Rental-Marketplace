class PhotosController < ApplicationController
 	
 	def new
    @item = Item.find(params[:id])
  	@photo = Photo.new
	end

	def upload_photos
	end

	def upload
		@photo = Photo.new(image: params[:file])
    parsed = Photo.parse_filename(params[:name])
    @photo.title = parsed[:title]
    if @photo.save
      head 200
    end
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
