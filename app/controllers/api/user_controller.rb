class Api::UserController < ApplicationController
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
    @user.password = nil
    success_response({
      user: @user,
      token: token
    })
  end

  def update
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    body = params
    email = body["email"]
    firstname = body["firstname"]
    lastname = body["lastname"]
    upload = body["upload"]
    @current = User.find_by(email: email)
    if @current && @current.id != user_id
      error_response('This email is already taken')
      return
    end
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    filename = @user.profile_pic
    if upload == 'true'
      upload_file = body['profile_img']
      ext = upload_file.original_filename.split('.').last
      filename = user_id.to_s + "-" + Time.now.to_i.to_s + "." + ext.to_s 
      File.delete(Rails.root.join('public','uploads','profile_img', @user.profile_pic))
      File.open(Rails.root.join('public', 'uploads','profile_img', filename.to_s ), 'wb') do |file|
        file.write(upload_file.read)
      end
    end

    @user.update(email:email,firstname:firstname,lastname:lastname,profile_pic:filename)
    @user.password = nil
    success_response({
      user: @user
    })
  end

  def password
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    body = JSON.parse(request.body.read)
    old_password = body["old_password"]
    password = body["new_password"]
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    if @user.password != old_password 
      error_response('Wrong Password',400)
      return
    end
    hashedPassword = BCrypt::Password.create(password)
    @user.update(password: hashedPassword)
    @user.password = nil
    success_response({
      user: @user
    })
  end

  def notification_get
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @reminders = UserReminder.where(users_id: user_id)
    success_response(@reminders)
  end

  def notification_patch
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    body = JSON.parse(request.body.read)
    data = [
      body["BEFORE_MORNING"],
      body["AFTER_MORNING"],
      body["BEFORE_NOON"],
      body["AFTER_NOON"],
      body["BEFORE_EVENING"],
      body["AFTER_EVENING"],
      body["BEDTIME"]
    ]
    data.each_with_index do |item, index|
      @reminder = UserReminder.find_by(users_id: @user.id, time_type: index)
      @reminder.update(time: data[index])
    end
    @reminders = UserReminder.where(users_id: user_id)
    success_response(@reminders)

  end
end
