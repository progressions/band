require 'fileutils'

public_dir = File.dirname(__FILE__) + '/../../../public'

## Copy Javascript into public javascripts folder

FileUtils.cp File.dirname(__FILE__) + '/resources/colour_picker.js', public_dir + '/javascripts/' unless File.exist?(public_dir + 'javascripts/colour_picker.js')

## Copy Images into Images Folder

FileUtils.mkdir public_dir + '/images/colour_picker' unless File.exist?(public_dir + '/images/colour_picker')
FileUtils.cp File.dirname(__FILE__) + '/resources/swatch.png', public_dir + '/images/colour_picker/' unless File.exist?(public_dir + 'images/colour_picker/swatch.png')
FileUtils.cp File.dirname(__FILE__) + '/resources/spacer.gif', public_dir + '/images/colour_picker/' unless File.exist?(public_dir + 'images/colour_picker/spacer.gif')

## Say what needs to happen next

puts ''
puts ' ** The plugin has now been installed successfully. The appropriate javascript file has been placed in your public/javascripts folder.'
puts ' ** You now need to include this file in your application layout using the code below:'
puts ' ** <%=javascript_include_tag \'colour_picker\' %>'
puts ''