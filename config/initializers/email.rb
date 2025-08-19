begin
  ActionMailer::Base.logger = nil
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => (ENV['SMTP_START_TLS'] == "true" ? true : false),
    :address              => ENV['SMTP_ADDRESS'],
    :domain               => ENV['SMTP_DOMAIN'],
    :port                 => ENV['SMTP_PORT'],
    :authentication       => :plain,
    :user_name            => ENV['SMTP_USERNAME'],
    :password             => ENV['SMTP_PASSWORD']
  }
rescue
end

Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    deliver_with: :deliver, # Rails >= 4.2.1 do not need this option since it defaults to :deliver_now
    email_prefix: "[#{ENV['NOTIFICATION_PREFIX']}] ",
    sender_address: "#{ENV['NOTIFICATION_SENDER']}",
    exception_recipients: "#{ENV['NOTIFICATION_RECIPIENTS']}"
  }