class Api::AllergiesController < ApplicationController
  include Token
  include Response
  def index
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @allergies = Allergy.where(users_id: user_id)
    success_response(@allergies)
  end

  def create
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    body = JSON.parse(request.body.read)
    medicine_name = body["medicine_name"]
    side_effect = body["side_effect"]
    Allergy.create(users_id: user_id, medicine_name: medicine_name, side_effect: side_effect)
    @allergies = Allergy.where(users_id: user_id)
    success_response(@allergies)
  end

  def update
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @id = params[:id]
    @allergy = Allergy.find_by(id: @id,users_id: user_id)
    if @allergy == nil
      error_response('Not found', 404)
      return
    end
    body = JSON.parse(request.body.read)
    medicine_name = body["medicine_name"]
    side_effect = body["side_effect"]
    @allergy.update(medicine_name: medicine_name, side_effect: side_effect)
    @allergies = Allergy.where(users_id: user_id)
    success_response(@allergies)
    
  end

  def destroy
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @id = params[:id]
    @allergy = Allergy.find_by(id: @id,users_id: user_id)
    if @allergy == nil
      error_response('Not found', 404)
      return
    end
    Allergy.destroy_by(id: @id,users_id: user_id)
    @allergies = Allergy.where(users_id: user_id)
    success_response(@allergies)
  end
end
