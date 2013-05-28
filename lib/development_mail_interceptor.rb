class DevelopmentMailInterceptor
	def self.delivering_email(message)
		message.subject = "[LaYoletteParisienne-DEV] #{message.to}"
		message.to = "akkouh.mahdi@gmail.com"
	end
end