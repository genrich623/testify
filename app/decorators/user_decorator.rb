class UserDecorator < Draper::Decorator
  delegate_all

  def code
    JsGenerator.new(url).code
  end
end
