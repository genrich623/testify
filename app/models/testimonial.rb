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
  has_one :testimonial_request

  validates_presence_of :name, :role, :company, :content

  before_save :prepare_template

  def template_with_pic
    template_compiled.gsub!('{image_path}', image(:small))
  end

  # makes code for embedding tile
  def code(base_url)
    "<script src=\"#{base_url}/embed.js\" type=\"text/javascript\">"\
    '</script><script type="text/javascript" charset="utf-8">testify(document).ready'\
    "(function() {testify_embed_testimonial(#{id});});"\
    "</script><div id=\"testify_embed_hook_testimonial_#{id}\"></div>"
  end

  private

  def prepare_template
    template = TestimonialTemplate.take.template # TODO make choosing templates (now any template)
    self.template_compiled = template.gsub!('{name}', name).gsub!('{role}', role)
                              .gsub!('{company}', company).gsub!('{content}', content)
  end
end
