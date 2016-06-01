class Backend::TestimonialsController < ApplicationController
  before_action :set_testimonial, except: [:index, :new, :create]

  def index
    @testimonials = current_user.testimonials.order('created_at DESC')
  end

  def new
    @testimonial = Testimonial.new
    @templates = TestimonialTemplate.all
    @request =
      Request.new :sender => current_user.name, :reply_to => current_user.email
  end

  def create
    @testimonial = current_user.testimonials.new(testimonial_params)

    if @testimonial.save
      redirect_to testimonials_path, notice: 'Testimonial created'
    else
      @templates = TestimonialTemplate.all
      @request =
        Request.new :sender => current_user.name, :reply_to => current_user.email
      render :new
    end
  end

  def edit
    @testimonial = Testimonial.find params[:id]
    @templates = TestimonialTemplate.all
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
    @testimonial.toggle(:published).save
    if @testimonial.testimonial_request && @testimonial.published?
      @testimonial.testimonial_request.destroy
    end
    redirect_to testimonials_path,
                notice: "Testimonial was #{'un' unless @testimonial.published? }published"
  end

  def approve
    @testimonial.update_attributes :approved => true

    redirect_to testimonials_path, :notice => "Testimonial was approved"
  end

  protected

  def set_testimonial
    @testimonial = current_user.testimonials.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:image, :name, :role, :company, :content, :template_id)
  end
end
