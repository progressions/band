class ShowReportsController < ApplicationController
  before_filter :get_show_report, :only => [:show, :edit, :destroy]
  
  def get_show_report
    @show = Show.find(params[:id])
    @show_report = @show.try(:show_report)
    unless @show_report
      flash[:notice] = "Could not find show report."
      if @show
        redirect_to @show
      else
        redirect_to admin_url
      end
    end
  end
  
  def index
    @show_reports = ShowReport.all
  end
  
  def show
  end
  
  def new
    @show_report = ShowReport.new
  end
  
  def create
    @show_report = ShowReport.new(params[:show_report])
    if @show_report.save
      flash[:notice] = "Successfully created show report."
      redirect_to @show_report
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @show_report.update_attributes(params[:show_report])
      flash[:notice] = "Successfully updated show report."
      redirect_to @show_report
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @show_report.destroy
    flash[:notice] = "Successfully destroyed show report."
    redirect_to show_reports_url
  end
end
