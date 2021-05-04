require 'bcrypt'
require 'jwt'
class Api::AuthController < ApplicationController
  def register
    body = JSON.parse(request.body.read)
    email = body["email"]
    password = body["password"]
    firstname = body["firstname"]
    lastname = body["lastname"]
    hashedPassword = BCrypt::Password.create(password)
    if User.find_by(email: email)
      render json: {
        message: 'This email is already taken'
      }, status: 400
      return
    end
    @user = User.create(email: email,password: hashedPassword, firstname: firstname, lastname: lastname)
    payload = {user_id: @user.id}
    token = JWT.encode payload, rsa_private = 'RS256'
    render json: {
      user: @user,
      token: token
    }, status: 200
  end

  def login
    body = JSON.parse(request.body.read)
    email = body["email"]
    password = body["password"]
    @user = User.find_by(email: email)
    if @user == nil
      render json: {
        message: 'This email does not exist'
      }, status: 404
      return
    end

    oldpassword = BCrypt::Password.new(@user.password)
    if oldpassword != password
      render json: {
        message: 'Wrong password'
      }, status: 403
      return
    end
    payload = {user_id: @user.id}
    token = JWT.encode payload, rsa_private = 'RS256'
    render json: {
      user: @user,
      token: token
    }
  end
end
