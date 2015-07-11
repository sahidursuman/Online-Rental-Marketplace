class LocationsController < ApplicationController
  def new
    @item = Item.find(params[:id])
    if Location.where(item_id: @item.id).blank?
      @location = Location.where(item_id: @item.id)
    else
  	  @location = Location.new
    end

  end

  def create
  	@item = Item.find params[:location][:item_id]
  	@location = Location.new(location_params)
		if @location.save
      respond_to do |format|
				format.html { redirect_to item_location_url(@item)}
				format.js 
			end	
    else
      render item_location_url(@item)
    end
  end

  def edit
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to item_location_url
    else
      render item_location_url(@item)
    end
  end

private

  def location_params
    params.require(:location).permit(:street, :apartment, 
                        :city, :state, :country, :zip)
  end

end
