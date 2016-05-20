class RequestMailer < ApplicationMailer
  def send_mail request
    @request = request
    @host = (Rails.env == 'production') ? 'testifysells.herokuapp.com' : '0.0.0.0:3000'
    mail(from: 'noreply@testifysells.herokuapp.com', to: request.email,
         subject: request.subject, template_name: request.request_type.to_s)
  end
end
