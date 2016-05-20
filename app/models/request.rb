class Request < ActiveRecord::Base
  enum :request_type => [:testimonial, :review]

  EMAIL_REGEX =
    /\A[0-9a-z](?:[a-z0-9\-_+\.]*[0-9a-z])?@(?:[a-z]+\.)+(?:info|\w{2,3})\z/i

  belongs_to :user

  validates_presence_of :name, :reply_to, :sender, :subject, :request_type
  validates :email, :presence => true, :format => { :with => EMAIL_REGEX }

  before_create { self.status = 'new' }
  after_create :generate_token

  def send_mail
    RequestMailer.send_mail(self).deliver
    self.update_attributes :status => 'sent'
  rescue
    self.update_attributes :status => 'failed to send'
  end

  def ready?
    status == 'Filled by customer'
  end

  private

  def generate_token
    self.update_attributes(
      :token =>  Digest::SHA1.hexdigest("{name}_#{email}_#{id}"))
  end
end
