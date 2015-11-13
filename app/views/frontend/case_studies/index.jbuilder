json.array!(@cases) do |case_study|
  json.user case_study.user.url
  json.(case_study, :body, :body_short, :client, :id, :title, :url, :user_id, :template, :template_id, :image_url)
  json.domain request.protocol + request.host_with_port
end