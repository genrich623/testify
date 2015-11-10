class Frontend::CaseStudiesController < Frontend::ApplicationController
  inherit_resources
  actions :index, :show
  resources_configuration[:self][:finder] = :find_by_url!
  belongs_to :user, finder: :find_by_url!, param: :user_url

  has_scope :page, default: 1

  protected def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:url]))
  end
end