class CodeGenerator
  FILE = Rails.root.join('app/views/frontend/case_studies/client_javascript.js.erb')
  SITE_URL = "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}#{':' + ENV['SITE_PORT'] if ENV['SITE_PORT']}"

  def initialize(user)
    @user = user
    @url = full_url
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
    <<-HTML.strip_heredoc
      <div id="testify-tiles"></div>
      <script type="text/javascript" charset="utf-8">#{js}</script>
    HTML
  end

  def uglify(js)
    Uglifier.compile js
  end

  def full_url
    url = @user.url
    domain = @user.domain
    "#{SITE_URL}#{Rails.application.routes.url_helpers.code_case_studies_path(url, sign: SignUtils.sign(domain))}"
  end
end