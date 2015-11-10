class CaseStudyDecorator < Draper::Decorator
  delegate_all

  REPLACES = {
    body: :body,
    title: :title,
    client: :client
  }

  def to_s
    if persisted?
      "#{client} - #{title}"
    else
      I18n.t('activerecord.models.case_study.one')
    end
  end

  def truncated_body
    body
  end

  def rendered_template
    template = self.template.dup
    REPLACES.each { |k, v| template.gsub!("{{#{k}}}", object.send(v)) }
    template
  end
end
