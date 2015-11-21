1.upto(3) do |i|
  txt = "#{i}-column layout"
  CaseStudyTemplate.create(
     title: txt,
     preview: URI("http://placeholdit.imgix.net/~text?txtsize=30&txt=#{txt}&w=320&h=240"),
     template: '<h1>Some html</h1>'
  )
end

1.upto(3) do |i|
  txt = "Style #{i}"
  TileTemplate.create(
     title: txt,
     preview: URI("http://placeholdit.imgix.net/~text?txtsize=30&txt=#{txt}&w=320&h=240"),
     template: '<h1>Some html</h1>'
  )
end