class Api::UserController < ApplicationController
  include Token
  include Response
  def index
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    @user.password = nil
    success_response({
      user: @user,
      token: token
    })
  end

  def update
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    body = JSON.parse(request.body.read)
    email = body["email"]
    firstname = body["firstname"]
    lastname = body["lastname"]
    @current = User.find_by(email: email)
    if @current && @current.id != user_id
      error_response('This email is already taken')
      return
    end
    @user = User.find_by(id: user_id)
    @user.email = email
    @user.firstname = firstname
    @user.lastname = lastname
    @user.save
    @user.password = nil
    success_response({
      user: @user
    })
  end

  def password
  end

  def image
  end
end
