class AddTokenToTestimonialRequests < ActiveRecord::Migration
  def change
    add_column :testimonial_requests, :token, :string
  end
end
