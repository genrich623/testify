class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, :index => true, :foreign_key => true

      t.string :name
      t.string :email
      t.string :sender
      t.string :reply_to
      t.string :subject
      t.text :message
      t.string :token
      t.string :status

      t.integer :request_type, :null => false

      t.timestamps :null => false
    end
  end
end
