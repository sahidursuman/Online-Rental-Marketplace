class ReservationsController < ApplicationController
require 'date' 

	def show
		@item = Item.find_by_id(params[:item_id])
    
		if params[:lending_id] == params[:lender_id]
      flash[:notice] = "Cannot reseve your own item."
      redirect_back_or item_path(@item)
      
    end

    if Time.zone.now > params[:borrow_date].in_time_zone
    	flash.keep[:notice] = "Cannot reseve in the past."
    	redirect_to item_path(@item) and return
      
    end

		@d1 = params[:borrow_date]
		@d2 = params[:due_date]
		@date1 = @d1.to_datetime
		@date2 = @d2.to_datetime
		@lending_user = User.find(session[:user_id])
		@lender_user = User.find_by_id(@item.user_id)
		@deposit = (@item.value.to_f * 0.3).round(2)
		@subtotal = ((((@d2.to_datetime - @d1.to_datetime)*24).to_i * (@item.lending_price.to_f/24)) + @deposit ).round(2)
		@fee = (@subtotal * 0.09).round(2)
		@total = @subtotal + @fee + @deposit
		@borrow_date = @d1[5,5] + "/" + @d1[0,4]
		@due_date = @d2[5,5] + "/" + @d2[0,4]
		@borrow_time = @d1[11,13]
		@due_time = @d2[11,13]

		###
		@reservations = Reservation.where(lender_id: @item.user_id,
                                      request_status: "Approved")
    @reserved = nil
    @reservations.each do |res|
    	if @date1 > res.borrow_date  &&  @date2 < res.due_date
    		@reserved = true
    	end
    end
    if @reserved == true
    	flash.keep[:info] = "Item is already reserved for those dates + times."
    	redirect_to item_path(@item) and return
    end
    ###

	end

	def create

		@item = Item.find_by_id(params[:item_id])

		###
		@reservations = Reservation.where(lender_id: @item.user_id,
                                      request_status: "Approved")
    @reserved = nil
    @reservations.each do |res|
    	if @date1 > res.borrow_date  &&  @date2 < res.due_date
    		@reserved = true
    	end
    end
    if @reserved == true
    	flash.keep[:notice] = "Item is already reserved for those dates + times."
    	redirect_to item_path(@item) and return
    	
    end
    ###
    if Time.zone.now > params[:borrow_date].in_time_zone
    	flash[:notice] = "Cannot reseve in the past."
    	redirect_to item_path(@item) and return
      
    end

		if params[:lending_id] == params[:lender_id]
      redirect_back_or item_path(@item) and return
      flash.keep[:notice] = "Cannot reseve your own item."
    end
    

		@lending_user = User.find(params[:lending_id])
		@lender_user = User.find(params[:lender_id])
		@reservation = @item.reservations.create(
									lender_id: @lender_user.id,
									lent_id: @lending_user.id,
									borrow_date: params[:borrow_date],
									due_date: params[:due_date],
									subtotal: params[:subtotal],
									fee: params[:fee]
									)

		@lending_user.update_attributes( token: params[:stripeToken])

		if @lending_user.customer_id.present?
			customer = @lending_user.customer_id
			lender = @lender_user.uid
		else
			customer = Stripe::Customer.create(
		  :source => token,
		  :description => "#{@lending_user.first_name} #{@lending_user.last_name}"
			)
			# Save customer ID in database
			@lending_user.update_attribute(:customer_id, customer.id)
		end

		flash.keep[:notice] = "'#{@item.item_name}' was requested. Your card will be charged when the request is approved."
		redirect_to my_requests_path
		

	end

  private
	  def stripe_params
	    params.permit :stripeEmail, :stripeToken, :borrow_date, :due_date, :item_id
	  end



end














