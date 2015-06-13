class ItemsController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  	@item = @user.items
  end

  def new
  end
end
