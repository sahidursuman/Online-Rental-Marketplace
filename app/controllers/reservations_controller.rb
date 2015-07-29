class ReservationsController < ApplicationController
require 'date' 

	def show
		@item = Item.find_by_id(params[:item_id])
		if params[:lending_id] == params[:lender_id]
      redirect_back_or item_path(@item)
      flash[:warning] = "Cannot reseve your own item."
    end
		d1 = params[:borrow_date]
		d2 = params[:due_date]
		@lending_user = User.find(session[:user_id])
		@lender_user = User.find_by_id(@item.user_id)
		@subtotal = (((d2.to_datetime - d1.to_datetime)*24).to_i * (@item.lending_price/24)).ceil
		@fee = @subtotal * 0.09
		@total = @subtotal + @fee
		@borrow_date = d1[5,5] + "/" + d1[0,4]
		@due_date = d2[5,5] + "/" + d2[0,4]
		@borrow_time = d1[11,13]
		@due_time = d2[11,13]
	end

	def create
		@item = Item.find_by_id(params[:item_id])
		if params[:lending_id] == params[:lender_id]
      redirect_back_or item_path(@item)
      flash[:warning] = "Cannot reseve your own item."
    end
		@lending_user = User.find(params[:lending_id])
		@lender_user = User.find(params[:lender_id])
		@reservation = @item.reservations.create(
									lender_id: @lender_user.id,
									lent_id: @lending_user.id,
									borrow_date: params[:borrow_date],
									due_date: params[:due_date]
									)

		token = params[:stripeToken]

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

		redirect_to my_reservations_path
		flash[:success] = "'#{@item.item_name}' was requested. Your card will be charged when the request is approved."

	end

  private
	  def stripe_params
	    params.permit :stripeEmail, :stripeToken, :borrow_date, :due_date, :item_id
	  end



end














