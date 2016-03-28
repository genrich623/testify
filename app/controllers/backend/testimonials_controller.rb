class Backend::TestimonialsController < ApplicationController
  #inherit_resources
  #has_scope :page, default: 1

  def index
    @testimonials = current_user.testimonials
  end

  def new
    @testimonial = Testimonial.new
  end

  def publish
    testimonial = Testimonial.find(params[:id])
    testimonial.toggle(:published).save
    if testimonial.testimonial_request && testimonial.published?
      testimonial.testimonial_request.destroy
    end
    redirect_to testimonials_path
  end

  protected
  #def begin_of_association_chain
  #  current_user
  #end

  def testimonial_params
    params.require(:testimonial).permit(:image, :name, :role, :company, :content)
  end

  #def collection_url
  #  testimonials_path
  #end

  #def resource_url
  #  testimonial_path(resource)
  #end
end
