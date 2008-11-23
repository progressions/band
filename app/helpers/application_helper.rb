# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
  def color_input method, options={}
    output = ""
    output += "<dt><%= f.text_field #{method} %></dt>"
    output += "<dd class='label'>#{options[:label]}</dd>" if options[:label]
    output += "<dd class='description'>#{options[:description]}</dd>" if options[:description]
    
    content_tag("dt", "<%= f.text_field #{method} %>")
  end
  
  def fckeditor_tag model, attribute="body", options={}
    options = {:toolbarSet => 'Basic', :width => '464px', :height => '400px'}.merge(options)
    fckeditor_textarea(model, attribute, options) 
  end
  
  def improved_select_tag(name, option_tags=[], options={})
    option_tags = option_tags.join("</option><option>")
    option_tags = "<option>#{option_tags}</option>"
    select_tag(name, option_tags, options)
  end
  
  def strip_leading_zero str
    if str[0].chr == "0"
      str[1..str.length]
    else
      str
    end
  end
  
  def header text, link=''
    wrs_text = "#{@global_settings.artist_name} <span class='type'>#{text}</span>"
    wrs_link = link_to(wrs_text, link)
    "<h1 class='header'>#{wrs_link}</h1>"    
  end
  
  def sidebar page_title
    render :partial => "/layouts/sidebar", :locals => {:page_title => page_title}
  end
  
  def admin
    render :partial => "layouts/admin" if logged_in?
  end
  
  def mp3_link mp3
    "http://www.progressions.org/music/racketeering/#{mp3}.mp3"
  end
  
  def video options
    render :partial => "/layouts/video", :locals => {:video => options[:video], :heading => options[:heading]}
  end
  
  def youtube options
    if options[:full_video]
      video_link = options[:full_video]
    else
      video_link = "http://www.youtube.com/#{options[:video]}"
    end
    "<div class='video'><object type='application/x-shockwave-flash' style='width:418px; height:350px;' data='#{video_link}'><param name='movie' value='#{video_link}' /></object></div>"
  end
  
  
  def music_player song_filename, index, width=290, height=24
    string = <<END_STRING
      <script type="text/javascript" src="/javascripts/audio-player.js"></script>
<object type="application/x-shockwave-flash" data="/javascripts/player.swf" id="audioplayer#{index}" height="#{height}" width="#{width}">
<param name="movie" value="/javascripts/player.swf" />
<param name="FlashVars" value="playerID=#{index}&amp;soundFile=#{song_filename}" />
<param name="quality" value="high" />
<param name="menu" value="false" />
<param name="wmode" value="transparent" />
</object>
END_STRING
  end
  
  def preview item, params, show_byline=true
    if params[:preview_button]
      render :partial => item, :locals => {:show_byline => show_byline}
    end
  end

  def unsubscribe_link fan, text="unsubscribe"
    link_to text, unsubscribe_url(fan, :f => fan.crypted_email, :host => 'www.worldracketeeringsquad.com')
  end
  

  def sidebar_module options, &block
    name = options[:name]
    path = eval("#{name.downcase}_path")
    content = ""
    if block_given?
      content += "<h2>" + link_to(name.capitalize, path) + "</h2>"
      content += capture(&block)
      # content += '<h5 class="more">' + link_to("more #{name.downcase}...", path) + "</h5>"
    end
    block_is_within_action_view?(block) ? concat(content, block.binding) : content
  end
  

	def map_from_address show
	#	http://maps.google.com/maps?f=q&hl=en&q=1216+W+22nd+St+Austin+TX+78705
		map = "http://maps.google.com/maps?q=#{h(show.address)}+#{h(show.city)}+#{h(show.state)}+#{show.zipcode}"
		map
	end
end

class ActionView::Base
	attr_accessor :got_submit
	
  def submit_tag(value = "Save changes", options = {})
  	options.update(:onclick => "$('submit_id').value = '#{value}'")
  	if options[:name] && options[:name]==:commit
  		options[:name]="commit_sub"
  	elsif options[:name].nil?
  		options[:name]="commit_sub"
  	end
  	res=super(value,options)
  	if @got_submit.nil?
  		@got_submit=true
  		res = res << %Q!<input id="submit_id" name="commit" type="hidden" 
  value="12345">!
  	end
  	res
  end
end
