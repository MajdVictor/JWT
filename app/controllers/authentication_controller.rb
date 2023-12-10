class AuthenticationController < ApplicationController

	def login
		@user = User.find_by(email: params[:email])
		if @user&.authenticate(params[:password])
			token = JsonWebToken.encode(payload: { user_id: @user.id })
			render json: { token: token }, status: :ok
		else
			render json: { errors: 'unauthorized' }, status: :unauthorized
		end
	end
end
