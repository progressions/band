module ActionView
  module Helpers
    module FormOptionsHelper
      
      def colour_field(object_name, method, options = {}, button_options = {})
        InstanceTag.new(object_name, method, self, nil, options.delete(:object)).to_colour_picker_tag(options, button_options)
      end
      
      alias color_field colour_field
    end
    
    class InstanceTag
      def to_colour_picker_tag(options = {}, button_options = {})
        options = options.stringify_keys
        add_default_name_and_id(options)
        options[:type] = "text"
        options[:use_swatch_icon] ||= false
  
        options[:value] ||= value(object)
        if options[:value].blank?
          # options[:style] = "width:50px; background-color:#efefef; border:1px solid #efefef;}"
        else
          # options[:style] = "width:50px; background-color:#{options[:value]}; color:#{options[:value]}; border:1px solid #{options[:value]};}" unless options[:value].blank?
        end
        
        rtn = Array.new
        rtn << tag('input', options)
        
        button_options[:value] ||= 'Pick a colour'
        button_options[:style] ||= 'margin-left:5px;'
        button_options[:onclick] = "cp_show(this.form.#{options['id']}); return false;"
        
        if options[:use_swatch_icon]
          button_options[:type] = 'image'
          button_options[:src] = 'images/colour_picker/swatch.png'
        else
          button_options[:type] = 'button'
        end
        rtn << tag('input', button_options)
        
        return rtn.join(" ")
      end
    end
    
  end
end