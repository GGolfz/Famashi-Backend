require 'bcrypt'
require 'jwt'

class Api::AuthController < ApplicationController
  include Response
  include Token
  def register
    body = JSON.parse(request.body.read)
    email = body["email"]
    password = body["password"]
    firstname = body["firstname"];
    lastname = body["lastname"];
    hashedPassword = BCrypt::Password.create(password)
    if User.find_by(email: email)
      error_response('This email is already taken')
      return
    end
    @user = User.create(email: email,password: hashedPassword, firstname: firstname, lastname: lastname)
    UserInfo.create(users_id:@user.id)
    # Todo: Generate User Reminder Here
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
      error_response('This email does not exist')
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
