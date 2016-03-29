module Publishable
  extend ActiveSupport::Concern

  class_methods do
    def progress_steps(*steps)
      instance_eval do
        define_method :next_step do
          if index = steps.find_index(self.step.to_sym)
            update(step: steps[index + 1] || 'draft')
          end
        end
      end
    end
  end

  included do
    def publish
      update(step: :published)
    end

    def published?
      step == 'published'
    end

    def unpublish
      update(step: :draft)
    end

    def draft?
      step == 'draft'
    end

    def ready?
      published? || draft?
    end

    def toggle_published
      update(step: published? ? :draft : :published)
    end
  end
end