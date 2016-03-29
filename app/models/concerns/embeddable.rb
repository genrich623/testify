module Embeddable
  extend ActiveSupport::Concern

  class_methods do
    def embed_as(object)
      instance_eval do
        define_method "#{object}_code" do
          "<script src=\"#{ENV['SITE_URL']}/embed.js\" type=\"text/javascript\"></script>"\
          "<script type=\"text/javascript\" charset=\"utf-8\">"\
          "testify(document).ready(function() {testify_embed_#{object}(#{id});});"\
          "</script><div id=\"testify_embed_hook_#{object}_#{id}\"></div>"
        end
      end
    end

    def embed_as_self
      embed_as(self.name.downcase)
    end
  end
end