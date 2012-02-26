class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :global_settings

  def global_settings
    @global_settings = Setting.first || Setting.create
    @site_name = @global_settings.site_name
  end
end
