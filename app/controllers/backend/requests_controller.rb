class Backend::RequestsController < ApplicationController
  #has_scope :page, default: 1
  before_action :init_request, :only => [:new_testimonial, :new_review]



  def create_testimonial
    @request = current_user.requests.new(request_params)
    @request.request_type = :testimonial

    if @request.save
      @request.send_mail
      redirect_to requests_path, :notice => 'Request for Testimonial sent'
    else
      @testimonial = Testimonial.new
      @templates = TestimonialTemplate.all
      render 'backend/testimonials/new'
    end
  end

  def create_review
    @request = current_user.requests.new(request_params)
    @request.request_type = :review

    if @request.save
      @request.send_mail
      redirect_to requests_path, :notice => 'Request for Review sent'
    else
      @review = Review.new
      render 'backend/reviews/new'
    end
  end

  def index
    @requests = current_user.requests.order('created_at DESC')
  end

  def destroy
    @request = current_user.requests.find params[:id]
    redirect_to requests_path, notice: 'Request destroyed' if @request.destroy
  end

  def new_customer_testimonial
    @request = Request.find_by_token params[:token]
    if @request && @request.status == 'sent'
      @testimonial =
        Testimonial.new :name => @request.name, :request_token => params[:token]
      @templates = TestimonialTemplate.all
    else
      redirect_to testimonials_path, :notice => 'Testimonial created'
    end
  end

  def new_customer_review
    @request = Request.find_by_token params[:token]
    if @request && @request.status == 'sent'
      @review =
        Review.new :name => @request.name, :request_token => params[:token]
    else
      redirect_to reviews_path, :notice => 'Review created'
    end
  end

  def create_customer_testimonial
    @request = Request.find_by_token params[:token]
    @user = @request.user
    @testimonial = @user.testimonials.new(testimonial_params)

    if @testimonial.save
      # @request.testimonial = @testimonial
      @request.update_attributes :status => 'Filled by customer'
      redirect_to testimonials_path, :notice => 'Thank you for your feedback!' # later thanks page
    else
      @templates = TestimonialTemplate.all
      render :new_customer_testimonial
    end
  end

  def create_customer_review
    @request = Request.find_by_token params[:token]
    @user = @request.user
    @review = @user.reviews.new(review_params)

    if @review.save
      # @request.review = @review
      @request.update_attributes :status => 'Filled by customer'
      redirect_to reviews_path, :notice => 'Thank you for your feedback!' # later thanks page
    else
      render :new_customer_review
    end
  end

  private

  def init_request
    @request =
      Request.new :sender => current_user.name, :reply_to => current_user.email
  end

  def testimonial_params
    params.require(:testimonial).permit(:image, :name, :role, :company, :content, :template_id)
  end

  def review_params
    params.require(:review).permit(:image, :name, :role, :company, :content, :title, :rating)
  end

  def request_params
    params.require(:request).
      permit(:name, :email, :sender, :reply_to, :subject, :message)
  end

end
