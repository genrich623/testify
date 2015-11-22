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
    raise 'TODO'
  end
end
