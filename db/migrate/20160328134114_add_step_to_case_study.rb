class AddStepToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :step, :string
  end
end
