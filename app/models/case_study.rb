# == Schema Information
#
# Table name: case_studies
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  url                    :string
#  client                 :string
#  title                  :string
#  image_file_name        :string
#  image_content_type     :string
#  image_file_size        :integer
#  image_updated_at       :datetime
#  template_content       :text
#  template_compiled      :text
#  tile_template_content  :text
#  tile_template_compiled :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_case_studies_on_url      (url)
#  index_case_studies_on_user_id  (user_id)
#

class CaseStudy < ActiveRecord::Base
  include FindableByUrl
  SITE_URL = "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}#{':' + ENV['SITE_PORT'] if ENV['SITE_PORT']}"

  paginates_per 10

  has_attached_file :image,
                    styles: { tile: '320x240#', huge: '1920x1080#' },
                    url: '/system/:class/:attachment/:hash.:extension',
                    hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  validates_presence_of :client, :title, :image, :template_content, :template_compiled
  validates_uniqueness_of :url, scope: :user_id

  before_validation :prepare_url

  # after_initialize { self.body ||= "<div class='container'>
  #   <div class='row'>
  #       <div class='sidebar col-md-4 col-md-push-8'>
  #           <h3 class='sidebar__title'>New Study case </h3>
  #           <ul class='sidebar__list list'>
  #               <li class='list__element'><a href='' class='list__link'>Celebrating a New</a></li>
  #               <li class='list__element'>Celebrating a New</li>
  #           </ul>
  #       </div>
  #       <div class='content col-md-8 col-md-pull-4'>
  #           <h3 class='content__title'>New Study case</h3>
  #           <p class='content__text'>Simple text.</p>
  #           <blockquote>
  #               Simple quote
  #           </blockquote>
  #       </div>
  #   </div>"
  # }


  def image_url
    SITE_URL + image.url(:tile)
  end

  class << self
    def find_by_user_url!(url)
      joins(:user).where(users: {url: url})
    end
  end

private
  def prepare_url
    self.url = "#{client} #{title}".parameterize
  end
end
