class RequestMailer < ApplicationMailer
  def send_mail(request)
    @request = request
    mail(from: request.name, to: request.email,
         subject: request.subject, template_name: 'request')
  end
end
