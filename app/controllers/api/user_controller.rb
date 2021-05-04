class Api::UserController < ApplicationController
  def index
    render json: {
      success: true,
    }, status: 200
  end

  def update
  end

  def password
  end

  def image
  end
end
