class Api::AllergiesController < ApplicationController
  def index
    render json: {
      success: true
    }, status: 200
  end

  def create
  end

  def update
  end

  def destroy
  end
end
