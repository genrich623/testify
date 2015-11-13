class Frontend::CaseStudiesController < Frontend::ApplicationController
  inherit_resources
  actions :index, :show
  resources_configuration[:self][:finder] = :find_by_url!
  belongs_to :user, finder: :find_by_url!, param: :user_url

  has_scope :page, default: 1

  # respond_to :html, except: [:index]
  # respond_to :html, :json, only: [:index]

  before_filter only: [:index] do
    response.headers['Access-Control-Allow-Origin'] = URI.join(request.referer, '/').to_s[0..-2] if validate_request
  end

  def index
    cases = User.find_by(url: params[:user_url]).case_studies
    render json: cases.to_json(:only => [:body, :body_short, :client, :id, :title, :url, :user_id, :template, :template_id], :methods => [:image_url])
  end

  protected def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:url]))
  end

  def validate_request
    return request.referer.present?

    # TODO
    u = URI(request.referer)
    u.query = u.path = u.fragment = nil
    SignUtils.sign(u.to_s) == params[:sign] && resource.domains.include?(u.domain)
  end
end