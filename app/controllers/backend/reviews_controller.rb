class Backend::ReviewsController < ApplicationController
  before_action :set_reviews, except: [:index, :new, :create]

  def index
    @reviews = current_user.reviews.order('created_at DESC')
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      redirect_to reviews_path, notice: 'Review created'
    else
      render :new
    end
  end

  # def edit
  #   @testimonial = Testimonial.find params[:id]
  #   @templates = TestimonialTemplate.all
  # end

  # def update
  #   if @testimonial.update(testimonial_params)
  #     redirect_to testimonials_path, notice: 'Testimonial updated'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   redirect_to testimonials_path, notice: 'Testimonial destroyed' if @testimonial.destroy
  # end

  # def publish
  #   @testimonial.toggle(:published).save
  #   if @testimonial.testimonial_request && @testimonial.published?
  #     @testimonial.testimonial_request.destroy
  #   end
  #   redirect_to testimonials_path,
  #               notice: "Testimonial was #{'un' unless @testimonial.published? }published"
  # end

  # def approve
  #   @testimonial.update_attributes :approved => true

  #   redirect_to testimonials_path, :notice => "Testimonial was approved"
  # end

  protected

  # def set_reviews
  #   @testimonial = current_user.testimonials.find(params[:id])
  # end

  def review_params
    params.require(:review).permit(:image, :name, :role, :company, :content, :title, :rating)
  end
end
