class Backend::TestimonialsController < ApplicationController
  inherit_resources
  has_scope :page, default: 1

  protected
  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(testimonial: [:image, :name, :role, :company, :content])
  end

  def collection_url
    testimonials_path
  end

  def resource_url
    testimonial_path(resource)
  end
end
