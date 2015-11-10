module FindableByUrl
  extend ActiveSupport::Concern

  class_methods do
    def find_by_url!(url)
      find_by!(url: url)
    end
  end
end
