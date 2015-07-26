class ReservationsController < ApplicationController
require 'date' 

	def show
		d1 = params[:borrow_date]
		d2 = params[:due_date]
		@item = Item.find_by_id(params[:item_id])
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
		@lending_user = User.find(params[:lending_id])
		@lender_user = User.find(params[:lender_id])
		@reservation = @item.reservations.create(
									lender_id: @lender_user.id,
									lent_id: @lending_user.id,
									borrow_date: params[:borrow_date],
									due_date: params[:due_date]
									)

		token = params[:stripeToken]

		if customer = Stripe::Customer.create(
		  :source => token,
		  :description => "#{@lending_user.first_name} #{@lending_user.last_name}"
		)

		# Charge the card
		Stripe.api_key = ENV['STRIPE_SECRET_KEY']
		Stripe::Charge.create({
		  :amount => 1000,
		  :currency => "usd",
		  :source => token,
		  :destination => @lender_user.uid
		  #:application_fee => 
		})

		# Save customer ID in database
		@lending_user.update_attribute(:customer_id, customer.id)

		flash[:success] = "'#{@item.item_name}' was requested. Your card will be charged when the request is approved."
		redirect_to my_reservations_path
		else
			render 'show'
		end
	end

  private
	  def stripe_params
	    params.permit :stripeEmail, :stripeToken, :borrow_date, :due_date, :item_id
	  end
end
