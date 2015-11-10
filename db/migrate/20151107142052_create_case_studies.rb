class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|
      t.references :user, index: true, foreign_key: true

      t.string :client

      t.string :title
      t.text :body
      t.attachment :image

      t.string :url, index: true
      t.text :body_short

      t.timestamps null: false
    end
  end
end
