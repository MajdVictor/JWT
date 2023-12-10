#
class ApplicationController < ActionController::API

  def authorize
    header_encoded_token = request.headers['Authorization'].split(' ').last

    begin
      @decoded_token = JsonWebToken.decode(token: header_encoded_token) #[{payload }, {hashing algo}]

      @user = User.find(@decoded_token[0]['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
