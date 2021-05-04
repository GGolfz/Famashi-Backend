require 'bcrypt'
class Api::AuthController < ApplicationController
  def register
    body = JSON.parse(request.body.read)
    username = body["username"]
    password = body["password"]
    firstname = body["firstname"]
    lastname = body["lastname"]
    hashedPassword = BCrypt::Password.create(password)
    render json: {
      password: hashedPassword
    }, status:200
  end

  def login
    body = JSON.parse(request.body.read)
    username = body["username"]
    password = body["password"]
    oldpassword = BCrypt::Password.new("$2a$12$ZANfZLbryuVV0/6vApCp7ejdJLWE4421IFG9lDCdo0hOQys9vBoeG")
    match = oldpassword == password
    render json: {
      match: match
    },status:200

  end
end
