class Backend::RequestsController < ApplicationController
  #has_scope :page, default: 1

  def new
    @request = TestimonialRequest.new(sender: current_user.name,
                                      reply_to: current_user.email)
  end

  def create
    @request = current_user.testimonial_requests.new(request_params)
    if @request.save
      @request.send_mail
      redirect_to requests_path
    else
      render :new
    end
  end

  def index
    @requests = current_user.testimonial_requests
  end

  def customers_testimonial
    @request = TestimonialRequest.find_by_token(params[:token])
    if @request && @request.status == 'sent'
      @testimonial = Testimonial.new(name: @request.name)
    else
      redirect_to root_path
    end
  end

  def customer_create
    request = TestimonialRequest.find(params[:request_id])
    user = request.user
    @testimonial = user.testimonials.new(testimonial_params)
    if @testimonial.save
      request.testimonial = @testimonial # maybe unnecessary
      request.update_attribute(:status, 'Filled by customer')
      redirect_to root_path # later thanks page
    else
      render :customers_testimonial
    end
  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:image, :name, :role, :company, :content)
  end

  def request_params
    params.require(:testimonial_request).permit(:name, :email, :sender,
                                                :reply_to, :subject, :message)
  end

end
