class CaseStudyDecorator < Draper::Decorator
  delegate_all

  def to_s
    if persisted?
      "#{client} - #{title}"
    else
      I18n.t('activerecord.models.case_study.one')
    end
  end
end
