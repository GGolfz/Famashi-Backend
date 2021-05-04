module Token
	def generate_token(user_id)
		payload = {user_id: user_id}
    	return JWT.encode payload, rsa_private = 'RS256'
	end
	def extract_token(token)
		return JWT.decode token, rsa_public, true, {algorithm: 'RS256'}
	end
end