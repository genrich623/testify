class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.references :user, index: true, foreign_key: true

      t.string :name
      t.string :role
      t.string :company

      t.attachment :image

      t.text :content
      t.text :template_compiled

      t.timestamps null: false
    end
  end
end
