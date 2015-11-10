# == Schema Information
#
# Table name: case_studies
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  client             :string
#  title              :string
#  body               :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  url                :string
#  body_short         :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_case_studies_on_url      (url)
#  index_case_studies_on_user_id  (user_id)
#

class CaseStudy < ActiveRecord::Base
  paginates_per 10

  has_attached_file :image,
                    styles: { tile: '320x240#', huge: '1920x1080#' },
                    url: '/system/:class/:attachment/:hash.:extension',
                    hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  validates_presence_of :client, :title
  validates_uniqueness_of :url, scope: :user_id

  before_validation :prepare_url

private
  def prepare_url
    self.url = "#{client} #{title}".parameterize
  end
end
