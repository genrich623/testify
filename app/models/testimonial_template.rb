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

class TestimonialTemplate < Template
end