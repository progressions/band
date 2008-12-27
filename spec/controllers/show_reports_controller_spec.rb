require File.dirname(__FILE__) + '/../spec_helper'
 
describe ShowReportsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => ShowReport.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ShowReport.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ShowReport.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(show_report_url(assigns[:show_report]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => ShowReport.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    ShowReport.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ShowReport.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ShowReport.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ShowReport.first
    response.should redirect_to(show_report_url(assigns[:show_report]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    show_report = ShowReport.first
    delete :destroy, :id => show_report
    response.should redirect_to(show_reports_url)
    ShowReport.exists?(show_report.id).should be_false
  end
end
