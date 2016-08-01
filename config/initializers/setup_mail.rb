ActionMailer::Base.smtp_settings = {
	address: "mail.livinglifefearless.co",
    port: 25,
    domain: "thecollectivv.co",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["EMAIL_USERNAME"],
    password: ENV["EMAIL_PASSWORD"],
    openssl_verify_mode: 'none' 
}