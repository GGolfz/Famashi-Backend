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

  def show 
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
    @reminders = Reminder.where(medicines_id: @medicine.id)
    success_response({medicine: @medicine,reminder: @reminders})
  end

  def create
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    body = params
    medicine_name = body["medicine_name"]  
    description = body["description"]  
    total_amount = body["total_amount"]  
    remain_amount = body["remain_amount"]   
    medicine_unit = body["medicine_unit"]   
    dosage_amount = body["dosage_amount"] 
    reminder = body["reminder"] 
    upload_image = body["upload_image"]
    upload_leaflet = body["upload_leaflet"]
    @medicine = Medicine.create(
      users_id: user_id, 
      medicine_name: medicine_name, 
      description: description,
      total_amount: total_amount,
      remain_amount: remain_amount,
      medicine_unit: medicine_unit,
      dosage_amount: dosage_amount,
    )
    reminder = reminder.split(',')
    reminder.each do |item|
      Reminder.create(medicines_id: @medicine.id, user_reminders_id: UserReminder.find_by(time_type: item).id)
    end
    
    if upload_image == 'true'
      medicine_image = body["medicine_image"] 
      ext = medicine_image.original_filename.split('.').last
      filename = user_id.to_s + "-" + @medicine.id.to_s + "-" + Time.now.to_i.to_s + "." + ext.to_s 
      File.open(Rails.root.join('public', 'uploads','medicine_image', filename.to_s ), 'wb') do |file|
        file.write(medicine_image.read)
      end
      @medicine.update(medicine_image: filename)
    end

    if upload_leaflet == 'true'
      medicine_leaflet = body["medicine_leaflet"] 
      ext = medicine_leaflet.original_filename.split('.').last
      filename = user_id.to_s + "-" + @medicine.id.to_s + "-" + Time.now.to_i.to_s + "." + ext.to_s 
      File.open(Rails.root.join('public', 'uploads','medicine_leaflet', filename.to_s ), 'wb') do |file|
        file.write(medicine_leaflet.read)
      end
      @medicine.update(medicine_leaflet: filename)
    end

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
    body = params
    medicine_name = body["medicine_name"]  
    description = body["description"]  
    total_amount = body["total_amount"]  
    remain_amount = body["remain_amount"]   
    medicine_unit = body["medicine_unit"]   
    dosage_amount = body["dosage_amount"]   
    reminder = body["reminder"]
    upload_image = body["upload_image"]
    upload_leaflet = body["upload_leaflet"]

    @medicine.update(
      users_id: user_id, 
      medicine_name: medicine_name, 
      description: description,
      total_amount: [total_amount,remain_amount].max,
      remain_amount: remain_amount,
      medicine_unit: medicine_unit,
      dosage_amount: dosage_amount,
    )

    reminder = reminder.split(',')
    Reminder.delete_by(medicines_id: @medicine.id)
    reminder.each do |item|
      Reminder.create(medicines_id: @medicine.id, user_reminders_id: UserReminder.find_by(time_type: item).id)
    end

    if upload_image == 'true'
      medicine_image = body["medicine_image"] 
      ext = medicine_image.original_filename.split('.').last
      filename = user_id.to_s + "-" + @medicine.id.to_s + "-" + Time.now.to_i.to_s + "." + ext.to_s 
      File.delete(Rails.root.join('public','uploads','medicine_image', @medicine.medicine_image))
      File.open(Rails.root.join('public', 'uploads','medicine_image', filename.to_s ), 'wb') do |file|
        file.write(medicine_image.read)
      end
      @medicine.update(medicine_image: filename)
    end

    if upload_leaflet == 'true'
      medicine_leaflet = body["medicine_leaflet"] 
      ext = medicine_leaflet.original_filename.split('.').last
      filename = user_id.to_s + "-" + @medicine.id.to_s + "-" + Time.now.to_i.to_s + "." + ext.to_s 
      File.delete(Rails.root.join('public','uploads','medicine_leaflet', @medicine.medicine_leaflet))
      File.open(Rails.root.join('public', 'uploads','medicine_leaflet', filename.to_s ), 'wb') do |file|
        file.write(medicine_leaflet.read)
      end
      @medicine.update(medicine_leaflet: filename)
    end
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
