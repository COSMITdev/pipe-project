class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@pipeproject.com"
  layout 'mailer'
end
