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
                    styles: { tile: '320x240#', huge: '1920x1080#' }
                    # we will not use hashes for now, later will plane file structure
                    #url: '/system/:class/:attachment/:hash.:extension',
                    #hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  validates_presence_of :client, :title, :image, :template_content, :tile_template_content
  validates_uniqueness_of :url, scope: :user_id

  before_validation :prepare_url
  after_validation :prepare_url_errors
  before_save :prepare_templates, :add_link_to_tile

  def image_url
    SITE_URL + image.url(:tile)
  end

  class << self
    def find_by_user_url!(url)
      joins(:user).where(users: {url: url})
    end
  end

  # makes code for embeding tile
  def tile_code(base_url)
    "<script src=\"#{base_url}/embed.js\" type=\"text/javascript\">"\
    '</script><script type="text/javascript" charset="utf-8">testify(document).ready'\
    "(function() {testify_embed_tile(#{id});});"\
    '</script><div id="testify_embed_hook"></div>'
  end

private
  def prepare_url
    self.url = "#{client} #{title}".parameterize
  end

  def prepare_url_errors
    errors[:client] = I18n.t('errors.messages.already_exists', attr: 'Title and Client') if errors[:url].try(:any?)
  end

  def prepare_templates
    %i[template tile_template].each(&method(:compile_template)).each(&method(:minify_template))
  end

  def compile_template(name)
    send "#{name}_compiled=", Liquid::Template.parse(send "#{name}_content").render(attributes_for_templates)
  end

  def minify_template(name)
    premailer = Premailer.new(send("#{name}_compiled"), warn_level: Premailer::Warnings::NONE, with_html_string: true)
    send "#{name}_compiled=", Nokogiri::HTML(premailer.to_inline_css).css('body').inner_html
  end

  def attributes_for_templates
    attributes.slice(:url, :client, :title).merge(image: CodeGenerator::SITE_URL + image.url(:tile)).stringify_keys
  end

  def add_link_to_tile
    # TODO refactor this!!!
    url_compiled = "http://testify-test.herokuapp.com/#{user.url}/#{url}"
    #url_compiled = "http://#{user.domain}.testify-test.herokuapp.com/#{url}"
    tile_link = "<a style=\"position: absolute; top: 0; left: 0; width: 100%; height: 100%;"\
     " text-indent: -9999px; overflow: hidden;\" href=\"#{url_compiled}\"></a></div>"
    template = tile_template_compiled.chomp('</div>') + tile_link
    self.tile_template_compiled = template
  end

end
