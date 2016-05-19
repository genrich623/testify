class Review < ActiveRecord::Base
  include Embeddable

  attr_accessor :request_token

  has_attached_file :image,
                    styles: { small: '60x60#', tile: '320x240#' }
  # we will not use hashes for now, later will plane file structure
  #url: '/system/:class/:attachment/:hash.:extension',
  #hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user
  # has_one :review_request

  validates_presence_of :name, :role, :company, :content, :title, :rating

  embed_as_self

  def to_s
    "#{name.humanize.titleize} from #{company.humanize}"
  end
end
