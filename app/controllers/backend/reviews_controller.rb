class Backend::ReviewsController < ApplicationController
  before_action :set_review, except: [:index, :new, :create]

  def index
    @reviews = current_user.reviews.order('created_at DESC')
  end

  def new
    @review = Review.new
    @request =
      Request.new :sender => current_user.name, :reply_to => current_user.email
  end

  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      redirect_to reviews_path, :notice => 'Review created'
    else
      @request =
        Request.new :sender => current_user.name, :reply_to => current_user.email
      render :new
    end
  end

  def edit
    @review = Review.find params[:id]
  end

  def update
    if @review.update(review_params)
      redirect_to reviews_path, :notice => 'Review updated'
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      redirect_to reviews_path, :notice => 'Review destroyed'
    end
  end

  # def publish
  #   @testimonial.toggle(:published).save
  #   if @testimonial.testimonial_request && @testimonial.published?
  #     @testimonial.testimonial_request.destroy
  #   end
  #   redirect_to testimonials_path,
  #               notice: "Testimonial was #{'un' unless @testimonial.published? }published"
  # end

  def approve
    @review.update_attributes :approved => true

    redirect_to reviews_path, :notice => "Review was approved"
  end

  protected

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:image, :name, :role, :company, :content, :title, :rating)
  end
end
