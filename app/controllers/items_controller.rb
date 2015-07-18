class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy, :update]
  before_action :correct_user,   only: :destroy
  include ItemsHelper

  def index
    @user = User.find(session[:user_id])
    if params[:item_name] || params[:city]
      item_query = Item.where(:item_name => params[:item_name])
      query = item_query.joins(:location).where('locations.city' => params[:city])
                                    
      @items = query.all.paginate(page: session[:page])

    else
  	@items = current_user.items.paginate(page: session[:page])
    end
  end

  def new
   # @item = current_user.items.build if logged_in?
   @item = Item.new
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "3 more steps."
      redirect_to edit_item_path(@item)
      
    else
      render root_url
    end
	end

  def update
    @item = Item.find(params[:id])
    url = Rails.application.routes.recognize_path(request.referrer)
    last_controller = url[:controller]
    last_action = url[:action]

    if %w(edit).include?(last_action)
      @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to edit_item_path(@item)
    elsif %w(calendar).include?(last_action)
      @item.update_columns(available_from: params[:item][:available_from],
                          available_to: params[:item][:available_to])
    else
      render edit_item_path(@item)
    end
  end


  def update_calendar
    @item = Item.find(params[:id])
    
    if %w(calendar).include?(last_action)
    @item.update_columns(available_from: params[:item][:available_from],
                          available_to: params[:item][:available_to])
    end
    redirect_to root_url
  end

  def edit
    @item = Item.find(params[:id])
  end

  def calendar
    @item = Item.find(params[:id])
  end

 

private

  def item_params
    params.require(:item).permit(:item_name, :lending_price, :description, :category, :available_from, :available_to)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to rack_url if @item.nil?
  end

end