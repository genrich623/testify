class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :type, index: true

      t.timestamps null: false
    end

    add_column :case_studies, :template, :text
    add_reference :case_studies, :template, index: true, foreign_key: true
  end

  def down
    remove_reference :case_studies, :template
    remove_column :case_studies, :template
    drop_table :templates
  end
end
