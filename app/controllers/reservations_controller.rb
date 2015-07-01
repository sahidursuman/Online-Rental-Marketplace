class ReservationsController < ApplicationController

	def show
		@user = User.find(session[:user_id])
	end
end
