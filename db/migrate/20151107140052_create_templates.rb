class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :type, index: true

      t.string :title
      t.string :description
      t.attachment :preview
      t.text :template

      t.timestamps null: false
    end
  end
end
