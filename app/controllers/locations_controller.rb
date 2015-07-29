class LocationsController < ApplicationController
  def new
    @item = Item.find(params[:id])

    if @item.location.blank?
      @location = Location.new
    else
      redirect_to edit_location_path(@item)
    end
    
  end

  def create
  	@item = Item.find params[:location][:item_id]
  	@location = @item.build_location(location_params)
		if @location.save
      if @item.edit_sections_present?(@item)
        @item.finish_listing
      end
      respond_to do |format|
				format.html { redirect_to item_calendar_url(@item)}
				format.js 
			end	
    else
      render item_location_url(@item)
    end
  end

  def edit
    @item = Item.find(params[:id])
    @location = @item.location
  end

  def update
    @location = Location.find(params[:id])
    @item = @location.item
    if @location.update_attributes(location_params)
      redirect_to item_calendar_url(@item)
      if @item.edit_sections_present?(@item)
        @item.finish_listing
      end
    else
      render edit_location_path(@item)
    end
  end

private

  def location_params
    params.require(:location).permit(:street, :apartment, 
                        :city, :state, :country, :zip, :item_id)
  end

end
