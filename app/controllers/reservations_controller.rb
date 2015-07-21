class ReservationsController < ApplicationController
require 'date' 

	def show
		d1 = params[:datetimepicker1]
		d2 = params[:datetimepicker2]
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
end
