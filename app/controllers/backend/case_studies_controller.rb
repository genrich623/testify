class Backend::CaseStudiesController < Backend::ApplicationController
  inherit_resources
  has_scope :page, default: 1

  protected
  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(case_study: [:image, :client, :title, :body])
  end

  def resource_url
    case_study_path(resource)
  end
end