class StatusReporter < Worker
  def self.send_status_report
    @global_settings = Setting.find(1)
    
    status_presenter = StatusPresenter.new(:site => @global_settings)
    Mailer.deliver_status_report(status_presenter)
  end
end