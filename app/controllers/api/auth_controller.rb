require 'bcrypt'
require 'jwt'

class Api::AuthController < ApplicationController
  include Response
  include Token
  def register
    body = JSON.parse(request.body.read)
    email = body["email"]
    password = body["password"]
    firstname = body["firstname"]
    lastname = body["lastname"]
    hashedPassword = BCrypt::Password.create(password)
    if User.find_by(email: email)
      error_response('This email is already taken')
      return
    end
    num = rand(1..10)
    profile_img = 'Avatar-'
    if num < 10
      profile_img += '0'+num.to_s+'.png'
    else 
      profile_img += num.to_s+'.png'
    end
    @user = User.create(email: email,password: hashedPassword, firstname: firstname, lastname: lastname,profile_pic: profile_img)
    UserInfo.create(users_id: @user.id)
    UserReminder.create(users_id: @user.id,time_type: 0,time:'07:00')
    UserReminder.create(users_id: @user.id,time_type: 1,time:'08:00')
    UserReminder.create(users_id: @user.id,time_type: 2,time:'12:00')
    UserReminder.create(users_id: @user.id,time_type: 3,time:'13:00')
    UserReminder.create(users_id: @user.id,time_type: 4,time:'17:00')
    UserReminder.create(users_id: @user.id,time_type: 5,time:'18:00')
    UserReminder.create(users_id: @user.id,time_type: 6,time:'22:00')
    token = generate_token(@user.id)
    @user.password = nil
    success_response({
      user: @user,
      token: token
    })
  end

  def login
    body = JSON.parse(request.body.read)
    email = body["email"]
    password = body["password"]
    @user = User.find_by(email: email)
    if @user == nil
      error_response('This email does not exist', 404)
      return
    end

    oldpassword = BCrypt::Password.new(@user.password)
    if oldpassword != password
      error_response('Password is incorrect')
      return
    end
    token = generate_token(@user.id)
    @user.password = nil
    success_response({
      user: @user,
      token: token
    })
  end
end
