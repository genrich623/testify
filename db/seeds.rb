1.upto(3) do |i|
  txt = "Template #{i}"
  CaseStudyTemplate.create(
     title: txt,
     preview: File.open(File.join('seeds', 'templates', "case_study_preview_#{i}.png")),
     template: File.read(File.join('seeds', 'templates', "case_study_#{i}.html"))
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