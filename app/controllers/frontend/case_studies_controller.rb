class Frontend::CaseStudiesController < Frontend::ApplicationController
  inherit_resources
  actions :index, :show
  belongs_to :user, finder: :find_by_url!, param: :user_url

  protected def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:url]))
  end
end