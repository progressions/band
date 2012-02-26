%W(frameworks).each do |lib|
  Dir["#{Rails.root}/lib/#{lib}/**"].sort.each do |file|
    require file unless File.directory?(file)
  end
end
