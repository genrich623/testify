class Backend::CaseStudiesController < Backend::ApplicationController
  #include Wicked::Wizard
  before_action :set_case_study, except: [:index, :new, :create]
  #steps :template, :content, :tile_template, :tile_content

  def index
    @case_studies = current_user.case_studies.all
  end

  def new
    @case_study = CaseStudy.new
  end

  def main
    wizard_save(nil, next: :logo, back: :edit)
  end

  def logo
    @case_study.update(case_study_params) if case_study_params
    wizard_save(:validate_logo, next: :template, back: :logo)
  end

  def template
    if case_study_params[:template_id]
      template_content = CaseStudyTemplate.find(case_study_params[:template_id]).template
      template_content.gsub!('{client}', @case_study.client)
          .gsub!('{title}', @case_study.title)
          .gsub!('{image_path}', @case_study.image.url)
      puts template_content
      @case_study.update(template_content: template_content)
    end
    wizard_save(:validate_template, next: :content, back: :template)
  end

  def content
    @case_study.update(case_study_params) if case_study_params
    #wizard_save(:validate_template, next: :tile_template, back: :content)
    redirect_to case_study_path(@case_study), notice: 'Case study created!'
  end

  def tile_template
    # TBD
  end

  def tile_content
    # TBD
  end

  def create
    @case_study = current_user.case_studies.new(case_study_params)
    wizard_save(nil, next: :logo, back: :new)
  end

  def show
  end

  def edit
    params[:step] ||= :new
    render params[:step]
  end

  def update
    send(params[:step]) if params[:step].present?
  end

  def destroy
  end

  #def add_template
  #  template = Nokogiri::HTML(params[:template].read)
  #  template.css('script,iframe').remove
  #  @template = template.to_s
  #  @editor_index =  %w(case_study tile).find_index(params[:type])
  #  respond_to :js
  #end

  protected

  def set_case_study
    @case_study = CaseStudy.find(params[:id])
  end

  def case_study_params
    if params[:case_study].present? && params[:case_study].any?
      params.require(:case_study).permit(:image, :client, :title, :template_id,
                                         :template_content, :tile_template_content)
    end
  end

  def wizard_save(validation, args = {})
    if (validation ? send(validation, @case_study) : true) && @case_study.save
      redirect_to edit_case_study_path(@case_study, step: args[:next])
    else
      render args[:back]
    end
  end

  private

  def validate_logo(cs)
    cs.errors[:image] << 'should be uploaded' unless cs.image.present?
    cs.errors.empty?
  end

  def validate_template(cs)
    cs.errors[:template_content] << 'should be choosen' unless cs.template_content.present?
    cs.errors.empty?
  end

end