require 'rss/2.0'
require 'open-uri'

class AboutController < ApplicationController
  before_filter :show_videos?, :only => [:videos]
  
  def index    
    @playlist = YouTube::Playlist.new(:id => "B407200BFFDB8F1E")
    @body_style = "home"      
    @blogs = Blog.paginate :all, :per_page => 5, :page => params[:page], :order => 'created_at DESC' if @global_settings.show_blog?
    #@songs = Song.find(:all, :limit => 3, :order => "created_at DESC")
    if @global_settings.show_news?
      @entries = Entry.find(:all, :offset => 1, :limit => 3, :order => "created_at DESC")  
      @first_entry = Entry.find(:all,  :limit => 1, :order => "created_at DESC")
    end
  end
  
  def rss
    blogs = @global_settings.show_blog? ? Blog.find(:all, :order => "created_at DESC") : []
    entries = @global_settings.show_news? ? Entry.find(:all, :order => "created_at DESC") : []
    lyrics = @global_settings.show_lyrics? ? Lyric.find(:all, :order => "created_at DESC") : []
    videos = @global_settings.show_videos? ? YouTube::User.new(:id => @global_settings.youtube_profile).videos : []
    items = blogs + entries + lyrics + videos
    @items = items.sort do |x,y|
      y.created_at <=> x.created_at
    end
    render :template => 'about/rss.rss.builder'
  end
  
  def videos
    @wrs = YouTube::User.new(:id => @global_settings.youtube_profile)
    @videos = @wrs.videos[0..9]
    @featured_videos = YouTube::Playlist.new(:id => "838EB0386BC516DE")
    @latest_demo = @featured_videos.videos[0]
  end
  
  private
  
  def show_videos?
    render_404 unless @global_settings.show_videos? || admin?
  end
end
