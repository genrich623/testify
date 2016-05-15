class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, :index => true, :foreign_key => true

      t.string :name
      t.string :role
      t.string :company

      t.attachment :image

      t.text :title
      t.text :content

      t.integer :rating

      t.boolean :published, :default => false
      t.boolean :approved, :default => false

      t.timestamps :null => false
    end
  end
end
