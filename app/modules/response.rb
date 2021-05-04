module Response
	def error_response(message,statusCode = 400)
		render json: {
			message: message
		}, status: statusCode
		return
	end
	def success_response(data,statusCode = 200)
		render json: data, status: statusCode
		return
	end
end