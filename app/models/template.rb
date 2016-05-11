# == Schema Information
#
# Table name: templates
#
#  id                   :integer          not null, primary key
#  type                 :string
#  title                :string
#  description          :string
#  preview_file_name    :string
#  preview_content_type :string
#  preview_file_size    :integer
#  preview_updated_at   :datetime
#  template             :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_templates_on_type  (type)
#

class Template < ActiveRecord::Base
  has_attached_file :preview,
                    styles: { tile: '320x240#' }
                    # we will not use hashes for now, later will plane file structure
                    #url: '/system/:class/:attachment/:hash.:extension',
                    #hash_secret: ENV['PAPERCLIP_HASH_SECRET']
  validates_attachment_content_type :preview, content_type: /\Aimage\/.*\Z/

  validates_presence_of :title, :template, :preview
end
