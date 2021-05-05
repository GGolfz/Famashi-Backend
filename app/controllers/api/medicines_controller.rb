class Api::MedicinesController < ApplicationController
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
    @medicines = Medicine.where(users_id: user_id)
    success_response(@medicines)
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
    description = body["description"]  
    total_amount = body["total_amount"]  
    remain_amount = body["remain_amount"]   
    medicine_unit = body["medicine_unit"]   
    dosage_amount = body["dosage_amount"]   
    dosage_unit = body["dosage_unit"]  
    # medicine_image = body["medicine_image"]   
    # medicine_leaflet = body["medicine_leaflet"]
    Medicine.create(
      users_id: user_id, 
      medicine_name: medicine_name, 
      description: description,
      total_amount: total_amount,
      remain_amount: remain_amount,
      medicine_unit: medicine_unit,
      dosage_amount: dosage_amount,
      dosage_unit: dosage_unit
    )
    @medicines = Medicine.where(users_id: user_id)
    success_response(@medicines)
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
    @medicine = Medicine.find_by(id: @id,users_id: user_id)
    if @medicine == nil
      error_response('Not found', 404)
      return
    end
    body = JSON.parse(request.body.read)
    medicine_name = body["medicine_name"]  
    description = body["description"]  
    total_amount = body["total_amount"]  
    remain_amount = body["remain_amount"]   
    medicine_unit = body["medicine_unit"]   
    dosage_amount = body["dosage_amount"]   
    dosage_unit = body["dosage_unit"]  
    @medicine.update(
      users_id: user_id, 
      medicine_name: medicine_name, 
      description: description,
      total_amount: total_amount,
      remain_amount: remain_amount,
      medicine_unit: medicine_unit,
      dosage_amount: dosage_amount,
      dosage_unit: dosage_unit
    )
    @medicines = Medicine.where(users_id: user_id)
    success_response(@medicines)
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
    @medicine = Medicine.find_by(id: @id,users_id: user_id)
    if @medicine == nil
      error_response('Not found', 404)
      return
    end
    Medicine.destroy_by(id: @id,users_id: user_id)
    @medicines = Medicine.where(users_id: user_id)
    success_response(@medicines)
  end
end
