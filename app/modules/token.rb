module Token
	def generate_token(user_id)
		secret = "f@m@$h1$3Cl23T"
		payload = {user_id: user_id}
    	return JWT.encode payload, secret, 'HS256'
	end
	def extract_token(token)
		secret = "f@m@$h1$3Cl23T"
		extracted_data = JWT.decode token, secret, true, {algorithm: 'HS256'}
		return extracted_data[0]["user_id"]
	end
end