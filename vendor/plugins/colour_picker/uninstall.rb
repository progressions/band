require 'fileutils'

public_dir = File.dirname(__FILE__) + '/../../../public'

## Remove Javascript

FileUtils.rm public_dir + '/javascripts/colour_picker.js'

## Remove Images

FileUtils.rm public_dir + '/images/colour_picker/swatch.png'
FileUtils.rm public_dir + '/images/colour_picker/spacer.gif'
FileUtils.rmdir public_dir + '/images/colour_picker/'

puts ''
puts ' ** Succssfully uninstalled the colour_picker plugin'
puts ''