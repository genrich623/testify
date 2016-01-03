# == Schema Information
#
# Table name: testimonials
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  name                    :string
#  role                 :string
#  complany                  :string
#  image_file_name        :string
#  image_content_type     :string
#  image_file_size        :integer
#  image_updated_at       :datetime
#  content       :text
#  template_compiled      :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_testimonials_on_user_id  (user_id)
#

class Testimonial < ActiveRecord::Base

  paginates_per 10

  has_attached_file :image,
                    styles: { small: '60x60#', tile: '320x240#' }
  # we will not use hashes for now, later will plane file structure
  #url: '/system/:class/:attachment/:hash.:extension',
  #hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  validates_presence_of :name, :role, :company, :content
end
