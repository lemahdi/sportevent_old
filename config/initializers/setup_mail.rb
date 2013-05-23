require 'development_mail_interceptor'

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.default content_type: "text/html"

ActionMailer::Base.smtp_settings = {
  address:              Rails.env.production? ? "smtp.sendgrid.net" : "smtp.gmail.com",
  port:                 587,
  domain:               Rails.env.production? ? "heroku.com" : "gmail.com",
  user_name:            Rails.env.production? ? ENV['SENDGRID_USERNAME'] : "mahdi00",
  password:             Rails.env.production? ? ENV['SENDGRID_PASSWORD'] : "paris0",
  authentication:       :plain,
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = Rails.env.production? ? "layoletteparisienne.herokuapp.com" : "localhost:3000"

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?