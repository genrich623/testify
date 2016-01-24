class CreateTestimonialRequests < ActiveRecord::Migration
  def change
    create_table :testimonial_requests do |t|
      t.references :user, index: true, foreign_key: true

      t.string :name
      t.string :email
      t.string :sender
      t.string :reply_to
      t.string :message

      t.timestamps null: false
    end
  end
end
