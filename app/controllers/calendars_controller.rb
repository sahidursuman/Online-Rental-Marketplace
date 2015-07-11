class CalendarsController < ApplicationController
  def new
  	@item = Item.find(params[:id])
  	@calendar = Calendar.new

  	if Calendar.exists?(:id)
      @location = Location.find(params[:id])
      @item = Item.find(@location.item_id)
      
    else
      @item = Item.find(params[:id])
  	  @location = Location.new
    end
  end

  def create
  	@item = Item.find params[:calendar][:item_id]
  	@calendar = Calendar.new(calendar_params)
		if @calendar.save
      respond_to do |format|
				format.html { redirect_to item_calendar_url(@item)}
			end	
    else
      render item_calendar_url(@item)
    end

  end

  def update
  end

private

  def calendar_params
    params.require(:calendar).permit(:available_from, :available_to)
  end
end
