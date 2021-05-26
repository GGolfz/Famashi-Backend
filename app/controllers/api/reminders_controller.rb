class Api::RemindersController < ApplicationController
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
    @reminders = Reminder.joins("INNER JOIN medicines ON medicines.id = reminders.medicines_id").joins("INNER JOIN user_reminders ON user_reminders.id = reminders.user_reminders_id").where(:medicines => {users_id:@user.id,remain_amount: 1..Float::INFINITY}).select("reminders.*,medicines.medicine_name,medicines.medicine_unit,medicines.dosage_amount,medicines.medicine_image,user_reminders.time_type,user_reminders.time")
    @usages = UsageHistory.where(users_id: @user.id,date:Time.now).select("*");
    success_response({reminders: @reminders,usages: @usages})
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
    @reminder = Reminder.find_by(id: @id)
    if @reminder == nil
      error_response('Reminder not found',404)
      return
    end
    @medicine = Medicine.find_by(id: @reminder.medicines_id)
    if @medicine == nil
      error_response('Medicine not found',404)
      return
    end
    @medicine.remain_amount -= @medicine.dosage_amount
    @medicine.save
    UsageHistory.create(users_id: @user.id, medicines_id: @medicine.id, amount: @medicine.dosage_amount, amount_unit: @medicine.medicine_unit,date: Time.now,time: Time.now,time_type: UserReminder.find_by(id: @reminder.user_reminders_id).time_type)
    @reminders = Reminder.joins("INNER JOIN medicines ON medicines.id = reminders.medicines_id").joins("INNER JOIN user_reminders ON user_reminders.id = reminders.user_reminders_id").where(:medicines => {users_id:@user.id,remain_amount: 1..Float::INFINITY}).select("reminders.*,medicines.medicine_name,medicines.medicine_unit,medicines.dosage_amount,medicines.medicine_image,user_reminders.time_type,user_reminders.time")
    @usages = UsageHistory.where(users_id: @user.id,date:Time.now).select("*");
    success_response({reminders: @reminders,usages: @usages})
  end
  
  def list
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @reminders = Reminder.joins("INNER JOIN user_reminders ON user_reminders.id = reminders.user_reminders_id").where(:user_reminders:{users_id: @user.id}).select("user_reminders.time_type,user_reminders.time").group(user_reminders:{:time_type,:time})
    success_response(@reminders)
  end
end
