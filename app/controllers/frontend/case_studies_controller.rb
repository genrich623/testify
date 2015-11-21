class Frontend::CaseStudiesController < Frontend::ApplicationController
  inherit_resources
  actions :index, :show
  resources_configuration[:self][:finder] = :find_by_url!
  belongs_to :user, finder: :find_by_url!, param: :user_url

  has_scope :page, default: 1

  respond_to :html, :json

  def code
    head :ok
  end

  before_filter :check_referer, only: [:code]
  protected
  def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:url]))
  end

  def validate_request
    u = URI(request.referer)
    u.query = u.fragment = nil
    u.path = ''
    SignUtils.sign(u.host) == params[:sign] && parent.domain == u.host rescue false
  end

  def check_referer
    return unless request.referer
    response.headers['Access-Control-Allow-Origin'] = URI.join(request.referer, '/').to_s[0..-2] if validate_request
  end
end