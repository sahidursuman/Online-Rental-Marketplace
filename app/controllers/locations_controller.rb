class LocationsController < ApplicationController
  def new
  	@item = Item.find(params[:id])
  	@location = Location.new
  end

  def create
  	@item = Item.find params[:photo][:item_id]
  	@location = @item.location.build(location_params)
		if @photo.save
      respond_to do |format|
				format.html { redirect_to edit_photos_url(@item)}
				format.js 
			end	
    else
      render edit_photos_url(@item)
    end
  end

  def edit
  end

  def update
  end

private

  def photo_params
    params.require(:photo).permit(:title, :image, :item_id)
  end

end
