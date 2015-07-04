module PhotosHelper

  def current_item(item_id)
  	if (@item.id == session[:item_id])
  		@current_item ||= Item.find_by(id: item_id)
  	end
  end

end
