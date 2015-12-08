class Image < ActiveRecord::Base
  has_attached_file :image
                    #styles: { tile: '320x240#', huge: '1920x1080#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
