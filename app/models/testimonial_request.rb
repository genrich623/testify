class TestimonialRequest < ActiveRecord::Base
  EMAIL_REGEX = /\A[0-9a-z](?:[a-z0-9\-_+\.]*[0-9a-z])?@(?:[a-z]+\.)+(?:info|\w{2,3})\z/i

  belongs_to :user
  belongs_to :testimonial

  validates_presence_of :name, :reply_to, :sender, :subject
  validates :email, presence: true, format: { with: EMAIL_REGEX }

  before_create { self.status = 'new' }
  after_create :generate_token

  def send_mail
    RequestMailer.send_mail(self).deliver
    update_attribute(:status, 'sent')
  rescue
    update_attribute(:status, 'failed to send')
  end

  def ready?
    status == 'Filled by customer'
  end

  private

  def generate_token
    update_attribute(:token,  Digest::SHA1.hexdigest("{name}_#{email}_#{id}"))
  end
end
