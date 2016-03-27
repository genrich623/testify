class AddTemplateToCaseStudy < ActiveRecord::Migration
  def change
    add_reference :case_studies, :template
  end
end
