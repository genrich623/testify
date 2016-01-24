class RequestMailer < ApplicationMailer
  def send_mail(request)
    @request = request
    @host = (Rails.env == 'production') ? 'testify-test.herokuapp.com' : '0.0.0.0:3000'
    mail(from: 'noreply@testify-test.herokuapp.com', to: request.email,
         subject: request.subject, template_name: 'request')
  end
end
