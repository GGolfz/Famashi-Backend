class Api::UserController < ApplicationController
  include Token
  def index
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    render json: {
      success: true,
      user_id: user_id
    }, status: 200
  end

  def update
  end

  def password
  end

  def image
  end
end
