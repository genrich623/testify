class RequestMailer < ApplicationMailer
  def send_mail(request)
    @request = request
    mail(from: 'noreply@testify-test@herokuapp.com', to: request.email,
         subject: request.subject, template_name: 'request')
  end
end
