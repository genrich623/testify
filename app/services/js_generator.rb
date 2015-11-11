class JsGenerator
  FILE = Rails.root.join('app/views/frontend/case_studies/client_javascript.js.erb')
  SITE_URL = "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}#{':' + ENV['SITE_PORT'] if ENV['SITE_PORT']}"

  def initialize(code)
    @code = code
    @url = full_url(code)
  end

  def code
    js = ApplicationController.new.render_to_string(
      template: 'frontend/case_studies/client_javascript',
      layout: false,
      locals: { :@url => @url }
    )
    html uglify js
  end

  private
  def html(js)
    <<-HTML
<script type="text/javascript" charset="utf-8">#{js}</script>
    HTML
  end

  def uglify(js)
    Uglifier.compile js
  end

  def full_url(url)
    "#{SITE_URL}#{Rails.application.routes.url_helpers.public_case_studies_path(url, :json)}"
  end
end