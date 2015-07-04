class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  include ItemsHelper

  def index
    @user = User.find(session[:user_id])
  	@items = current_user.items.paginate(page: session[:page])
  end

  def new
   # @item = current_user.items.build if logged_in?
   @item = Item.new
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "3 more steps."
      remember_item @item 
      redirect_to rack_path
      
    else
      render root_url
    end
	end

  def pictures
    @item = Item.find(params[:id])
    @pictures = @item.pictures
    respond_with(@pictures) do |format|
      format.json { render json: @pictures}
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])  
  end

private

  def item_params
    params.require(:item).permit(:item_name, :lending_price, :description, :category)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to rack_url if @item.nil?
  end

end