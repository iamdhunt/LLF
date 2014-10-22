# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LLF::Application.initialize!

ActionMailer::Base.smtp_settings = {
	address: "mail.livinglifefearless.co",
    port: 25,
    domain: "l-l-f.co",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["EMAIL_USERNAME"],
    password: ENV["EMAIL_PASSWORD"],
    openssl_verify_mode: 'none' 
}