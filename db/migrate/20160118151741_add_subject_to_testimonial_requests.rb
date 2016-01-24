class AddSubjectToTestimonialRequests < ActiveRecord::Migration
  def change
    add_column :testimonial_requests, :subject, :string
  end
end
