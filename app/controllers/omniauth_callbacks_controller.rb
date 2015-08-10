class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def stripe_connect
    @user = current_user
    if User.where(uid: request.env["omniauth.auth"].uid).present?
      flash[:warning] = "Cannot register 2 accoutns with the same Stripe account."
      redirect_to rackit_path
    else
      if @user.update_attributes({
        provider: request.env["omniauth.auth"].provider,
        uid: request.env["omniauth.auth"].uid,
        access_code: request.env["omniauth.auth"].credentials.token,
        publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
      })
        # anything else you need to do in response..
        redirect_to rackit_path, :event => :authentication
        flash[:success] = "Succesfully authenticated Stripe account."
      else
        session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
        redirect_to rackit_path
      end
    end
  end
end
