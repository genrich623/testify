class UserDecorator < Draper::Decorator
  delegate_all

  def code
    CodeGenerator.new(self).code
  end
end
