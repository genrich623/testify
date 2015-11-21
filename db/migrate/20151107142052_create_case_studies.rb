class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|
      t.references :user, index: true, foreign_key: true
      t.string :url, index: true

      t.string :client
      t.string :title

      t.attachment :image

      t.text :template_content
      t.text :template_compiled

      t.text :tile_template_content
      t.text :tile_template_compiled

      t.timestamps null: false
    end
  end
end
