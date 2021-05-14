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
    @reminders = Reminder.where(medicines_id: Medicine.where(users_id:@user.id))
    success_response(@reminders)
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
    @medicine = Medicine.find_by(id: @reminder.medicines_id)
    @medicine.remain_amount -= @medicine.dosage_amount
    @medicine.save
    UsageHistory.create(users_id: @user.id, medicines_id: @medicine.id, amount: @medicine.dosage_amount, amount_unit: @medicine.dosage_unit)
    @reminders = Reminder.where(medicines_id: Medicine.where(users_id:@user.id))
    success_response(@reminders)
  end
end
