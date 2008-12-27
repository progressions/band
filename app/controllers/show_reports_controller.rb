class ShowReportsController < ApplicationController
  def index
    @show_reports = ShowReport.all
  end
  
  def show
    @show = Show.find(params[:id])
    @show_report = @show ? @show.report : nil
  end
  
  def new
    @show_report = ShowReport.new
  end
  
  def create
    @show_report = ShowReport.new(params[:show_report])
    if @show_report.save
      flash[:notice] = "Successfully created showreport."
      redirect_to @show_report
    else
      render :action => 'new'
    end
  end
  
  def edit
    @show_report = ShowReport.find(params[:id])
  end
  
  def update
    @show_report = ShowReport.find(params[:id])
    if @show_report.update_attributes(params[:show_report])
      flash[:notice] = "Successfully updated showreport."
      redirect_to @show_report
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @show_report = ShowReport.find(params[:id])
    @show_report.destroy
    flash[:notice] = "Successfully destroyed showreport."
    redirect_to show_reports_url
  end
end
