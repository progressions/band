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
    options = {:toolbarSet => "WRS", :width => 464, :height => 400}.merge(options)
    options[:height] = "#{options[:height].to_i}px"
    options[:width] = "#{options[:width].to_i}px"
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
  
  def admin?
    params[:admin]
  end
  
  def show_sidebar?
    !admin?
  end
  
  def mp3_link mp3
    "http://www.progressions.org/music/racketeering/#{mp3}.mp3"
  end
  
  def video options
    render :partial => "/layouts/video", :locals => {:video => options[:video], :heading => options[:heading]}
  end
  
  def default_video_format
    @global_settings.video_format || WIDESCREEN
  end
  
  def youtube(options)
    # standard frame is 418x350
    # widescreen frame is 480x295
    
    width = options[:width] || VIDEO_WIDTH[default_video_format]
    height = options[:height] || VIDEO_HEIGHT[default_video_format]
    if options[:full_video]
      video_link = options[:full_video]
    else
      video_link = "http://www.youtube.com/#{options[:video]}"
    end
    #"<div class='video'><object type='application/x-shockwave-flash' style='width:#{width}px; height:#{height}px;' data='#{video_link}'><param name='movie' value='#{video_link}' /></object></div>"
    
    "<div class='video'><object width='#{width}' height='#{height}'><param name='movie' value='#{video_link}'></param><param name='allowFullScreen' value='true'></param><param name='allowscriptaccess' value='always'></param><embed src='#{video_link}' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='#{width}' height='#{height}'></embed></object></div>"

  end
  
  def music_player(song_filename, index, width=290, height=24)
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
  
  def preview(item, params, show_byline=true)
    if params[:preview_button]
      render :partial => item, :locals => {:show_byline => show_byline}
    end
  end

  def unsubscribe_link(fan, text="unsubscribe")
    link_to text, unsubscribe_url(fan, :f => fan.crypted_email, :host => 'www.worldracketeeringsquad.com')
  end
  
  def twitter_profile
	  "http://www.twitter.com/#{@global_settings.twitter_profile}"
  end
  
  def twitter_profile_link
    link_to(@global_settings.twitter_profile, twitter_profile)
  end
  
  def twitter_user
    twitter.user(@global_settings.twitter_profile)
  end
	
	def twitter
	  Twitter::Base.new(@global_settings.twitter_profile, @global_settings.twitter_password)
  end
  
  def twitter_feed(count=MAX_TWITTER_COUNT)
    twitter.timeline(:user, :count => count)
  rescue
    []
  end
  
  def add_twitter_links(text)
    text = auto_link(text)
    text = text.gsub(/@[^\s]*/) {|s| "<a href='http://www.twitter.com/#{s.gsub('@','')}'>#{s}</a>"}
  end
  
  def add_links(text)
    text.gsub(/http[^\s]*/) {|s| "<a href='#{s}'>#{s}</a>"}
  end
  
  def convert_to_html(text)
    text.gsub!("&lt;", "<")
    text.gsub!("&gt;", ">")
    text.gsub!("&quot;", '"')
    text
  end
  
  def post_twitter_update(s)
		"<li class=\"text\">#{add_twitter_links(s.text)}</li>
		<li class=\"byline\">#{time_ago_in_words(s.created_at)} ago from #{convert_to_html(s.source)}</li>"
  end
  
  def myspace_link(profile)
    "http://www.myspace.com/#{profile}"
  end

	def map_from_address(show)
	#	http://maps.google.com/maps?f=q&hl=en&q=1216+W+22nd+St+Austin+TX+78705
		map = "http://maps.google.com/maps?q=#{h(show.address)}+#{h(show.city)}+#{h(show.state)}+#{show.zipcode}"
		map
	end
	
	def shows(options={})
	  options = {:show_body => true, :show_byline => true, :show_map => true, :show_year => true}.merge(options)
	  render :partial => @show, :locals => options
	end
	
	def post_tweet_check_box(checked=true, message="Post on Twitter?")
    "#{check_box_tag :post_tweet, 'yes', checked} #{message}"
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
