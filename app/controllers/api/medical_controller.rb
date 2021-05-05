class Api::MedicalController < ApplicationController
  include Response
  include Token
  def index
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    @userInfo = UserInfo.find_by(users_id:user_id)
    success_response(@userInfo)
  end

  def update
    token = request.headers['Authorization'].split(' ').last
    user_id = extract_token(token)
    @user = User.find_by(id: user_id)
    if @user == nil
      error_response('Unauthorize', 401)
      return
    end
    body = JSON.parse(request.body.read)
    gender = body["gender"]
    birthdate = body["birthdate"]
    weight = body["weight"]
    height = body["height"]
    isG6PD = body["isG6PD"]
    isLiver = body["isLiver"]
    isKidney = body["isKidney"]
    isGastritis = body["isGastritis"]
    isBreastfeeding = body["isBreastfeeding"]
    isPregnant = body["isPregnant"]
    @userInfo = UserInfo.find_by(users_id:user_id)
    @userInfo.update(
      gender: gender,
      birthdate: birthdate,
      weight: weight,
      height: height,
      isG6PD: isG6PD,
      isLiver: isLiver,
      isKidney: isKidney,
      isGastritis: isGastritis,
      isBreastfeeding: isBreastfeeding,
      isPregnant: isPregnant
    )
    
    success_response(@userInfo)
    
  end
end
