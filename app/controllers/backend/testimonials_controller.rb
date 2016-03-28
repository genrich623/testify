class Backend::TestimonialsController < ApplicationController
  #inherit_resources
  #has_scope :page, default: 1


  def index
    @testimonials = current_user.testimonials
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    if @testimonial.save
      redirect_to testimonials_path, notice: 'Testimonial created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to testimonials_path, notice: 'Testimonial updated'
    else
      render :edit
    end
  end

  def destroy
    redirect_to testimonials_path, notice: 'Testimonial destroyed' if @testimonial.destroy
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

  def set_testimonial
    @testimonial = current_user.testimonials.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:image, :name, :role, :company, :content)
  end
end
