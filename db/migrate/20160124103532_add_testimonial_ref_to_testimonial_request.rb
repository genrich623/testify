class AddTestimonialRefToTestimonialRequest < ActiveRecord::Migration
  def change
    add_reference :testimonial_requests, :testimonial, index: true,
                  foreign_key: true
  end
end
