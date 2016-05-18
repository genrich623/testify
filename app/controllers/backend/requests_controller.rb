class Backend::RequestsController < ApplicationController
  #has_scope :page, default: 1
  before_action :init_request, :only => [:new_testimonial, :new_review]



  def create_testimonial
    @request = current_user.requests.new(request_params)
    @request.request_type = :testimonial

    if @request.save
      @request.send_mail
      redirect_to requests_path
    else
      render :new
    end
  end

  def create_review
    @request = current_user.requests.new(request_params)
    @request.request_type = :review

    if @request.save
      @request.send_mail
      redirect_to requests_path
    else
      render :new
    end
  end

  def index
    @requests = current_user.requests
  end

  def new_customer_testimonial
    @request = Request.find_by_token params[:token]
    if @request && @request.status == 'sent'
      @testimonial = Testimonial.new :name => @request.name
    else
      redirect_to root_path
    end
  end

  def new_customer_review
    @request = Request.find_by_token params[:token]
    if @request && @request.status == 'sent'
      @testimonial = Review.new :name => @request.name
    else
      redirect_to root_path
    end
  end

  def create_customer_testimonial
    @request = Request.find(params[:request_id])
    @user = @request.user
    @testimonial = @user.testimonials.new(testimonial_params)

    if @testimonial.save
      # @request.testimonial = @testimonial
      @request.update_attributes :status => 'Filled by customer'
      redirect_to root_path, :notice => 'Thank you for your feedback!' # later thanks page
    else
      render :new_customer_testimonial
    end
  end

  def create_customer_review
    @request = Request.find(params[:request_id])
    @user = @request.user
    @review = @user.reviews.new(review_params)

    if @review.save
      @request.review = @review
      @request.update_attributes :status => 'Filled by customer'
      redirect_to root_path, :notice => 'Thank you for your feedback!' # later thanks page
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
    params.require(:testimonial).permit(:image, :name, :role, :company, :content)
  end

  def request_params
    # params.require(:testimonial_request).permit(:name, :email, :sender,
    #                                             :reply_to, :subject, :message)
    params.require(:request).
      permit(:name, :email, :sender, :reply_to, :subject, :message)
  end

end
