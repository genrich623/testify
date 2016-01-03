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
     preview: File.open(File.join('seeds', 'templates', "tile_preview_#{i}.png")),
     template: File.read(File.join('seeds', 'templates', "tile_#{i}.html"))
  )
end



txt = "Style 1"
TestimonialTemplate.create(
    title: txt,
    preview: File.open(File.join('seeds', 'templates', "testimonial_preview_1.png")),
    template: File.read(File.join('seeds', 'templates', "testimonial_1.html"))
)