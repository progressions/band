class DownloadsController < ApplicationController
  def index
    if @global_settings.free_download?
      email = params[:email]
      if email && Fan.find_by_email(email)
        send_file("#{Rails.root}/downloads/#{@global_settings.free_download_filename}", :type => "audio/mpeg")
      else
        redirect_to new_fan_url(:email => email)
      end
    else
      redirect_to home_url
    end
  end
end
