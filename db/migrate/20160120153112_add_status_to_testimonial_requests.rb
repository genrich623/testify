class AddStatusToTestimonialRequests < ActiveRecord::Migration
  def change
    add_column :testimonial_requests, :status, :string
  end
end
