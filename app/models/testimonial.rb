class Testimonial < ActiveRecord::Base
  include Embeddable

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

  embed_as_self

  def template_with_pic
    template_compiled.gsub!('{image_path}', image(:small))
  end

  def to_s
    "#{name.humanize.titleize} from #{company.humanize}"
  end

  private

  def prepare_template
    template = TestimonialTemplate.take.template # TODO make choosing templates (now any template)
    self.template_compiled = template.gsub!('{name}', name).gsub!('{role}', role)
                              .gsub!('{company}', company).gsub!('{content}', content)
  end
end
