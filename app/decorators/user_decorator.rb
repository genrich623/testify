class UserDecorator < Draper::Decorator
  delegate_all

  def code
    JsGenerator.new(self).code
  end
end
