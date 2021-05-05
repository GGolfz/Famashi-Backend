class Api::UserController < ApplicationController
  include Token
  def index
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    @user.password = nil
    render json: {
      user: @user,
      token: token
    }, status: 200
  end

  def update
  end

  def password
  end

  def image
  end
end
