class AddApprovedToTestimonial < ActiveRecord::Migration
  def change
    add_column :testimonials, :approved, :boolean, :default => false
  end
end
