module ItemsHelper

  def remember_item(item)
    cookies.permanent.signed[:item_id] = item.id
    session[:item_id] = item.id
  end

end
