require 'rss/2.0'
require 'open-uri'

class AboutController < ApplicationController
  before_filter :show_videos?, :only => [:videos]
  
  def index    
    @playlist = YouTube::Playlist.new(:id => "B407200BFFDB8F1E")
    @body_style = "home"      
    @blogs = Blog.paginate(:all, :per_page => 10, :page => params[:page], :order => 'posted_at DESC, created_at DESC') if @global_settings.show_blog?
    if @global_settings.show_news?
      @entries = Entry.find(:all, :offset => 1, :limit => 3, :order => "created_at DESC")  
      @first_entry = Entry.find(:all,  :limit => 1, :order => "created_at DESC")
    end
  end
  
  def rss
    blogs = @global_settings.show_blog? ? Blog.active.posted_yet.find(:all, :order => "posted_at DESC, created_at DESC") : []
    entries = @global_settings.show_news? ? Entry.find(:all, :order => "created_at DESC") : []
    lyrics = @global_settings.show_lyrics? ? Lyric.find(:all, :order => "created_at DESC") : []
    videos = @global_settings.show_videos? ? YouTube::User.new(:id => @global_settings.youtube_profile).videos : []
    items = blogs + entries + lyrics + videos
    @items = items.sort do |x,y|
      (y[:posted_at] || y[:created_at]) <=> (x[:posted_at] || x[:created_at])
    end
    render :template => 'about/rss.rss.builder'
  end
  
  def videos
    @wrs = YouTube::User.new(:id => @global_settings.youtube_profile)
    @videos = @wrs.videos[0..9]
    unless @global_settings.featured_playlist.blank?
      @featured_videos = YouTube::Playlist.new(:id => @global_settings.featured_playlist) 
      @latest_demo = @featured_videos.videos[0]
    end
  end
  
  private
  
  def show_videos?
    render_404 unless @global_settings.show_videos? || admin?
  end
end
