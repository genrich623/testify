# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_type  (type)
#

class Template < ActiveRecord::Base
end
