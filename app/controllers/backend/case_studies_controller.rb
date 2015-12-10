class Backend::CaseStudiesController < Backend::ApplicationController
  inherit_resources
  has_scope :page, default: 1

  def add_image # refactor it!
    image = Image.create(image: params[:image])
    @image = image.image
    respond_to :js
  end

  def add_template
    template = Nokogiri::HTML(params[:template].read)
    template.css('style,script,iframe').remove
    @template = template.to_s
    respond_to :js
  end

  protected
  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(case_study: [:image, :client, :title, :template_content, :tile_template_content])
  end

  def collection_url
    case_studies_path
  end

  def resource_url
    case_study_path(resource)
  end
end