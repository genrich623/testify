module ApplicationHelper
  def li(cond = false)
    opts = cond ? { class: 'active' } : {}
    content_tag(:li, opts) do
      yield
    end
  end

  def controller?(*controller)
    controller.map!(&:to_s)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.map!(&:to_s)
    action.include?(params[:action])
  end
end
