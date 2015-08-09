class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:index, :my_reservations, :requests, :new, :create, :destroy, :update]
  before_action :correct_user,   only: [:destroy, :edit, :create, :update]
  before_action :correct_reservations, only: :my_reservations
  before_action :correct_lender, only: :approve

  include ItemsHelper

  def index
    @user = User.find(session[:user_id])
    if params[:item_name] || params[:city]
      if params[:item_name].empty?
        item_query = Item.all
        else
        item_query = Item.where('item_name like ?', params[:item_name])
      end
      query = item_query.joins(:location).where('locations.city like ?', params[:city])
                                    
      @items = query.all.paginate(page: session[:page])

    else
      @items = current_user.items.paginate(page: session[:page])
      @items.each do |item|
        item.reservations.each do |res|
          if Time.zone.now > res.due_date.in_time_zone && res.request_status != "Passed"    
          item.set_lending_status_available
            if res.request_status == "Approved"
              res.set_request_completed
            else
              res.set_request_passed
            end
          end
        end
      end # end item iteration
    end
  end

  def my_reservations
    @user = User.find(session[:user_id])
    @reservations = Reservation.where(lent_id: @user.id,
                                      request_status: "Approved")
    @items = @reservations.map(&:item)
    @items = @items.paginate(page: session[:page])
    #@due_in = hours:minutes
  end

  def requests
    

    @user = User.find(session[:user_id])
    @reservations = Reservation.where(lender_id: @user.id)
    @reservations.each do |res|
      if Time.zone.now > res.due_date.in_time_zone && res.request_status != "Passed"
      @item = Item.find(res.item_id)     
      @item.update_attributes( listing_status: "Available")
        if res.request_status == "Approved"
          res.update_attributes( request_status: "Completed") 
          @item.update_attributes( listing_status: "Available")
        else
          res.update_attributes( request_status: "Passed")
          @item.update_attributes( listing_status: "Available")
        end
      end
    end
    @reservations = @reservations.where( "request_status like ?", "Pending")



    @requests = Reservation.where(lent_id: @user.id)
    @requests.each do |res|
      if Time.zone.now > res.due_date.in_time_zone && res.request_status != "Passed"  
      @item = Item.find(res.item_id)   
        if res.request_status == "Approved"
          res.update_attributes( request_status: "Completed")       
          @item.update_attributes( listing_status: "Available")
        else
          res.update_attributes( request_status: "Passed")
          @item.update_attributes( listing_status: "Available")
        end
      end
    end


    @req_items = @requests.map(&:item)
    @req_count = @requests.where("request_status == ?", "Pending") #Current requests that are pending or approved
                                # ^ withing dates greater than Time.now


    @items = @reservations.map(&:item)
    @items = @items.paginate(page: session[:page])
    @reqs = @req_items.zip(@requests)
    @resr = @items.zip(@reservations)
  end

  def approve
    @reservation = Reservation.find(params[:approve][:res_id])

    @item = Item.find(@reservation.item_id)
    if @reservation.request_status == "Passed"
      redirect_to my_requests_path(@item) and return
      flash.keep[:warning] = "Borrow date is passed"
    end

    @customer = User.find(@reservation.lent_id)

    @lender_id = User.find(@reservation.lender_id)
    @customer_id = @customer.customer_id
    @token = @customer.token
    @subtotal = (@reservation.subtotal.to_f*100).to_i
    @fee = (@reservation.fee.to_f*100).to_i

    #Attempt to charge card

    if charge_card(@lender_id, @customer_id, @token, @subtotal, @fee) && @reservation.borrow_date > Time.zone.now 
            
      @reservation.set_request_approved
      @item.set_lending_status_reserved
      Transaction.create(reservation_id: @reservation.id,
                         amount: @reservation.subtotal,
                         transaction_type: "Charge" )
      Transaction.create(reservation_id: @reservation.id,
                         amount: @reservation.fee,
                         transaction_type: "Fee" )
      flash.keep[:info] = "#{@customer.first_name} was charged. Please prepare your item for pickup."
      redirect_to rack_path
    else
      redirect_to my_requests_path(@item) and return
    end

  end

  def show
    @item = Item.find(params[:id])
    @lending_user = User.find(session[:user_id])
    @lender_user = User.find_by_id(@item.user_id)
  end

  def new
   # @item = current_user.items.build if logged_in?
   @user = User.find(session[:user_id])
   @item = Item.new

  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "3 more steps."
      redirect_to edit_item_path(@item)
      @item.update_attributes({
      listing_status: "Unlisted",
      lending_status: "Unavailable"
      })
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
      redirect_to edit_photos_url(@item)
    elsif %w(calendar).include?(last_action)
      @item.update_columns(available_from: params[:item][:available_from],
                          available_to: params[:item][:available_to])

    else
      render edit_item_path(@item)
    end
  end


  def edit
    @item = Item.find(params[:id])
  end


 

private

  def charge_card(lender, customer, token, subtotal, fee) 
    # Charge the card
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    Stripe::Charge.create({
      :amount => subtotal,
      :currency => "usd",
      :source => token,
      :destination => "acct_16T12ZBPUpjt04Z3",
      :application_fee => fee
      })
  end

  def item_params
    params.require(:item).permit(:item_name, :value, :lending_price, :description, :category, :available_from, :available_to)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to rack_url if @item.nil?
  end

  def correct_reservations
    @reservations = Reservation.where(lent_id: current_user.id)
    redirect_to rack_url if @reservations.nil?
  end

  def correct_lender
    @reservations = Reservation.where(lender_id: current_user.id)
    redirect_to rack_url if @reservations.nil?
  end

  def is_merchant
    @merchant = current_user.uid
    redirect_to rack_url if @merchant.nil?
  end


end














