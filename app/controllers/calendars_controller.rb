class CalendarsController < ApplicationController
  def new
  	@item = Item.find(params[:id])


  	if @item.calendar.blank?    
      @calendar = Calendar.new
    else
  	  @calendar = @item.calendar
    end
  end

  def create
  	@item = Item.find params[:calendar][:item_id]
  	@calendar = @item.build_calendar(calendar_params)

		if @calendar.save
      if @item.edit_sections_present?(@item)
        @item.finish_listing
      end
      respond_to do |format|
				format.html { redirect_to rack_path}
			end	
    else
      render item_calendar_url(@item)
    end

  end

  def update
    @item = Item.find params[:calendar][:item_id]
    @item.calendar.update_attributes(calendar_params)
    if @item.edit_sections_present?(@item)
      @item.finish_listing
    end
    redirect_to rack_path
    
  end

private


  def calendar_params
    params.require(:calendar).permit(:available_from, :available_to, :item_id, :availability)
  end
end
