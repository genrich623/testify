class AddPublishedToTestimonial < ActiveRecord::Migration
  def change
    add_column :testimonials, :published, :boolean, default: false
  end
end
